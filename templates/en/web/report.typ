#import "style.typ": tweaselStyle
#show: tweaselStyle

#text(weight: 700, 1.75em)[Technical report: Analysis of website "{{ analysis.website.name }}"]

= Introduction

This report details the findings and methodology of an automated analysis concerning tracking and similar data transmissions performed on the website "{{ analysis.website.name }}", located at {{ analysis.website.url | safe }}, (hereinafter: "the website"). through the Tweasel project, operated by Datenanfragen.de e.~V.

= Findings

During the analysis, the network traffic initiated by the website was recorded. In total, {{ harEntries.length }} requests were recorded between {{ harEntries[0].startTime | dateFormat }} and {{ harEntries[harEntries.length - 1].startTime | dateFormat }}. The recorded traffic is attached as a HAR file{% if analysis.harMd5 %} (MD5 checksum of the HAR file: {{ analysis.harMd5 | code }}){% endif %}, a standard format used by HTTP(S) monitoring tools to export collected data.#footnote[#link("http://www.softwareishard.com/blog/har-12-spec/")] HAR files can be viewed using Firefox or Chrome, for example.#footnote[https://docs.tweasel.org/background/har-tutorial/] The contents of the recorded traffic are also reproduced in @har2pdf[Appendix]

== Network traffic without any interaction

The requests described in this section happened *without any interaction* with the website or any potential consent dialogs.

In total, there were {{ trackHarResult.length }} requests detected that transmitted data to {{ findings | length }} tracker(s) without any interaction.

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

== Network traffic with interaction

The requests described in this section happened after a period of {{ periodWithoutInteraction | durationFormat }} without any interaction with the website or any potential consent dialogs. The traffic in this section can therefore be a result of my interaction with the website.{% if analysis.interactionNoConsent %} However, I assure that I did not consciously interact with any elements on the website, in particular consent dialogs, in a way which could have been interpreted as consent by the controller.{% endif %}

In total, there were {{ trackHarResultInteraction.length }} requests detected that transmitted data to {{ findingsInteraction | length }} tracker(s) in the second period with interaction{% if analysis.interactionNoConsent %} but without explicit consent{% endif %}.

{% for adapterSlug, adapterResult in findingsInteraction %}
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

= Method

The analysis was performed on {{ analysis.date | dateFormat }} using {{ analysis.environment.browser }}.

== Analysis environment

The traffic was collected using the TweaselForWeb addon#footnote[#link("https://github.com/tweaselORG/addon")] in the following analysis environment:

#table(
  columns: (auto, auto),
  [*Browser*], [{{ analysis.environment.browser }} {{ analysis.environment.browserVersion }}],
  [*Addon version*], [{{ analysis.environment.addonVersion }}],
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

TODO

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

#include "har-no-interaction.typ"

== Traffic with interaction

#include "har-interaction.typ"
