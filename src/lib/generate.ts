import type { Har } from 'har-format';
import { type processRequest } from 'trackhar';
import { generateTyp as generateTypForHar } from './har2pdf';
import { renderNunjucks } from './nunjucks';
import { prepareTraffic, type PrepareTrafficOptions } from './traffic';
import { templates, type SupportedLanguage } from './translations';
import { compileTypst } from './typst';
import type { NetworkActivityReport } from './user-network-activity';

export type App = {
    id: string;
    name: string;
    version: string;
    url?: string;
    store?: 'Google Play Store' | 'Apple App Store';

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
    controllerAddressSourceUrl: string;

    userDeviceAppStore: string;
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
          language: SupportedLanguage;

          analysis: Analysis;
      }
    | {
          type: 'complaint';
          language: SupportedLanguage;

          /** Data for the initial analysis, that the notice to the controller was based on. */
          initialAnalysis: Analysis;
          /** Data for the second analysis, that will be the basis for the complaint. */
          analysis: Analysis;
          complaintOptions: ComplaintOptions;
      };

export const generate = (options: GenerateOptions) => {
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