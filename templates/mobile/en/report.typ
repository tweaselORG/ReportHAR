#import "style.typ": tweaselStyle
#show: tweaselStyle

#text(weight: 700, 1.75em)[Technical report: Analysis of {{ analysis.app.platform }} app "{{ analysis.app.name }}" ({{ analysis.app.version }})]

= Introduction

This report details the findings and methodology of an automated analysis concerning tracking and similar data transmissions performed on the {{ analysis.app.platform }} app "{{ analysis.app.name }}"{% if analysis.app.url %}#footnote[{{ analysis.app.url | safe }}]{% endif %} (app ID: {{ analysis.app.id | code }}, hereinafter: "the app") through the Tweasel project, operated by Datenanfragen.de e.~V.

= Findings

During the analysis, the network traffic initiated by the app was recorded. In total, {{ harEntries.length }} requests were recorded between {{ harEntries[0].startTime | dateFormat }} and {{ harEntries[harEntries.length - 1].startTime | dateFormat }}. The recorded traffic is attached as a HAR file{% if analysis.harMd5 %} (MD5 checksum of the HAR file: {{ analysis.harMd5 | code }}){% endif %}, a standard format used by HTTP(S) monitoring tools to export collected data.#footnote[#link("http://www.softwareishard.com/blog/har-12-spec/")] HAR files can be viewed using Firefox or Chrome, for example.#footnote[https://docs.tweasel.org/background/har-tutorial/] The contents of the recorded traffic are also reproduced in @har2pdf[Appendix]

== Network traffic without any interaction

The requests described in this section happened *without any interaction* with the app or any potential consent dialogs.

In total, there were {{ trackHarResult.length }} requests detected that transmitted data to {{ findings | length }} tracker(s) without any interaction.

{% for adapterSlug, adapterResult in findings %}
=== {{ adapterResult.adapter.name }}

The app sent the following {{ adapterResult.requests.length }} request(s) to the tracker "{{ adapterResult.adapter.name }}", operated by "{{ adapterResult.adapter.tracker.name }}". For details on how the requests to this tracker were decoded and the reasoning for how the transmitted information was determined, see the documentation in the Tweasel Tracker Wiki#footnote[The documentation for "{{ adapterResult.adapter.name }}" is available at: #link("https://trackers.tweasel.org/t/{{ adapterSlug | safe }}")].

{% for request in adapterResult.requests %}
{% set harEntry = harEntries[request.harIndex] %}
==== {{ harEntry.request.method | code }} request to {{ harEntry.request.host | code }} ({{ harEntry.startTime | timeFormat }})

On {{ harEntry.startTime | dateFormat }}, the app sent a {{ harEntry.request.method | code }} request to {{ harEntry.request.host | code }}. This request is reproduced in @har2pdf-e{{ request.harIndex | safe }}[Appendix].

The following information was detected as being transmitted through this request:

{% for transmission in request.transmissions -%}
+ {{ t("properties", transmission.property) }} (transmitted as {{ transmission.path | code }} with the value {{ transmission.value | code }})
{% endfor %}
{% endfor %}
{% endfor %}

= Method

The analysis was performed on {{ analysis.date | dateFormat }} on version {{ analysis.app.version }} of the app{% if analysis.app.store %}, downloaded from the {{ analysis.app.store }}{% endif %}.

== Analysis environment

The traffic was collected on the following {% if analysis.deviceType === 'emulator' %}emulator{% else %}device{% endif %}:

#table(
  columns: (auto, auto),
  [*Operating system*], [{{ analysis.app.platform }} {{ analysis.platformVersion }}],
  {% if analysis.platformBuildString %}[*Build string*], [{{ analysis.platformBuildString }}],{% endif %}
  {% if analysis.deviceManufacturer %}[*Manufacturer*], [{{ analysis.deviceManufacturer }}],{% endif %}
  {% if analysis.deviceModel %}[*Model*], [{{ analysis.deviceModel }}],{% endif %}
)

The analysis was performed using the following versions of the tools and libraries:

#table(
  columns: (auto, auto),
  [*Tool*], [*Version*],
  {% for tool, version in analysis.dependencies -%}
  [{{ tool | code }}], [{{ version }}],
  {% endfor %}
)

== Analysis steps

To collect, record and analyze the data, the Tweasel toolchain#footnote[An overview of the tools can be found here: #link("https://docs.tweasel.org")] was used.

The `appstraction`#footnote[#link("https://github.com/tweaselORG/appstraction")] library was used to control the device and set up the environment the app is running in. It allows to change and read out app settings, and install, remove and start apps. {% if analysis.app.platform  === 'Android' -%}
It uses the Android Debug Bridge (`adb`)#footnote[#link("https://developer.android.com/tools/adb")] to control the device and read out information via the USB Debugging API built into Android. The device was rooted before the analysis was started and `adb` was used to open an elevated shell to manipulate system functions. Where Android does not provide an accessible API, `appstraction` uses the instrumentation toolkit Frida#footnote[#link("https://frida.re/")], which can hook into an app's functions while the process is running and access its execution context. `appstraction` contains scripts to hook into system functions, e.g. to set the content of the clipboard.
{% elif analysis.app.platform === 'iOS' -%}
To do so, it accesses iOS's `lockdownd` service via a USB connection and using the `pymobiledevice3`#footnote[#link("https://github.com/doronz88/pymobiledevice3/")] library. This is used i.a. to install apps and read out system information. The device was jailbroken and a SSH server was installed on the device to access more advanced functionality via a remote shell which also allows for root access to the device. Internal system and app APIs are used via the instrumentation toolkit Frida#footnote[#link("https://frida.re/")], which hooks into an app's functions while the process is running and accesses its execution context.
{%- endif %}

For the analysis, the app was started on the device and left running for 60 seconds. During this time, no input at all was provided to the device or app, meaning that no controls, buttons, inputs, etc. could have been clicked or otherwise interacted with. The app's traffic was recorded by the `cyanoacrylate`#footnote[#link("https://github.com/tweaselORG/cyanoacrylate")] library using the machine-in-the-middle (MITM) proxy `mitmproxy`#footnote[#link("https://mitmproxy.org/")]. {% if analysis.app.platform === 'Android' -%}
On the device, the traffic was routed to `mitmproxy` using a WireGuard#footnote[#link("https://www.wireguard.com/")] VPN tunnel, which was configured to only tunnel the traffic of the app under test. To decrypt TLS-encrypted traffic, the certificate authority generated by `mitmproxy` was placed and trusted on the device. Certificate pinning was bypassed using the HTTP Toolkit certificate unpinning script for Frida#footnote[#link("https://httptoolkit.com/blog/frida-certificate-pinning/")].
{% elif analysis.app.platform === 'iOS' -%}
On the device, traffic was routed to `mitmproxy` using the HTTP proxy built into iOS, set via the system settings. The proxy does not allow to discriminate traffic according to the originating app. To decrypt TLS-encrypted traffic, the certificate authority generated by `mitmproxy` was placed and trusted on the device. Certificate pinning was bypassed using SSL Kill Switch 2#footnote[#link("https://julioverne.github.io/description.html?id=com.julioverne.sslkillswitch2")].
{%- endif %}

The transmitted tracking data was identified using TrackHAR#footnote[#link("https://github.com/tweaselORG/TrackHAR")], which in principle supports both a traditional indicator matching and an adapter-based matching approach. Indicator matching identifies transmitted data by checking the recorded traffic for known character sequences. For this analysis however, only the adapters were used, which are schemas of how to decode and interpret specific requests for each contacted endpoint. These adapters are the result of previous research and the reasoning for why a data type is assigned to a value is documented with the adapter and given in this report. Adapter-based matching can only find data transmissions which have gone to already known endpoints and cannot find unexpected transmissions.

More technical details on the methods of the Tweasel toolchain and instructions on how to independently reproduce the results are available in the Tweasel documentation.#footnote(link("https://docs.tweasel.org/background/architechture"))

// Appendix
#pagebreak()

#counter(heading).update(0)
#set heading(numbering: (..nums) => "A" + nums.pos().map(str).join(".") + ".")

#text(weight: 700, 1.75em)[Appendix]

= Recorded traffic <har2pdf>

Below is a reproduction of the recorded network requests that are mentioned in the report as documented in the attached HAR file. Only requests are shown, all responses are omitted. Binary request content is represented as a hexdump. Request content longer than 4,096 bytes is truncated. The full recorded traffic with all requests and including responses and full request content can be seen the in attached HAR file.

#include "har.typ"
