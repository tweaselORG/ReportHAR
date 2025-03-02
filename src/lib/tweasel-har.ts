import type { Har } from 'har-format';

// Vendored from cyanoacrylate.

/**
 * A HAR file with additional tweasel metadata containing information about the analysis that the traffic was collected
 * through.
 */
export type TweaselHar = Har & {
    log: {
        /** Metadata about the traffic collection. */
        _tweasel: TweaselHarMetaV2;
    };
};
/** Metadata about the traffic collection as included in a {@link TweaselHar}. */
export type TweaselHarMetaV2 = {
    /** The time and date at which the traffic collection was started. */
    startDate: string;
    /** The time and date at which the traffic collection was stopped. */
    endDate: string;
    /** The options that were used for the traffic collection. */
    options?: TrafficCollectionOptions;
    /** Details about the device that the analysis was run on. */
    device: Device;
    /** The versions of the dependencies used in the analysis. */
    versions: Record<string, string>;
    /**
     * Details about the app(s) that was/were analyzed. Currently only populated if the traffic was recorded through an
     * app analysis.
     */
    apps?: App[];
    /** Duration in milliseconds for how long the analysis target is guaranteed to have not been interacted with. */
    periodWithoutInteraction?: number;
    /**
     * The version of the tweasel-specific metadata format. Currently, `1.0` is the only version. If the format is ever
     * changed or extended in the future, this version will be incremented.
     */
    metaVersion: '2.0';
};

/** Metadata about the traffic collection as included in a {@link TweaselHar}. */
export type TweaselHarMetaV1 = {
    /** The time and date at which the traffic collection was started. */
    startDate: string;
    /** The time and date at which the traffic collection was stopped. */
    endDate: string;
    /** The options that were used for the traffic collection. */
    options: TrafficCollectionOptions;
    /** Details about the device that the analysis was run on. */
    device: Device;
    /** The versions of the dependencies used in the analysis. */
    versions: Record<string, string>;
    /**
     * Details about the app(s) that was/were analyzed. Currently only populated if the traffic was recorded through an
     * app analysis.
     */
    apps?: App[];
    /**
     * The version of the tweasel-specific metadata format. Currently, `1.0` is the only version. If the format is ever
     * changed or extended in the future, this version will be incremented.
     */
    metaVersion: '1.0';
};
/**
 * Options for a traffic collection that specifies which apps to collect traffic from.
 *
 * - `mode: 'all-apps'`: Collect traffic from all apps.
 * - `mode: 'allowlist'`: Collect traffic only from the apps with the app IDs in the `apps` array.
 * - `mode: 'denylist'`: Collect traffic from all apps except the apps with the app IDs in the `apps` array.
 */
export type TrafficCollectionOptions =
    | {
          mode: 'all-apps';
      }
    | {
          mode: 'allowlist' | 'denylist';
          apps: string[];
      };
/** Metadata about the device the analysis was run on. */
export type Device = {
    /** The device's operating system. */
    platform: SupportedPlatform;
    /** The type of device (emulator, physical device). */
    runTarget: SupportedRunTarget<SupportedPlatform>;
    /** The version of the OS. */
    osVersion: string;
    /** The build string of the OS. */
    osBuild?: string;
    /** The device's manufacturer. */
    manufacturer?: string;
    /** The device's model. */
    model?: string;
    /** The device's model code name. */
    modelCodeName?: string;
    /** Architectures/ABIs supported by the device. */
    architectures: string;
};
/** Metadata about an app. */
export type App = {
    /** The platform the app is for. */
    platform: SupportedPlatform;
    /** The app/bundle ID. */
    id: string;
    /** The app's display name. */
    name?: string;
    /** The app's human-readable version. */
    version?: string;
    /** The app's version code. */
    versionCode?: string;
    /**
     * A list of the architectures that the app supports. The identifiers for the architectures are normalized across
     * Android and iOS.
     *
     * On Android, this will be empty for apps that don't have native code.
     */
    architectures: ('arm64' | 'arm' | 'x86' | 'x86_64' | 'mips' | 'mips64')[];
    /**
     * The MD5 hash of the app's package file.
     *
     * In the case of split APKs on Android, this will be the hash of the main APK. In the case of custom APK bundle
     * formats (`.xapk`, `.apkm` and `.apks`), this will be the hash of the entire bundle.
     *
     * **Be careful when interpreting this value.** App stores can deliver different distributions of the exact same
     * app. For example, apps downloaded from the App Store on iOS include the user's Apple ID, thus leading to
     * different hashes even if different users download the very same version of the same app.
     */
    md5?: string;
};
/** A platform that is supported by this library. */
export type SupportedPlatform = 'android' | 'ios';
/** A run target that is supported by this library for the given platform. */
export type SupportedRunTarget<Platform extends SupportedPlatform> = Platform extends 'android'
    ? 'emulator' | 'device'
    : Platform extends 'ios'
    ? 'device'
    : never;
