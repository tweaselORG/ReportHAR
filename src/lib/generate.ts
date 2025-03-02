import type { Har } from 'har-format';
import { type processRequest } from 'trackhar';
import { generateTyp as generateTypForHar } from './har2pdf';
import { renderNunjucks } from './nunjucks';
import { prepareTraffic, type PrepareTrafficOptions } from './traffic';
import { templates, type SupportedLanguage } from './translations';
import { compileTypst } from './typst';
import type { NetworkActivityReport } from './user-network-activity';

/** Information about an app. */
export type App = {
    /** The app's ID, i.e. the bundle ID on iOS or package name on Android. */
    id: string;
    /** The app's user-facing name. */
    name: string;
    /** The version of the app that was analyzed. */
    version: string;
    /** The URL to the app's store page, if available. */
    url?: string;
    /** The app store the app is distributed through, if applicable. */
    store?: 'Google Play Store' | 'Apple App Store';

    /** The platform the app runs on. */
    platform: 'Android' | 'iOS';
};
/** Information about a network traffic analysis that was performed. */
export type Analysis = {
    /** The date and time the analysis was performed. */
    date: Date;

    /** Whether the analysis was run on an emulator or a physical device. */
    deviceType: 'device' | 'emulator';
    /** The operating system of the device/emulator the analysis as performed on. */
    platform: string;
    /** The operating system version of the device/emulator the analysis was performed on. */
    platformVersion: string;
    /** The OS build string of the device/emulator the analysis was performed on. */
    platformBuildString?: string;
    /** The manufacturer of the device/emulator the analysis was performed on. */
    deviceManufacturer?: string;
    /** The model of the device/emulator the analysis was performed on. */
    deviceModel?: string;

    /** The recorded network traffic in HAR format. */
    har: Har;
    /**
     * The MD5 hash of the HAR file such that recipients of the report can verify the integrity of the attached HAR
     * file.
     */
    harMd5?: string;

    /** The [TrackHAR](https://github.com/tweaselORG/TrackHAR) analysis results for the HAR. */
    trackHarResult: ReturnType<typeof processRequest>[];

    /** The versions of the dependencies used in the analysis. */
    dependencies: Record<string, string>;
} & (
    | {
          /** Information about the analyzed app. */
          app: App;
          /**
           * Which toolchain collected the HAR, with the following possible values:
           *
           * - `web` for HARs originating from the TweaselForWeb addon.
           * - `mobile` for HARs collected using the Tweasel mobile toolchain.
           */
          source: 'mobile';
      }
    | {
          /**
           * Which toolchain collected the HAR, with the following possible values:
           *
           * - `web` for HARs originating from the TweaselForWeb addon.
           * - `mobile` for HARs collected using the Tweasel mobile toolchain.
           */
          source: 'web';
          /** Information about the analyzed website. */
          website: {
              /** The name or title of the website. */
              name: string;
              /** The full URL of the specific (sub-)page which was analyzed. */
              url: string;
          };
          /** Duration in milliseconds for how long the website is guaranteed to have not been interacted with. */
          periodWithoutInteraction: number;
          /** The name of the browser the analysis was done in. */
          browser: string;
          /** The version of the browser the analysis was done in. */
          browserVersion: string;
          /** Name of the addon the traffic was collect with. */
          addonName: string;
          /** Version of the addon the traffic was collect with. */
          addonVersion: string;
      }
);
/** Additional information required for generating an informal complaint to a data protection authority. */
export type ComplaintOptionsInformal = {
    /** The date the complaint is being made. */
    date: Date;
    /** The complaint's reference number, to be used in any further communication about this complaint. */
    reference: string;

    /** The date the notice to the controller was sent. */
    noticeDate: Date;

    /**
     * If the complaint should also reference the ePrivacy directive, the name of the national law implementing it.
     * Supported values:
     *
     * - `TDDDG`: Germany (previously TTDSG).
     */
    nationalEPrivacyLaw: 'TDDDG' | false;

    /** The complainant's postal address. */
    complainantAddress: string;
    /** The controller's postal address. */
    controllerAddress: string;
    /** The URL of the source where the controller's postal address was found. */
    controllerAddressSourceUrl: string;

    /**
     * How the controller responded to the notice, with the following possible values:
     *
     * - `none`: The controller did not respond.
     * - `denial`: The controller denied the claims made in the notice.
     * - `broken-promise`: The controller promised to make changes, but did not actually do so.
     */
    controllerResponse: 'none' | 'denial' | 'broken-promise';

    /** The complainant's contact details, e.g. email address. */
    complainantContactDetails: string;
    /** Whether the complainant agrees to the DPA communicating with them via unencrypted email. */
    complainantAgreesToUnencryptedCommunication: boolean;
};
/** Additional information for formal complaints about mobile apps to a data protection authority. */
export type ComplaintOptionsFormalMobile = {
    /** The app store the app was installed through on the user's device. */
    userDeviceAppStore?: string;
    /** Whether the user is logged into this app store account on their device. */
    loggedIntoAppStore: boolean;
    /** Whether the user's device has a SIM card registered to them. */
    deviceHasRegisteredSimCard: boolean;

    /**
     * A report of the user's network activity, as recorded using the iOS App Privacy Report or Tracker Control on
     * Android. This is used to prove that the user's device actually sent requests to the relevant trackers.
     *
     * Parse the raw exports from the platforms into the correct format using {@link parseNetworkActivityReport}.
     */
    userNetworkActivity: NetworkActivityReport;
};
/** Additional information for formal complaints about websites to a data protection authority. */
export type ComplaintOptionsFormalWeb = {
    /** True, if the user assures that during the interaction they did not knowingly consent to tracking. */
    interactionNoConsent?: boolean;
};

/** Options for generating a report or controller notice using the {@link generateAdvanced} function. */
export type GenerateAdvancedOptionsDefault = {
    /**
     * The type of document to generate, with the following possible values:
     *
     * - `report`: Generate a technical report.
     * - `notice`: Generate a notice to the controller.
     */
    type: 'report' | 'notice';

    /** The language the generated document should be in. */
    language: SupportedLanguage;

    /** Information about the network traffic analysis that the document should be based on. */
    analysis: Analysis;
} & (
    | {
          /**
           * Which toolchain collected the HAR, with the following possible values:
           *
           * - `web` for HARs originating from the TweaselForWeb addon.
           * - `mobile` for HARs collected using the Tweasel mobile toolchain.
           */
          analysisSource: 'web';
          /**
           * Information about the network traffic analysis which might contain interaction triggered traffic that will
           * be the basis for the complaint.
           */
          analysisInteraction: Analysis;
      }
    | {
          /**
           * Which toolchain collected the HAR, with the following possible values:
           *
           * - `web` for HARs originating from the TweaselForWeb addon.
           * - `mobile` for HARs collected using the Tweasel mobile toolchain.
           */
          analysisSource: 'mobile';
      }
);

/** Options for generating a formal complaint for mobiles apps using the {@link generateAdvanced} function. */
export type GenerateAdvancedOptionsComplaintFormalMobile = {
    /**
     * The type of document to generate, with the following possible values:
     *
     * - `complaint`: Generate a formal complaint to a data protection authority.
     */
    type: 'complaint';
    /**
     * Which toolchain collected the HAR, with the following possible values:
     *
     * - `web` for HARs originating from the TweaselForWeb addon.
     * - `mobile` for HARs collected using the Tweasel mobile toolchain.
     */
    analysisSource: 'mobile';
    /** The language the generated document should be in. */
    language: SupportedLanguage;

    /** Information about the initial network traffic analyis that the notice to the controller was based on. */
    initialAnalysis: Analysis;
    /** Information about the second network traffic analyis that will be the basis for the complaint. */
    analysis: Analysis;

    /** Additional metadata for formal complaints. */
    complaintOptions: ComplaintOptionsInformal & ComplaintOptionsFormalMobile;
};

/** Options for generating a formal complaint for websites using the {@link generateAdvanced} function. */
export type GenerateAdvancedOptionsComplaintFormalWeb = {
    /**
     * The type of document to generate, with the following possible values:
     *
     * - `complaint`: Generate a formal complaint to a data protection authority.
     */
    type: 'complaint';
    /**
     * Which toolchain collected the HAR, with the following possible values:
     *
     * - `web` for HARs originating from the TweaselForWeb addon.
     * - `mobile` for HARs collected using the Tweasel mobile toolchain.
     */
    analysisSource: 'web';
    /** The language the generated document should be in. */
    language: SupportedLanguage;

    /** Information about the initial network traffic analysis that the notice to the controller was based on. */
    initialAnalysis: Analysis;
    /**
     * Information about the initial network traffic analysis which might contain interaction triggered traffic that the
     * notice to the controller was based on.
     */
    initialAnalysisInteraction: Analysis;
    /** Information about the second network traffic analysis that will be the basis for the complaint. */
    analysis: Analysis;
    /**
     * Information about the second network traffic analysis which might contain interaction triggered traffic that will
     * be the basis for the complaint.
     */
    analysisInteraction: Analysis;

    /** Additional metadata for formal complaints. */
    complaintOptions: ComplaintOptionsInformal & ComplaintOptionsFormalWeb;
};

/** Options for generating a formal or in informal complaint using the {@link generateAdvanced} function. */
export type GenerateAdvancedOptionsComplaintInformalMobile = {
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
    /** The language the generated document should be in. */
    language: SupportedLanguage;

    /** Information about the initial network traffic analyis that the notice to the controller was based on. */
    initialAnalysis: Analysis;
    /** Information about the second network traffic analyis that will be the basis for the complaint. */
    analysis: Analysis;

    /** Additional metadata for complaints. */
    complaintOptions: ComplaintOptionsInformal;
};

/** Options for generating a formal or in informal complaint using the {@link generateAdvanced} function. */
export type GenerateAdvancedOptionsComplaintInformalWeb = {
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
    /** The language the generated document should be in. */
    language: SupportedLanguage;

    /** Information about the initial network traffic analysis that the notice to the controller was based on. */
    initialAnalysis: Analysis;
    /**
     * Information about the initial network traffic analysis which might contain interaction triggered traffic that the
     * notice to the controller was based on.
     */
    initialAnalysisInteraction: Analysis;
    /** Information about the second network traffic analysis that will be the basis for the complaint. */
    analysis: Analysis;
    /**
     * Information about the second network traffic analysis which might contain interaction triggered traffic that will
     * be the basis for the complaint.
     */
    analysisInteraction: Analysis;

    /** Additional metadata for complaints. */
    complaintOptions: ComplaintOptionsInformal;
};
/**
 * Options for the {@link generateAdvanced} function.
 *
 * @remarks
 * The options type is a discriminated union based on the `type` property:
 *
 * - For `type: 'report' | 'notice'`, provide {@link GenerateAdvancedOptionsDefault}.
 * - For `type: 'complaint'`, provide {@link GenerateAdvancedOptionsComplaintFormal}.
 * - For `type: 'complaint-informal'`, provide {@link GenerateAdvancedOptionsComplaintInformal}.
 */
export type GenerateAdvancedOptions =
    | GenerateAdvancedOptionsDefault
    | GenerateAdvancedOptionsComplaintFormalMobile
    | GenerateAdvancedOptionsComplaintFormalWeb
    | GenerateAdvancedOptionsComplaintInformalMobile
    | GenerateAdvancedOptionsComplaintInformalWeb;

/**
 * Generate a technical report, controller notice or DPA complaint based on a network traffic analysis, manually
 * specifying all metadata.
 *
 * @remarks
 * If the analysis was performed using tweasel tools, you can instead use {@link generate} to have the metadata
 * automatically extracted from the tweasel HAR file.
 * @param options The options specifying what to generate.
 *
 * @returns The generated document as a PDF file.
 */
export const generateAdvanced = (options: GenerateAdvancedOptions) => {
    // Prepare traffic.
    const prepareTrafficOptions: PrepareTrafficOptions = {
        har: options.analysis.har,
        trackHarResult: options.analysis.trackHarResult,
    };
    if (options.type === 'complaint' && options.analysisSource === 'mobile') {
        options.complaintOptions.userNetworkActivity = options.complaintOptions.userNetworkActivity.filter(
            (e) => e.appId === undefined || options.analysis.source !== 'mobile' || e.appId === options.analysis.app.id
        );

        // For complaints, only consider results from adapters for which we know that the user's device contacted at
        // least one matching hostname.
        prepareTrafficOptions.entryFilter = (entry) => {
            const hostname = entry.harEntry?.request.host;
            if (!hostname) return false;

            return options.complaintOptions.userNetworkActivity.some((e) => e.hostname === hostname);
        };
    }
    const { harEntries, trackHarResult, findings } = prepareTraffic(prepareTrafficOptions);

    let nunjucksContext: Record<string, unknown> = {
        type: options.type,
        analysis: options.analysis,
        initialAnalysis:
            (options.type === 'complaint' || options.type === 'complaint-informal') && options.initialAnalysis,
        complaintOptions:
            (options.type === 'complaint' || options.type === 'complaint-informal') && options.complaintOptions,
        harEntries,
        trackHarResult,
        findings,
    };

    const additionalFiles: Record<string, string> = {
        '/style.typ': templates[options.analysisSource][options.language].style,
        ...(options.type === 'report' && {
            '/har.typ': generateTypForHar(
                harEntries
                    .map((e, index) => ({ ...e, index }))
                    .filter((e) => trackHarResult.some((r) => r.harIndex === e.index)),
                {
                    includeResponses: false,
                    truncateContent: 4096,
                    language: options.language,
                    topHeadingLevel: options.analysisSource === 'web' ? 3 : 2,
                }
            ),
        }),
    };

    if (options.analysisSource === 'web') {
        const {
            harEntries: harEntriesInteraction,
            trackHarResult: trackHarResultInteraction,
            findings: findingsInteraction,
        } = prepareTraffic({
            har: options.analysisInteraction.har,
            trackHarResult: options.analysisInteraction.trackHarResult,
        });

        nunjucksContext = {
            ...nunjucksContext,
            harEntriesInteraction,
            trackHarResultInteraction,
            findingsInteraction,
            analysisInteraction: options.analysisInteraction,
        };

        if (options.type === 'report')
            additionalFiles['/har-interaction.typ'] = generateTypForHar(
                harEntriesInteraction
                    .map((e, index) => ({ ...e, index }))
                    .filter((e) => trackHarResultInteraction.some((r) => r.harIndex === e.index)),
                {
                    includeResponses: false,
                    truncateContent: 4096,
                    language: options.language,
                    topHeadingLevel: 3,
                    key: 'interaction',
                }
            );
    }

    // Render Nunjucks template.
    const typSource = renderNunjucks({
        template:
            templates[options.analysisSource][options.language][
                options.type === 'complaint' || options.type === 'complaint-informal' ? 'complaint' : options.type
            ],
        language: options.language,
        context: nunjucksContext,
    });

    // Compile Typst to PDF.
    return compileTypst({
        mainContent: typSource,
        additionalFiles,
    });
};
