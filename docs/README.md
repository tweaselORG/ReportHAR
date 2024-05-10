reporthar

# reporthar

## Table of contents

### Type Aliases

- [Analysis](README.md#analysis)
- [App](README.md#app)
- [ComplaintOptions](README.md#complaintoptions)
- [GenerateAdvancedOptions](README.md#generateadvancedoptions)
- [GenerateAdvancedOptionsComplaint](README.md#generateadvancedoptionscomplaint)
- [GenerateAdvancedOptionsDefault](README.md#generateadvancedoptionsdefault)
- [GenerateOptions](README.md#generateoptions)
- [GenerateOptionsComplaint](README.md#generateoptionscomplaint)
- [GenerateOptionsDefault](README.md#generateoptionsdefault)
- [IosAppPrivacyReportNetworkActivityEntry](README.md#iosappprivacyreportnetworkactivityentry)
- [NetworkActivityReport](README.md#networkactivityreport)
- [SupportedLanguage](README.md#supportedlanguage)
- [TrackerControlNetworkTrafficExportEntry](README.md#trackercontrolnetworktrafficexportentry)

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
| `har` | `Har` | The recorded network traffic in HAR format. |
| `harMd5?` | `string` | The MD5 hash of the HAR file such that recipients of the report can verify the integrity of the attached HAR file. |
| `platformVersion` | `string` | The operating system version of the device/emulator the analysis was performed on. |
| `trackHarResult` | `ReturnType`<typeof `processRequest`\>[] | The [TrackHAR](https://github.com/tweaselORG/TrackHAR) analysis results for the HAR. |

#### Defined in

[lib/generate.ts:27](https://github.com/tweaselORG/complaint-generator/blob/main/src/lib/generate.ts#L27)

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

[lib/generate.ts:11](https://github.com/tweaselORG/complaint-generator/blob/main/src/lib/generate.ts#L11)

___

### ComplaintOptions

Ƭ **ComplaintOptions**: `Object`

Additional information required for generating a complaint to a data protection authority.

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
| `deviceHasRegisteredSimCard` | `boolean` | Whether the user's device has a SIM card registered to them. |
| `loggedIntoAppStore` | `boolean` | Whether the user is logged into this app store account on their device. |
| `nationalEPrivacyLaw` | ``"TTDSG"`` \| ``false`` | If the complaint should also reference the ePrivacy directive, the name of the national law implementing it. Supported values: - `TTDSG`: Germany. |
| `noticeDate` | `Date` | The date the notice to the controller was sent. |
| `reference` | `string` | The complaint's reference number, to be used in any further communication about this complaint. |
| `userDeviceAppStore` | `string` | The app store the app was installed through on the user's device. |
| `userNetworkActivity` | [`NetworkActivityReport`](README.md#networkactivityreport) | A report of the user's network activity, as recorded using the iOS App Privacy Report or Tracker Control on Android. This is used to prove that the user's device actually sent requests to the relevant trackers. Parse the raw exports from the platforms into the correct format using [parseNetworkActivityReport](README.md#parsenetworkactivityreport). |

#### Defined in

[lib/generate.ts:48](https://github.com/tweaselORG/complaint-generator/blob/main/src/lib/generate.ts#L48)

___

### GenerateAdvancedOptions

Ƭ **GenerateAdvancedOptions**: [`GenerateAdvancedOptionsDefault`](README.md#generateadvancedoptionsdefault) \| [`GenerateAdvancedOptionsComplaint`](README.md#generateadvancedoptionscomplaint)

Options for the [generateAdvanced](README.md#generateadvanced) function.

**`Remarks`**

The options type is a discriminated union based on the `type` property:

- For `type: 'report' | 'notice'`, provide [GenerateAdvancedOptionsDefault](README.md#generateadvancedoptionsdefault).
- For `type: 'complaint'`, provide [GenerateAdvancedOptionsComplaint](README.md#generateadvancedoptionscomplaint).

#### Defined in

[lib/generate.ts:145](https://github.com/tweaselORG/complaint-generator/blob/main/src/lib/generate.ts#L145)

___

### GenerateAdvancedOptionsComplaint

Ƭ **GenerateAdvancedOptionsComplaint**: `Object`

Options for generating a complaint using the [generateAdvanced](README.md#generateadvanced) function.

#### Type declaration

| Name | Type | Description |
| :------ | :------ | :------ |
| `analysis` | [`Analysis`](README.md#analysis) | Information about the second network traffic analyis that will be the basis for the complaint. |
| `complaintOptions` | [`ComplaintOptions`](README.md#complaintoptions) | Additional metadata for complaints. |
| `initialAnalysis` | [`Analysis`](README.md#analysis) | Information about the initial network traffic analyis that the notice to the controller was based on. |
| `language` | [`SupportedLanguage`](README.md#supportedlanguage) | The language the generated document should be in. |
| `type` | ``"complaint"`` | The type of document to generate, with the following possible values: - `complaint`: Generate a complaint to a data protection authority. |

#### Defined in

[lib/generate.ts:118](https://github.com/tweaselORG/complaint-generator/blob/main/src/lib/generate.ts#L118)

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

[lib/generate.ts:103](https://github.com/tweaselORG/complaint-generator/blob/main/src/lib/generate.ts#L103)

___

### GenerateOptions

Ƭ **GenerateOptions**: [`GenerateOptionsDefault`](README.md#generateoptionsdefault) \| [`GenerateOptionsComplaint`](README.md#generateoptionscomplaint)

Options for the [generate](README.md#generate) function.

**`Remarks`**

The options type is a discriminated union based on the `type` property:

- For `type: 'report' | 'notice'`, provide [GenerateOptionsDefault](README.md#generateoptionsdefault).
- For `type: 'complaint'`, provide [GenerateOptionsComplaint](README.md#generateoptionscomplaint).

#### Defined in

[index.ts:88](https://github.com/tweaselORG/complaint-generator/blob/main/src/index.ts#L88)

___

### GenerateOptionsComplaint

Ƭ **GenerateOptionsComplaint**: `Object`

Options for generating a complaint using the [generate](README.md#generate) function.

#### Type declaration

| Name | Type | Description |
| :------ | :------ | :------ |
| `complaintOptions` | [`ComplaintOptions`](README.md#complaintoptions) | Additional metadata for complaints. |
| `har` | `TweaselHar` | The HAR containing the recorded network traffic of second analysis, that will be the basis for the complaint. Must be a tweasel HAR with metadata. |
| `harMd5?` | `string` | The MD5 hash of the second HAR file such that recipients of the report can verify the integrity of the attached HAR file. |
| `initialHar` | `TweaselHar` | The HAR containing the recorded network traffic of the initial analysis that the notice to the controller was based on. Must be a tweasel HAR with metadata. |
| `initialHarMd5?` | `string` | The MD5 hash of the initial HAR file such that recipients of the report can verify the integrity of the attached HAR file. |
| `initialTrackHarResult` | `ReturnType`<typeof `processRequest`\>[] | The [TrackHAR](https://github.com/tweaselORG/TrackHAR) analysis results for the initial HAR. |
| `language` | [`SupportedLanguage`](README.md#supportedlanguage) | The language the generated document should be in. |
| `trackHarResult` | `ReturnType`<typeof `processRequest`\>[] | The [TrackHAR](https://github.com/tweaselORG/TrackHAR) analysis results for the second HAR. |
| `type` | ``"complaint"`` | The type of document to generate, with the following possible values: - `complaint`: Generate a complaint to a data protection authority. |

#### Defined in

[index.ts:40](https://github.com/tweaselORG/complaint-generator/blob/main/src/index.ts#L40)

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

[index.ts:18](https://github.com/tweaselORG/complaint-generator/blob/main/src/index.ts#L18)

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

[lib/user-network-activity.ts:23](https://github.com/tweaselORG/complaint-generator/blob/main/src/lib/user-network-activity.ts#L23)

___

### NetworkActivityReport

Ƭ **NetworkActivityReport**: { `appId`: `string` ; `hostname`: `string` ; `index`: `number` ; `timestamp`: `Date`  }[]

An entry in a network activity report, containing information about the hostnames that were contacted on the user's
device.

#### Defined in

[lib/user-network-activity.ts:7](https://github.com/tweaselORG/complaint-generator/blob/main/src/lib/user-network-activity.ts#L7)

___

### SupportedLanguage

Ƭ **SupportedLanguage**: keyof typeof `templates` & keyof typeof `translations`

A language that translations are available for.

#### Defined in

[lib/translations.ts:18](https://github.com/tweaselORG/complaint-generator/blob/main/src/lib/translations.ts#L18)

___

### TrackerControlNetworkTrafficExportEntry

Ƭ **TrackerControlNetworkTrafficExportEntry**: `Object`

An entry in a network traffic export from the Tracker Control app on Android.

#### Type declaration

| Name | Type |
| :------ | :------ |
| `App` | `string` |
| `Category` | `string` |
| `Package` | `string` |
| `Tracker` | `string` |
| `daddr` | `string` |
| `time` | `string` |
| `uid` | `string` |
| `uncertain` | `string` |

#### Defined in

[lib/user-network-activity.ts:51](https://github.com/tweaselORG/complaint-generator/blob/main/src/lib/user-network-activity.ts#L51)

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

[index.ts:106](https://github.com/tweaselORG/complaint-generator/blob/main/src/index.ts#L106)

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

[lib/generate.ts:158](https://github.com/tweaselORG/complaint-generator/blob/main/src/lib/generate.ts#L158)

___

### parseNetworkActivityReport

▸ **parseNetworkActivityReport**(`type`, `report`): [`NetworkActivityReport`](README.md#networkactivityreport)

Parse a network activity report from the iOS App Privacy Report or Tracker Control on Android into a standardized
[NetworkActivityReport](README.md#networkactivityreport) format.

#### Parameters

| Name | Type | Description |
| :------ | :------ | :------ |
| `type` | ``"ios-app-privacy-report-ndjson"`` \| ``"tracker-control-csv"`` | The type/format of the input report, with the following possible values: - `ios-app-privacy-report-ndjson`: A report exported from the iOS App Privacy Report feature, in NDJSON format. - `tracker-control-csv`: A CSV export of the network traffic log from the Tracker Control Android app. |
| `report` | `string` | The report to parse. |

#### Returns

[`NetworkActivityReport`](README.md#networkactivityreport)

The parsed report as a [NetworkActivityReport](README.md#networkactivityreport).

#### Defined in

[lib/user-network-activity.ts:75](https://github.com/tweaselORG/complaint-generator/blob/main/src/lib/user-network-activity.ts#L75)
