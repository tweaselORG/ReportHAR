import { createTypstCompiler } from '@myriaddreamin/typst.ts/dist/esm/compiler.mjs';
import { readFileSync } from 'fs';
import type { Har } from 'har-format';
import Nunjucks from 'nunjucks';
import { type processRequest } from 'trackhar';
import trackHarTranslationsEn from 'trackhar/i18n/en.json';
import { generateTyp as generateTypForHar } from './lib/har2pdf';
import { prepareTraffic, type PrepareTrafficOptions } from './lib/traffic';
import type { NetworkActivityReport } from './lib/user-network-activity';

export type App = {
    id: string;
    name: string;
    version: string;
    url: string;
    store: 'Google Play Store' | 'Apple App Store';

    platform: 'Android' | 'iOS';
};
export type Analysis = {
    date: Date;

    app: App;
    platformVersion: string;

    har: Har;
    harMd5?: string;

    trackHarResult: ReturnType<typeof processRequest>[];
};
export type ComplaintOptions = {
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

export type GenerateOptions =
    | {
          type: 'report' | 'notice';
          language: 'en';

          analysis: Analysis;
      }
    | {
          type: 'complaint';
          language: 'en';

          /** Data for the initial analysis, that the notice to the controller was based on. */
          initialAnalysis: Analysis;
          /** Data for the second analysis, that will be the basis for the complaint. */
          analysis: Analysis;
          complaintOptions: ComplaintOptions;
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
    // Prepare traffic.
    const prepareTrafficOptions: PrepareTrafficOptions = {
        har: options.analysis.har,
        trackHarResult: options.analysis.trackHarResult,
    };
    if (options.type === 'complaint') {
        // For complaints, only consider results from adapters for which we know that the user's device contacted at
        // least one matching hostname.
        prepareTrafficOptions.entryFilter = (entry) => {
            const hostname = entry.harEntry?.request.host;
            if (!hostname) return false;

            return options.complaintOptions.userNetworkActivity
                .filter((e) => e.appId === options.analysis.app.id)
                .some((e) => e.hostname === hostname);
        };
    }
    const { harEntries, trackHarResult, findings } = prepareTraffic(prepareTrafficOptions);

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
        analysis: options.analysis,
        initialAnalysis: options.type === 'complaint' && options.initialAnalysis,
        complaintOptions: options.type === 'complaint' && options.complaintOptions,
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
