import { createTypstCompiler } from '@myriaddreamin/typst.ts/dist/esm/compiler.mjs';
import { readFileSync } from 'fs';
import type { Har } from 'har-format';
import Nunjucks from 'nunjucks';
import { adapters, type Adapter, type AnnotatedResult } from 'trackhar';
import trackHarTranslationsEn from 'trackhar/i18n/en.json';
import { generateTyp as generateTypForHar, unhar } from './lib/har2pdf';
import type { NetworkActivityReport } from './lib/user-network-activity';

export type GenerateOptions = {
    type: 'report' | 'notice' | 'complaint';
    language: 'en';

    analysisMeta: {
        platform: 'Android' | 'iOS';

        appName: string;
        appVersion: string;
        appUrl: string;
        appStore: 'Google Play Store' | 'Apple App Store';

        // For complaints.
        initialAnalysisDate: Date;
        // For complaints, this is the date of the second analysis.
        analysisDate: Date;
        analysisPlatformVersion: string;

        harMd5?: string;
    };
    har: Har;
    trackHarResult: (null | AnnotatedResult)[];

    complaintOptions: {
        date: Date;
        reference: string;

        noticeDate: Date;

        nationalEPrivacyLaw: 'TTDSG' | false;

        complainantAddress: string;
        controllerAddress: string;

        loggedIntoAppStore: boolean;
        deviceHasRegisteredSimCard: boolean;

        controllerResponse: 'none' | 'denial' | 'broken-promise';

        complainantContactDetails: string;
        complainantAgreesToUnencryptedCommunication: boolean;

        userNetworkActivity: NetworkActivityReport;
    };
};

const templates = {
    en: {
        report: readFileSync(new URL('../templates/en/report.typ', import.meta.url), 'utf-8'),
        notice: readFileSync(new URL('../templates/en/notice.typ', import.meta.url), 'utf-8'),
        complaint: readFileSync(new URL('../templates/en/complaint.typ', import.meta.url), 'utf-8'),
        style: readFileSync(new URL('../templates/en/style.typ', import.meta.url), 'utf-8'),
    },
};

const translations = {
    en: trackHarTranslationsEn,
};

export const generate = async (options: GenerateOptions) => {
    const harEntries = unhar(options.har);
    const trackHarResult = options.trackHarResult
        .map((transmissions, harIndex) =>
            transmissions === null || transmissions.length === 0
                ? null
                : // eslint-disable-next-line @typescript-eslint/no-non-null-assertion
                  { harIndex, adapter: transmissions[0]!.adapter, transmissions }
        )
        .filter((e): e is NonNullable<typeof e> => e !== null);
    const findings = trackHarResult.reduce<
        Record<
            string,
            { adapter: Adapter; requests: typeof trackHarResult; receivedData: Record<string, Array<string>> }
        >
    >((acc, req) => {
        if (!acc[req.adapter]) {
            const adapter = adapters.find((a) => a.tracker.slug + '/' + a.slug === req.adapter);
            if (!adapter) throw new Error(`Unknown adapter: ${req.adapter}`);
            acc[req.adapter] = {
                adapter,
                requests: [],
                receivedData: {},
            };
        }

        // eslint-disable-next-line @typescript-eslint/no-non-null-assertion
        acc[req.adapter]!.requests.push(req);

        for (const transmission of req.transmissions) {
            const property = String(transmission.property);

            if (!acc[req.adapter]?.receivedData[property]) {
                // eslint-disable-next-line @typescript-eslint/no-non-null-assertion
                acc[req.adapter]!.receivedData[property] = [];
            }

            // eslint-disable-next-line @typescript-eslint/no-non-null-assertion
            acc[req.adapter]!.receivedData[property] = [
                // eslint-disable-next-line @typescript-eslint/no-non-null-assertion
                ...new Set([...acc[req.adapter]!.receivedData[property]!, transmission.value]),
            ];
        }

        return acc;
    }, {});

    const nunjucks = Nunjucks.configure({ autoescape: true, throwOnUndefined: true });
    nunjucks.addFilter('dateFormat', (date: Date | string | undefined, includeTime = true) =>
        date
            ? new Date(date).toLocaleString(options.language, {
                  dateStyle: 'long',
                  timeStyle: includeTime ? 'long' : undefined,
              })
            : undefined
    );
    nunjucks.addFilter('timeFormat', (date: Date | string | undefined) =>
        date ? new Date(date).toLocaleTimeString(options.language) : undefined
    );
    // Wrap content in a raw/code block, properly escaping user input.
    nunjucks.addFilter(
        'code',
        (s: string | undefined) =>
            new Nunjucks.runtime.SafeString(s === undefined ? '' : `\`\`\` ${(s + '').replace(/`/g, '`\u200b')}\`\`\``)
    );
    // Convert string from TrackHAR's markup language to Typst.
    nunjucks.addFilter('trackharMl', (str: string) => str.replace(/\s*\[(https?:\/\/.+?)\]/g, '#footnote[$1]'));
    // Translate.
    nunjucks.addGlobal(
        't',
        <TScope extends keyof (typeof translations)['en']>(
            scope: TScope,
            key: keyof (typeof translations)['en'][TScope] & string
        ) => (
            (() => {
                const translation = translations[options.language][scope][key];
                if (!translation) throw new Error(`Translation not found: ${scope}::${key}`);
            })(),
            translations[options.language][scope][key]
        )
    );

    const typSource = nunjucks.renderString(templates[options.language][options.type], {
        analysisMeta: options.analysisMeta,
        complaintOptions: options.complaintOptions,
        harEntries,
        trackHarResult,
        findings,
    });

    const mainFilePath = '/main.typ';

    const cc = createTypstCompiler();
    await cc.init({ beforeBuild: [] });

    cc.addSource(mainFilePath, typSource);
    cc.addSource('/style.typ', templates[options.language].style);
    if (options.type === 'report')
        cc.addSource(
            '/har.typ',
            generateTypForHar(
                harEntries
                    .map((e, index) => ({ ...e, index }))
                    .filter((e) => trackHarResult.some((r) => r.harIndex === e.index)),
                { includeResponses: false, truncateContent: 4096 }
            )
        );

    return await cc.compile({ mainFilePath, format: 'pdf' });
};
