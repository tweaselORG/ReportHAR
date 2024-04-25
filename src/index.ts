import { type TweaselHar } from 'cyanoacrylate';
import { type processRequest } from 'trackhar';
import {
    generate as generateInternal,
    type ComplaintOptions,
    type GenerateOptions as GenerateInternalOptions,
} from './lib/generate';
import { type SupportedLanguage } from './lib/translations';

// TODO: Due to the stacks of unreleased package versions we're using through yalc here, the `App` type from
// appstraction doesn't arrive here. Remove once they are released.
type App = {
    platform: 'android' | 'ios';
    id: string;
    name?: string;
    version?: string;
    versionCode?: string;
    architectures: ('arm64' | 'arm' | 'x86' | 'x86_64' | 'mips' | 'mips64')[];
};

export type GenerateOptions =
    | {
          type: 'report' | 'notice';
          language: SupportedLanguage;

          har: TweaselHar;
          trackHarResult: ReturnType<typeof processRequest>[];
      }
    | {
          type: 'complaint';
          language: SupportedLanguage;

          /** HAR for the initial analysis, that the notice to the controller was based on. */
          initialHar: TweaselHar;
          initialTrackHarResult: ReturnType<typeof processRequest>[];

          /** HAR for the second analysis, that will be the basis for the complaint. */
          har: TweaselHar;
          trackHarResult: ReturnType<typeof processRequest>[];

          complaintOptions: ComplaintOptions;
      };

const platformMapping = {
    android: 'Android',
    ios: 'iOS',
} as const;

export const generate = (options: GenerateOptions) => {
    const errHint = (m: string) => `${m} Use generateInternal() instead and manually provide the required metadata.`;
    if (!('_tweasel' in options.har.log) || (options.type === 'complaint' && !('_tweasel' in options.initialHar.log)))
        throw new Error(
            errHint(
                'The generate() function relies on the additional metadata in tweasel HAR files. If you have a HAR file produced by another tool:'
            )
        );

    const getAnalysisMeta = (har: TweaselHar, trackHarResult: ReturnType<typeof processRequest>[]) => {
        const apps = har.log._tweasel.apps;
        if (!apps)
            throw new Error(errHint('Your HAR file does not contain any metadata on the app that was analyzed.'));
        if (apps.length !== 1)
            throw new Error('Your HAR file contains traffic for more than one app. This is not supported.');
        const app = apps[0] as App;

        const appVersion = app.version || app.versionCode;
        if (!appVersion)
            throw new Error(
                errHint('Your HAR file does not contain any metadata on the version of the app that was analyzed.')
            );

        return {
            date: new Date(har.log._tweasel.startDate),
            app: {
                id: app.id,
                name: app.name || app.id,
                version: appVersion,

                platform: platformMapping[app.platform],
            },
            platformVersion: har.log._tweasel.device.osVersion,
            har: har,
            trackHarResult: trackHarResult,
        };
    };

    // TODO: harMd5

    if (options.type === 'complaint')
        return generateInternal({
            type: options.type,
            language: options.language,

            analysis: getAnalysisMeta(options.har, options.trackHarResult),
            initialAnalysis: getAnalysisMeta(options.initialHar, options.initialTrackHarResult),

            complaintOptions: options.complaintOptions,
        });
    return generateInternal({
        type: options.type,
        language: options.language,

        analysis: getAnalysisMeta(options.har, options.trackHarResult),
    });
};

export { generateInternal, type GenerateInternalOptions };
