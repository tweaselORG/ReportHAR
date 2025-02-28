/** Usage: tsx test-generate.ts -p <platform> --ePrivacyLaw <national e-privacy law> */

import { mkdirSync, readFileSync, writeFileSync } from 'fs';
import { dirname, join } from 'path';
import { process as processHar } from 'trackhar';
import { fileURLToPath } from 'url';
import { parseArgs } from 'util';
import type { ComplaintOptionsFormalMobile, ComplaintOptionsInformal, SupportedLanguage } from '../dist';
import { generate, parseNetworkActivityReport, templates } from '../dist';
import { type TweaselHar } from '../src/lib/tweasel-har';

const cliArgs = parseArgs({
    options: {
        platform: {
            type: 'string',
            short: 'p',
        },
        ePrivacyLaw: {
            type: 'string',
        },
        language: {
            type: 'string',
            short: 'l',
        },
    },
});

const nationalEPrivacyLaw = (
    cliArgs.values.ePrivacyLaw && ['TDDDG'].includes(cliArgs.values.ePrivacyLaw) ? cliArgs.values.ePrivacyLaw : false
) as 'TDDDG' | false;

const supportedLanguages = Object.keys(templates);
if (cliArgs.values.language && !supportedLanguages.includes(cliArgs.values.language))
    throw new Error(`Invalid language: ${cliArgs.values.language} (should be one of ${supportedLanguages})`);
const language = (cliArgs.values.language ?? 'en') as SupportedLanguage;

if (cliArgs.values.platform && !['ios', 'android'].includes(cliArgs.values.platform))
    throw new Error(`Invalid platform: ${cliArgs.values.platform} (should be 'ios' or 'android')`);
const platform = (cliArgs.values.platform as 'ios' | 'android') ?? 'android';

const __dirname = dirname(fileURLToPath(import.meta.url));
const fixtureFolder = join(__dirname, 'fixtures', platform);

const initialHar = JSON.parse(readFileSync(join(fixtureFolder, 'first-run.har'), 'utf-8')) as TweaselHar;
const secondHar = JSON.parse(readFileSync(join(fixtureFolder, 'second-run.har'), 'utf-8')) as TweaselHar;

const userNetworkActivity =
    platform === 'ios'
        ? parseNetworkActivityReport(
              'ios-app-privacy-report-ndjson',
              readFileSync(join(fixtureFolder, 'app-privacy-report.ndjson'), 'utf-8')
          )
        : parseNetworkActivityReport(
              'tracker-control-csv',
              readFileSync(join(fixtureFolder, 'tracker-control-report.csv'), 'utf-8')
          );

const reference = '2024-1ONO079C';

const complaintOptions: ComplaintOptionsFormalMobile & ComplaintOptionsInformal = {
    date: new Date(),
    reference,
    noticeDate: new Date(),

    nationalEPrivacyLaw,

    complainantAddress: 'Kim Mustermensch, Musterstraße 123, 12345 Musterstadt, Musterland',
    controllerAddress: 'Musterfirma, Musterstraße 123, 12345 Musterstadt, Musterland',
    controllerAddressSourceUrl: 'https://play.google.com/store/apps/details?id=tld.sample.app',

    userDeviceAppStore: platform === 'ios' ? 'App Store' : 'Google Play Store',
    loggedIntoAppStore: true,
    deviceHasRegisteredSimCard: true,

    controllerResponse: 'denial',

    complainantContactDetails: 'kim.muster@example.tld',
    complainantAgreesToUnencryptedCommunication: true,

    userNetworkActivity: userNetworkActivity,
};

(async () => {
    // Initial report and notice.
    const initialTrackHarResult = await processHar(initialHar);

    const resultsDir = join(__dirname, 'results');
    mkdirSync(resultsDir, { recursive: true });

    const initialReport = await generate({
        type: 'report',
        analysisSource: 'mobile',
        language,

        har: initialHar,
        trackHarResult: initialTrackHarResult,
    });
    writeFileSync(join(resultsDir, 'initial-report.pdf'), initialReport);
    const notice = await generate({
        type: 'notice',
        analysisSource: 'mobile',
        language,

        har: initialHar,
        trackHarResult: initialTrackHarResult,
    });
    writeFileSync(join(resultsDir, 'notice.pdf'), notice);

    // Second report and complaint.
    const secondTrackHarResult = await processHar(secondHar);

    const secondReport = await generate({
        type: 'report',
        analysisSource: 'mobile',
        language,

        har: secondHar,
        trackHarResult: secondTrackHarResult,
    });
    writeFileSync(join(resultsDir, 'second-report.pdf'), secondReport);
    const complaint = await generate({
        type: 'complaint',
        analysisSource: 'mobile',
        language,

        initialHar,
        initialTrackHarResult,
        har: secondHar,
        trackHarResult: secondTrackHarResult,

        complaintOptions,
    });
    writeFileSync(join(resultsDir, 'complaint.pdf'), complaint);
    const informalComplaint = await generate({
        type: 'complaint-informal',
        analysisSource: 'mobile',
        language,

        initialHar,
        initialTrackHarResult,
        har: secondHar,
        trackHarResult: secondTrackHarResult,

        complaintOptions,
    });
    writeFileSync(join(resultsDir, 'complaint-informal.pdf'), informalComplaint);
})();
