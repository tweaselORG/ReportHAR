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

    /** Information about the analyzed app. */
    app: App;
    /** The operating system version of the device/emulator the analysis was performed on. */
    platformVersion: string;

    /** The recorded network traffic in HAR format. */
    har: Har;
    /**
     * The MD5 hash of the HAR file such that recipients of the report can verify the integrity of the attached HAR
     * file.
     */
    harMd5?: string;

    /** The [TrackHAR](https://github.com/tweaselORG/TrackHAR) analysis results for the HAR. */
    trackHarResult: ReturnType<typeof processRequest>[];
};
/** Additional information required for generating a complaint to a data protection authority. */
export type ComplaintOptions = {
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
     * - `TTDSG`: Germany.
     */
    nationalEPrivacyLaw: 'TTDSG' | false;

    /** The complainant's postal address. */
    complainantAddress: string;
    /** The controller's postal address. */
    controllerAddress: string;
    /** The URL of the source where the controller's postal address was found. */
    controllerAddressSourceUrl: string;

    /** The app store the app was installed through on the user's device. */
    userDeviceAppStore: string;
    /** Whether the user is logged into this app store account on their device. */
    loggedIntoAppStore: boolean;
    /** Whether the user's device has a SIM card registered to them. */
    deviceHasRegisteredSimCard: boolean;

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

    /**
     * A report of the user's network activity, as recorded using the iOS App Privacy Report or Tracker Control on
     * Android. This is used to prove that the user's device actually sent requests to the relevant trackers.
     *
     * Parse the raw exports from the platforms into the correct format using {@link parseNetworkActivityReport}.
     */
    userNetworkActivity: NetworkActivityReport;
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

    /** Information about the network traffic analyis that the document should be based on. */
    analysis: Analysis;
};
/** Options for generating a complaint using the {@link generateAdvanced} function. */
export type GenerateAdvancedOptionsComplaint = {
    /**
     * The type of document to generate, with the following possible values:
     *
     * - `complaint`: Generate a complaint to a data protection authority.
     */
    type: 'complaint';
    /** The language the generated document should be in. */
    language: SupportedLanguage;

    /** Information about the initial network traffic analyis that the notice to the controller was based on. */
    initialAnalysis: Analysis;
    /** Information about the second network traffic analyis that will be the basis for the complaint. */
    analysis: Analysis;

    /** Additional metadata for complaints. */
    complaintOptions: ComplaintOptions;
};
/**
 * Options for the {@link generateAdvanced} function.
 *
 * @remarks
 * The options type is a discriminated union based on the `type` property:
 *
 * - For `type: 'report' | 'notice'`, provide {@link GenerateAdvancedOptionsDefault}.
 * - For `type: 'complaint'`, provide {@link GenerateAdvancedOptionsComplaint}.
 */
export type GenerateAdvancedOptions = GenerateAdvancedOptionsDefault | GenerateAdvancedOptionsComplaint;

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

    // Render Nunjucks template.
    const typSource = renderNunjucks({
        template: templates[options.language][options.type],
        language: options.language,
        context: {
            analysis: options.analysis,
            initialAnalysis: options.type === 'complaint' && options.initialAnalysis,
            complaintOptions: options.type === 'complaint' && options.complaintOptions,
            harEntries,
            trackHarResult,
            findings,
        },
    });

    // Compile Typst to PDF.
    return compileTypst({
        mainContent: typSource,
        additionalFiles: {
            '/style.typ': templates[options.language].style,
            ...(options.type === 'report' && {
                '/har.typ': generateTypForHar(
                    harEntries
                        .map((e, index) => ({ ...e, index }))
                        .filter((e) => trackHarResult.some((r) => r.harIndex === e.index)),
                    { includeResponses: false, truncateContent: 4096 }
                ),
            }),
        },
    });
};
