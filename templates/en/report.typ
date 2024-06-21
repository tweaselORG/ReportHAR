#import "style.typ": tweaselStyle
#show: tweaselStyle

#text(weight: 700, 1.75em)[Technical report: Analysis of {{ analysis.app.platform }} app "{{ analysis.app.name }}"]

= Introduction

This report details the findings and methodology of an automated analysis concerning tracking and similar data transmissions performed on the {{ analysis.app.platform }} app "{{ analysis.app.name }}"{% if analysis.app.url %}#footnote[{{ analysis.app.url | safe }}]{% endif %} (hereinafter: "the app") through the tweasel project, operated by Datenanfragen.de e.~V.

The analysis was performed on {{ analysis.date | dateFormat }} on version {{ analysis.app.version }} of the app, {% if analysis.app.store %}downloaded from the {{ analysis.app.store }}, {% endif %}running on {{ analysis.app.platform }} {{ analysis.platformVersion }}.

The following tools were used for the analysis:

#table(
  columns: (auto, auto),
  [*Tool*], [*Version*],
  {% for tool, version in analysis.dependencies -%}
  [{{ tool }}], [{{ version }}],
  {% endfor %}
)

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


{% if analysis.device %}
The traffic was collected on the following device:

#table(
  columns: (auto, auto),
  [Platform], [{{ analysis.device.platform }}],
  [Platform Version], [{{ analysis.device.osVersion }}],
  [Build String], [{{ analysis.device.osBuild }}],
  [Manufacturer], [{{ analysis.device.manufacturer }}],
  [Model], [{{ analysis.device.model }}],
)

{% if analysis.device.runTarget === 'emulator' %}An emulator was used to simulate a device.{% endif %}
{% endif %}

To collect record and analyze the data, the Tweasel toolchain#footnote[You can find an overview of the tools here: #link("https://docs.tweasel.org")] was used. They are a collection of scripts written in Typescript and running on nodejs.

The library `appstraction`#footnote[#link("https://github.com/tweaselORG/appstraction")] was used to control device and set up the environment the app is running on. It allows to insert honey data on the device, change and read out app settings, and install, remove and start apps. {% if analysis.device.platform  === 'android' -%}
It used the Android Debug Bridge (`adb`)#footnote[#link("https://developer.android.com/tools/adb")], which to control the device and read out information via the USB Debugging API built into Android. The device was rooted before the analysis was started and `adb` was used to open an elevated shell to manipulate system functions. Where Android does not provide an accesibile API, `appstraction` uses the instrumentation toolkit Frida#footnote[#link("https://frida.re/")], which can hook into an app‘s functions while the process is running and change its behaviour and access its execution context. `appstraction` contains scripts to hook into system functions, e.g. to set the content of the Clipboard. Frida needs the `frida-server` to be installed, which is done automatically in `appstraction`.
{% elif analysis.device.platform === 'ios' -%}
To do so, it accessed iOS‘s `lockdownd` service via a USB connection and using the `pymobiledevice3`#footnote[#link("https://github.com/doronz88/pymobiledevice3/")] python library. This was used i.a. to install apps and read out system information. The device was jailbroken and a SSH server was installed on the deive, to access more advanced functionality via a remote shell which also allows for root access to the device. Internal system and app APIs were used via the instrumentation toolkit Frida#footnote[#link("https://frida.re/")], which hooks into an app‘s functions while the process is running, changes its behaviour and accesses its execution context. Frida was installed on the jailbroken device as a tweak.
{%- endif %}

The traffic was recorded via a machine-in-the-middle (MITM) attack. `mitmproxy`#footnote[#link("https://mitmproxy.org/")] was used to act as the attacker. {% if analysis.device.platform === 'android' -%}
On the device, the traffic was routed to `mitmproxy` using a WireGuard#footnote[#link("https://www.wireguard.com/")] VPN tunnel. {% if analysis.trafficCollectionOptions and analysis.trafficCollectionOptions.mode === 'all-apps' -%}
All of the traffic of the device was tunneled via the VPN.
{% elif analysis.trafficCollectionOptions and analysis.trafficCollectionOptions.mode === 'allowlist' -%}
Only the following apps‘ traffic was tunneled through the VPN: {{ analysis.trafficCollectionOptions.apps | join(', ') }}
{% elif analysis.trafficCollectionOptions and analysis.trafficCollectionOptions.mode === 'denylist' -%}
All apps except for the following apps‘ traffic was tunneled through the VPN: {{ analysis.trafficCollectionOptions.apps | join(', ') }}
{%- endif %}
To decrypt TLS-encrypted traffic, a ceritifcate authority generated by `mitmproxy` was placed and trusted on the device. Certificate pinning was bypassed using httptoolkit‘s certificate unpinning script for Frida#footnote[#link("https://github.com/httptoolkit/frida-android-unpinning/blob/4d477da8c58c353a0290ec4829a1de4ca1ca5ae5/frida-script.js")].
{% elif analysis.device.platform === 'ios' -%}
On the device, traffic was routed to `mitmproxy` using the HTTP proxy built into iOS, set via the system settings. The proxy does not allow to discrimintate traffic according to the originating app. To decrypt TLS-encrypted traffic, a ceritifcate authority generated by `mitmproxy` was placed and trusted on the device. Certificate pinning was bypassed using SSL Kill Switch 2#footnote[#link("https://julioverne.github.io/description.html?id=com.julioverne.sslkillswitch2")], a tweak activated via the jailbreak.
{%- endif %}

Transmitted data was identified using TrackHAR#footnote[#link("https://github.com/tweaselORG/TrackHAR")], which combines a traditional indicator matching with an adapter-based matching approach. Indicator matching identifies transmitted data in the decrypted transmissions by checking for (endcoded) character sequences which are known before the traffic recording and unique enough they could not be transmitted for another reason. This could e.g. be some unique identifier or other unique data such as the name of a contact. The main matching approch in TrackHAR, however, uses adapters, which are schemas of how to decode and interpret specific requests for each contacted endpoint. These adapters are the result of previous research and the reasoing for way a data type is assigned to a value is documented with the adapter and given in this report. Adapter-based matching can only find data transmissions which have gone to already known endpoints and can not find unexpected transmissions.

The methods of how this report and the Tweasel toolchain are explained in more detail to be recreated in the docuemnation of the toolchain: #link("https://docs.tweasel.org/background/architechture")

// Appendix
#pagebreak()

#counter(heading).update(0)
#set heading(numbering: (..nums) => "A" + nums.pos().map(str).join(".") + ".")

#text(weight: 700, 1.75em)[Appendix]

= Recorded traffic <har2pdf>

Below is a reproduction of the recorded network requests that are mentioned in the report as documented in the attached HAR file. Only requests are shown, all responses are omitted. Binary request content is represented as a hexdump. Request content longer than 4,096 bytes is truncated. The full recorded traffic with all requests and including responses and full request content can be seen the in attached HAR file.

#include "har.typ"
