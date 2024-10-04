#import "style.typ": tweaselStyle
#show: tweaselStyle

#text(weight: 700, 1.75em)[Datenschutz-Verstöße in Ihrer {{ analysis.app.platform }}-App "{{ analysis.app.name }}"]

= Einleitung

Ich bin Nutzer_in Ihrer {{ analysis.app.platform }}-App "{{ analysis.app.name }}"{% if analysis.app.url %}#footnote[{{ analysis.app.url | safe }}]{% endif %} (im Folgenden: "die App").

Durch eine automatisierte Analyse der App musste ich leider feststellen, dass diese Tracking und vergleichbare Datenübermittlungen ohne Einwilligung durchführt, was meines Erachtens gegen geltendes Datenschutzrecht verstößt.

Ich weise Sie hiermit auf diese Verstöße hin und gebe Ihnen die Möglichkeit, sie abzustellen.

= Sachverhalt

Ich habe {{ trackHarResult.length }} Anfragen aufgezeichnet, die zwischen {{ harEntries[0].startTime | dateFormat }} und {{ harEntries[harEntries.length - 1].startTime | dateFormat }} Daten an {{ findings | length }} Tracker übertragen haben. Diese Anfragen haben *ohne irgendeine Interaktion* mit der App oder etwaigen Einwilligungsdialogen, und daher ohne Einwilligung, stattgefunden. Weitere Details finden sich im angehängten technischen Bericht.

{% for adapterSlug, adapterResult in findings %}
== {{ adapterResult.adapter.name }}

Die App hat {{ adapterResult.requests.length }} Anfrage(n) an den Tracker "{{ adapterResult.adapter.name }}" gesendet, betrieben von "{{ adapterResult.adapter.tracker.name }}". Über diese Anfragen wurden mindestens die folgenden Informationen übermittelt:

#table(
  columns: (33.3333%, 66.6666%),

  [*Datentyp*], [*Übermittelte(r) Wert(e)*],
  {% for property, value in adapterResult.receivedData -%}
  [{{ t("properties", property) }}], [{{ value | join(', ') | code }}],
  {% endfor %}
)
{% endfor %}

= Rechtliche Einordnung

Ich gehe davon aus, dass Sie durch das Übermitteln der oben aufgelisteten Informationen gegen die DSGVO und ePrivacy-Richtlinie verstoßen haben.

Da die Informationen eindeutige Identifier beinhalten, welche die Identifizierung der Nutzer_innen der App ermöglichen, handelt es sich dabei um personenbezogene Daten nach Art. 4 Nr. 1 DSGVO und sie fallen in den Anwendungsbereich der DSGVO.

Nach Art. 6 Abs. 1 DSGVO ist die Verarbeitung personenbezogener Daten nur rechtmäßig, wenn sie sich auf mindestens eine der sechs möglichen Rechtsgrundlagen berufen kann. Allerdings ist keine Rechtsgrundlage anwendbar für die Verarbeitung, welche Sie durchgeführt haben.

Die Datenschutzaufsichtsbehörden haben wiederholt Orientierungshilfen veröffentlicht, in welchen sie darauf hinweisen, dass eine Einwilligung die einzige Rechtsgrundlage ist, die üblicherweise für Tracking verwendet werden kann.#footnote[vgl. z.~B. https://edpb.europa.eu/sites/default/files/files/file1/edpb_guidelines-art_6-1-b-adopted_after_public_consultation_en.pdf, https://www.datenschutzkonferenz-online.de/media/oh/20221130_OH_Telemedien_2021_Version_1_1.pdf, https://www.baden-wuerttemberg.datenschutz.de/wp-content/uploads/2022/03/FAQ-Tracking-online.pdf]

Eine Einwilligung kann allerdings nur durch eine Erklärung oder sonstige eindeutig bestätigende Handlung abgegeben werden (Art. 4 Nr. 11 DSGVO). Erwägungsgrund 32 DSGVO stellt klar, dass Stillschweigen, bereits angekreuzte Kästchen oder Untätigkeit keine Einwilligung darstellen.

Wie beschrieben haben die oben aufgeführten Übermittlungen ohne jegliche Interaktion stattgefunden. Daher kann keine Einwilligung für sie erteilt worden sein.

Verarbeitungen, welche sich ausschließlich auf eine Einwilligung als Rechtsgrundlage berufen können, dürfen nur stattfinden, nachdem diese Einwilligung erteilt wurde, und als Verantwortliche müssen Sie nachweisen können, dass die Einwilligung erteilt wurde (Art. 7 Abs. 1 DSGVO).

Darüber hinaus mandatiert Art. 5 Abs. 1 lit. c DSGVO das Prinzip der Datenminimierung, welches Sie verpflichtet, Daten nur auf das für die Zwecke der Verarbeitung notwendige Maß beschränkt zu verarbeiten. Ferner gilt nach Art. 25 Abs. 1 DSGVO das Prinzip von Datenschutz durch Technikgestaltung und durch datenschutzfreundliche Voreinstellungen.

Nach Art. 5 Abs. 2, Art. 7 Abs. 1 und Art. 24 Abs. 1 DSGVO trifft Sie die Last nachzuweisen, dass all Ihre Datenverarbeitungen im Einklang mit der DSGVO stattfinden. Dies wurde explizit vom EuGH in der Rechtssache C-175/20 bestätigt.

Schließlich gehe ich davon aus, dass Sie auch gegen Art. 5 Abs. 3 ePrivacy-Richtlinie verstoßen haben. Im Gegensatz zur DSGVO erstreckt sich Art. 5 Abs. 3 ePR nicht nur auf personenbezogene Daten, sondern auf sämtliche Informationen, die vom Endgerät einer Nutzer_in gelesen oder darin gespeichert werden.

Art. 5 Abs. 3 ePR eröffnet im Gegensatz zur DSGVO auch keine unterschiedlichen möglichen Rechtsgrundlagen, die anwendbar sein könnten. Er legt fest, dass die Speicherung von Informationen oder der Zugriff auf Informationen, die im Endgerät der Nutzer_in gespeichert sind, nur gestattet sind, wenn die Nutzer_in ihre Einwilligung gegeben hat.

Die zwei möglichen Ausnahmen zu dieser Regelung sind eng auszulegen und nach der Artikel-29-Datenschutzgruppe sind Tracking und Werbung nicht unbedingt erforderlich.#footnote[https://ec.europa.eu/justice/article-29/documentation/opinion-recommendation/files/2012/wp194_de.pdf]

Art. 5 Abs. 3 ePR verweist im Hinblick auf die Anforderungen an Einwilligungen auf die DSGVO. Insofern gelten dieselben Überlegungen auch hier. Sie haben auch keine Einwilligung unter Art. 5 Abs. 3 ePR erhalten.

= Beschwerde

Angesichts des beschriebenen Sachverhalts muss ich schlussfolgern, dass Sie meine Datenschutzrechte als Nutzer_in der App verletzt haben. Art. 77 DSGVO gibt mir das Recht, in solchen Fällen eine Beschwerde bei den Datenschutzaufsichtsbehörden einzureichen.

Die Datenschutzaufsichtsbehörden haben nach Art. 58 DSGVO Untersuchungs- und Abhilfebefugnisse. Nach Art. 83 Abs. 5 DSGVO dürfen sie bei Verstößen insbesondere Bußgelder von bis zu 20~Millionen Euro oder von bis zu 4 % Ihres gesamten weltweit erzielten Jahresumsatzes des vorangegangenen Geschäftsjahrs, je nachdem, welcher der Beträge höher ist, gegen Sie verhängen.

Um unnötige Arbeit für mich, die Datenschutzaufsichtsbehörden und Sie zu vermeiden, gewähre ich Ihnen allerdings freiwillig eine Frist von 60 Tagen ab dem Datum dieses Schreibens. Wenn Sie die beschriebenen Verstöße bis dahin abstellen und dafür sorgen, dass die App im vollen Einklang mit der DSGVO und ePrivacy-Richtlinie ist, werde ich in dieser Angelegenheit keine Beschwerde gegen Sie einreichen.
