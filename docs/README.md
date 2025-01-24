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
| `deviceManufacturer?` | `string` | The manufacturer of the device/emulator the analysis was performed on. |
| `deviceModel?` | `string` | The model of the device/emulator the analysis was performed on. |
| `deviceType` | ``"device"`` \| ``"emulator"`` | Whether the analysis was run on an emulator or a physical device. |
| `har` | `Har` | The recorded network traffic in HAR format. |
| `harMd5?` | `string` | The MD5 hash of the HAR file such that recipients of the report can verify the integrity of the attached HAR file. |
| `platformBuildString?` | `string` | The OS build string of the device/emulator the analysis was performed on. |
| `platformVersion` | `string` | The operating system version of the device/emulator the analysis was performed on. |
| `trackHarResult` | `ReturnType`<typeof `processRequest`\>[] | The [TrackHAR](https://github.com/tweaselORG/TrackHAR) analysis results for the HAR. |

#### Defined in

[src/lib/generate.ts:27](https://github.com/tweaselORG/ReportHAR/blob/main/src/lib/generate.ts#L27)

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

[src/lib/generate.ts:11](https://github.com/tweaselORG/ReportHAR/blob/main/src/lib/generate.ts#L11)

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

[src/lib/generate.ts:99](https://github.com/tweaselORG/ReportHAR/blob/main/src/lib/generate.ts#L99)

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
| `nationalEPrivacyLaw` | ``"TDDDG"`` \| ``false`` | If the complaint should also reference the ePrivacy directive, the name of the national law implementing it. Supported values: - `TDDDG`: Germany (previously TTDSG). |
| `noticeDate` | `Date` | The date the notice to the controller was sent. |
| `reference` | `string` | The complaint's reference number, to be used in any further communication about this complaint. |

#### Defined in

[src/lib/generate.ts:60](https://github.com/tweaselORG/ReportHAR/blob/main/src/lib/generate.ts#L60)

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

[src/lib/generate.ts:179](https://github.com/tweaselORG/ReportHAR/blob/main/src/lib/generate.ts#L179)

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

[src/lib/generate.ts:132](https://github.com/tweaselORG/ReportHAR/blob/main/src/lib/generate.ts#L132)

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

[src/lib/generate.ts:151](https://github.com/tweaselORG/ReportHAR/blob/main/src/lib/generate.ts#L151)

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

[src/lib/generate.ts:117](https://github.com/tweaselORG/ReportHAR/blob/main/src/lib/generate.ts#L117)

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

[src/index.ts:123](https://github.com/tweaselORG/ReportHAR/blob/main/src/index.ts#L123)

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

[src/index.ts:34](https://github.com/tweaselORG/ReportHAR/blob/main/src/index.ts#L34)

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

[src/index.ts:74](https://github.com/tweaselORG/ReportHAR/blob/main/src/index.ts#L74)

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

[src/index.ts:12](https://github.com/tweaselORG/ReportHAR/blob/main/src/index.ts#L12)

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

[src/lib/user-network-activity.ts:28](https://github.com/tweaselORG/ReportHAR/blob/main/src/lib/user-network-activity.ts#L28)

___

### NetworkActivityReport

Ƭ **NetworkActivityReport**: { `appId`: `string` \| `undefined` ; `hostname`: `string` ; `index`: `number` ; `timestamp`: `Date`  }[]

An entry in a network activity report, containing information about the hostnames that were contacted on the user's
device.

#### Defined in

[src/lib/user-network-activity.ts:7](https://github.com/tweaselORG/ReportHAR/blob/main/src/lib/user-network-activity.ts#L7)

___

### SupportedLanguage

Ƭ **SupportedLanguage**: keyof typeof [`templates`](README.md#templates) & keyof typeof [`translations`](README.md#translations)

A language that translations and templates are available for.

#### Defined in

[src/lib/translations.ts:27](https://github.com/tweaselORG/ReportHAR/blob/main/src/lib/translations.ts#L27)

___

### TrackerControlNetworkTrafficExportEntry

Ƭ **TrackerControlNetworkTrafficExportEntry**: { `App`: `string` ; `Category`: `string` ; `Package`: `string` ; `Tracker`: `string` ; `daddr`: `string` ; `time`: `string` ; `uid`: `string` ; `uncertain`: `string`  } \| { `Tracker Category`: `string` ; `Tracker Name`: `string` ; `daddr`: `string` ; `time`: `string` ; `uncertain`: `string`  }

An entry in a network traffic export from the Tracker Control app on Android.

Exports across all apps contain more fields than exports for just one app.

#### Defined in

[src/lib/user-network-activity.ts:60](https://github.com/tweaselORG/ReportHAR/blob/main/src/lib/user-network-activity.ts#L60)

## Variables

### supportedLanguages

• `Const` **supportedLanguages**: ``"en"``[]

The languages that translations and templates are available for.

#### Defined in

[src/lib/translations.ts:22](https://github.com/tweaselORG/ReportHAR/blob/main/src/lib/translations.ts#L22)

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

[src/lib/translations.ts:12](https://github.com/tweaselORG/ReportHAR/blob/main/src/lib/translations.ts#L12)

___

### translations

• `Const` **translations**: `Object`

The string translations.

#### Type declaration

| Name | Type |
| :------ | :------ |
| `en` | { `properties`: { `accelerometerX`: `string` = "Accelerometer X"; `accelerometerY`: `string` = "Accelerometer Y"; `accelerometerZ`: `string` = "Accelerometer Z"; `advertisingId`: `string` = "Device advertising ID (GAID/IDFA)"; `appId`: `string` = "App ID"; `appName`: `string` = "App name"; `appVersion`: `string` = "App version"; `architecture`: `string` = "Architecture"; `batteryLevel`: `string` = "Battery level"; `browserId`: `string` = "Unique ID for the browser"; `browserWindowHeight`: `string` = "Browser window height"; `browserWindowWidth`: `string` = "Browser window width"; `campaignCreative`: `string` = "Campaign creative/content (utm\_content)"; `campaignCreativePosition`: `string` = "Campaign creative position"; `campaignMedium`: `string` = "Campaign medium (utm\_medium)"; `campaignName`: `string` = "Campaign name/ID (utm\_campaign)"; `campaignSource`: `string` = "Campaign source (utm\_source)"; `campaignTerm`: `string` = "Campaign term/keyword (utm\_term)"; `carrier`: `string` = "Carrier"; `consentState`: `string` = "Consent state"; `country`: `string` = "Country"; `currency`: `string` = "Currency"; `developerScopedId`: `string` = "Developer-scoped device ID (IDFV/ASID/ANDROID\_ID)"; `deviceId`: `string` = "Unique device ID"; `deviceName`: `string` = "Device name"; `diskFree`: `string` = "Free disk space"; `diskTotal`: `string` = "Total disk space"; `diskUsed`: `string` = "Used disk space"; `errorInformation`: `string` = "Error information"; `hashedAdvertisingId`: `string` = "Hashed device advertising ID"; `installTime`: `string` = "App install time"; `installationId`: `string` = "Unique installation ID"; `interactedElement`: `string` = "Element the user interacted with"; `isAutomated`: `string` = "Is device/browser controlled automatically?"; `isCharging`: `string` = "Charging status"; `isConversion`: `string` = "Is this a conversion event?"; `isDntEnabled`: `string` = "Is “Do Not Track” enabled?"; `isEmulator`: `string` = "Is device an emulator?"; `isFirstLaunch`: `string` = "Is first launch/visit?"; `isInDarkMode`: `string` = "Is app in dark mode?"; `isInForeground`: `string` = "Is app in foreground?"; `isJsEnabled`: `string` = "Is JavaScript enabled?"; `isMobileDevice`: `string` = "Is device a mobile device?"; `isRoaming`: `string` = "Is device roaming?"; `isRooted`: `string` = "Is device rooted?"; `isUserActive`: `string` = "Is user active?"; `isUserInactive`: `string` = "Is user inactive?"; `language`: `string` = "Language"; `lastActivityTime`: `string` = "Time of last activity by the user"; `latitude`: `string` = "Latitude"; `localIp`: `string` = "Local IP address(es)"; `longitude`: `string` = "Longitude"; `macAddress`: `string` = "MAC address"; `manufacturer`: `string` = "Manufacturer"; `model`: `string` = "Model"; `networkConnectionType`: `string` = "Network connection type"; `orientation`: `string` = "Orientation"; `osName`: `string` = "OS name"; `osVersion`: `string` = "OS version"; `otherIdentifiers`: `string` = "Other unique identifier"; `pageHeight`: `string` = "Page height"; `pageWidth`: `string` = "Page width"; `propertyId`: `string` = "ID for the property (website/app)"; `publicIp`: `string` = "Public IP address"; `pushNotificationToken`: `string` = "Push notification token"; `ramFree`: `string` = "Free RAM"; `ramTotal`: `string` = "Total RAM"; `ramUsed`: `string` = "Used RAM"; `referer`: `string` = "Referer"; `revenue`: `string` = "Earned revenue"; `rotationX`: `string` = "Rotation X"; `rotationY`: `string` = "Rotation Y"; `rotationZ`: `string` = "Rotation Z"; `screenColorDepth`: `string` = "Screen color depth"; `screenHeight`: `string` = "Screen height"; `screenWidth`: `string` = "Screen width"; `scrollPositionX`: `string` = "Scroll position X"; `scrollPositionY`: `string` = "Scroll position Y"; `segment`: `string` = "Segment for the user"; `sessionCount`: `string` = "Session count"; `sessionDuration`: `string` = "Session duration"; `sessionId`: `string` = "Unique session ID"; `signalStrengthCellular`: `string` = "Signal strength (cellular)"; `signalStrengthWifi`: `string` = "Signal strength (Wi-Fi)"; `startTime`: `string` = "App start time"; `state`: `string` = "State/Sub national entity"; `timeSpent`: `string` = "Time spent in app"; `timezone`: `string` = "Time zone"; `trackerSdkVersion`: `string` = "Tracker SDK version"; `uptime`: `string` = "Uptime"; `userAction`: `string` = "Action performed by the user"; `userActionSource`: `string` = "Source of the action performed by the user"; `userActiveTime`: `string` = "How long has the user been active?"; `userAgent`: `string` = "User agent"; `userGender`: `string` = "Gender of the user"; `userId`: `string` = "Unique user ID"; `userInterests`: `string` = "User interests"; `viewedPage`: `string` = "Viewed page"; `viewedPageCategory`: `string` = "Category of the viewed page"; `viewedPageKeywords`: `string` = "Keywords related to the viewed page"; `viewedPageLanguage`: `string` = "Language of the viewed page"; `volume`: `string` = "Volume"; `websiteName`: `string` = "Website name"; `websiteUrl`: `string` = "Website URL" } ; `tracker-descriptions`: { `adjust`: `string` = "Adjust offers the following services:\n\n- User engagement tracking using events. “You can define in-app events for your app to measure user registrations, add-to-carts, or level ups, while setting up revenue events lets you record in-app purchases and transactions. Set up events to: See where your users go directly after install, Discover the app features your users like the most, Identify the last thing a user does before they become inactive”[https://help.adjust.com/en/article/add-events]\n- Mobile attribution, in order to “[i]dentify [the] best users and channels”.[https://www.adjust.com/product/mobile-app-attribution/] “Adjust's attribution matches your app users to the source that drove their install. You can use this attribution data to measure campaign performance, run effective retargeting campaigns, optimize your creative assets, and more.”[https://help.adjust.com/en/article/attribution-methods] Additionally, “Adjust can reattribute dormant users who engage with a new source and then return to [the] app.”[https://help.adjust.com/en/article/reattribution]\n\n  Adjust uses two attribution methods:\n    - “Deterministic attribution is Adjust's main attribution method and involves device matching. We collect a unique identifier from recorded engagements and installs, and if both IDs match, we can attribute that engagement to the install. With a 100% accuracy rate, click-based device matching is the most reliable attribution method. We use deterministic attribution to attribute installs (first app opens) and reattribute (assign new attribution sources to) inactive users. Adjust uses the following identifiers for deterministic attribution: Advertising IDs […], Device IDs […], Adjust reftags […]”[https://help.adjust.com/en/article/attribution-methods#deterministic-attribution]\n    - “Probabilistic modeling […] uses machine learning to support a statistical approach to measurement.”[https://help.adjust.com/en/article/attribution-methods#probabilistic-modeling]\n- Uninstall and reinstall tracking. “When a user installs [the] app, the app is given a unique push token which the Adjust SDK forwards to Adjust's servers. Silent push notifications are then sent once per day to check if the app is still installed.”[https://help.adjust.com/en/article/uninstalls-reinstalls]\n- Audience segmentation to “group users together based on […] criteria”.[https://www.adjust.com/product/audience-builder/]\n- Fraud prevention. “Organic users are captured accurately and not misattributed”.[https://www.adjust.com/product/fraud-prevention/]\n\nAdditionally, Adjust can pull in tracking data from partner companies.[https://help.adjust.com/en/article/partner-connections]"; `branch-io`: `string` = "Branch offers the following services:\n\n- Mobile attribution[https://www.branch.io/attribution/] to “[c]apture every customer touchpoint across any channel, platform, OS to optimize […] campaigns and maximize ROI.”[https://www.branch.io/features/]\n- Ad conversion tracking. Branch can “[r]etarget app users who see a web ad and then purchase in the app, attribute revenue to the web ad that drove the install, and measure cumulative revenue from users across both web and app.”[https://www.branch.io/universal-ads/]\n- Custom audiences to “communicate the perfect message to the ideal customer, at the right moment”. “Get higher return on ad spend (ROAS) with precision retargeting of high-value active users and eliminate wasted spend in your acquisition campaigns by excluding existing customers. Re-engage lapsed users, boost propensity to purchase, and increase sessions per user.”[https://www.branch.io/engagement-builder/]\n- Fraud protection.[https://www.branch.io/fraud-protection/]\n\nBranch provides integrations to automatically “send Branch data to […] marketing and analytics partners to measure and optimize […] campaigns.”[https://www.branch.io/data-feeds/]"; `branch-io-attribution-api`: `string` = "The Branch Attribution API is used for “deep linking and session attribution. […] Every time the API is called, it will track an INSTALL, REINSTALL, or OPEN event in Branch and return deep link data in the response if the session is attributed.”[https://help.branch.io/developers-hub/reference/attribution-api] It can also track “additional downstream conversion events” like PURCHASE.[https://help.branch.io/developers-hub/reference/attribution-api#tracking-downstream-events]"; `chartboost`: `string` = "Chartboost is an advertising platform focused on mobile gaming that caters to both publishers[https://www.chartboost.com/products/monetization/] and advertisers[https://www.chartboost.com/products/advertising/].\n\nChartboost supports mediation (real-time bidding)[https://www.chartboost.com/products/mediation/], analytics[https://docs.chartboost.com/en/mediation/analytics/], and A/B testing[https://docs.chartboost.com/en/mediation/ab-tests/]."; `criteo`: `string` = "Criteo is an advertising company for online display advertisements.\n\nCriteo boasts with being able to perfectly tailor and personalize ads to each individual user, offering services like:\n\n- Predictive Bidding, which supposedly “accurately forecasts each shopper’s engagement, conversion, and average order value, and bids the right price for each ad inventory to reach them.”[https://www.criteo.com/technology/predictive-bidding/]\n- Product Recommendations, which “consider a shopper’s overall browsing habits, and go beyond what was last viewed or best sellers“[https://www.criteo.com/technology/product-recommendations/]\n- Audience Targeting: “Reengage people who already know you. Connect your customer data, and target groups like lapsed or loyal customers with dynamic ads that help them discover more of your products that they’ll love.”[https://www.criteo.com/solutions/audiences/]\n\nThese services make use of the Criteo Shopper Graph of “[r]eal-time identity data […] [to ensure] accurate cross-device identification from billions of active shoppers using multiple devices to shop”.[https://www.criteo.com/technology/shopper-graph/] This “continuously growing identity graph connects online and offline shopper identifiers […] for a holistic view of each individual’s shopping intent.”[https://www.criteo.com/technology/shopper-graph/] It also “connects shopper engagement events to products, categories and brand identifiers”.[https://www.criteo.com/technology/shopper-graph/]\n\nCriteo then uses “advanced AI algorithms” to analyze data from the Shopper Graph in real time and “[learn] from real shopper behaviors”.[https://www.criteo.com/technology/ai-engine/] The goal is to “assign a value to each customer and change the bid for every ad placement”.[https://www.criteo.com/technology/ai-engine/]\n\nCriteo lets customers “[e]nrich [their] first-party data with commerce data from 18,000+ advertisers and thousands of publishers”.[https://www.criteo.com/platform/commerce-growth/]"; `criteo-commerce-grid-prebidjs`: `string` = "Criteo Commerce Grid is a supply-side platform that superseded IPONWEB’s “The MediaGrid SSP” with Criteo’s legacy “Direct Bidder” solution.[https://www.criteo.com/wp-content/uploads/2023/06/Criteo-Launches-First-ever-Supply-side-Platform-Built-for-Commerce.pdf]\n\nIt uses the OpenRTB standard through the Prebid.org header bidding solution."; `criteo-grid-bidder-prebidjs`: `string` = "This endpoint uses the OpenRTB standard through the Prebid.js header bidding solution."; `doubleclick-cookie-matching-pixel`: `string` = "The DoubleClick Pixel for Cookie Matching is part of Google’s features for real-time bidding (RTB) to exchange user IDs between bidders and Google: “Cookie Matching is a feature that enables [bidders] to match [their] cookie—for example, an ID for a user that browsed [their] website—with a corresponding bidder-specific Google User ID, and construct user lists that can help [them] make more effective bidding choices.”[https://developers.google.com/authorized-buyers/rtb/cookie-guide]\n\nThe goal of cookie matching is to circumvent the browser security features that would otherwise restrict the reading of cookies set by another domain.[https://developers.google.com/authorized-buyers/rtb/cookie-guide#what-is-cookie-matching]\n\nCookie matching uses match tables that record the mapping from a Google User ID to the user ID in the bidder’s system (and/or vice versa). These match tables can be populated and hosted by bidders themselves or by Google, with Google recommending bidders to let Google host the match tables.[https://developers.google.com/authorized-buyers/rtb/cookie-guide#match-tables]\n\nBidders can additionally sort user IDs into user lists.[https://developers.google.com/authorized-buyers/rtb/cookie-guide#user-lists]"; `facebook-audience-network`: `string` = "Meta Audience Network is a service by Facebook that allows app developers to monetize their apps with ads.[https://developers.facebook.com/docs/audience-network] Facebook offers Audience Network SDKs for Android[https://developers.facebook.com/docs/audience-network/setting-up/platform-setup/android/add-sdk], iOS[https://developers.facebook.com/docs/audience-network/setting-up/platform-setup/ios/add-sdk], and Unity[https://developers.facebook.com/docs/audience-network/setting-up/platform-steup/unity/add-sdk]."; `facebook-graph-app-events`: `string` = "The Graph API is provided by Facebook to “get data into and out of the Facebook platform”.[https://developers.facebook.com/docs/graph-api/overview] It can be accessed through the Facebook SDKs for Android[https://developers.facebook.com/docs/android/graph] and iOS[https://developers.facebook.com/docs/ios/graph].\n\nThe App Events endpoint allows developers to “track actions that occur in [a] mobile app or web page such as app installs and purchase events” in order to “measure ad performance and build audiences for ad targeting”. The Facebook SDK automatically logs app installs, app sessions, and in-app purchases using this endpoint. Additionally, developers can manually log their own events.[https://developers.facebook.com/docs/marketing-api/app-event-api]"; `firebaseinstallations`: `string` = "The Firebase Installations service (FIS) provides a unique identifier for each installed instance of a Firebase app, called Firebase installation ID (FID).[https://firebase.google.com/docs/projects/manage-installations] “Many Firebase services depend on the Firebase Installations API in order to identify app installs and/or authenticate client requests to their servers.”[https://console.cloud.google.com/marketplace/product/google/firebaseinstallations.googleapis.com] Other purposes include user segmentation, message delivery, performance monitoring, tracking the number of unique users, or selecting which configuration values to return.[https://firebase.google.com/docs/projects/manage-installations]\n\nFIDs can also be used by Google Analytics for attribution.[https://firebase.google.com/docs/projects/manage-installations]"; `firebaseremoteconfig`: `string` = "The Firebase Remote Config service lets developers remotely change the functionality and appearance of their apps without having to publish an app update.[https://firebase.google.com/docs/remote-config]\n\nDevelopers can use user segmentation and return different configuration to different users based on app version, language, Google Analytics audience, and imported segment.[https://firebase.google.com/docs/remote-config] They can also “[use] machine learning to continuously tailor individual user experience to optimize for goals like user engagement, ad clicks, and revenue—or any custom event [they] can measure with Google Analytics”.[https://firebase.google.com/docs/remote-config] Finally, they can use A/B testing.[https://firebase.google.com/docs/remote-config]"; `google-analytics`: `string` = "Google Analytics is an analytics platform that claims to give publishers a “complete understanding of [their] customers across devices and platforms” to “[u]nderstand how [their] customers interact across […] sites and apps, throughout their entire lifecycle.”[https://marketingplatform.google.com/about/analytics/]\n\nGoogle Analytics provides JavaScript libraries, mobile app SDKs, and an open measurement protocol to collect data from website visitors and app users.[https://marketingplatform.google.com/about/analytics/features/] “Every time a user visits a webpage, the tracking code will collect pseudonymous information about how that user interacted with the page.”[https://support.google.com/analytics/answer/12159447] Based on that, Google then provides additional features:\n\n- Real-time reporting, allowing publishers to “[m]onitor activity on [their] site or app as it happens.”[https://marketingplatform.google.com/about/analytics/features/]\n- Attribution, allowing publishers to “[u]nderstand [their] customers’ paths to conversion”.[https://marketingplatform.google.com/about/analytics/features/]\n- Path and user exploration. Publishers can “[v]isualize [their] users’ paths to conversion as they interact with [their] website and app.”[https://marketingplatform.google.com/about/analytics/features/] They can even “[s]elect specific groups of users and drill down deeper to understand how those users engage with [the] site or app.“[https://marketingplatform.google.com/about/analytics/features/]\n- Funnel exploration: “Visualize the steps users take to complete tasks on [the] site or app, […] and identify over- or under-performing audiences.”[https://marketingplatform.google.com/about/analytics/features/]\n- Predictive capabilities: “By applying […] machine learning models, Analytics can analyze [publishers’] data and predict future actions people may take, like making a purchase or churning. [They] can then create audiences that are predicted to take these actions to drive conversions or retain more of [their] users.”[https://marketingplatform.google.com/about/analytics/features/]\n\nGoogle Analytics integrates with various other Google products, including Google Ads, Google Search Ads 360, Google Search Console, and Google Play.[https://marketingplatform.google.com/about/analytics/features/]\n\nThere have been multiple generations of Google Analytics. The current generation is Google Analytics 4 (GA4). The previous generation, Universal Analytics, stopped processing data in July 2023. It used property tags starting with “UA-“.[https://support.google.com/analytics/answer/11583528]"; `google-fundingchoices`: `string` = "With Google's Privacy & Messaging API (formerly Funding Choices[https://support.google.com/fundingchoices/answer/9010669?hl=en]), app developers can manage users' consent choices[https://developers.google.com/funding-choices] and show consent forms[https://developers.google.com/admob/android/privacy#load-and-show-form]. It can also be used to detect ad blockers and display messages to “recover lost revenue from ad blocking users”.[https://support.google.com/admob/answer/10107561]\n\nThe Privacy & Messaging API is available through Google's AdMob, Ad Manager, and AdSense SDKs on the web, Android, and iOS.[https://support.google.com/fundingchoices/answer/9010669?hl=en]"; `google-gtag`: `string` = "Google tag (gtag.js) is a single script that publishers can add to their website to include and use multiple Google measurement and advertising products like Google Ads, Google Analytics, Campaign Manager, Display & Video 360, and Search Ads 360.[https://developers.google.com/tag-platform/gtagjs]\n\nGoogle advertises that the Google tag can be used for example to “[a]utomatically measure page views, clicks, scrolls, and more in Google Analytics” and “[a]utomatically measure key events and campaign performance in Google Ads”.[https://support.google.com/tagmanager/answer/7582054]"; `google-publisher-tag`: `string` = "The Google Publisher Tag (GPT) is an ad tagging library for Google Ad Manager.[https://developers.google.com/publisher-tag/guides/get-started] By default, Google serves personalized ads through GPT, “with ad selection based on both the content of the web page and the history of the individual user visiting the page.”[https://support.google.com/admanager/answer/7678538]"; `googledatatransport-batchlog`: `string` = "The GoogleDataTransport SDK is a transport layer used internally by many other Firebase (e.g. Crashlytics, Performance, Core) Google (e.g. ML Kit) SDKs and services.[https://github.com/firebase/firebase-ios-sdk/issues/8220#issuecomment-858040701] It batches application-specific data from within an app to Google, using a common endpoint regardless of the actual SDK that was integrated by the app developer.[https://stackoverflow.com/a/76334853]"; `googletagmanager-gtm`: `string` = "Google Tag Manager is a tag management system that allows publishers to add and update tags for analytics, marketing, and advertising services without modifying the website/app code directly.[https://support.google.com/tagmanager/answer/6102821]\n\nIn addition to Google's own tags like Google Ads and Google Analytics, it also supports many third-party tags like Adobe Analytics, AppsFlyer, Criteo, and Microsoft Bing Ads as well as custom  tags.[https://support.google.com/tagmanager/answer/6106924]"; `id5`: `string` = "The ID5 ID is a shared identifier to be used by publishers, advertisers and ad tech platform, designed for scenarios where 3rd party cookies may not be available.[https://docs.prebid.org/dev-docs/modules/userid-submodules/id5.html] It claims to be able to recognize users across different types of devices and relies on signals like hashed email addresses, page URL, IP addresses, timestamps, as well as a machine learning algorithm.[https://github.com/id5io/id5-api.js/blob/874ace5d11a667b992650df198d53775fdb60709/README.md#id5-id] The explicit goal is to have a single user identifier that is shared across the entire ecosystem.[https://wiki.id5.io/en/identitycloud/retrieve-id5-ids/prebid-user-id-module/id5-prebid-user-id-module]\n\nID5 requires publishers and advertisers to send data like IP address and user agent, and recommends sharing data like hashed email addresses and mobile advertising IDs.[https://wiki.id5.io/identitycloud/retrieve-id5-ids/passing-partner-data-to-id5#what-is-partner-data]"; `id5-cookie-sync`: `string` = "The ID5 Cookie Sync Pixel is used to synchronize and share the ID5 ID with the user IDs of other ad tech vendors.[https://wiki.id5.io/en/identitycloud/cookie-sync-with-id5/inititiate-cookie-sync-to-id5]"; `id5-prebid-user-id`: `string` = "This endpoint is used to integrate ID5 into the User ID module of the Prebid.js header bidding solution.[https://docs.prebid.org/dev-docs/modules/userid-submodules/id5.html] With this integration, demand partners configured in Prebid can retrieve the ID5 ID and share it with server-side RTB partners, allowing them to target individual users.[https://wiki.id5.io/en/identitycloud/retrieve-id5-ids/prebid-user-id-module/id5-prebid-user-id-module#how-does-the-id5-id-work]"; `infonline`: `string` = "INFOnline provides digital audience measurement for websites and apps.[https://www.infonline.de/en/]\n\nThey offer two separate measurement systems: Census Measurement (IOMb[https://www.infonline.de/download/?wpdmdl=7135]) and INFOnline Measurement pseudonymous (IOMp[https://www.infonline.de/download/?wpdmdl=7135], formerly SZMnG[https://www.infonline.de/faqs/]). Census Measurement can be recognized by the URL path fragment “base.io”, whereas INFOnline Measurement pseudonymous uses “tx.io”.[https://docs.infonline.de/infonline-measurement/en/integration/web/checkliste\_web\_allgemein/]\n\nINFOnline boasts with constantly adapting their technology in order to circumvent browser restrictions, ad and tracking blockers, and privacy-preserving changes by operating systems.[https://www.infonline.de/measurement/]"; `infonline-pseudonymous`: `string` = "Unlike Census Measurement, which works anonymously without identifiers, INFOnline Measurement pseudonymous “is designed as a pseudonymous system (with client identifiers)”.[https://docs.infonline.de/infonline-measurement/en/getting-started/verfahrensbeschreibung/]\n\nAccording INFOnline’s own documentation, “[…] the pseudonymous INFOnline Measurement may only be loaded and executed if there is active consent from the user of [the] web page. […] The following also applies to apps: Only start the session of pseudonymous measurement if you have the user's consent.”[https://docs.infonline.de/infonline-measurement/en/getting-started/rechtliche-auswirkungen/]"; `ironsource`: `string` = "ironSource offers the following services:\n\n- Analytics.[https://www.is.com/analytics/]\n- App monetization for publishers[https://www.is.com/monetization/], including ad mediation[https://www.is.com/mediation/], real-time bidding[https://www.is.com/in-app-bidding/], and A/B testing[https://www.is.com/monetization-ab-testing/].\n- Advertising for user acquisition, to “[k]eep your best users in your portfolio with cross promotion campaigns”.[https://www.is.com/user-growth/] Advertisers can “[a]ccurately measure the ad revenue generated for each device and impression – from any ad unit, across every ad network.”[https://www.is.com/impression-level-revenue/]\n- Audience segmentation, to “[p]ersonalize the ad experience for different audiences to keep users coming back and encourage them to progress in your game”.[https://www.is.com/segments/]"; `microsoft-appcenter`: `string` = "Visual Studio App Center is a collection of services by Microsoft to help developers “continuously build, test, release,\nand monitor apps for every platform.”[https://learn.microsoft.com/en-us/appcenter/]\n\nAmong those services are:\n\n- App Center Diagnostics, to “[collect] information about crashes and errors” in apps.[https://learn.microsoft.com/en-us/appcenter/diagnostics/]\n- App Center Analytics, which “helps [developers] understand user behavior and customer engagement […]. The SDK automatically captures session count and device properties like model, OS version, etc. [Developers] can define [their] own custom events […].”[https://learn.microsoft.com/en-us/appcenter/sdk/analytics/android] By tracking events, developers can “learn more about […] users' behavior and understand the interaction between […] users and […] apps.”[https://learn.microsoft.com/en-us/appcenter/analytics/event-metrics]\n\nRegardless of the particular SDK or service, all data sent to App Center goes to a single endpoint.[https://learn.microsoft.com/en-us/appcenter/sdk/data-collected]"; `mopub`: `string` = "MoPub was a mobile app monetization service.[https://web.archive.org/web/20210126085400/https://www.mopub.com/en]\n\nMoPub has since been acquired by AppLovin and integrated into AppLovin MAX.[https://www.applovin.com/blog/applovins-acquisition-of-mopub-has-officially-closed/]"; `onesignal`: `string` = "OneSignal provides SDKs and APIs to help developers “send push notifications, in-app messages, SMS, and emails.”[https://documentation.onesignal.com/docs/onesignal-platform]\n\nFor that, it also offers personalization[https://onesignal.com/personalization], user segmentation[https://onesignal.com/targeting-segmentation], and A/B testing[https://documentation.onesignal.com/docs/ab-testing] features. Developers can “send personalized messages based on real-time user behavior, […] user attributes, events, location, language, and more”.[https://onesignal.com/personalization] Audience cohorts can be synced from various analytics providers.[https://onesignal.com/targeting-segmentation]\n\nAdditionally, OneSignal offers analytics features. Developers can “[c]reate an understanding as to how [their] messaging drives direct, indirect, and unattributed user actions” and “[e]asily quantify which messages are driving sales, engagement, and more”.[https://onesignal.com/analytics] OneSignal advertises with helping developers “know precisely when a device receives a notification”, even if “[u]sers uninstall apps, swap phones, turn off their phones, or are unreachable”.[https://onesignal.com/analytics] Analytics data can be shared with various third-party tracking companies using integrations.[https://onesignal.com/integrations/category/analytics]"; `onesignal-add-a-device`: `string` = "The “Add a device” endpoint is used ”to register a new device with OneSignal.“[https://documentation.onesignal.com/v9.0/reference/add-a-device]"; `singular-net`: `string` = "Singular offers the following services:\n\n- Analytics on a company's marketing spending and efficacy[https://www.singular.net/marketing-analytics/], with the goal of “[acquiring] the highest value users”[https://www.singular.net/ad-monetization/].\n- Tracking and attribution of users, “connecting the install of a mobile app and the user’s activities inside the app to the marketing campaign that led to the installation”.[https://www.singular.net/mobile-attribution/] “For every install, Singular scans its database for relevant ad interactions (ad clicks and ad views) that originated from the same device […]. […] The goal is to reconstruct the user journey as the first step toward finding the touchpoint that most likely led the user to install the app.”[https://support.singular.net/hc/en-us/articles/115000526963-Understanding-Singular-Mobile-App-Attribution] Additionally, Singular attributes the following events to the user: ”User sessions (i.e., every time the user opens the app), Revenue events (purchases made through the app), Any other events that are relevant to [the] app, such as sign-ups, tutorial completions, or level-ups.“, as well as app uninstalls[https://support.singular.net/hc/en-us/articles/115000526963-Understanding-Singular-Mobile-App-Attribution]\n- Mobile ad fraud prevention.[https://www.singular.net/fraud-prevention/]\n\nSingular boasts with being able to track users across devices, using “advertiser-reported IDs to tie different devices to the same user”.[https://www.singular.net/cross-device-attribution/] They claim: “By implementing an API call to the Singular SDK or server with a user ID, Singular helps you sync up users and devices in such a way that you can recognize customers or users and properly attribute conversions to ad spend and marketing activity, plus assign customers or users to cohorts, regardless of which device or platform they’re using at any given moment.”[https://www.singular.net/glossary/cross-device-attribution/]\n\nAdditionally, they pull in, aggregate, standardize, and match tracking data from thousands of partner companies in the fields of analytics, attribution, audience measurement, and ad monetization.[https://www.singular.net/partner-integrations/]"; `smartbear-bugsnag`: `string` = "BugSnag offers the following services:\n\n- Error monitoring, collecting and visualizing crash data.[https://www.bugsnag.com/error-monitoring/]\n- Real user monitoring, to “[o]ptimize your application based on real-time user actions with your application” and give “visibility into critical performance metrics like hot and cold app starts, network requests, screen-load time and more.”[https://www.bugsnag.com/real-user-monitoring/]"; `smartbear-bugsnag-notify`: `string` = "The Error Reporting API is used to send error reports and crashes to BugSnag.[https://bugsnagerrorreportingapi.docs.apiary.io/#reference/0/minidump/send-error-reports]"; `smartbear-bugsnag-session`: `string` = "The Session Tracking API is used to “notify Bugsnag of sessions starting in web, mobile or desktop applications.”[https://bugsnagsessiontrackingapi.docs.apiary.io/#reference/0/session/report-a-session-starting]" }  } |
| `en.properties` | { `accelerometerX`: `string` = "Accelerometer X"; `accelerometerY`: `string` = "Accelerometer Y"; `accelerometerZ`: `string` = "Accelerometer Z"; `advertisingId`: `string` = "Device advertising ID (GAID/IDFA)"; `appId`: `string` = "App ID"; `appName`: `string` = "App name"; `appVersion`: `string` = "App version"; `architecture`: `string` = "Architecture"; `batteryLevel`: `string` = "Battery level"; `browserId`: `string` = "Unique ID for the browser"; `browserWindowHeight`: `string` = "Browser window height"; `browserWindowWidth`: `string` = "Browser window width"; `campaignCreative`: `string` = "Campaign creative/content (utm\_content)"; `campaignCreativePosition`: `string` = "Campaign creative position"; `campaignMedium`: `string` = "Campaign medium (utm\_medium)"; `campaignName`: `string` = "Campaign name/ID (utm\_campaign)"; `campaignSource`: `string` = "Campaign source (utm\_source)"; `campaignTerm`: `string` = "Campaign term/keyword (utm\_term)"; `carrier`: `string` = "Carrier"; `consentState`: `string` = "Consent state"; `country`: `string` = "Country"; `currency`: `string` = "Currency"; `developerScopedId`: `string` = "Developer-scoped device ID (IDFV/ASID/ANDROID\_ID)"; `deviceId`: `string` = "Unique device ID"; `deviceName`: `string` = "Device name"; `diskFree`: `string` = "Free disk space"; `diskTotal`: `string` = "Total disk space"; `diskUsed`: `string` = "Used disk space"; `errorInformation`: `string` = "Error information"; `hashedAdvertisingId`: `string` = "Hashed device advertising ID"; `installTime`: `string` = "App install time"; `installationId`: `string` = "Unique installation ID"; `interactedElement`: `string` = "Element the user interacted with"; `isAutomated`: `string` = "Is device/browser controlled automatically?"; `isCharging`: `string` = "Charging status"; `isConversion`: `string` = "Is this a conversion event?"; `isDntEnabled`: `string` = "Is “Do Not Track” enabled?"; `isEmulator`: `string` = "Is device an emulator?"; `isFirstLaunch`: `string` = "Is first launch/visit?"; `isInDarkMode`: `string` = "Is app in dark mode?"; `isInForeground`: `string` = "Is app in foreground?"; `isJsEnabled`: `string` = "Is JavaScript enabled?"; `isMobileDevice`: `string` = "Is device a mobile device?"; `isRoaming`: `string` = "Is device roaming?"; `isRooted`: `string` = "Is device rooted?"; `isUserActive`: `string` = "Is user active?"; `isUserInactive`: `string` = "Is user inactive?"; `language`: `string` = "Language"; `lastActivityTime`: `string` = "Time of last activity by the user"; `latitude`: `string` = "Latitude"; `localIp`: `string` = "Local IP address(es)"; `longitude`: `string` = "Longitude"; `macAddress`: `string` = "MAC address"; `manufacturer`: `string` = "Manufacturer"; `model`: `string` = "Model"; `networkConnectionType`: `string` = "Network connection type"; `orientation`: `string` = "Orientation"; `osName`: `string` = "OS name"; `osVersion`: `string` = "OS version"; `otherIdentifiers`: `string` = "Other unique identifier"; `pageHeight`: `string` = "Page height"; `pageWidth`: `string` = "Page width"; `propertyId`: `string` = "ID for the property (website/app)"; `publicIp`: `string` = "Public IP address"; `pushNotificationToken`: `string` = "Push notification token"; `ramFree`: `string` = "Free RAM"; `ramTotal`: `string` = "Total RAM"; `ramUsed`: `string` = "Used RAM"; `referer`: `string` = "Referer"; `revenue`: `string` = "Earned revenue"; `rotationX`: `string` = "Rotation X"; `rotationY`: `string` = "Rotation Y"; `rotationZ`: `string` = "Rotation Z"; `screenColorDepth`: `string` = "Screen color depth"; `screenHeight`: `string` = "Screen height"; `screenWidth`: `string` = "Screen width"; `scrollPositionX`: `string` = "Scroll position X"; `scrollPositionY`: `string` = "Scroll position Y"; `segment`: `string` = "Segment for the user"; `sessionCount`: `string` = "Session count"; `sessionDuration`: `string` = "Session duration"; `sessionId`: `string` = "Unique session ID"; `signalStrengthCellular`: `string` = "Signal strength (cellular)"; `signalStrengthWifi`: `string` = "Signal strength (Wi-Fi)"; `startTime`: `string` = "App start time"; `state`: `string` = "State/Sub national entity"; `timeSpent`: `string` = "Time spent in app"; `timezone`: `string` = "Time zone"; `trackerSdkVersion`: `string` = "Tracker SDK version"; `uptime`: `string` = "Uptime"; `userAction`: `string` = "Action performed by the user"; `userActionSource`: `string` = "Source of the action performed by the user"; `userActiveTime`: `string` = "How long has the user been active?"; `userAgent`: `string` = "User agent"; `userGender`: `string` = "Gender of the user"; `userId`: `string` = "Unique user ID"; `userInterests`: `string` = "User interests"; `viewedPage`: `string` = "Viewed page"; `viewedPageCategory`: `string` = "Category of the viewed page"; `viewedPageKeywords`: `string` = "Keywords related to the viewed page"; `viewedPageLanguage`: `string` = "Language of the viewed page"; `volume`: `string` = "Volume"; `websiteName`: `string` = "Website name"; `websiteUrl`: `string` = "Website URL" } |
| `en.properties.accelerometerX` | `string` |
| `en.properties.accelerometerY` | `string` |
| `en.properties.accelerometerZ` | `string` |
| `en.properties.advertisingId` | `string` |
| `en.properties.appId` | `string` |
| `en.properties.appName` | `string` |
| `en.properties.appVersion` | `string` |
| `en.properties.architecture` | `string` |
| `en.properties.batteryLevel` | `string` |
| `en.properties.browserId` | `string` |
| `en.properties.browserWindowHeight` | `string` |
| `en.properties.browserWindowWidth` | `string` |
| `en.properties.campaignCreative` | `string` |
| `en.properties.campaignCreativePosition` | `string` |
| `en.properties.campaignMedium` | `string` |
| `en.properties.campaignName` | `string` |
| `en.properties.campaignSource` | `string` |
| `en.properties.campaignTerm` | `string` |
| `en.properties.carrier` | `string` |
| `en.properties.consentState` | `string` |
| `en.properties.country` | `string` |
| `en.properties.currency` | `string` |
| `en.properties.developerScopedId` | `string` |
| `en.properties.deviceId` | `string` |
| `en.properties.deviceName` | `string` |
| `en.properties.diskFree` | `string` |
| `en.properties.diskTotal` | `string` |
| `en.properties.diskUsed` | `string` |
| `en.properties.errorInformation` | `string` |
| `en.properties.hashedAdvertisingId` | `string` |
| `en.properties.installTime` | `string` |
| `en.properties.installationId` | `string` |
| `en.properties.interactedElement` | `string` |
| `en.properties.isAutomated` | `string` |
| `en.properties.isCharging` | `string` |
| `en.properties.isConversion` | `string` |
| `en.properties.isDntEnabled` | `string` |
| `en.properties.isEmulator` | `string` |
| `en.properties.isFirstLaunch` | `string` |
| `en.properties.isInDarkMode` | `string` |
| `en.properties.isInForeground` | `string` |
| `en.properties.isJsEnabled` | `string` |
| `en.properties.isMobileDevice` | `string` |
| `en.properties.isRoaming` | `string` |
| `en.properties.isRooted` | `string` |
| `en.properties.isUserActive` | `string` |
| `en.properties.isUserInactive` | `string` |
| `en.properties.language` | `string` |
| `en.properties.lastActivityTime` | `string` |
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
| `en.properties.pageHeight` | `string` |
| `en.properties.pageWidth` | `string` |
| `en.properties.propertyId` | `string` |
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
| `en.properties.screenColorDepth` | `string` |
| `en.properties.screenHeight` | `string` |
| `en.properties.screenWidth` | `string` |
| `en.properties.scrollPositionX` | `string` |
| `en.properties.scrollPositionY` | `string` |
| `en.properties.segment` | `string` |
| `en.properties.sessionCount` | `string` |
| `en.properties.sessionDuration` | `string` |
| `en.properties.sessionId` | `string` |
| `en.properties.signalStrengthCellular` | `string` |
| `en.properties.signalStrengthWifi` | `string` |
| `en.properties.startTime` | `string` |
| `en.properties.state` | `string` |
| `en.properties.timeSpent` | `string` |
| `en.properties.timezone` | `string` |
| `en.properties.trackerSdkVersion` | `string` |
| `en.properties.uptime` | `string` |
| `en.properties.userAction` | `string` |
| `en.properties.userActionSource` | `string` |
| `en.properties.userActiveTime` | `string` |
| `en.properties.userAgent` | `string` |
| `en.properties.userGender` | `string` |
| `en.properties.userId` | `string` |
| `en.properties.userInterests` | `string` |
| `en.properties.viewedPage` | `string` |
| `en.properties.viewedPageCategory` | `string` |
| `en.properties.viewedPageKeywords` | `string` |
| `en.properties.viewedPageLanguage` | `string` |
| `en.properties.volume` | `string` |
| `en.properties.websiteName` | `string` |
| `en.properties.websiteUrl` | `string` |
| `en.tracker-descriptions` | { `adjust`: `string` = "Adjust offers the following services:\n\n- User engagement tracking using events. “You can define in-app events for your app to measure user registrations, add-to-carts, or level ups, while setting up revenue events lets you record in-app purchases and transactions. Set up events to: See where your users go directly after install, Discover the app features your users like the most, Identify the last thing a user does before they become inactive”[https://help.adjust.com/en/article/add-events]\n- Mobile attribution, in order to “[i]dentify [the] best users and channels”.[https://www.adjust.com/product/mobile-app-attribution/] “Adjust's attribution matches your app users to the source that drove their install. You can use this attribution data to measure campaign performance, run effective retargeting campaigns, optimize your creative assets, and more.”[https://help.adjust.com/en/article/attribution-methods] Additionally, “Adjust can reattribute dormant users who engage with a new source and then return to [the] app.”[https://help.adjust.com/en/article/reattribution]\n\n  Adjust uses two attribution methods:\n    - “Deterministic attribution is Adjust's main attribution method and involves device matching. We collect a unique identifier from recorded engagements and installs, and if both IDs match, we can attribute that engagement to the install. With a 100% accuracy rate, click-based device matching is the most reliable attribution method. We use deterministic attribution to attribute installs (first app opens) and reattribute (assign new attribution sources to) inactive users. Adjust uses the following identifiers for deterministic attribution: Advertising IDs […], Device IDs […], Adjust reftags […]”[https://help.adjust.com/en/article/attribution-methods#deterministic-attribution]\n    - “Probabilistic modeling […] uses machine learning to support a statistical approach to measurement.”[https://help.adjust.com/en/article/attribution-methods#probabilistic-modeling]\n- Uninstall and reinstall tracking. “When a user installs [the] app, the app is given a unique push token which the Adjust SDK forwards to Adjust's servers. Silent push notifications are then sent once per day to check if the app is still installed.”[https://help.adjust.com/en/article/uninstalls-reinstalls]\n- Audience segmentation to “group users together based on […] criteria”.[https://www.adjust.com/product/audience-builder/]\n- Fraud prevention. “Organic users are captured accurately and not misattributed”.[https://www.adjust.com/product/fraud-prevention/]\n\nAdditionally, Adjust can pull in tracking data from partner companies.[https://help.adjust.com/en/article/partner-connections]"; `branch-io`: `string` = "Branch offers the following services:\n\n- Mobile attribution[https://www.branch.io/attribution/] to “[c]apture every customer touchpoint across any channel, platform, OS to optimize […] campaigns and maximize ROI.”[https://www.branch.io/features/]\n- Ad conversion tracking. Branch can “[r]etarget app users who see a web ad and then purchase in the app, attribute revenue to the web ad that drove the install, and measure cumulative revenue from users across both web and app.”[https://www.branch.io/universal-ads/]\n- Custom audiences to “communicate the perfect message to the ideal customer, at the right moment”. “Get higher return on ad spend (ROAS) with precision retargeting of high-value active users and eliminate wasted spend in your acquisition campaigns by excluding existing customers. Re-engage lapsed users, boost propensity to purchase, and increase sessions per user.”[https://www.branch.io/engagement-builder/]\n- Fraud protection.[https://www.branch.io/fraud-protection/]\n\nBranch provides integrations to automatically “send Branch data to […] marketing and analytics partners to measure and optimize […] campaigns.”[https://www.branch.io/data-feeds/]"; `branch-io-attribution-api`: `string` = "The Branch Attribution API is used for “deep linking and session attribution. […] Every time the API is called, it will track an INSTALL, REINSTALL, or OPEN event in Branch and return deep link data in the response if the session is attributed.”[https://help.branch.io/developers-hub/reference/attribution-api] It can also track “additional downstream conversion events” like PURCHASE.[https://help.branch.io/developers-hub/reference/attribution-api#tracking-downstream-events]"; `chartboost`: `string` = "Chartboost is an advertising platform focused on mobile gaming that caters to both publishers[https://www.chartboost.com/products/monetization/] and advertisers[https://www.chartboost.com/products/advertising/].\n\nChartboost supports mediation (real-time bidding)[https://www.chartboost.com/products/mediation/], analytics[https://docs.chartboost.com/en/mediation/analytics/], and A/B testing[https://docs.chartboost.com/en/mediation/ab-tests/]."; `criteo`: `string` = "Criteo is an advertising company for online display advertisements.\n\nCriteo boasts with being able to perfectly tailor and personalize ads to each individual user, offering services like:\n\n- Predictive Bidding, which supposedly “accurately forecasts each shopper’s engagement, conversion, and average order value, and bids the right price for each ad inventory to reach them.”[https://www.criteo.com/technology/predictive-bidding/]\n- Product Recommendations, which “consider a shopper’s overall browsing habits, and go beyond what was last viewed or best sellers“[https://www.criteo.com/technology/product-recommendations/]\n- Audience Targeting: “Reengage people who already know you. Connect your customer data, and target groups like lapsed or loyal customers with dynamic ads that help them discover more of your products that they’ll love.”[https://www.criteo.com/solutions/audiences/]\n\nThese services make use of the Criteo Shopper Graph of “[r]eal-time identity data […] [to ensure] accurate cross-device identification from billions of active shoppers using multiple devices to shop”.[https://www.criteo.com/technology/shopper-graph/] This “continuously growing identity graph connects online and offline shopper identifiers […] for a holistic view of each individual’s shopping intent.”[https://www.criteo.com/technology/shopper-graph/] It also “connects shopper engagement events to products, categories and brand identifiers”.[https://www.criteo.com/technology/shopper-graph/]\n\nCriteo then uses “advanced AI algorithms” to analyze data from the Shopper Graph in real time and “[learn] from real shopper behaviors”.[https://www.criteo.com/technology/ai-engine/] The goal is to “assign a value to each customer and change the bid for every ad placement”.[https://www.criteo.com/technology/ai-engine/]\n\nCriteo lets customers “[e]nrich [their] first-party data with commerce data from 18,000+ advertisers and thousands of publishers”.[https://www.criteo.com/platform/commerce-growth/]"; `criteo-commerce-grid-prebidjs`: `string` = "Criteo Commerce Grid is a supply-side platform that superseded IPONWEB’s “The MediaGrid SSP” with Criteo’s legacy “Direct Bidder” solution.[https://www.criteo.com/wp-content/uploads/2023/06/Criteo-Launches-First-ever-Supply-side-Platform-Built-for-Commerce.pdf]\n\nIt uses the OpenRTB standard through the Prebid.org header bidding solution."; `criteo-grid-bidder-prebidjs`: `string` = "This endpoint uses the OpenRTB standard through the Prebid.js header bidding solution."; `doubleclick-cookie-matching-pixel`: `string` = "The DoubleClick Pixel for Cookie Matching is part of Google’s features for real-time bidding (RTB) to exchange user IDs between bidders and Google: “Cookie Matching is a feature that enables [bidders] to match [their] cookie—for example, an ID for a user that browsed [their] website—with a corresponding bidder-specific Google User ID, and construct user lists that can help [them] make more effective bidding choices.”[https://developers.google.com/authorized-buyers/rtb/cookie-guide]\n\nThe goal of cookie matching is to circumvent the browser security features that would otherwise restrict the reading of cookies set by another domain.[https://developers.google.com/authorized-buyers/rtb/cookie-guide#what-is-cookie-matching]\n\nCookie matching uses match tables that record the mapping from a Google User ID to the user ID in the bidder’s system (and/or vice versa). These match tables can be populated and hosted by bidders themselves or by Google, with Google recommending bidders to let Google host the match tables.[https://developers.google.com/authorized-buyers/rtb/cookie-guide#match-tables]\n\nBidders can additionally sort user IDs into user lists.[https://developers.google.com/authorized-buyers/rtb/cookie-guide#user-lists]"; `facebook-audience-network`: `string` = "Meta Audience Network is a service by Facebook that allows app developers to monetize their apps with ads.[https://developers.facebook.com/docs/audience-network] Facebook offers Audience Network SDKs for Android[https://developers.facebook.com/docs/audience-network/setting-up/platform-setup/android/add-sdk], iOS[https://developers.facebook.com/docs/audience-network/setting-up/platform-setup/ios/add-sdk], and Unity[https://developers.facebook.com/docs/audience-network/setting-up/platform-steup/unity/add-sdk]."; `facebook-graph-app-events`: `string` = "The Graph API is provided by Facebook to “get data into and out of the Facebook platform”.[https://developers.facebook.com/docs/graph-api/overview] It can be accessed through the Facebook SDKs for Android[https://developers.facebook.com/docs/android/graph] and iOS[https://developers.facebook.com/docs/ios/graph].\n\nThe App Events endpoint allows developers to “track actions that occur in [a] mobile app or web page such as app installs and purchase events” in order to “measure ad performance and build audiences for ad targeting”. The Facebook SDK automatically logs app installs, app sessions, and in-app purchases using this endpoint. Additionally, developers can manually log their own events.[https://developers.facebook.com/docs/marketing-api/app-event-api]"; `firebaseinstallations`: `string` = "The Firebase Installations service (FIS) provides a unique identifier for each installed instance of a Firebase app, called Firebase installation ID (FID).[https://firebase.google.com/docs/projects/manage-installations] “Many Firebase services depend on the Firebase Installations API in order to identify app installs and/or authenticate client requests to their servers.”[https://console.cloud.google.com/marketplace/product/google/firebaseinstallations.googleapis.com] Other purposes include user segmentation, message delivery, performance monitoring, tracking the number of unique users, or selecting which configuration values to return.[https://firebase.google.com/docs/projects/manage-installations]\n\nFIDs can also be used by Google Analytics for attribution.[https://firebase.google.com/docs/projects/manage-installations]"; `firebaseremoteconfig`: `string` = "The Firebase Remote Config service lets developers remotely change the functionality and appearance of their apps without having to publish an app update.[https://firebase.google.com/docs/remote-config]\n\nDevelopers can use user segmentation and return different configuration to different users based on app version, language, Google Analytics audience, and imported segment.[https://firebase.google.com/docs/remote-config] They can also “[use] machine learning to continuously tailor individual user experience to optimize for goals like user engagement, ad clicks, and revenue—or any custom event [they] can measure with Google Analytics”.[https://firebase.google.com/docs/remote-config] Finally, they can use A/B testing.[https://firebase.google.com/docs/remote-config]"; `google-analytics`: `string` = "Google Analytics is an analytics platform that claims to give publishers a “complete understanding of [their] customers across devices and platforms” to “[u]nderstand how [their] customers interact across […] sites and apps, throughout their entire lifecycle.”[https://marketingplatform.google.com/about/analytics/]\n\nGoogle Analytics provides JavaScript libraries, mobile app SDKs, and an open measurement protocol to collect data from website visitors and app users.[https://marketingplatform.google.com/about/analytics/features/] “Every time a user visits a webpage, the tracking code will collect pseudonymous information about how that user interacted with the page.”[https://support.google.com/analytics/answer/12159447] Based on that, Google then provides additional features:\n\n- Real-time reporting, allowing publishers to “[m]onitor activity on [their] site or app as it happens.”[https://marketingplatform.google.com/about/analytics/features/]\n- Attribution, allowing publishers to “[u]nderstand [their] customers’ paths to conversion”.[https://marketingplatform.google.com/about/analytics/features/]\n- Path and user exploration. Publishers can “[v]isualize [their] users’ paths to conversion as they interact with [their] website and app.”[https://marketingplatform.google.com/about/analytics/features/] They can even “[s]elect specific groups of users and drill down deeper to understand how those users engage with [the] site or app.“[https://marketingplatform.google.com/about/analytics/features/]\n- Funnel exploration: “Visualize the steps users take to complete tasks on [the] site or app, […] and identify over- or under-performing audiences.”[https://marketingplatform.google.com/about/analytics/features/]\n- Predictive capabilities: “By applying […] machine learning models, Analytics can analyze [publishers’] data and predict future actions people may take, like making a purchase or churning. [They] can then create audiences that are predicted to take these actions to drive conversions or retain more of [their] users.”[https://marketingplatform.google.com/about/analytics/features/]\n\nGoogle Analytics integrates with various other Google products, including Google Ads, Google Search Ads 360, Google Search Console, and Google Play.[https://marketingplatform.google.com/about/analytics/features/]\n\nThere have been multiple generations of Google Analytics. The current generation is Google Analytics 4 (GA4). The previous generation, Universal Analytics, stopped processing data in July 2023. It used property tags starting with “UA-“.[https://support.google.com/analytics/answer/11583528]"; `google-fundingchoices`: `string` = "With Google's Privacy & Messaging API (formerly Funding Choices[https://support.google.com/fundingchoices/answer/9010669?hl=en]), app developers can manage users' consent choices[https://developers.google.com/funding-choices] and show consent forms[https://developers.google.com/admob/android/privacy#load-and-show-form]. It can also be used to detect ad blockers and display messages to “recover lost revenue from ad blocking users”.[https://support.google.com/admob/answer/10107561]\n\nThe Privacy & Messaging API is available through Google's AdMob, Ad Manager, and AdSense SDKs on the web, Android, and iOS.[https://support.google.com/fundingchoices/answer/9010669?hl=en]"; `google-gtag`: `string` = "Google tag (gtag.js) is a single script that publishers can add to their website to include and use multiple Google measurement and advertising products like Google Ads, Google Analytics, Campaign Manager, Display & Video 360, and Search Ads 360.[https://developers.google.com/tag-platform/gtagjs]\n\nGoogle advertises that the Google tag can be used for example to “[a]utomatically measure page views, clicks, scrolls, and more in Google Analytics” and “[a]utomatically measure key events and campaign performance in Google Ads”.[https://support.google.com/tagmanager/answer/7582054]"; `google-publisher-tag`: `string` = "The Google Publisher Tag (GPT) is an ad tagging library for Google Ad Manager.[https://developers.google.com/publisher-tag/guides/get-started] By default, Google serves personalized ads through GPT, “with ad selection based on both the content of the web page and the history of the individual user visiting the page.”[https://support.google.com/admanager/answer/7678538]"; `googledatatransport-batchlog`: `string` = "The GoogleDataTransport SDK is a transport layer used internally by many other Firebase (e.g. Crashlytics, Performance, Core) Google (e.g. ML Kit) SDKs and services.[https://github.com/firebase/firebase-ios-sdk/issues/8220#issuecomment-858040701] It batches application-specific data from within an app to Google, using a common endpoint regardless of the actual SDK that was integrated by the app developer.[https://stackoverflow.com/a/76334853]"; `googletagmanager-gtm`: `string` = "Google Tag Manager is a tag management system that allows publishers to add and update tags for analytics, marketing, and advertising services without modifying the website/app code directly.[https://support.google.com/tagmanager/answer/6102821]\n\nIn addition to Google's own tags like Google Ads and Google Analytics, it also supports many third-party tags like Adobe Analytics, AppsFlyer, Criteo, and Microsoft Bing Ads as well as custom  tags.[https://support.google.com/tagmanager/answer/6106924]"; `id5`: `string` = "The ID5 ID is a shared identifier to be used by publishers, advertisers and ad tech platform, designed for scenarios where 3rd party cookies may not be available.[https://docs.prebid.org/dev-docs/modules/userid-submodules/id5.html] It claims to be able to recognize users across different types of devices and relies on signals like hashed email addresses, page URL, IP addresses, timestamps, as well as a machine learning algorithm.[https://github.com/id5io/id5-api.js/blob/874ace5d11a667b992650df198d53775fdb60709/README.md#id5-id] The explicit goal is to have a single user identifier that is shared across the entire ecosystem.[https://wiki.id5.io/en/identitycloud/retrieve-id5-ids/prebid-user-id-module/id5-prebid-user-id-module]\n\nID5 requires publishers and advertisers to send data like IP address and user agent, and recommends sharing data like hashed email addresses and mobile advertising IDs.[https://wiki.id5.io/identitycloud/retrieve-id5-ids/passing-partner-data-to-id5#what-is-partner-data]"; `id5-cookie-sync`: `string` = "The ID5 Cookie Sync Pixel is used to synchronize and share the ID5 ID with the user IDs of other ad tech vendors.[https://wiki.id5.io/en/identitycloud/cookie-sync-with-id5/inititiate-cookie-sync-to-id5]"; `id5-prebid-user-id`: `string` = "This endpoint is used to integrate ID5 into the User ID module of the Prebid.js header bidding solution.[https://docs.prebid.org/dev-docs/modules/userid-submodules/id5.html] With this integration, demand partners configured in Prebid can retrieve the ID5 ID and share it with server-side RTB partners, allowing them to target individual users.[https://wiki.id5.io/en/identitycloud/retrieve-id5-ids/prebid-user-id-module/id5-prebid-user-id-module#how-does-the-id5-id-work]"; `infonline`: `string` = "INFOnline provides digital audience measurement for websites and apps.[https://www.infonline.de/en/]\n\nThey offer two separate measurement systems: Census Measurement (IOMb[https://www.infonline.de/download/?wpdmdl=7135]) and INFOnline Measurement pseudonymous (IOMp[https://www.infonline.de/download/?wpdmdl=7135], formerly SZMnG[https://www.infonline.de/faqs/]). Census Measurement can be recognized by the URL path fragment “base.io”, whereas INFOnline Measurement pseudonymous uses “tx.io”.[https://docs.infonline.de/infonline-measurement/en/integration/web/checkliste\_web\_allgemein/]\n\nINFOnline boasts with constantly adapting their technology in order to circumvent browser restrictions, ad and tracking blockers, and privacy-preserving changes by operating systems.[https://www.infonline.de/measurement/]"; `infonline-pseudonymous`: `string` = "Unlike Census Measurement, which works anonymously without identifiers, INFOnline Measurement pseudonymous “is designed as a pseudonymous system (with client identifiers)”.[https://docs.infonline.de/infonline-measurement/en/getting-started/verfahrensbeschreibung/]\n\nAccording INFOnline’s own documentation, “[…] the pseudonymous INFOnline Measurement may only be loaded and executed if there is active consent from the user of [the] web page. […] The following also applies to apps: Only start the session of pseudonymous measurement if you have the user's consent.”[https://docs.infonline.de/infonline-measurement/en/getting-started/rechtliche-auswirkungen/]"; `ironsource`: `string` = "ironSource offers the following services:\n\n- Analytics.[https://www.is.com/analytics/]\n- App monetization for publishers[https://www.is.com/monetization/], including ad mediation[https://www.is.com/mediation/], real-time bidding[https://www.is.com/in-app-bidding/], and A/B testing[https://www.is.com/monetization-ab-testing/].\n- Advertising for user acquisition, to “[k]eep your best users in your portfolio with cross promotion campaigns”.[https://www.is.com/user-growth/] Advertisers can “[a]ccurately measure the ad revenue generated for each device and impression – from any ad unit, across every ad network.”[https://www.is.com/impression-level-revenue/]\n- Audience segmentation, to “[p]ersonalize the ad experience for different audiences to keep users coming back and encourage them to progress in your game”.[https://www.is.com/segments/]"; `microsoft-appcenter`: `string` = "Visual Studio App Center is a collection of services by Microsoft to help developers “continuously build, test, release,\nand monitor apps for every platform.”[https://learn.microsoft.com/en-us/appcenter/]\n\nAmong those services are:\n\n- App Center Diagnostics, to “[collect] information about crashes and errors” in apps.[https://learn.microsoft.com/en-us/appcenter/diagnostics/]\n- App Center Analytics, which “helps [developers] understand user behavior and customer engagement […]. The SDK automatically captures session count and device properties like model, OS version, etc. [Developers] can define [their] own custom events […].”[https://learn.microsoft.com/en-us/appcenter/sdk/analytics/android] By tracking events, developers can “learn more about […] users' behavior and understand the interaction between […] users and […] apps.”[https://learn.microsoft.com/en-us/appcenter/analytics/event-metrics]\n\nRegardless of the particular SDK or service, all data sent to App Center goes to a single endpoint.[https://learn.microsoft.com/en-us/appcenter/sdk/data-collected]"; `mopub`: `string` = "MoPub was a mobile app monetization service.[https://web.archive.org/web/20210126085400/https://www.mopub.com/en]\n\nMoPub has since been acquired by AppLovin and integrated into AppLovin MAX.[https://www.applovin.com/blog/applovins-acquisition-of-mopub-has-officially-closed/]"; `onesignal`: `string` = "OneSignal provides SDKs and APIs to help developers “send push notifications, in-app messages, SMS, and emails.”[https://documentation.onesignal.com/docs/onesignal-platform]\n\nFor that, it also offers personalization[https://onesignal.com/personalization], user segmentation[https://onesignal.com/targeting-segmentation], and A/B testing[https://documentation.onesignal.com/docs/ab-testing] features. Developers can “send personalized messages based on real-time user behavior, […] user attributes, events, location, language, and more”.[https://onesignal.com/personalization] Audience cohorts can be synced from various analytics providers.[https://onesignal.com/targeting-segmentation]\n\nAdditionally, OneSignal offers analytics features. Developers can “[c]reate an understanding as to how [their] messaging drives direct, indirect, and unattributed user actions” and “[e]asily quantify which messages are driving sales, engagement, and more”.[https://onesignal.com/analytics] OneSignal advertises with helping developers “know precisely when a device receives a notification”, even if “[u]sers uninstall apps, swap phones, turn off their phones, or are unreachable”.[https://onesignal.com/analytics] Analytics data can be shared with various third-party tracking companies using integrations.[https://onesignal.com/integrations/category/analytics]"; `onesignal-add-a-device`: `string` = "The “Add a device” endpoint is used ”to register a new device with OneSignal.“[https://documentation.onesignal.com/v9.0/reference/add-a-device]"; `singular-net`: `string` = "Singular offers the following services:\n\n- Analytics on a company's marketing spending and efficacy[https://www.singular.net/marketing-analytics/], with the goal of “[acquiring] the highest value users”[https://www.singular.net/ad-monetization/].\n- Tracking and attribution of users, “connecting the install of a mobile app and the user’s activities inside the app to the marketing campaign that led to the installation”.[https://www.singular.net/mobile-attribution/] “For every install, Singular scans its database for relevant ad interactions (ad clicks and ad views) that originated from the same device […]. […] The goal is to reconstruct the user journey as the first step toward finding the touchpoint that most likely led the user to install the app.”[https://support.singular.net/hc/en-us/articles/115000526963-Understanding-Singular-Mobile-App-Attribution] Additionally, Singular attributes the following events to the user: ”User sessions (i.e., every time the user opens the app), Revenue events (purchases made through the app), Any other events that are relevant to [the] app, such as sign-ups, tutorial completions, or level-ups.“, as well as app uninstalls[https://support.singular.net/hc/en-us/articles/115000526963-Understanding-Singular-Mobile-App-Attribution]\n- Mobile ad fraud prevention.[https://www.singular.net/fraud-prevention/]\n\nSingular boasts with being able to track users across devices, using “advertiser-reported IDs to tie different devices to the same user”.[https://www.singular.net/cross-device-attribution/] They claim: “By implementing an API call to the Singular SDK or server with a user ID, Singular helps you sync up users and devices in such a way that you can recognize customers or users and properly attribute conversions to ad spend and marketing activity, plus assign customers or users to cohorts, regardless of which device or platform they’re using at any given moment.”[https://www.singular.net/glossary/cross-device-attribution/]\n\nAdditionally, they pull in, aggregate, standardize, and match tracking data from thousands of partner companies in the fields of analytics, attribution, audience measurement, and ad monetization.[https://www.singular.net/partner-integrations/]"; `smartbear-bugsnag`: `string` = "BugSnag offers the following services:\n\n- Error monitoring, collecting and visualizing crash data.[https://www.bugsnag.com/error-monitoring/]\n- Real user monitoring, to “[o]ptimize your application based on real-time user actions with your application” and give “visibility into critical performance metrics like hot and cold app starts, network requests, screen-load time and more.”[https://www.bugsnag.com/real-user-monitoring/]"; `smartbear-bugsnag-notify`: `string` = "The Error Reporting API is used to send error reports and crashes to BugSnag.[https://bugsnagerrorreportingapi.docs.apiary.io/#reference/0/minidump/send-error-reports]"; `smartbear-bugsnag-session`: `string` = "The Session Tracking API is used to “notify Bugsnag of sessions starting in web, mobile or desktop applications.”[https://bugsnagsessiontrackingapi.docs.apiary.io/#reference/0/session/report-a-session-starting]" } |
| `en.tracker-descriptions.adjust` | `string` |
| `en.tracker-descriptions.branch-io` | `string` |
| `en.tracker-descriptions.branch-io-attribution-api` | `string` |
| `en.tracker-descriptions.chartboost` | `string` |
| `en.tracker-descriptions.criteo` | `string` |
| `en.tracker-descriptions.criteo-commerce-grid-prebidjs` | `string` |
| `en.tracker-descriptions.criteo-grid-bidder-prebidjs` | `string` |
| `en.tracker-descriptions.doubleclick-cookie-matching-pixel` | `string` |
| `en.tracker-descriptions.facebook-audience-network` | `string` |
| `en.tracker-descriptions.facebook-graph-app-events` | `string` |
| `en.tracker-descriptions.firebaseinstallations` | `string` |
| `en.tracker-descriptions.firebaseremoteconfig` | `string` |
| `en.tracker-descriptions.google-analytics` | `string` |
| `en.tracker-descriptions.google-fundingchoices` | `string` |
| `en.tracker-descriptions.google-gtag` | `string` |
| `en.tracker-descriptions.google-publisher-tag` | `string` |
| `en.tracker-descriptions.googledatatransport-batchlog` | `string` |
| `en.tracker-descriptions.googletagmanager-gtm` | `string` |
| `en.tracker-descriptions.id5` | `string` |
| `en.tracker-descriptions.id5-cookie-sync` | `string` |
| `en.tracker-descriptions.id5-prebid-user-id` | `string` |
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

[src/lib/translations.ts:5](https://github.com/tweaselORG/ReportHAR/blob/main/src/lib/translations.ts#L5)

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

[src/index.ts:144](https://github.com/tweaselORG/ReportHAR/blob/main/src/index.ts#L144)

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

[src/lib/generate.ts:195](https://github.com/tweaselORG/ReportHAR/blob/main/src/lib/generate.ts#L195)

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

[src/lib/user-network-activity.ts:94](https://github.com/tweaselORG/ReportHAR/blob/main/src/lib/user-network-activity.ts#L94)
