import Papa from 'papaparse';

/**
 * An entry in a network activity report, containing information about the hostnames that were contacted on the user's
 * device.
 */
export type NetworkActivityReport = {
    /** A unique index for this entry within the report. */
    index: number;
    /** The date and time the request occurred. */
    timestamp: Date;
    /** The hostname that was contacted. */
    hostname: string;
    /** The ID of the app that made the request. */
    appId: string;
}[];

/**
 * A network access as recorded in an iOS App Privacy Report.
 *
 * @see https://developer.apple.com/documentation/network/privacy_management/inspecting_app_activity_data#3845757
 */
export type IosAppPrivacyReportNetworkActivityEntry = {
    /** The domain of the network connection. */
    domain: string;
    /** The time of the first connection to this domain. */
    firstTimeStamp: string;
    /** The website that made the connection, if applicable. */
    context: string;
    /** The time of the most recent connection. */
    timeStamp: string;
    /**
     * When the associated value is `1`, the domain has been identified as potentially collecting information across
     * apps and sites, and potentially profiling users. A value of `2` means that the domain hasn’t been identified as
     * such.
     */
    domainType: 1 | 2;
    /** Whether the app (`AppInitiated`) or the user (`NonAppInitiated`) initiated the connection. */
    initiatedType: 'AppInitiated' | 'NonAppInitiated';
    /** The number of times the app contacted the domain in the last seven days. */
    hits: number;
    /** An associated value of `networkActivity` means that this dictionary describes network activity data. */
    type: 'networkActivity';
    /** The owner of the domain, if applicable. */
    domainOwner: string;
    /** The bundle identifier of the initiating app. */
    bundleID: string;
};

/** An entry in a network traffic export from the Tracker Control app on Android. */
export type TrackerControlNetworkTrafficExportEntry = {
    uid: string;
    daddr: string;
    time: string;
    uncertain: string;
    Tracker: string;
    Category: string;
    Package: string;
    App: string;
};

/**
 * Parse a network activity report from the iOS App Privacy Report or Tracker Control on Android into a standardized
 * {@link NetworkActivityReport} format.
 *
 * @param type The type/format of the input report, with the following possible values:
 *
 *   - `ios-app-privacy-report-ndjson`: A report exported from the iOS App Privacy Report feature, in NDJSON format.
 *   - `tracker-control-csv`: A CSV export of the network traffic log from the Tracker Control Android app.
 *
 * @param report The report to parse.
 *
 * @returns The parsed report as a {@link NetworkActivityReport}.
 */
export const parseNetworkActivityReport = (
    type: 'ios-app-privacy-report-ndjson' | 'tracker-control-csv',
    report: string
): NetworkActivityReport => {
    report = report.trim();

    if (type === 'ios-app-privacy-report-ndjson')
        return report
            .split('\n')
            .map((e) => JSON.parse(e) as IosAppPrivacyReportNetworkActivityEntry)
            .filter((e) => e.type === 'networkActivity')
            .map((e, index) => ({
                index,
                timestamp: new Date(e.timeStamp),
                hostname: e.domain,
                appId: e.bundleID,
            }));

    if (type === 'tracker-control-csv')
        return (Papa.parse(report, { header: true }).data as TrackerControlNetworkTrafficExportEntry[]).map(
            (e, index) => ({
                index,
                timestamp: new Date(+e.time),
                hostname: e.daddr,
                appId: e.Package,
            })
        );

    throw new Error(`Unknown type: ${type}`);
};
