#import "style.typ": tweaselStyle
#show: tweaselStyle

#text(weight: 700, 1.75em)[Technical report: Analysis of website "{{ analysis.website.name }}"]

= Introduction

This report details the findings and methodology of an automated analysis concerning tracking and similar data transmissions performed on the website "{{ analysis.website.name }}", located at {{ analysis.website.url | safe }}, (hereinafter: "the website") using the Tweasel browser addon.

= Findings

During the analysis, the network traffic initiated by the website was recorded. In total, {{ harEntries.length }} requests were recorded without interaction between {{ harEntries[0].startTime | dateFormat }} and {{ harEntries[harEntries.length - 1].startTime | dateFormat }} (first analysis part), and {{ harEntriesInteraction.length }} requests were recorded with possible interaction between {{ harEntriesInteraction[0].startTime | dateFormat }} and {{ harEntriesInteraction[harEntriesInteraction.length - 1].startTime | dateFormat }} (second analysis part). The recorded traffic is attached as two HAR files{% if analysis.harMd5 and analysis.harInteractionMd5 %} (MD5 checksum of the HAR files: {{ analysis.harMd5 | code }} without interaction, {{ analysis.harInteractionMd5 | code }} with possible interaction){% endif %}, a standard format used by HTTP(S) monitoring tools to export collected data.#footnote[#link("http://www.softwareishard.com/blog/har-12-spec/")] HAR files can be viewed using Firefox or Chrome, for example.#footnote[https://docs.tweasel.org/background/har-tutorial/] The contents of the recorded traffic are also reproduced in @har2pdf[Appendix]

== Network traffic without any interaction

The requests described in this section happened in the first analysis part, i.e. *without any interaction* with the website or any potential consent dialogs.

In total, there were {{ trackHarResult.length }} requests detected that transmitted data to {{ findings | length }} tracker(s) without any interaction.

{% if findings | length == 0 %}
_no tracking transmissions were detected in this part of the analysis_
{% endif %}
{% for adapterSlug, adapterResult in findings %}
=== {{ adapterResult.adapter.name }}

The website sent the following {{ adapterResult.requests.length }} request(s) to the tracker "{{ adapterResult.adapter.name }}", operated by "{{ adapterResult.adapter.tracker.name }}". For details on how the requests to this tracker were decoded and the reasoning for how the transmitted information was determined, see the documentation in the Tweasel Tracker Wiki#footnote[The documentation for "{{ adapterResult.adapter.name }}" is available at: #link("https://trackers.tweasel.org/t/{{ adapterSlug | safe }}")].

{% for request in adapterResult.requests %}
{% set harEntry = harEntries[request.harIndex] %}
==== {{ harEntry.request.method | code }} request to {{ harEntry.request.host | code }} ({{ harEntry.startTime | timeFormat }})

On {{ harEntry.startTime | dateFormat }}, the website sent a {{ harEntry.request.method | code }} request to {{ harEntry.request.host | code }}. This request is reproduced in @har2pdf-e{{ request.harIndex | safe }}[Appendix].

The following information was detected as being transmitted through this request:

{% for transmission in request.transmissions -%}
+ {{ t("properties", transmission.property) }} (transmitted as {{ transmission.path | code }} with the value {{ transmission.value | code }})
{% endfor %}
{% endfor %}
{% endfor %}

{% if findingsInteraction | length > 0 %}

== Network traffic with interaction

The requests described in this section happened in the second analysis part. The traffic in this section can therefore be a result of interaction with the website.

In total, there were {{ trackHarResultInteraction.length }} requests detected that transmitted data to {{ findingsInteraction | length }} tracker(s) during this part.

{% for adapterSlug, adapterResult in findingsInteraction %}
=== {{ adapterResult.adapter.name }}

The website sent the following {{ adapterResult.requests.length }} request(s) to the tracker "{{ adapterResult.adapter.name }}", operated by "{{ adapterResult.adapter.tracker.name }}". For details on how the requests to this tracker were decoded and the reasoning for how the transmitted information was determined, see the documentation in the Tweasel Tracker Wiki#footnote[The documentation for "{{ adapterResult.adapter.name }}" is available at: #link("https://trackers.tweasel.org/t/{{ adapterSlug | safe }}")].

{% for request in adapterResult.requests %}
{% set harEntry = harEntriesInteraction[request.harIndex] %}
==== {{ harEntry.request.method | code }} request to {{ harEntry.request.host | code }} ({{ harEntry.startTime | timeFormat }})

On {{ harEntry.startTime | dateFormat }}, the website sent a {{ harEntry.request.method | code }} request to {{ harEntry.request.host | code }}. This request is reproduced in @har2pdf-e{{ request.harIndex | safe }}-interaction[Appendix].

The following information was detected as being transmitted through this request:

{% for transmission in request.transmissions -%}
+ {{ t("properties", transmission.property) }} (transmitted as {{ transmission.path | code }} with the value {{ transmission.value | code }})
{% endfor %}
{% endfor %}
{% endfor %}

{% endif %}

= Method

The analysis was performed on {{ analysis.date | dateFormat }} using {{ analysis.browser }}.

== Analysis environment

The traffic was collected using the Tweasel browser addon#footnote[#link("https://github.com/tweaselORG/addon")] in the following analysis environment:

#table(
  columns: (auto, auto),
  [*Browser*], [{{ analysis.browser }} {{ analysis.browserVersion }}],
  [*Addon version*], [{{ analysis.addonVersion }}],
  {% if analysis.platform %}[*Operating system*], [{{ analysis.platform }} {{ analysis.platformVersion }}],{% endif %}
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

To collect, record and analyze the data, the Tweasel browser addon #footnote[An overview of the addon functionality can be found here: #link("https://docs.tweasel.org")] was used.

To start an analysis, the addon opens the website in a new browsing context via the web extension `contextualidentities` API#footnote[#link("https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/API/contextualIdentities")], also know as "containers". This ensures that no site-related data#footnote[Site-related data includes among others cookies, localStorage, indexedDB, HTTP Cache and Image Cache. See #link("https://support.mozilla.org/en-US/questions/1283528") for more details.] from previous browsing which might have stored consent information is available to the website. In the first {{ analysis.periodWithoutInteraction | durationFormat }}, the website is loaded in a hidden tab, disabling user interaction. After this period, the tab is unhidden and interaction with the website is possible. Using the `webRequests` API, HTTP(S) request data is collected and saved in the HAR format. Request data is split into data for the hidden tab, which is guaranteed to not have been interacted with, and requests after the tab was shown, which may contain interactions.

The transmitted tracking data was identified using TrackHAR#footnote[#link("https://github.com/tweaselORG/TrackHAR")], which in principle supports both a traditional indicator matching and an adapter-based matching approach. Indicator matching identifies transmitted data by checking the recorded traffic for known character sequences. For this analysis however, only the adapters were used, which are schemas of how to decode and interpret specific requests for each contacted endpoint. These adapters are the result of previous research and the reasoning for why a data type is assigned to a value is documented with the adapter and given in this report. Adapter-based matching can only find data transmissions which have gone to already known endpoints and cannot find unexpected transmissions.

More technical details on the methods of the Tweasel toolchain and instructions on how to independently reproduce the results are available in the Tweasel documentation.#footnote(link("https://docs.tweasel.org/background/architechture"))

// Appendix
#pagebreak()

#counter(heading).update(0)
#set heading(numbering: (..nums) => "A" + nums.pos().map(str).join(".") + ".")

#text(weight: 700, 1.75em)[Appendix]

= Recorded traffic <har2pdf>

Below is a reproduction of the recorded network requests that are mentioned in the report as documented in the attached HAR file. Only requests are shown, all responses are omitted. Binary request content is represented as a hexdump. Request content longer than 4,096 bytes is truncated. The full recorded traffic with all requests and including responses and full request content can be seen the in attached HAR file.

== Traffic before any interaction

#include "har.typ"

== Traffic with interaction

#include "har-interaction.typ"
