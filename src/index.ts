import { type processRequest } from 'trackhar';
import { generateAdvanced, type ComplaintOptions, type GenerateAdvancedOptions } from './lib/generate';
import { type SupportedLanguage } from './lib/translations';
import { type TweaselHar } from './lib/tweasel-har';

/** Options for generating a report or controller notice using the {@link generate} function. */
export type GenerateOptionsDefault = {
    /**
     * The type of document to generate, with the following possible values:
     *
     * - `report`: Generate a technical report.
     * - `notice`: Generate a notice to the controller.
     */
    type: 'report' | 'notice';
    /** The language the generated document should be in. */
    language: SupportedLanguage;

    /** The HAR containing the recorded network traffic. Must be a tweasel HAR with metadata. */
    har: TweaselHar;
    /**
     * The MD5 hash of the HAR file such that recipients of the report can verify the integrity of the attached HAR
     * file.
     */
    harMd5?: string;
    /** The [TrackHAR](https://github.com/tweaselORG/TrackHAR) analysis results for the HAR. */
    trackHarResult: ReturnType<typeof processRequest>[];
};
/** Options for generating a complaint using the {@link generate} function. */
export type GenerateOptionsComplaint = {
    /**
     * The type of document to generate, with the following possible values:
     *
     * - `complaint`: Generate a complaint to a data protection authority.
     */
    type: 'complaint';
    /** The language the generated document should be in. */
    language: SupportedLanguage;

    /**
     * The HAR containing the recorded network traffic of the initial analysis that the notice to the controller was
     * based on. Must be a tweasel HAR with metadata.
     */
    initialHar: TweaselHar;
    /**
     * The MD5 hash of the initial HAR file such that recipients of the report can verify the integrity of the attached
     * HAR file.
     */
    initialHarMd5?: string;
    /** The [TrackHAR](https://github.com/tweaselORG/TrackHAR) analysis results for the initial HAR. */
    initialTrackHarResult: ReturnType<typeof processRequest>[];

    /**
     * The HAR containing the recorded network traffic of second analysis, that will be the basis for the complaint.
     * Must be a tweasel HAR with metadata.
     */
    har: TweaselHar;
    /**
     * The MD5 hash of the second HAR file such that recipients of the report can verify the integrity of the attached
     * HAR file.
     */
    harMd5?: string;
    /** The [TrackHAR](https://github.com/tweaselORG/TrackHAR) analysis results for the second HAR. */
    trackHarResult: ReturnType<typeof processRequest>[];

    /** Additional metadata for complaints. */
    complaintOptions: ComplaintOptions;
};
/**
 * Options for the {@link generate} function.
 *
 * @remarks
 * The options type is a discriminated union based on the `type` property:
 *
 * - For `type: 'report' | 'notice'`, provide {@link GenerateOptionsDefault}.
 * - For `type: 'complaint'`, provide {@link GenerateOptionsComplaint}.
 */
export type GenerateOptions = GenerateOptionsDefault | GenerateOptionsComplaint;

const platformMapping = {
    android: 'Android',
    ios: 'iOS',
} as const;

/**
 * Generate a technical report, controller notice or DPA complaint based on a network traffic analysis performed using
 * tweasel tools.
 *
 * @remarks
 * This is a high-level function that takes a tweasel HAR and relies on the additionaly metadata therein. If you have a
 * HAR from another source, use {@link generateAdvanced} instead and manually provide the required metadata.
 * @param options The options specifying what to generate.
 *
 * @returns The generated document as a PDF file.
 */
export const generate = (options: GenerateOptions) => {
    const errHint = (m: string) => `${m} Use generateAdvanced() instead and manually provide the required metadata.`;
    if (!('_tweasel' in options.har.log) || (options.type === 'complaint' && !('_tweasel' in options.initialHar.log)))
        throw new Error(
            errHint(
                'The generate() function relies on the additional metadata in tweasel HAR files. If you have a HAR file produced by another tool:'
            )
        );

    const getAnalysisMeta = (har: TweaselHar, trackHarResult: ReturnType<typeof processRequest>[], harMd5?: string) => {
        const apps = har.log._tweasel.apps;
        if (!apps)
            throw new Error(errHint('Your HAR file does not contain any metadata on the app that was analyzed.'));
        const app = apps[0];
        if (apps.length !== 1 || !app)
            throw new Error('Your HAR file contains traffic for more than one app. This is not supported.');

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
            harMd5,
            trackHarResult: trackHarResult,
            dependencies: har.log._tweasel.versions,
        };
    };

    if (options.type === 'complaint')
        return generateAdvanced({
            type: options.type,
            language: options.language,

            analysis: getAnalysisMeta(options.har, options.trackHarResult, options.harMd5),
            initialAnalysis: getAnalysisMeta(options.initialHar, options.initialTrackHarResult, options.initialHarMd5),

            complaintOptions: options.complaintOptions,
        });
    return generateAdvanced({
        type: options.type,
        language: options.language,

        analysis: getAnalysisMeta(options.har, options.trackHarResult, options.harMd5),
    });
};

export type { Analysis, App, GenerateAdvancedOptionsComplaint, GenerateAdvancedOptionsDefault } from './lib/generate';
export { prepareTraffic, type PrepareTrafficOptions } from './lib/traffic';
export { supportedLanguages, templates, translations } from './lib/translations';
export {
    parseNetworkActivityReport,
    type IosAppPrivacyReportNetworkActivityEntry,
    type NetworkActivityReport,
    type TrackerControlNetworkTrafficExportEntry,
} from './lib/user-network-activity';
export { generateAdvanced, type ComplaintOptions, type GenerateAdvancedOptions, type SupportedLanguage };
