import { type processRequest } from 'trackhar';
import {
    generateAdvanced,
    type ComplaintOptionsFormalMobile,
    type ComplaintOptionsFormalWeb,
    type ComplaintOptionsInformal,
    type GenerateAdvancedOptions,
} from './lib/generate';
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
} & (
    | {
          /**
           * Which toolchain collected the HAR, with the following possible values:
           *
           * - `web` for HARs originating from the TweaselForWeb addon.
           * - `mobile` for HARs collected using the Tweasel mobile toolchain.
           */
          analysisSource: 'mobile';
          /**
           * The HAR containing the recorded network traffic where interaction with the website was allowed. Can be a
           * tweasel HAR with metadata. This option is disabled for the mobile toolchain.
           */
          harInteraction: never;
          /** The [TrackHAR](https://github.com/tweaselORG/TrackHAR) analysis results for the HAR. */
          trackHarResultInteraction: never;
          /**
           * The MD5 hash of the HAR file such that recipients of the report can verify the integrity of the attached
           * HAR file.
           */
          harInteractionMd5: never;
      }
    | {
          /**
           * Which toolchain collected the HAR, with the following possible values:
           *
           * - `web` for HARs originating from the TweaselForWeb addon.
           * - `mobile` for HARs collected using the Tweasel mobile toolchain.
           */
          analysisSource: 'web';
          /**
           * The HAR containing the recorded network traffic where interaction with the website was allowed. Can be a
           * tweasel HAR with metadata. This option is disabled for the mobile toolchain.
           */
          harInteraction: TweaselHar;
          /**
           * The [TrackHAR](https://github.com/tweaselORG/TrackHAR) analysis results for the HAR where interaction with
           * the website was allowed.
           */
          trackHarResultInteraction: ReturnType<typeof processRequest>[];
          /**
           * The MD5 hash of the HAR file such that recipients of the report can verify the integrity of the attached
           * HAR file.
           */
          harInteractionMd5?: string;
      }
);

export type GenerateOptionsComplaintCommon = {
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
};

/** Options for generating a formal complaint for mobile devices using the {@link generate} function. */
export type GenerateOptionsComplaintFormalMobile = {
    /**
     * The type of document to generate, with the following possible values:
     *
     * - `complaint`: Generate a complaint to a data protection authority.
     */
    type: 'complaint';
    /**
     * Which toolchain collected the HAR, with the following possible values:
     *
     * - `web` for HARs originating from the TweaselForWeb addon.
     * - `mobile` for HARs collected using the Tweasel mobile toolchain.
     */
    analysisSource: 'mobile';
    /** Additional metadata for formal complaints. */
    complaintOptions: ComplaintOptionsInformal & ComplaintOptionsFormalMobile;
} & GenerateOptionsComplaintCommon;

/** Options for generating a formal complaint for websites using the {@link generate} function. */
export type GenerateOptionsComplaintFormalWeb = {
    /**
     * The type of document to generate, with the following possible values:
     *
     * - `complaint`: Generate a complaint to a data protection authority.
     */
    type: 'complaint';
    /**
     * Which toolchain collected the HAR, with the following possible values:
     *
     * - `web` for HARs originating from the TweaselForWeb addon.
     * - `mobile` for HARs collected using the Tweasel mobile toolchain.
     */
    analysisSource: 'web';
    /** Additional metadata for formal complaints. */
    complaintOptions: ComplaintOptionsInformal & ComplaintOptionsFormalWeb;

    /**
     * The HAR containing the recorded network traffic where interaction with the website was allowed. Can be a tweasel
     * HAR with metadata. This option is disabled for the mobile toolchain.
     */
    harInteraction: TweaselHar;
    /**
     * The MD5 hash of the HAR file such that recipients of the report can verify the integrity of the attached HAR
     * file.
     */
    harInteractionMd5?: string;

    /**
     * The HAR containing the recorded network traffic of the initial analysis that the notice to the controller was
     * based on. Must be a tweasel HAR with metadata.
     */
    initialHarInteraction: TweaselHar;
    /**
     * The MD5 hash of the initial HAR file such that recipients of the report can verify the integrity of the attached
     * HAR file.
     */
    initialHarInteractionMd5?: string;
} & GenerateOptionsComplaintCommon;
/** Options for generating an informal complaint for mobile devices using the {@link generate} function. */
export type GenerateOptionsComplaintInformalMobile = {
    /**
     * The type of document to generate, with the following possible values:
     *
     * - `complaint-informal`: Generate an informal suggestion for investigation to a data protection authority.
     */
    type: 'complaint-informal';
    /**
     * Which toolchain collected the HAR, with the following possible values:
     *
     * - `web` for HARs originating from the TweaselForWeb addon.
     * - `mobile` for HARs collected using the Tweasel mobile toolchain.
     */
    analysisSource: 'mobile';

    /** Additional metadata for informal complaints. */
    complaintOptions: ComplaintOptionsInformal;
} & GenerateOptionsComplaintCommon;

/** Options for generating an informal complaint for websites using the {@link generate} function. */
export type GenerateOptionsComplaintInformalWeb = {
    /**
     * The type of document to generate, with the following possible values:
     *
     * - `complaint-informal`: Generate an informal suggestion for investigation to a data protection authority.
     */
    type: 'complaint-informal';
    /**
     * Which toolchain collected the HAR, with the following possible values:
     *
     * - `web` for HARs originating from the TweaselForWeb addon.
     * - `mobile` for HARs collected using the Tweasel mobile toolchain.
     */
    analysisSource: 'web';

    /** Additional metadata for informal complaints. */
    complaintOptions: ComplaintOptionsInformal;

    /**
     * The HAR containing the recorded network traffic where interaction with the website was allowed. Can be a tweasel
     * HAR with metadata. This option is disabled for the mobile toolchain.
     */
    harInteraction: TweaselHar;
    /**
     * The MD5 hash of the HAR file such that recipients of the report can verify the integrity of the attached HAR
     * file.
     */
    harInteractionMd5?: string;

    /**
     * The HAR containing the recorded network traffic of the initial analysis that the notice to the controller was
     * based on. Must be a tweasel HAR with metadata.
     */
    initialHarInteraction: TweaselHar;
    /**
     * The MD5 hash of the initial HAR file such that recipients of the report can verify the integrity of the attached
     * HAR file.
     */
    initialHarInteractionMd5?: string;
} & GenerateOptionsComplaintCommon;
/**
 * Options for the {@link generate} function.
 *
 * @remarks
 * The options type is a discriminated union based on the `type` property:
 *
 * - For `type: 'report' | 'notice'`, provide {@link GenerateOptionsDefault}.
 * - For `type: 'complaint'`, provide {@link GenerateOptionsComplaintFormal}.
 * - For `type: 'complaint-informal'`, provide {@link GenerateOptionsComplaintInformal}.
 */
export type GenerateOptions =
    | GenerateOptionsDefault
    | GenerateOptionsComplaintFormalWeb
    | GenerateOptionsComplaintFormalMobile
    | GenerateOptionsComplaintInformalMobile
    | GenerateOptionsComplaintInformalWeb;

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
    if (
        !('_tweasel' in options.har.log) ||
        ((options.type === 'complaint' || options.type === 'complaint-informal') &&
            !('_tweasel' in options.initialHar.log))
    )
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
            deviceType: har.log._tweasel.device.runTarget,
            platformVersion: har.log._tweasel.device.osVersion,
            platformBuildString: har.log._tweasel.device.osBuild,
            deviceManufacturer: har.log._tweasel.device.manufacturer,
            deviceModel: har.log._tweasel.device.model,
            har: har,
            harMd5,
            trackHarResult: trackHarResult,
            dependencies: har.log._tweasel.versions,
        };
    };

    let generateAdvancedOptions: Partial<GenerateAdvancedOptions> = {
        type: options.type,
        analysisSource: options.analysisSource,
        language: options.language,

        analysis: getAnalysisMeta(options.har, options.trackHarResult, options.harMd5),
    };

    if (options.type === 'complaint' || options.type === 'complaint-informal')
        generateAdvancedOptions = {
            ...generateAdvancedOptions,
            type: options.type as 'complaint-informal',
            language: options.language,

            analysis: getAnalysisMeta(options.har, options.trackHarResult, options.harMd5),
            initialAnalysis: getAnalysisMeta(options.initialHar, options.initialTrackHarResult, options.initialHarMd5),

            complaintOptions: options.complaintOptions,
        };
    else if (options.analysisSource === 'web')
        generateAdvancedOptions = {
            ...generateAdvancedOptions,
            analysisInteraction: getAnalysisMeta(
                options.harInteraction,
                options.trackHarResultInteraction,
                options.harInteractionMd5
            ),
        };

    return generateAdvanced(generateAdvancedOptions);
};

export type {
    Analysis,
    App,
    GenerateAdvancedOptionsComplaintFormalMobile,
    GenerateAdvancedOptionsComplaintFormalWeb,
    GenerateAdvancedOptionsComplaintInformalMobile,
    GenerateAdvancedOptionsComplaintInformalWeb,
    GenerateAdvancedOptionsDefault,
} from './lib/generate';
export { prepareTraffic, type PrepareTrafficOptions } from './lib/traffic';
export { supportedLanguages, templates, translations } from './lib/translations';
export {
    parseNetworkActivityReport,
    type IosAppPrivacyReportNetworkActivityEntry,
    type NetworkActivityReport,
    type TrackerControlNetworkTrafficExportEntry,
} from './lib/user-network-activity';
export {
    generateAdvanced,
    type ComplaintOptionsFormal,
    type ComplaintOptionsInformal,
    type GenerateAdvancedOptions,
    type SupportedLanguage,
};
