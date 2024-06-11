reporthar

# reporthar

## Table of contents

### Type Aliases

- [Analysis](README.md#analysis)
- [App](README.md#app)
- [ComplaintOptionsFormal](README.md#complaintoptionsformal)
- [ComplaintOptionsInformal](README.md#complaintoptionsinformal)
- [GenerateAdvancedOptions](README.md#generateadvancedoptions)
- [GenerateAdvancedOptionsComplaintFormal](README.md#generateadvancedoptionscomplaintformal)
- [GenerateAdvancedOptionsComplaintInformal](README.md#generateadvancedoptionscomplaintinformal)
- [GenerateAdvancedOptionsDefault](README.md#generateadvancedoptionsdefault)
- [GenerateOptions](README.md#generateoptions)
- [GenerateOptionsComplaintFormal](README.md#generateoptionscomplaintformal)
- [GenerateOptionsComplaintInformal](README.md#generateoptionscomplaintinformal)
- [GenerateOptionsDefault](README.md#generateoptionsdefault)
- [IosAppPrivacyReportNetworkActivityEntry](README.md#iosappprivacyreportnetworkactivityentry)
- [NetworkActivityReport](README.md#networkactivityreport)
- [SupportedLanguage](README.md#supportedlanguage)
- [TrackerControlNetworkTrafficExportEntry](README.md#trackercontrolnetworktrafficexportentry)

### Variables

- [supportedLanguages](README.md#supportedlanguages)
- [templates](README.md#templates)
- [translations](README.md#translations)

### Functions

- [generate](README.md#generate)
- [generateAdvanced](README.md#generateadvanced)
- [parseNetworkActivityReport](README.md#parsenetworkactivityreport)

## Type Aliases

### Analysis

Ƭ **Analysis**: `Object`

Information about a network traffic analysis that was performed.

#### Type declaration

| Name | Type | Description |
| :------ | :------ | :------ |
| `app` | [`App`](README.md#app) | Information about the analyzed app. |
| `date` | `Date` | The date and time the analysis was performed. |
| `dependencies` | `Record`<`string`, `string`\> | The versions of the dependencies used in the analysis. |
| `har` | `Har` | The recorded network traffic in HAR format. |
| `harMd5?` | `string` | The MD5 hash of the HAR file such that recipients of the report can verify the integrity of the attached HAR file. |
| `platformVersion` | `string` | The operating system version of the device/emulator the analysis was performed on. |
| `trackHarResult` | `ReturnType`<typeof `processRequest`\>[] | The [TrackHAR](https://github.com/tweaselORG/TrackHAR) analysis results for the HAR. |

#### Defined in

[src/lib/generate.ts:27](https://github.com/tweaselORG/complaint-generator/blob/main/src/lib/generate.ts#L27)

___

### App

Ƭ **App**: `Object`

Information about an app.

#### Type declaration

| Name | Type | Description |
| :------ | :------ | :------ |
| `id` | `string` | The app's ID, i.e. the bundle ID on iOS or package name on Android. |
| `name` | `string` | The app's user-facing name. |
| `platform` | ``"Android"`` \| ``"iOS"`` | The platform the app runs on. |
| `store?` | ``"Google Play Store"`` \| ``"Apple App Store"`` | The app store the app is distributed through, if applicable. |
| `url?` | `string` | The URL to the app's store page, if available. |
| `version` | `string` | The version of the app that was analyzed. |

#### Defined in

[src/lib/generate.ts:11](https://github.com/tweaselORG/complaint-generator/blob/main/src/lib/generate.ts#L11)

___

### ComplaintOptionsFormal

Ƭ **ComplaintOptionsFormal**: `Object`

Additional information for formal complaints to a data protection authority.

#### Type declaration

| Name | Type | Description |
| :------ | :------ | :------ |
| `deviceHasRegisteredSimCard` | `boolean` | Whether the user's device has a SIM card registered to them. |
| `loggedIntoAppStore` | `boolean` | Whether the user is logged into this app store account on their device. |
| `userDeviceAppStore?` | `string` | The app store the app was installed through on the user's device. |
| `userNetworkActivity` | [`NetworkActivityReport`](README.md#networkactivityreport) | A report of the user's network activity, as recorded using the iOS App Privacy Report or Tracker Control on Android. This is used to prove that the user's device actually sent requests to the relevant trackers. Parse the raw exports from the platforms into the correct format using [parseNetworkActivityReport](README.md#parsenetworkactivityreport). |

#### Defined in

[src/lib/generate.ts:90](https://github.com/tweaselORG/complaint-generator/blob/main/src/lib/generate.ts#L90)

___

### ComplaintOptionsInformal

Ƭ **ComplaintOptionsInformal**: `Object`

Additional information required for generating an informal complaint to a data protection authority.

#### Type declaration

| Name | Type | Description |
| :------ | :------ | :------ |
| `complainantAddress` | `string` | The complainant's postal address. |
| `complainantAgreesToUnencryptedCommunication` | `boolean` | Whether the complainant agrees to the DPA communicating with them via unencrypted email. |
| `complainantContactDetails` | `string` | The complainant's contact details, e.g. email address. |
| `controllerAddress` | `string` | The controller's postal address. |
| `controllerAddressSourceUrl` | `string` | The URL of the source where the controller's postal address was found. |
| `controllerResponse` | ``"none"`` \| ``"denial"`` \| ``"broken-promise"`` | How the controller responded to the notice, with the following possible values: - `none`: The controller did not respond. - `denial`: The controller denied the claims made in the notice. - `broken-promise`: The controller promised to make changes, but did not actually do so. |
| `date` | `Date` | The date the complaint is being made. |
| `nationalEPrivacyLaw` | ``"TTDSG"`` \| ``false`` | If the complaint should also reference the ePrivacy directive, the name of the national law implementing it. Supported values: - `TTDSG`: Germany. |
| `noticeDate` | `Date` | The date the notice to the controller was sent. |
| `reference` | `string` | The complaint's reference number, to be used in any further communication about this complaint. |

#### Defined in

[src/lib/generate.ts:51](https://github.com/tweaselORG/complaint-generator/blob/main/src/lib/generate.ts#L51)

___

### GenerateAdvancedOptions

Ƭ **GenerateAdvancedOptions**: [`GenerateAdvancedOptionsDefault`](README.md#generateadvancedoptionsdefault) \| [`GenerateAdvancedOptionsComplaintFormal`](README.md#generateadvancedoptionscomplaintformal) \| [`GenerateAdvancedOptionsComplaintInformal`](README.md#generateadvancedoptionscomplaintinformal)

Options for the [generateAdvanced](README.md#generateadvanced) function.

**`Remarks`**

The options type is a discriminated union based on the `type` property:

- For `type: 'report' | 'notice'`, provide [GenerateAdvancedOptionsDefault](README.md#generateadvancedoptionsdefault).
- For `type: 'complaint'`, provide [GenerateAdvancedOptionsComplaintFormal](README.md#generateadvancedoptionscomplaintformal).
- For `type: 'complaint-informal'`, provide [GenerateAdvancedOptionsComplaintInformal](README.md#generateadvancedoptionscomplaintinformal).

#### Defined in

[src/lib/generate.ts:170](https://github.com/tweaselORG/complaint-generator/blob/main/src/lib/generate.ts#L170)

___

### GenerateAdvancedOptionsComplaintFormal

Ƭ **GenerateAdvancedOptionsComplaintFormal**: `Object`

Options for generating a formal complaint using the [generateAdvanced](README.md#generateadvanced) function.

#### Type declaration

| Name | Type | Description |
| :------ | :------ | :------ |
| `analysis` | [`Analysis`](README.md#analysis) | Information about the second network traffic analyis that will be the basis for the complaint. |
| `complaintOptions` | [`ComplaintOptionsInformal`](README.md#complaintoptionsinformal) & [`ComplaintOptionsFormal`](README.md#complaintoptionsformal) | Additional metadata for formal complaints. |
| `initialAnalysis` | [`Analysis`](README.md#analysis) | Information about the initial network traffic analyis that the notice to the controller was based on. |
| `language` | [`SupportedLanguage`](README.md#supportedlanguage) | The language the generated document should be in. |
| `type` | ``"complaint"`` | The type of document to generate, with the following possible values: - `complaint`: Generate a formal complaint to a data protection authority. |

#### Defined in

[src/lib/generate.ts:123](https://github.com/tweaselORG/complaint-generator/blob/main/src/lib/generate.ts#L123)

___

### GenerateAdvancedOptionsComplaintInformal

Ƭ **GenerateAdvancedOptionsComplaintInformal**: `Object`

Options for generating a formal or in informal complaint using the [generateAdvanced](README.md#generateadvanced) function.

#### Type declaration

| Name | Type | Description |
| :------ | :------ | :------ |
| `analysis` | [`Analysis`](README.md#analysis) | Information about the second network traffic analyis that will be the basis for the complaint. |
| `complaintOptions` | [`ComplaintOptionsInformal`](README.md#complaintoptionsinformal) | Additional metadata for complaints. |
| `initialAnalysis` | [`Analysis`](README.md#analysis) | Information about the initial network traffic analyis that the notice to the controller was based on. |
| `language` | [`SupportedLanguage`](README.md#supportedlanguage) | The language the generated document should be in. |
| `type` | ``"complaint-informal"`` | The type of document to generate, with the following possible values: - `complaint-informal`: Generate an informal suggestion for investigation to a data protection authority. |

#### Defined in

[src/lib/generate.ts:142](https://github.com/tweaselORG/complaint-generator/blob/main/src/lib/generate.ts#L142)

___

### GenerateAdvancedOptionsDefault

Ƭ **GenerateAdvancedOptionsDefault**: `Object`

Options for generating a report or controller notice using the [generateAdvanced](README.md#generateadvanced) function.

#### Type declaration

| Name | Type | Description |
| :------ | :------ | :------ |
| `analysis` | [`Analysis`](README.md#analysis) | Information about the network traffic analyis that the document should be based on. |
| `language` | [`SupportedLanguage`](README.md#supportedlanguage) | The language the generated document should be in. |
| `type` | ``"report"`` \| ``"notice"`` | The type of document to generate, with the following possible values: - `report`: Generate a technical report. - `notice`: Generate a notice to the controller. |

#### Defined in

[src/lib/generate.ts:108](https://github.com/tweaselORG/complaint-generator/blob/main/src/lib/generate.ts#L108)

___

### GenerateOptions

Ƭ **GenerateOptions**: [`GenerateOptionsDefault`](README.md#generateoptionsdefault) \| [`GenerateOptionsComplaintFormal`](README.md#generateoptionscomplaintformal) \| [`GenerateOptionsComplaintInformal`](README.md#generateoptionscomplaintinformal)

Options for the [generate](README.md#generate) function.

**`Remarks`**

The options type is a discriminated union based on the `type` property:

- For `type: 'report' | 'notice'`, provide [GenerateOptionsDefault](README.md#generateoptionsdefault).
- For `type: 'complaint'`, provide [GenerateOptionsComplaintFormal](README.md#generateoptionscomplaintformal).
- For `type: 'complaint-informal'`, provide [GenerateOptionsComplaintInformal](README.md#generateoptionscomplaintinformal).

#### Defined in

[src/index.ts:123](https://github.com/tweaselORG/complaint-generator/blob/main/src/index.ts#L123)

___

### GenerateOptionsComplaintFormal

Ƭ **GenerateOptionsComplaintFormal**: `Object`

Options for generating a formal complaint using the [generate](README.md#generate) function.

#### Type declaration

| Name | Type | Description |
| :------ | :------ | :------ |
| `complaintOptions` | [`ComplaintOptionsInformal`](README.md#complaintoptionsinformal) & [`ComplaintOptionsFormal`](README.md#complaintoptionsformal) | Additional metadata for formal complaints. |
| `har` | `TweaselHar` | The HAR containing the recorded network traffic of second analysis, that will be the basis for the complaint. Must be a tweasel HAR with metadata. |
| `harMd5?` | `string` | The MD5 hash of the second HAR file such that recipients of the report can verify the integrity of the attached HAR file. |
| `initialHar` | `TweaselHar` | The HAR containing the recorded network traffic of the initial analysis that the notice to the controller was based on. Must be a tweasel HAR with metadata. |
| `initialHarMd5?` | `string` | The MD5 hash of the initial HAR file such that recipients of the report can verify the integrity of the attached HAR file. |
| `initialTrackHarResult` | `ReturnType`<typeof `processRequest`\>[] | The [TrackHAR](https://github.com/tweaselORG/TrackHAR) analysis results for the initial HAR. |
| `language` | [`SupportedLanguage`](README.md#supportedlanguage) | The language the generated document should be in. |
| `trackHarResult` | `ReturnType`<typeof `processRequest`\>[] | The [TrackHAR](https://github.com/tweaselORG/TrackHAR) analysis results for the second HAR. |
| `type` | ``"complaint"`` | The type of document to generate, with the following possible values: - `complaint`: Generate a complaint to a data protection authority. |

#### Defined in

[src/index.ts:34](https://github.com/tweaselORG/complaint-generator/blob/main/src/index.ts#L34)

___

### GenerateOptionsComplaintInformal

Ƭ **GenerateOptionsComplaintInformal**: `Object`

Options for generating an informal complaint using the [generate](README.md#generate) function.

#### Type declaration

| Name | Type | Description |
| :------ | :------ | :------ |
| `complaintOptions` | [`ComplaintOptionsInformal`](README.md#complaintoptionsinformal) | Additional metadata for informal complaints. |
| `har` | `TweaselHar` | The HAR containing the recorded network traffic of second analysis, that will be the basis for the complaint. Must be a tweasel HAR with metadata. |
| `harMd5?` | `string` | The MD5 hash of the second HAR file such that recipients of the report can verify the integrity of the attached HAR file. |
| `initialHar` | `TweaselHar` | The HAR containing the recorded network traffic of the initial analysis that the notice to the controller was based on. Must be a tweasel HAR with metadata. |
| `initialHarMd5?` | `string` | The MD5 hash of the initial HAR file such that recipients of the report can verify the integrity of the attached HAR file. |
| `initialTrackHarResult` | `ReturnType`<typeof `processRequest`\>[] | The [TrackHAR](https://github.com/tweaselORG/TrackHAR) analysis results for the initial HAR. |
| `language` | [`SupportedLanguage`](README.md#supportedlanguage) | The language the generated document should be in. |
| `trackHarResult` | `ReturnType`<typeof `processRequest`\>[] | The [TrackHAR](https://github.com/tweaselORG/TrackHAR) analysis results for the second HAR. |
| `type` | ``"complaint-informal"`` | The type of document to generate, with the following possible values: - `complaint-informal`: Generate an informal suggestion for investigation to a data protection authority. |

#### Defined in

[src/index.ts:74](https://github.com/tweaselORG/complaint-generator/blob/main/src/index.ts#L74)

___

### GenerateOptionsDefault

Ƭ **GenerateOptionsDefault**: `Object`

Options for generating a report or controller notice using the [generate](README.md#generate) function.

#### Type declaration

| Name | Type | Description |
| :------ | :------ | :------ |
| `har` | `TweaselHar` | The HAR containing the recorded network traffic. Must be a tweasel HAR with metadata. |
| `harMd5?` | `string` | The MD5 hash of the HAR file such that recipients of the report can verify the integrity of the attached HAR file. |
| `language` | [`SupportedLanguage`](README.md#supportedlanguage) | The language the generated document should be in. |
| `trackHarResult` | `ReturnType`<typeof `processRequest`\>[] | The [TrackHAR](https://github.com/tweaselORG/TrackHAR) analysis results for the HAR. |
| `type` | ``"report"`` \| ``"notice"`` | The type of document to generate, with the following possible values: - `report`: Generate a technical report. - `notice`: Generate a notice to the controller. |

#### Defined in

[src/index.ts:12](https://github.com/tweaselORG/complaint-generator/blob/main/src/index.ts#L12)

___

### IosAppPrivacyReportNetworkActivityEntry

Ƭ **IosAppPrivacyReportNetworkActivityEntry**: `Object`

A network access as recorded in an iOS App Privacy Report.

**`See`**

https://developer.apple.com/documentation/network/privacy_management/inspecting_app_activity_data#3845757

#### Type declaration

| Name | Type | Description |
| :------ | :------ | :------ |
| `bundleID` | `string` | The bundle identifier of the initiating app. |
| `context` | `string` | The website that made the connection, if applicable. |
| `domain` | `string` | The domain of the network connection. |
| `domainOwner` | `string` | The owner of the domain, if applicable. |
| `domainType` | ``1`` \| ``2`` | When the associated value is `1`, the domain has been identified as potentially collecting information across apps and sites, and potentially profiling users. A value of `2` means that the domain hasn’t been identified as such. |
| `firstTimeStamp` | `string` | The time of the first connection to this domain. |
| `hits` | `number` | The number of times the app contacted the domain in the last seven days. |
| `initiatedType` | ``"AppInitiated"`` \| ``"NonAppInitiated"`` | Whether the app (`AppInitiated`) or the user (`NonAppInitiated`) initiated the connection. |
| `timeStamp` | `string` | The time of the most recent connection. |
| `type` | ``"networkActivity"`` | An associated value of `networkActivity` means that this dictionary describes network activity data. |

#### Defined in

[src/lib/user-network-activity.ts:28](https://github.com/tweaselORG/complaint-generator/blob/main/src/lib/user-network-activity.ts#L28)

___

### NetworkActivityReport

Ƭ **NetworkActivityReport**: { `appId`: `string` \| `undefined` ; `hostname`: `string` ; `index`: `number` ; `timestamp`: `Date`  }[]

An entry in a network activity report, containing information about the hostnames that were contacted on the user's
device.

#### Defined in

[src/lib/user-network-activity.ts:7](https://github.com/tweaselORG/complaint-generator/blob/main/src/lib/user-network-activity.ts#L7)

___

### SupportedLanguage

Ƭ **SupportedLanguage**: keyof typeof [`templates`](README.md#templates) & keyof typeof [`translations`](README.md#translations)

A language that translations and templates are available for.

#### Defined in

[src/lib/translations.ts:27](https://github.com/tweaselORG/complaint-generator/blob/main/src/lib/translations.ts#L27)

___

### TrackerControlNetworkTrafficExportEntry

Ƭ **TrackerControlNetworkTrafficExportEntry**: { `App`: `string` ; `Category`: `string` ; `Package`: `string` ; `Tracker`: `string` ; `daddr`: `string` ; `time`: `string` ; `uid`: `string` ; `uncertain`: `string`  } \| { `Tracker Category`: `string` ; `Tracker Name`: `string` ; `daddr`: `string` ; `time`: `string` ; `uncertain`: `string`  }

An entry in a network traffic export from the Tracker Control app on Android.

Exports across all apps contain more fields than exports for just one app.

#### Defined in

[src/lib/user-network-activity.ts:60](https://github.com/tweaselORG/complaint-generator/blob/main/src/lib/user-network-activity.ts#L60)

## Variables

### supportedLanguages

• `Const` **supportedLanguages**: ``"en"``[]

The languages that translations and templates are available for.

#### Defined in

[src/lib/translations.ts:22](https://github.com/tweaselORG/complaint-generator/blob/main/src/lib/translations.ts#L22)

___

### templates

• `Const` **templates**: `Object`

The Typst template files.

#### Type declaration

| Name | Type |
| :------ | :------ |
| `en` | { `complaint`: `string` ; `notice`: `string` ; `report`: `string` ; `style`: `string`  } |
| `en.complaint` | `string` |
| `en.notice` | `string` |
| `en.report` | `string` |
| `en.style` | `string` |

#### Defined in

[src/lib/translations.ts:12](https://github.com/tweaselORG/complaint-generator/blob/main/src/lib/translations.ts#L12)

___

### translations

• `Const` **translations**: `Object`

The string translations.

#### Type declaration

| Name | Type |
| :------ | :------ |
| `en` | { `properties`: { `accelerometerX`: `string` = "Accelerometer X"; `accelerometerY`: `string` = "Accelerometer Y"; `accelerometerZ`: `string` = "Accelerometer Z"; `appId`: `string` = "App ID"; `appName`: `string` = "App name"; `appVersion`: `string` = "App version"; `architecture`: `string` = "Architecture"; `batteryLevel`: `string` = "Battery level"; `carrier`: `string` = "Carrier"; `country`: `string` = "Country"; `deviceName`: `string` = "Device name"; `diskFree`: `string` = "Free disk space"; `diskTotal`: `string` = "Total disk space"; `diskUsed`: `string` = "Used disk space"; `hashedIdfa`: `string` = "Hashed device advertising ID"; `idfa`: `string` = "Device advertising ID (GAID/IDFA)"; `idfv`: `string` = "Developer-scoped device ID (IDFV/ASID/ANDROID\_ID)"; `installTime`: `string` = "App install time"; `isCharging`: `string` = "Charging status"; `isEmulator`: `string` = "Is device an emulator?"; `isFirstLaunch`: `string` = "Is first launch?"; `isInDarkMode`: `string` = "Is app in dark mode?"; `isInForeground`: `string` = "Is app in foreground?"; `isRoaming`: `string` = "Is device roaming?"; `isRooted`: `string` = "Is device rooted?"; `language`: `string` = "Language"; `latitude`: `string` = "Latitude"; `localIp`: `string` = "Local IP address(es)"; `longitude`: `string` = "Longitude"; `macAddress`: `string` = "MAC address"; `manufacturer`: `string` = "Manufacturer"; `model`: `string` = "Model"; `networkConnectionType`: `string` = "Network connection type"; `orientation`: `string` = "Orientation"; `osName`: `string` = "OS name"; `osVersion`: `string` = "OS version"; `otherIdentifiers`: `string` = "Other unique identifiers for the user, device, session, or installation"; `publicIp`: `string` = "Public IP address"; `pushNotificationToken`: `string` = "Push notification token"; `ramFree`: `string` = "Free RAM"; `ramTotal`: `string` = "Total RAM"; `ramUsed`: `string` = "Used RAM"; `referer`: `string` = "Referer"; `revenue`: `string` = "Earned revenue"; `rotationX`: `string` = "Rotation X"; `rotationY`: `string` = "Rotation Y"; `rotationZ`: `string` = "Rotation Z"; `screenHeight`: `string` = "Screen height"; `screenWidth`: `string` = "Screen width"; `signalStrengthCellular`: `string` = "Signal strength (cellular)"; `signalStrengthWifi`: `string` = "Signal strength (Wi-Fi)"; `startTime`: `string` = "App start time"; `state`: `string` = "State/Sub national entity"; `timeSpent`: `string` = "Time spent in app"; `timezone`: `string` = "Time zone"; `trackerSdkVersion`: `string` = "Tracker SDK version"; `uptime`: `string` = "Uptime"; `userAgent`: `string` = "User agent"; `viewedPage`: `string` = "Viewed page"; `volume`: `string` = "Volume" } ; `tracker-descriptions`: { `adjust`: `string` = "Adjust offers the following services:\n\n- User engagement tracking using events. “You can define in-app events for your app to measure user registrations, add-to-carts, or level ups, while setting up revenue events lets you record in-app purchases and transactions. Set up events to: See where your users go directly after install, Discover the app features your users like the most, Identify the last thing a user does before they become inactive”[https://help.adjust.com/en/article/add-events]\n- Mobile attribution, in order to “[i]dentify [the] best users and channels”.[https://www.adjust.com/product/mobile-app-attribution/] “Adjust's attribution matches your app users to the source that drove their install. You can use this attribution data to measure campaign performance, run effective retargeting campaigns, optimize your creative assets, and more.”[https://help.adjust.com/en/article/attribution-methods] Additionally, “Adjust can reattribute dormant users who engage with a new source and then return to [the] app.”[https://help.adjust.com/en/article/reattribution]\n\n  Adjust uses two attribution methods:\n    - “Deterministic attribution is Adjust's main attribution method and involves device matching. We collect a unique identifier from recorded engagements and installs, and if both IDs match, we can attribute that engagement to the install. With a 100% accuracy rate, click-based device matching is the most reliable attribution method. We use deterministic attribution to attribute installs (first app opens) and reattribute (assign new attribution sources to) inactive users. Adjust uses the following identifiers for deterministic attribution: Advertising IDs […], Device IDs […], Adjust reftags […]”[https://help.adjust.com/en/article/attribution-methods#deterministic-attribution]\n    - “Probabilistic modeling […] uses machine learning to support a statistical approach to measurement.”[https://help.adjust.com/en/article/attribution-methods#probabilistic-modeling]\n- Uninstall and reinstall tracking. “When a user installs [the] app, the app is given a unique push token which the Adjust SDK forwards to Adjust's servers. Silent push notifications are then sent once per day to check if the app is still installed.”[https://help.adjust.com/en/article/uninstalls-reinstalls]\n- Audience segmentation to “group users together based on […] criteria”.[https://www.adjust.com/product/audience-builder/]\n- Fraud prevention. “Organic users are captured accurately and not misattributed”.[https://www.adjust.com/product/fraud-prevention/]\n\nAdditionally, Adjust can pull in tracking data from partner companies.[https://help.adjust.com/en/article/partner-connections]"; `branch-io`: `string` = "Branch offers the following services:\n\n- Mobile attribution[https://www.branch.io/attribution/] to “[c]apture every customer touchpoint across any channel, platform, OS to optimize […] campaigns and maximize ROI.”[https://www.branch.io/features/]\n- Ad conversion tracking. Branch can “[r]etarget app users who see a web ad and then purchase in the app, attribute revenue to the web ad that drove the install, and measure cumulative revenue from users across both web and app.”[https://www.branch.io/universal-ads/]\n- Custom audiences to “communicate the perfect message to the ideal customer, at the right moment”. “Get higher return on ad spend (ROAS) with precision retargeting of high-value active users and eliminate wasted spend in your acquisition campaigns by excluding existing customers. Re-engage lapsed users, boost propensity to purchase, and increase sessions per user.”[https://www.branch.io/engagement-builder/]\n- Fraud protection.[https://www.branch.io/fraud-protection/]\n\nBranch provides integrations to automatically “send Branch data to […] marketing and analytics partners to measure and optimize […] campaigns.”[https://www.branch.io/data-feeds/]"; `branch-io-attribution-api`: `string` = "The Branch Attribution API is used for “deep linking and session attribution. […] Every time the API is called, it will track an INSTALL, REINSTALL, or OPEN event in Branch and return deep link data in the response if the session is attributed.”[https://help.branch.io/developers-hub/reference/attribution-api] It can also track “additional downstream conversion events” like PURCHASE.[https://help.branch.io/developers-hub/reference/attribution-api#tracking-downstream-events]"; `chartboost`: `string` = "Chartboost is an advertising platform focused on mobile gaming that caters to both publishers[https://www.chartboost.com/products/monetization/] and advertisers[https://www.chartboost.com/products/advertising/].\n\nChartboost supports mediation (real-time bidding)[https://www.chartboost.com/products/mediation/], analytics[https://docs.chartboost.com/en/mediation/analytics/], and A/B testing[https://docs.chartboost.com/en/mediation/ab-tests/]."; `facebook-audience-network`: `string` = "Meta Audience Network is a service by Facebook that allows app developers to monetize their apps with ads.[https://developers.facebook.com/docs/audience-network] Facebook offers Audience Network SDKs for Android[https://developers.facebook.com/docs/audience-network/setting-up/platform-setup/android/add-sdk], iOS[https://developers.facebook.com/docs/audience-network/setting-up/platform-setup/ios/add-sdk], and Unity[https://developers.facebook.com/docs/audience-network/setting-up/platform-steup/unity/add-sdk]."; `facebook-graph-app-events`: `string` = "The Graph API is provided by Facebook to “get data into and out of the Facebook platform”.[https://developers.facebook.com/docs/graph-api/overview] It can be accessed through the Facebook SDKs for Android[https://developers.facebook.com/docs/android/graph] and iOS[https://developers.facebook.com/docs/ios/graph].\n\nThe App Events endpoint allows developers to “track actions that occur in [a] mobile app or web page such as app installs and purchase events” in order to “measure ad performance and build audiences for ad targeting”. The Facebook SDK automatically logs app installs, app sessions, and in-app purchases using this endpoint. Additionally, developers can manually log their own events.[https://developers.facebook.com/docs/marketing-api/app-event-api]"; `firebaseinstallations`: `string` = "The Firebase Installations service (FIS) provides a unique identifier for each installed instance of a Firebase app, called Firebase installation ID (FID).[https://firebase.google.com/docs/projects/manage-installations] “Many Firebase services depend on the Firebase Installations API in order to identify app installs and/or authenticate client requests to their servers.”[https://console.cloud.google.com/marketplace/product/google/firebaseinstallations.googleapis.com] Other purposes include user segmentation, message delivery, performance monitoring, tracking the number of unique users, or selecting which configuration values to return.[https://firebase.google.com/docs/projects/manage-installations]\n\nFIDs can also be used by Google Analytics for attribution.[https://firebase.google.com/docs/projects/manage-installations]"; `google-fundingchoices`: `string` = "With Google's Privacy & Messaging API (formerly Funding Choices[https://support.google.com/fundingchoices/answer/9010669?hl=en]), app developers can manage users' consent choices[https://developers.google.com/funding-choices] and show consent forms[https://developers.google.com/admob/android/privacy#load-and-show-form]. It can also be used to detect ad blockers and display messages to “recover lost revenue from ad blocking users”.[https://support.google.com/admob/answer/10107561]\n\nThe Privacy & Messaging API is available through Google's AdMob, Ad Manager, and AdSense SDKs on the web, Android, and iOS.[https://support.google.com/fundingchoices/answer/9010669?hl=en]"; `googledatatransport-batchlog`: `string` = "The GoogleDataTransport SDK is a transport layer used internally by many other Firebase (e.g. Crashlytics, Performance, Core) Google (e.g. ML Kit) SDKs and services.[https://github.com/firebase/firebase-ios-sdk/issues/8220#issuecomment-858040701] It batches application-specific data from within an app to Google, using a common endpoint regardless of the actual SDK that was integrated by the app developer.[https://stackoverflow.com/a/76334853]"; `infonline`: `string` = "INFOnline provides digital audience measurement for websites and apps.[https://www.infonline.de/en/]\n\nThey offer two separate measurement systems: Census Measurement (IOMb[https://www.infonline.de/download/?wpdmdl=7135]) and INFOnline Measurement pseudonymous (IOMp[https://www.infonline.de/download/?wpdmdl=7135], formerly SZMnG[https://www.infonline.de/faqs/]). Census Measurement can be recognized by the URL path fragment “base.io”, whereas INFOnline Measurement pseudonymous uses “tx.io”.[https://docs.infonline.de/infonline-measurement/en/integration/web/checkliste\_web\_allgemein/]\n\nINFOnline boasts with constantly adapting their technology in order to circumvent browser restrictions, ad and tracking blockers, and privacy-preserving changes by operating systems.[https://www.infonline.de/measurement/]"; `infonline-pseudonymous`: `string` = "Unlike Census Measurement, which works anonymously without identifiers, INFOnline Measurement pseudonymous “is designed as a pseudonymous system (with client identifiers)”.[https://docs.infonline.de/infonline-measurement/en/getting-started/verfahrensbeschreibung/]\n\nAccording INFOnline’s own documentation, “[…] the pseudonymous INFOnline Measurement may only be loaded and executed if there is active consent from the user of [the] web page. […] The following also applies to apps: Only start the session of pseudonymous measurement if you have the user's consent.”[https://docs.infonline.de/infonline-measurement/en/getting-started/rechtliche-auswirkungen/]"; `ironsource`: `string` = "ironSource offers the following services:\n\n- Analytics.[https://www.is.com/analytics/]\n- App monetization for publishers[https://www.is.com/monetization/], including ad mediation[https://www.is.com/mediation/], real-time bidding[https://www.is.com/in-app-bidding/], and A/B testing[https://www.is.com/monetization-ab-testing/].\n- Advertising for user acquisition, to “[k]eep your best users in your portfolio with cross promotion campaigns”.[https://www.is.com/user-growth/] Advertisers can “[a]ccurately measure the ad revenue generated for each device and impression – from any ad unit, across every ad network.”[https://www.is.com/impression-level-revenue/]\n- Audience segmentation, to “[p]ersonalize the ad experience for different audiences to keep users coming back and encourage them to progress in your game”.[https://www.is.com/segments/]"; `microsoft-appcenter`: `string` = "Visual Studio App Center is a collection of services by Microsoft to help developers “continuously build, test, release,\nand monitor apps for every platform.”[https://learn.microsoft.com/en-us/appcenter/]\n\nAmong those services are:\n\n- App Center Diagnostics, to “[collect] information about crashes and errors” in apps.[https://learn.microsoft.com/en-us/appcenter/diagnostics/]\n- App Center Analytics, which “helps [developers] understand user behavior and customer engagement […]. The SDK automatically captures session count and device properties like model, OS version, etc. [Developers] can define [their] own custom events […].”[https://learn.microsoft.com/en-us/appcenter/sdk/analytics/android] By tracking events, developers can “learn more about […] users' behavior and understand the interaction between […] users and […] apps.”[https://learn.microsoft.com/en-us/appcenter/analytics/event-metrics]\n\nRegardless of the particular SDK or service, all data sent to App Center goes to a single endpoint.[https://learn.microsoft.com/en-us/appcenter/sdk/data-collected]"; `mopub`: `string` = "MoPub was a mobile app monetization service.[https://web.archive.org/web/20210126085400/https://www.mopub.com/en]\n\nMoPub has since been acquired by AppLovin and integrated into AppLovin MAX.[https://www.applovin.com/blog/applovins-acquisition-of-mopub-has-officially-closed/]"; `onesignal`: `string` = "OneSignal provides SDKs and APIs to help developers “send push notifications, in-app messages, SMS, and emails.”[https://documentation.onesignal.com/docs/onesignal-platform]\n\nFor that, it also offers personalization[https://onesignal.com/personalization], user segmentation[https://onesignal.com/targeting-segmentation], and A/B testing[https://documentation.onesignal.com/docs/ab-testing] features. Developers can “send personalized messages based on real-time user behavior, […] user attributes, events, location, language, and more”.[https://onesignal.com/personalization] Audience cohorts can be synced from various analytics providers.[https://onesignal.com/targeting-segmentation]\n\nAdditionally, OneSignal offers analytics features. Developers can “[c]reate an understanding as to how [their] messaging drives direct, indirect, and unattributed user actions” and “[e]asily quantify which messages are driving sales, engagement, and more”.[https://onesignal.com/analytics] OneSignal advertises with helping developers “know precisely when a device receives a notification”, even if “[u]sers uninstall apps, swap phones, turn off their phones, or are unreachable”.[https://onesignal.com/analytics] Analytics data can be shared with various third-party tracking companies using integrations.[https://onesignal.com/integrations/category/analytics]"; `onesignal-add-a-device`: `string` = "The “Add a device” endpoint is used ”to register a new device with OneSignal.“[https://documentation.onesignal.com/v9.0/reference/add-a-device]"; `singular-net`: `string` = "Singular offers the following services:\n\n- Analytics on a company's marketing spending and efficacy[https://www.singular.net/marketing-analytics/], with the goal of “[acquiring] the highest value users”[https://www.singular.net/ad-monetization/].\n- Tracking and attribution of users, “connecting the install of a mobile app and the user’s activities inside the app to the marketing campaign that led to the installation”.[https://www.singular.net/mobile-attribution/] “For every install, Singular scans its database for relevant ad interactions (ad clicks and ad views) that originated from the same device […]. […] The goal is to reconstruct the user journey as the first step toward finding the touchpoint that most likely led the user to install the app.”[https://support.singular.net/hc/en-us/articles/115000526963-Understanding-Singular-Mobile-App-Attribution] Additionally, Singular attributes the following events to the user: ”User sessions (i.e., every time the user opens the app), Revenue events (purchases made through the app), Any other events that are relevant to [the] app, such as sign-ups, tutorial completions, or level-ups.“, as well as app uninstalls[https://support.singular.net/hc/en-us/articles/115000526963-Understanding-Singular-Mobile-App-Attribution]\n- Mobile ad fraud prevention.[https://www.singular.net/fraud-prevention/]\n\nSingular boasts with being able to track users across devices, using “advertiser-reported IDs to tie different devices to the same user”.[https://www.singular.net/cross-device-attribution/] They claim: “By implementing an API call to the Singular SDK or server with a user ID, Singular helps you sync up users and devices in such a way that you can recognize customers or users and properly attribute conversions to ad spend and marketing activity, plus assign customers or users to cohorts, regardless of which device or platform they’re using at any given moment.”[https://www.singular.net/glossary/cross-device-attribution/]\n\nAdditionally, they pull in, aggregate, standardize, and match tracking data from thousands of partner companies in the fields of analytics, attribution, audience measurement, and ad monetization.[https://www.singular.net/partner-integrations/]"; `smartbear-bugsnag`: `string` = "BugSnag offers the following services:\n\n- Error monitoring, collecting and visualizing crash data.[https://www.bugsnag.com/error-monitoring/]\n- Real user monitoring, to “[o]ptimize your application based on real-time user actions with your application” and give “visibility into critical performance metrics like hot and cold app starts, network requests, screen-load time and more.”[https://www.bugsnag.com/real-user-monitoring/]"; `smartbear-bugsnag-notify`: `string` = "The Error Reporting API is used to send error reports and crashes to BugSnag.[https://bugsnagerrorreportingapi.docs.apiary.io/#reference/0/minidump/send-error-reports]"; `smartbear-bugsnag-session`: `string` = "The Session Tracking API is used to “notify Bugsnag of sessions starting in web, mobile or desktop applications.”[https://bugsnagsessiontrackingapi.docs.apiary.io/#reference/0/session/report-a-session-starting]" }  } |
| `en.properties` | { `accelerometerX`: `string` = "Accelerometer X"; `accelerometerY`: `string` = "Accelerometer Y"; `accelerometerZ`: `string` = "Accelerometer Z"; `appId`: `string` = "App ID"; `appName`: `string` = "App name"; `appVersion`: `string` = "App version"; `architecture`: `string` = "Architecture"; `batteryLevel`: `string` = "Battery level"; `carrier`: `string` = "Carrier"; `country`: `string` = "Country"; `deviceName`: `string` = "Device name"; `diskFree`: `string` = "Free disk space"; `diskTotal`: `string` = "Total disk space"; `diskUsed`: `string` = "Used disk space"; `hashedIdfa`: `string` = "Hashed device advertising ID"; `idfa`: `string` = "Device advertising ID (GAID/IDFA)"; `idfv`: `string` = "Developer-scoped device ID (IDFV/ASID/ANDROID\_ID)"; `installTime`: `string` = "App install time"; `isCharging`: `string` = "Charging status"; `isEmulator`: `string` = "Is device an emulator?"; `isFirstLaunch`: `string` = "Is first launch?"; `isInDarkMode`: `string` = "Is app in dark mode?"; `isInForeground`: `string` = "Is app in foreground?"; `isRoaming`: `string` = "Is device roaming?"; `isRooted`: `string` = "Is device rooted?"; `language`: `string` = "Language"; `latitude`: `string` = "Latitude"; `localIp`: `string` = "Local IP address(es)"; `longitude`: `string` = "Longitude"; `macAddress`: `string` = "MAC address"; `manufacturer`: `string` = "Manufacturer"; `model`: `string` = "Model"; `networkConnectionType`: `string` = "Network connection type"; `orientation`: `string` = "Orientation"; `osName`: `string` = "OS name"; `osVersion`: `string` = "OS version"; `otherIdentifiers`: `string` = "Other unique identifiers for the user, device, session, or installation"; `publicIp`: `string` = "Public IP address"; `pushNotificationToken`: `string` = "Push notification token"; `ramFree`: `string` = "Free RAM"; `ramTotal`: `string` = "Total RAM"; `ramUsed`: `string` = "Used RAM"; `referer`: `string` = "Referer"; `revenue`: `string` = "Earned revenue"; `rotationX`: `string` = "Rotation X"; `rotationY`: `string` = "Rotation Y"; `rotationZ`: `string` = "Rotation Z"; `screenHeight`: `string` = "Screen height"; `screenWidth`: `string` = "Screen width"; `signalStrengthCellular`: `string` = "Signal strength (cellular)"; `signalStrengthWifi`: `string` = "Signal strength (Wi-Fi)"; `startTime`: `string` = "App start time"; `state`: `string` = "State/Sub national entity"; `timeSpent`: `string` = "Time spent in app"; `timezone`: `string` = "Time zone"; `trackerSdkVersion`: `string` = "Tracker SDK version"; `uptime`: `string` = "Uptime"; `userAgent`: `string` = "User agent"; `viewedPage`: `string` = "Viewed page"; `volume`: `string` = "Volume" } |
| `en.properties.accelerometerX` | `string` |
| `en.properties.accelerometerY` | `string` |
| `en.properties.accelerometerZ` | `string` |
| `en.properties.appId` | `string` |
| `en.properties.appName` | `string` |
| `en.properties.appVersion` | `string` |
| `en.properties.architecture` | `string` |
| `en.properties.batteryLevel` | `string` |
| `en.properties.carrier` | `string` |
| `en.properties.country` | `string` |
| `en.properties.deviceName` | `string` |
| `en.properties.diskFree` | `string` |
| `en.properties.diskTotal` | `string` |
| `en.properties.diskUsed` | `string` |
| `en.properties.hashedIdfa` | `string` |
| `en.properties.idfa` | `string` |
| `en.properties.idfv` | `string` |
| `en.properties.installTime` | `string` |
| `en.properties.isCharging` | `string` |
| `en.properties.isEmulator` | `string` |
| `en.properties.isFirstLaunch` | `string` |
| `en.properties.isInDarkMode` | `string` |
| `en.properties.isInForeground` | `string` |
| `en.properties.isRoaming` | `string` |
| `en.properties.isRooted` | `string` |
| `en.properties.language` | `string` |
| `en.properties.latitude` | `string` |
| `en.properties.localIp` | `string` |
| `en.properties.longitude` | `string` |
| `en.properties.macAddress` | `string` |
| `en.properties.manufacturer` | `string` |
| `en.properties.model` | `string` |
| `en.properties.networkConnectionType` | `string` |
| `en.properties.orientation` | `string` |
| `en.properties.osName` | `string` |
| `en.properties.osVersion` | `string` |
| `en.properties.otherIdentifiers` | `string` |
| `en.properties.publicIp` | `string` |
| `en.properties.pushNotificationToken` | `string` |
| `en.properties.ramFree` | `string` |
| `en.properties.ramTotal` | `string` |
| `en.properties.ramUsed` | `string` |
| `en.properties.referer` | `string` |
| `en.properties.revenue` | `string` |
| `en.properties.rotationX` | `string` |
| `en.properties.rotationY` | `string` |
| `en.properties.rotationZ` | `string` |
| `en.properties.screenHeight` | `string` |
| `en.properties.screenWidth` | `string` |
| `en.properties.signalStrengthCellular` | `string` |
| `en.properties.signalStrengthWifi` | `string` |
| `en.properties.startTime` | `string` |
| `en.properties.state` | `string` |
| `en.properties.timeSpent` | `string` |
| `en.properties.timezone` | `string` |
| `en.properties.trackerSdkVersion` | `string` |
| `en.properties.uptime` | `string` |
| `en.properties.userAgent` | `string` |
| `en.properties.viewedPage` | `string` |
| `en.properties.volume` | `string` |
| `en.tracker-descriptions` | { `adjust`: `string` = "Adjust offers the following services:\n\n- User engagement tracking using events. “You can define in-app events for your app to measure user registrations, add-to-carts, or level ups, while setting up revenue events lets you record in-app purchases and transactions. Set up events to: See where your users go directly after install, Discover the app features your users like the most, Identify the last thing a user does before they become inactive”[https://help.adjust.com/en/article/add-events]\n- Mobile attribution, in order to “[i]dentify [the] best users and channels”.[https://www.adjust.com/product/mobile-app-attribution/] “Adjust's attribution matches your app users to the source that drove their install. You can use this attribution data to measure campaign performance, run effective retargeting campaigns, optimize your creative assets, and more.”[https://help.adjust.com/en/article/attribution-methods] Additionally, “Adjust can reattribute dormant users who engage with a new source and then return to [the] app.”[https://help.adjust.com/en/article/reattribution]\n\n  Adjust uses two attribution methods:\n    - “Deterministic attribution is Adjust's main attribution method and involves device matching. We collect a unique identifier from recorded engagements and installs, and if both IDs match, we can attribute that engagement to the install. With a 100% accuracy rate, click-based device matching is the most reliable attribution method. We use deterministic attribution to attribute installs (first app opens) and reattribute (assign new attribution sources to) inactive users. Adjust uses the following identifiers for deterministic attribution: Advertising IDs […], Device IDs […], Adjust reftags […]”[https://help.adjust.com/en/article/attribution-methods#deterministic-attribution]\n    - “Probabilistic modeling […] uses machine learning to support a statistical approach to measurement.”[https://help.adjust.com/en/article/attribution-methods#probabilistic-modeling]\n- Uninstall and reinstall tracking. “When a user installs [the] app, the app is given a unique push token which the Adjust SDK forwards to Adjust's servers. Silent push notifications are then sent once per day to check if the app is still installed.”[https://help.adjust.com/en/article/uninstalls-reinstalls]\n- Audience segmentation to “group users together based on […] criteria”.[https://www.adjust.com/product/audience-builder/]\n- Fraud prevention. “Organic users are captured accurately and not misattributed”.[https://www.adjust.com/product/fraud-prevention/]\n\nAdditionally, Adjust can pull in tracking data from partner companies.[https://help.adjust.com/en/article/partner-connections]"; `branch-io`: `string` = "Branch offers the following services:\n\n- Mobile attribution[https://www.branch.io/attribution/] to “[c]apture every customer touchpoint across any channel, platform, OS to optimize […] campaigns and maximize ROI.”[https://www.branch.io/features/]\n- Ad conversion tracking. Branch can “[r]etarget app users who see a web ad and then purchase in the app, attribute revenue to the web ad that drove the install, and measure cumulative revenue from users across both web and app.”[https://www.branch.io/universal-ads/]\n- Custom audiences to “communicate the perfect message to the ideal customer, at the right moment”. “Get higher return on ad spend (ROAS) with precision retargeting of high-value active users and eliminate wasted spend in your acquisition campaigns by excluding existing customers. Re-engage lapsed users, boost propensity to purchase, and increase sessions per user.”[https://www.branch.io/engagement-builder/]\n- Fraud protection.[https://www.branch.io/fraud-protection/]\n\nBranch provides integrations to automatically “send Branch data to […] marketing and analytics partners to measure and optimize […] campaigns.”[https://www.branch.io/data-feeds/]"; `branch-io-attribution-api`: `string` = "The Branch Attribution API is used for “deep linking and session attribution. […] Every time the API is called, it will track an INSTALL, REINSTALL, or OPEN event in Branch and return deep link data in the response if the session is attributed.”[https://help.branch.io/developers-hub/reference/attribution-api] It can also track “additional downstream conversion events” like PURCHASE.[https://help.branch.io/developers-hub/reference/attribution-api#tracking-downstream-events]"; `chartboost`: `string` = "Chartboost is an advertising platform focused on mobile gaming that caters to both publishers[https://www.chartboost.com/products/monetization/] and advertisers[https://www.chartboost.com/products/advertising/].\n\nChartboost supports mediation (real-time bidding)[https://www.chartboost.com/products/mediation/], analytics[https://docs.chartboost.com/en/mediation/analytics/], and A/B testing[https://docs.chartboost.com/en/mediation/ab-tests/]."; `facebook-audience-network`: `string` = "Meta Audience Network is a service by Facebook that allows app developers to monetize their apps with ads.[https://developers.facebook.com/docs/audience-network] Facebook offers Audience Network SDKs for Android[https://developers.facebook.com/docs/audience-network/setting-up/platform-setup/android/add-sdk], iOS[https://developers.facebook.com/docs/audience-network/setting-up/platform-setup/ios/add-sdk], and Unity[https://developers.facebook.com/docs/audience-network/setting-up/platform-steup/unity/add-sdk]."; `facebook-graph-app-events`: `string` = "The Graph API is provided by Facebook to “get data into and out of the Facebook platform”.[https://developers.facebook.com/docs/graph-api/overview] It can be accessed through the Facebook SDKs for Android[https://developers.facebook.com/docs/android/graph] and iOS[https://developers.facebook.com/docs/ios/graph].\n\nThe App Events endpoint allows developers to “track actions that occur in [a] mobile app or web page such as app installs and purchase events” in order to “measure ad performance and build audiences for ad targeting”. The Facebook SDK automatically logs app installs, app sessions, and in-app purchases using this endpoint. Additionally, developers can manually log their own events.[https://developers.facebook.com/docs/marketing-api/app-event-api]"; `firebaseinstallations`: `string` = "The Firebase Installations service (FIS) provides a unique identifier for each installed instance of a Firebase app, called Firebase installation ID (FID).[https://firebase.google.com/docs/projects/manage-installations] “Many Firebase services depend on the Firebase Installations API in order to identify app installs and/or authenticate client requests to their servers.”[https://console.cloud.google.com/marketplace/product/google/firebaseinstallations.googleapis.com] Other purposes include user segmentation, message delivery, performance monitoring, tracking the number of unique users, or selecting which configuration values to return.[https://firebase.google.com/docs/projects/manage-installations]\n\nFIDs can also be used by Google Analytics for attribution.[https://firebase.google.com/docs/projects/manage-installations]"; `google-fundingchoices`: `string` = "With Google's Privacy & Messaging API (formerly Funding Choices[https://support.google.com/fundingchoices/answer/9010669?hl=en]), app developers can manage users' consent choices[https://developers.google.com/funding-choices] and show consent forms[https://developers.google.com/admob/android/privacy#load-and-show-form]. It can also be used to detect ad blockers and display messages to “recover lost revenue from ad blocking users”.[https://support.google.com/admob/answer/10107561]\n\nThe Privacy & Messaging API is available through Google's AdMob, Ad Manager, and AdSense SDKs on the web, Android, and iOS.[https://support.google.com/fundingchoices/answer/9010669?hl=en]"; `googledatatransport-batchlog`: `string` = "The GoogleDataTransport SDK is a transport layer used internally by many other Firebase (e.g. Crashlytics, Performance, Core) Google (e.g. ML Kit) SDKs and services.[https://github.com/firebase/firebase-ios-sdk/issues/8220#issuecomment-858040701] It batches application-specific data from within an app to Google, using a common endpoint regardless of the actual SDK that was integrated by the app developer.[https://stackoverflow.com/a/76334853]"; `infonline`: `string` = "INFOnline provides digital audience measurement for websites and apps.[https://www.infonline.de/en/]\n\nThey offer two separate measurement systems: Census Measurement (IOMb[https://www.infonline.de/download/?wpdmdl=7135]) and INFOnline Measurement pseudonymous (IOMp[https://www.infonline.de/download/?wpdmdl=7135], formerly SZMnG[https://www.infonline.de/faqs/]). Census Measurement can be recognized by the URL path fragment “base.io”, whereas INFOnline Measurement pseudonymous uses “tx.io”.[https://docs.infonline.de/infonline-measurement/en/integration/web/checkliste\_web\_allgemein/]\n\nINFOnline boasts with constantly adapting their technology in order to circumvent browser restrictions, ad and tracking blockers, and privacy-preserving changes by operating systems.[https://www.infonline.de/measurement/]"; `infonline-pseudonymous`: `string` = "Unlike Census Measurement, which works anonymously without identifiers, INFOnline Measurement pseudonymous “is designed as a pseudonymous system (with client identifiers)”.[https://docs.infonline.de/infonline-measurement/en/getting-started/verfahrensbeschreibung/]\n\nAccording INFOnline’s own documentation, “[…] the pseudonymous INFOnline Measurement may only be loaded and executed if there is active consent from the user of [the] web page. […] The following also applies to apps: Only start the session of pseudonymous measurement if you have the user's consent.”[https://docs.infonline.de/infonline-measurement/en/getting-started/rechtliche-auswirkungen/]"; `ironsource`: `string` = "ironSource offers the following services:\n\n- Analytics.[https://www.is.com/analytics/]\n- App monetization for publishers[https://www.is.com/monetization/], including ad mediation[https://www.is.com/mediation/], real-time bidding[https://www.is.com/in-app-bidding/], and A/B testing[https://www.is.com/monetization-ab-testing/].\n- Advertising for user acquisition, to “[k]eep your best users in your portfolio with cross promotion campaigns”.[https://www.is.com/user-growth/] Advertisers can “[a]ccurately measure the ad revenue generated for each device and impression – from any ad unit, across every ad network.”[https://www.is.com/impression-level-revenue/]\n- Audience segmentation, to “[p]ersonalize the ad experience for different audiences to keep users coming back and encourage them to progress in your game”.[https://www.is.com/segments/]"; `microsoft-appcenter`: `string` = "Visual Studio App Center is a collection of services by Microsoft to help developers “continuously build, test, release,\nand monitor apps for every platform.”[https://learn.microsoft.com/en-us/appcenter/]\n\nAmong those services are:\n\n- App Center Diagnostics, to “[collect] information about crashes and errors” in apps.[https://learn.microsoft.com/en-us/appcenter/diagnostics/]\n- App Center Analytics, which “helps [developers] understand user behavior and customer engagement […]. The SDK automatically captures session count and device properties like model, OS version, etc. [Developers] can define [their] own custom events […].”[https://learn.microsoft.com/en-us/appcenter/sdk/analytics/android] By tracking events, developers can “learn more about […] users' behavior and understand the interaction between […] users and […] apps.”[https://learn.microsoft.com/en-us/appcenter/analytics/event-metrics]\n\nRegardless of the particular SDK or service, all data sent to App Center goes to a single endpoint.[https://learn.microsoft.com/en-us/appcenter/sdk/data-collected]"; `mopub`: `string` = "MoPub was a mobile app monetization service.[https://web.archive.org/web/20210126085400/https://www.mopub.com/en]\n\nMoPub has since been acquired by AppLovin and integrated into AppLovin MAX.[https://www.applovin.com/blog/applovins-acquisition-of-mopub-has-officially-closed/]"; `onesignal`: `string` = "OneSignal provides SDKs and APIs to help developers “send push notifications, in-app messages, SMS, and emails.”[https://documentation.onesignal.com/docs/onesignal-platform]\n\nFor that, it also offers personalization[https://onesignal.com/personalization], user segmentation[https://onesignal.com/targeting-segmentation], and A/B testing[https://documentation.onesignal.com/docs/ab-testing] features. Developers can “send personalized messages based on real-time user behavior, […] user attributes, events, location, language, and more”.[https://onesignal.com/personalization] Audience cohorts can be synced from various analytics providers.[https://onesignal.com/targeting-segmentation]\n\nAdditionally, OneSignal offers analytics features. Developers can “[c]reate an understanding as to how [their] messaging drives direct, indirect, and unattributed user actions” and “[e]asily quantify which messages are driving sales, engagement, and more”.[https://onesignal.com/analytics] OneSignal advertises with helping developers “know precisely when a device receives a notification”, even if “[u]sers uninstall apps, swap phones, turn off their phones, or are unreachable”.[https://onesignal.com/analytics] Analytics data can be shared with various third-party tracking companies using integrations.[https://onesignal.com/integrations/category/analytics]"; `onesignal-add-a-device`: `string` = "The “Add a device” endpoint is used ”to register a new device with OneSignal.“[https://documentation.onesignal.com/v9.0/reference/add-a-device]"; `singular-net`: `string` = "Singular offers the following services:\n\n- Analytics on a company's marketing spending and efficacy[https://www.singular.net/marketing-analytics/], with the goal of “[acquiring] the highest value users”[https://www.singular.net/ad-monetization/].\n- Tracking and attribution of users, “connecting the install of a mobile app and the user’s activities inside the app to the marketing campaign that led to the installation”.[https://www.singular.net/mobile-attribution/] “For every install, Singular scans its database for relevant ad interactions (ad clicks and ad views) that originated from the same device […]. […] The goal is to reconstruct the user journey as the first step toward finding the touchpoint that most likely led the user to install the app.”[https://support.singular.net/hc/en-us/articles/115000526963-Understanding-Singular-Mobile-App-Attribution] Additionally, Singular attributes the following events to the user: ”User sessions (i.e., every time the user opens the app), Revenue events (purchases made through the app), Any other events that are relevant to [the] app, such as sign-ups, tutorial completions, or level-ups.“, as well as app uninstalls[https://support.singular.net/hc/en-us/articles/115000526963-Understanding-Singular-Mobile-App-Attribution]\n- Mobile ad fraud prevention.[https://www.singular.net/fraud-prevention/]\n\nSingular boasts with being able to track users across devices, using “advertiser-reported IDs to tie different devices to the same user”.[https://www.singular.net/cross-device-attribution/] They claim: “By implementing an API call to the Singular SDK or server with a user ID, Singular helps you sync up users and devices in such a way that you can recognize customers or users and properly attribute conversions to ad spend and marketing activity, plus assign customers or users to cohorts, regardless of which device or platform they’re using at any given moment.”[https://www.singular.net/glossary/cross-device-attribution/]\n\nAdditionally, they pull in, aggregate, standardize, and match tracking data from thousands of partner companies in the fields of analytics, attribution, audience measurement, and ad monetization.[https://www.singular.net/partner-integrations/]"; `smartbear-bugsnag`: `string` = "BugSnag offers the following services:\n\n- Error monitoring, collecting and visualizing crash data.[https://www.bugsnag.com/error-monitoring/]\n- Real user monitoring, to “[o]ptimize your application based on real-time user actions with your application” and give “visibility into critical performance metrics like hot and cold app starts, network requests, screen-load time and more.”[https://www.bugsnag.com/real-user-monitoring/]"; `smartbear-bugsnag-notify`: `string` = "The Error Reporting API is used to send error reports and crashes to BugSnag.[https://bugsnagerrorreportingapi.docs.apiary.io/#reference/0/minidump/send-error-reports]"; `smartbear-bugsnag-session`: `string` = "The Session Tracking API is used to “notify Bugsnag of sessions starting in web, mobile or desktop applications.”[https://bugsnagsessiontrackingapi.docs.apiary.io/#reference/0/session/report-a-session-starting]" } |
| `en.tracker-descriptions.adjust` | `string` |
| `en.tracker-descriptions.branch-io` | `string` |
| `en.tracker-descriptions.branch-io-attribution-api` | `string` |
| `en.tracker-descriptions.chartboost` | `string` |
| `en.tracker-descriptions.facebook-audience-network` | `string` |
| `en.tracker-descriptions.facebook-graph-app-events` | `string` |
| `en.tracker-descriptions.firebaseinstallations` | `string` |
| `en.tracker-descriptions.google-fundingchoices` | `string` |
| `en.tracker-descriptions.googledatatransport-batchlog` | `string` |
| `en.tracker-descriptions.infonline` | `string` |
| `en.tracker-descriptions.infonline-pseudonymous` | `string` |
| `en.tracker-descriptions.ironsource` | `string` |
| `en.tracker-descriptions.microsoft-appcenter` | `string` |
| `en.tracker-descriptions.mopub` | `string` |
| `en.tracker-descriptions.onesignal` | `string` |
| `en.tracker-descriptions.onesignal-add-a-device` | `string` |
| `en.tracker-descriptions.singular-net` | `string` |
| `en.tracker-descriptions.smartbear-bugsnag` | `string` |
| `en.tracker-descriptions.smartbear-bugsnag-notify` | `string` |
| `en.tracker-descriptions.smartbear-bugsnag-session` | `string` |

#### Defined in

[src/lib/translations.ts:5](https://github.com/tweaselORG/complaint-generator/blob/main/src/lib/translations.ts#L5)

## Functions

### generate

▸ **generate**(`options`): `Promise`<`Uint8Array`\>

Generate a technical report, controller notice or DPA complaint based on a network traffic analysis performed using
tweasel tools.

**`Remarks`**

This is a high-level function that takes a tweasel HAR and relies on the additionaly metadata therein. If you have a
HAR from another source, use [generateAdvanced](README.md#generateadvanced) instead and manually provide the required metadata.

#### Parameters

| Name | Type | Description |
| :------ | :------ | :------ |
| `options` | [`GenerateOptions`](README.md#generateoptions) | The options specifying what to generate. |

#### Returns

`Promise`<`Uint8Array`\>

The generated document as a PDF file.

#### Defined in

[src/index.ts:144](https://github.com/tweaselORG/complaint-generator/blob/main/src/index.ts#L144)

___

### generateAdvanced

▸ **generateAdvanced**(`options`): `Promise`<`Uint8Array`\>

Generate a technical report, controller notice or DPA complaint based on a network traffic analysis, manually
specifying all metadata.

**`Remarks`**

If the analysis was performed using tweasel tools, you can instead use [generate](README.md#generate) to have the metadata
automatically extracted from the tweasel HAR file.

#### Parameters

| Name | Type | Description |
| :------ | :------ | :------ |
| `options` | [`GenerateAdvancedOptions`](README.md#generateadvancedoptions) | The options specifying what to generate. |

#### Returns

`Promise`<`Uint8Array`\>

The generated document as a PDF file.

#### Defined in

[src/lib/generate.ts:186](https://github.com/tweaselORG/complaint-generator/blob/main/src/lib/generate.ts#L186)

___

### parseNetworkActivityReport

▸ **parseNetworkActivityReport**(`type`, `report`): [`NetworkActivityReport`](README.md#networkactivityreport)

Parse a network activity report from the iOS App Privacy Report or Tracker Control on Android into a standardized
[NetworkActivityReport](README.md#networkactivityreport) format.

#### Parameters

| Name | Type | Description |
| :------ | :------ | :------ |
| `type` | ``"ios-app-privacy-report-ndjson"`` \| ``"tracker-control-csv"`` | The type/format of the input report, with the following possible values: - `ios-app-privacy-report-ndjson`: A report exported from the iOS App Privacy Report feature, in NDJSON format. - `tracker-control-csv`: A CSV export of the network traffic log from the Tracker Control Android app. This supports both the full export of all apps and the individual app export. In the latter case, the `appId` in the result will always be `undefined`. |
| `report` | `string` | The report to parse. |

#### Returns

[`NetworkActivityReport`](README.md#networkactivityreport)

The parsed report as a [NetworkActivityReport](README.md#networkactivityreport).

#### Defined in

[src/lib/user-network-activity.ts:94](https://github.com/tweaselORG/complaint-generator/blob/main/src/lib/user-network-activity.ts#L94)
