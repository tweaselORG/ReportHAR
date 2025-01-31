#import "style.typ": tweaselStyle
#show: tweaselStyle

// Title page
#align(center)[
  #v(120pt)

  #block(text(weight: 700, 2.5em, [
    {% if type === 'complaint' %}
      Beschwerde nach DSGVO{% if complaintOptions.nationalEPrivacyLaw %} und {{ complaintOptions.nationalEPrivacyLaw }}{% endif %}
    {% else %}
      Kontrollanregung
    {% endif %}
  ]))

  #v(30pt)

  _erhoben von_ \
  {{ complaintOptions.complainantAddress }} \
  (Beschwerdeführer_in, im Folgenden: "ich")

  _gegen_ \
  die Verantwortliche für die {{ analysis.app.platform }}-App "{{ analysis.app.name }}", angenommen als \
  {{ complaintOptions.controllerAddress }} \
  (Beschwerdegegnerin, im Folgenden: "Verantwortliche")

  _am_ \
  {{ complaintOptions.date | dateFormat(false) }}

  _wegen_ \
  Art.~6 Abs.~1 DSGVO (Rechtmäßigkeit der Verarbeitung), Art.~25 DSGVO (Datenschutz durch Technikgestaltung und durch datenschutzfreundliche Voreinstellungen), Art.~5 Abs.~1 lit.~c DSGVO (Datenminimierung)
  {%- if complaintOptions.nationalEPrivacyLaw -%}
    ,
    {% if complaintOptions.nationalEPrivacyLaw === 'TDDDG' -%}
      §~25 TDDDG (Schutz der Privatsphäre bei Endeinrichtungen)
    {% endif %}
  {% endif %}

  _unter dem Zeichen_ \
  {{ complaintOptions.reference }} \
  (bitte bei Antwort angeben)
]

#pagebreak()

// Main content
= Einleitung

{% if type === 'complaint' %}
Ich reiche hiermit Beschwerde nach Art. 77 Abs. 1 DSGVO wegen der {{ analysis.app.platform }}-App "{{ analysis.app.name }}" (im Folgenden: "die App") ein.

Soweit ich feststellen kann, wird die App von {{ complaintOptions.controllerAddress }} betrieben.#footnote[{{ complaintOptions.controllerAddressSourceUrl | safe }}] Ich gehe daher davon aus, dass diese die Verantwortliche für die App ist. Sollte diese Annahme nicht korrekt sein, richtet sich meine Beschwerde gegen die tatsächliche Verantwortliche für die App.

Ich bin Nutzer_in der App auf meinem persönlichen {{ analysis.app.platform }}-Gerät. Das {{ analysis.app.platform }}-Gerät wird nur von mir persönlich genutzt.{% if complaintOptions.userDeviceAppStore and complaintOptions.loggedIntoAppStore %} Ich habe die App über den {{ complaintOptions.userDeviceAppStore }} installiert. Ich bin mit meinem persönlichen Konto im {{ complaintOptions.userDeviceAppStore }} angemeldet.{% endif %}

{% if complaintOptions.deviceHasRegisteredSimCard %}Mein {{ analysis.app.platform }}-Gerät hat eine auf meinen Namen registrierte SIM-Karte installiert.{% endif %}
{% else %}
Hiermit bitte ich Sie, die {{ analysis.app.platform }}-App "{{ analysis.app.name }}" (im Folgenden: "die App") zu untersuchen.

Soweit ich feststellen kann, wird die App von {{ complaintOptions.controllerAddress }} betrieben.#footnote[{{ complaintOptions.controllerAddressSourceUrl | safe }}] Ich gehe daher davon aus, dass diese die Verantwortliche für die App ist. Sollte diese Annahme nicht korrekt sein, richtet sich meine Anfrage gegen die tatsächliche Verantwortliche für die App.
{% endif %}

= Sachverhalt

== Vorbemerkungen

Um zu verstehen, wie die App meine Daten verarbeitet, habe ich die Tools des Tweasel-Projekts#footnote[https://docs.tweasel.org/], betrieben vom Datenanfragen.de e.~V., verwendet, um eine automatisierte Analyse des Netzwerkverkehrs der App durchzuführen. Die Analyse wurde am {{ initialAnalysis.date | dateFormat }} mit Version {{ initialAnalysis.app.version }} der App durchgeführt, {% if analysis.app.store %}heruntergeladen aus dem {{ analysis.app.store }}, {% endif %}auf {{ initialAnalysis.app.platform }} {{ initialAnalysis.platformVersion }} laufend.

Während dieser Analyse wurde die App _ohne jegliche Eingaben_ ausgeführt (d.~h. es gab keinerlei Interaktion mit der App) und ihr Netzwerkverkehr wurde aufgezeichnet. Der aufgezeichnete Traffic wurde dann auf Tracking und ähnliche Datenübertragungen analysiert. Darauf basierend erstellten die Tweasel-Tools einen technischen Bericht.

Sowohl dieser technische Bericht als auch die Trafficaufzeichnung sind als Beweismittel als Teil meiner Kommunikation mit der Verantwortlichen angehängt. Der Bericht enthält auch eine detaillierte Beschreibung der für die Analyse verwendeten Methodik und ihrer Grundlage in der mobilen Datenschutzforschung.

Durch die Analyse musste ich leider feststellen, dass die App Tracking ohne Einwilligung durchführt (wie in @tracking erläutert), was meiner Meinung nach gegen DSGVO{% if complaintOptions.nationalEPrivacyLaw %} und {{ complaintOptions.nationalEPrivacyLaw }}{% endif %} verstößt (wie in @legal-grounds erläutert).

Am {{ complaintOptions.noticeDate | dateFormat(false) }} habe ich der Verantwortlichen eine Mitteilung geschickt, in der ich sie auf die von mir entdeckten Verstöße aufmerksam gemacht und ihr die Möglichkeit gegeben habe, diese zu beheben.

Im Interesse der Vermeidung unnötiger Arbeit für die Datenschutzbehörden, die Verantwortliche und mich selbst habe ich der Verantwortlichen eine freiwillige Frist von 60 Tagen eingeräumt, um ihre App in Einklang mit geltendem Datenschutzrecht zu bringen. Ich habe sie auch darüber informiert, dass ich andernfalls plane, eine Beschwerde einzureichen.

{% if complaintOptions.controllerResponse === "none" %}
  Ich habe keine Antwort von der Verantwortlichen erhalten.
{% elif complaintOptions.controllerResponse === "denial" %}
  Ich habe eine Antwort von der Verantwortlichen erhalten, in der sie bestreitet, dass es in ihre App Verstöße gibt. Ich liefere unten eine umfangreiche technische und rechtliche Begründung, warum ich der Meinung bin, dass die Verantwortliche gegen DSGVO {% if complaintOptions.nationalEPrivacyLaw %} und {{ complaintOptions.nationalEPrivacyLaw }}{% endif %} verstößt.
{% elif complaintOptions.controllerResponse === "broken-promise" %}
  Ich habe eine Antwort von der Verantwortlichen erhalten, in der sie zugesagt hat, die von mir entdeckten Verstöße zu beheben. Wie ich jedoch unten erläutern werde, hat sie dies tatsächlich nicht getan.
{% endif %}

Ich füge meine Mitteilung an die Verantwortliche{% if complaintOptions.controllerResponse !== "none" %} sowie jegliche Kommunikation, die ich von ihr in dieser Angelegenheit erhalten habe,{% endif %} bei.

Am {{ analysis.date | dateFormat }}, {% if complaintOptions.controllerResponse === "none" %}und damit nach Ablauf der freiwilligen Frist{% else %}nachdem die Verantwortliche geantwortet hatte{% endif %}, habe ich die App erneut mit den Tweasel-Tools getestet. Die Analyse wurde mit Version {{ analysis.app.version }} der App durchgeführt, {% if analysis.app.store %}heruntergeladen aus dem {{ analysis.app.store }}, {% endif %}auf {{ analysis.app.platform }} {{ analysis.platformVersion }} laufend. Leider musste ich feststellen, dass die App immer noch Tracking durchführt, das gegen DSGVO {% if complaintOptions.nationalEPrivacyLaw %} und {{ complaintOptions.nationalEPrivacyLaw }}{% endif %} verstößt. Sowohl dieser zweite technische Bericht als auch die Trafficaufzeichnung sind ebenfalls beigefügt.

{% if type === 'complaint' %}
Um zu überprüfen, ob das Tracking auch mich persönlich betrifft, habe ich {% if analysis.app.platform === 'Android' %}die "TrackerControl"-App#footnote[https://trackercontrol.org/#network-traffic-analysis]{% elif analysis.app.platform === 'iOS' %}die "App-Datenschutzbericht"-Funktion#footnote[https://support.apple.com/de-de/HT212958]{% endif %} auf meinem persönlichen {{ analysis.app.platform }}-Gerät verwendet. Dies bestätigte, dass die App auch auf meinem eigenen Gerät diese Tracking-Server kontaktiert.#footnote[Die Aufzeichnung des Netzwerkverkehrs eines Telefons erfordert das Rooten des Geräts und schwerwiegende Konfigurationsänderungen. Dies ist für Geräte, die tatsächlich im täglichen Gebrauch sind, nicht durchführbar oder ratsam. Deshalb stellt das Tweasel-Projekt öffentliche Infrastruktur zur Verfügung, um solche Tests auf Geräten/Emulatoren durchzuführen, die nur für diesen Zweck verwendet werden. Das Protokollieren einer Liste von DNS-Hostnamen, die von einer App kontaktiert werden, ist jedoch ohne solche schwerwiegenden Verfahren {% if analysis.app.platform === 'Android' %}durch die Installation der "TrackerControl"-App{% elif analysis.app.platform === 'iOS' %}mit der "App-Datenschutzbericht"-Funktion, die direkt in iOS integriert ist,{% endif %} möglich.\
\
Während die Ergebnisse dieses Protokolls keine Inspektion der tatsächlich übertragenen Daten ermöglichen, beweisen sie, dass die App die gleichen Tracking-Server kontaktiert hat. In Kombination mit dem technischen Bericht des Tweasel-Projekts, bei dem der Anfrageninhalt tatsächlich analysiert wurde, liefert dies einen sehr starken Hinweis darauf, dass ich vom gleichen Tracking betroffen bin. Wie ich in @legal-grounds-burden-of-proof erläutern werde, liegt die Beweislast dafür, dass ihre Verarbeitung im Einklang mit der DSGVO steht, bei der Verantwortlichen. Es wäre also an ihr, Beweise vorzulegen, welche die Schlussfolgerung, die ich hier ziehe, widerlegen.] Ich habe die Beweise dafür in @personal-hostnames[Anhang] beigefügt.
{% endif %}

== Tracking ohne Interaktion <tracking>

In diesem Abschnitt erläutere ich detailliert die Tracking-Datenübertragungen, welche die App durchgeführt hat. Ich berücksichtige nur Übertragungen aus dem zweiten technischen Bericht des Tweasel-Projekts vom {{ analysis.date | dateFormat(false) }}. Alle diese Übertragungen erfolgten also {% if complaintOptions.controllerResponse === "none" %}*mindestens 60 Tage nachdem* ich die Verantwortliche über die von mir ursprünglich entdeckten Verstöße informiert und ihr die Möglichkeit gegeben hatte, diese zu beheben{% else %}nachdem die Verantwortliche auf meine Mitteilung geantwortet hatte{% endif %}.

{% if type === 'complaint' %}
Zusätzlich berücksichtige ich nur Übertragungen an Server, für die das Protokoll von {% if analysis.app.platform === 'Android' %}der "TrackerControl"-App{% elif analysis.app.platform === 'iOS' %}dem "App-Datenschutzbericht"{% endif %} bestätigt hat, dass die App sie auch auf meinem persönlichen Gerät kontaktiert, wie oben erläutert. Es ist daher sicher anzunehmen, dass all diese Übertragungen auch mich persönlich betreffen.
{% endif %}

Es sei noch einmal darauf hingewiesen, dass die hier beschriebenen Tracking-Übertragungen durch die Analysemethodik garantiert alle *ohne jegliche Interaktion* mit der App oder einem möglichen Einwilligungsdialog erfolgten.

{% for adapterSlug, adapterResult in findings %}
== {{ adapterResult.adapter.name }}

Die App sendete {{ adapterResult.requests.length }} Anfrage(n) an den Tracker "{{ adapterResult.adapter.name }}", betrieben von "{{ adapterResult.adapter.tracker.name }}".

{% if adapterResult.adapter.tracker.description %}
{{ t("tracker-descriptions", adapterResult.adapter.tracker.description) | trackharMl | safe }}
{% endif %}

{% if adapterResult.adapter.description %}
{{ t("tracker-descriptions", adapterResult.adapter.description) | trackharMl | safe }}
{% endif %}

Durch diese Anfrage(n) wurden mindestens die folgenden Informationen übermittelt:

#table(
  columns: (33.3333%, 66.6666%),

  [*Data type*], [*Transmitted value(s)*],
  {% for property, value in adapterResult.receivedData -%}
  [{{ t("properties", property) }}], [{{ value | join(', ') | code }}],
  {% endfor %}
)

Der vollständige Inhalt dieser Anfrage(n) und die Methode zur Dekodierung der Anfrage(n) und Extraktion dieser Informationen sind im beigefügten technischen Bericht dokumentiert.
{% endfor %}

= Kontext: Online-Tracking <context-online-tracking>

Die von der Verantwortlichen in der App eingesetzten Tracking-Praktiken sind Teil eines größeren Ökosystems des Online-Trackings, das im Web und in mobilen Apps allgegenwärtig geworden ist. Umfangreiche Forschung hat immer wieder weit verbreitete Verstöße gegen und eine vorherrschende Missachtung des Datenschutzrechts in diesem Zusammenhang aufgedeckt. Die riesigen Mengen personenbezogener Daten, die durch solche Tracking-Aktivitäten gesammelt werden, fließen in ein undurchsichtiges und schattenhaftes System aus Tausenden von Unternehmen, was sehr reale Gefahren für die Nutzer_innen darstellt.

== Notorische Verstöße gegen das Datenschutzrecht

Studien, die das Tracking ohne Einwilligung untersucht haben, haben bewiesen, wie verbreitet Tracking ist, selbst bevor es überhaupt eine Interaktion durch die Nutzer_in gab.

Im Web ergab die Forschung, dass zwischen 49~% und 75~% der Websites Tracking durchführen, bevor die Nutzer_innen mit einem Einwilligungsdialog interagieren oder sogar nachdem sie diesen ausdrücklich abgelehnt haben.#footnote[Trevisan/Traverso/Bassi/Mellia, 4 Years of EU Cookie Law: Results and Lessons Learned, 2019, https://petsymposium.org/popets/2019/popets-2019-0023.pdf; Papadogiannakis/Papadopoulos/Kourtellis/Markatos, User Tracking in the Post-cookie Era: How Websites Bypass GDPR Consent to Track Users, 2021, https://dl.acm.org/doi/10.1145/3442381.3450056]

Studien, die Apps auf Android und iOS analysierten, kamen zu ähnlichen Ergebnissen und berichten, dass etwa 75~% der Apps ohne Einwilligung Tracker kontaktieren und zwischen 55~% und 72~% der Apps eindeutige Geräteidentifikatoren wie die Werbe-ID weitergeben.#footnote[Kollnig/Shuba/Binns/Van Kleek/Shadbolt, Are iPhones Really Better for Privacy? A Comparative Study of iOS and Android Apps, 2022, https://petsymposium.org/popets/2022/popets-2022-0033.pdf; Altpeter, Informed Consent? A Study of "Consent Dialogs" on Android and iOS, 2022, https://benjamin-altpeter.de/doc/thesis-consent-dialogs.pdf] Tatsächlich übertragen Apps mehr personenbezogene Daten an Tracker, bevor sie eine Einwilligung einholen, als danach.#footnote[Koch/Altpeter/Johns, The OK Is Not Enough: A Large Scale Study of Consent Dialogs in Smartphone Applications, 2023, https://www.usenix.org/system/files/usenixsecurity23-koch.pdf; Altpeter, Informed Consent? A Study of "Consent Dialogs" on Android and iOS, 2022, https://benjamin-altpeter.de/doc/thesis-consent-dialogs.pdf] Entwickler_innen sind sich häufig ihrer Verpflichtungen nach dem Datenschutzrecht nicht bewusst oder verstehen sie falsch.#footnote[Tin Nguyen/Backes/Marnau/Stock, Share First, Ask Later (or Never?) Studying Violations of GDPR’s Explicit Consent in Android Apps, 2021, https://www.usenix.org/system/files/sec21-nguyen.pdf]

Websites und Apps, die versuchen, die Einwilligung der Nutzer_innen einzuholen, verwenden typischerweise Dark Patterns und Nudging, um Nutzer_innen dazu zu bringen, eine Einwilligung zu geben, auch wenn sie dies eigentlich nicht wollen. Mehrere Studien im Web und auf Mobilgeräten ergaben, dass etwa 90~% der Einwilligungsdialoge mindestens ein Dark Pattern verwendeten, das in Orientierungshilfen von Datenschutzaufsichtsbehörden ausdrücklich als Verstoß gegen die Bedingungen für eine gültige Einwilligung nach der DSGVO beschrieben wird.#footnote[Koch/Altpeter/Johns, The OK Is Not Enough: A Large Scale Study of Consent Dialogs in Smartphone Applications, 2023, https://www.usenix.org/system/files/usenixsecurity23-koch.pdf; Altpeter, Informed Consent? A Study of "Consent Dialogs" on Android and iOS, 2022, https://benjamin-altpeter.de/doc/thesis-consent-dialogs.pdf; Nouwens/Liccardi/Veale/Karger/Kagal, Dark Patterns after the GDPR: Scraping Consent Pop-ups and Demonstrating their Influence, 2020, https://dl.acm.org/doi/10.1145/3313831.3376321] Zu diesen Dark Patterns gehören, dass die Ablehnung der Einwilligung schwieriger gemacht wird als die Erteilung und dass die "Akzeptieren"-Schaltfläche im Vergleich zur "Ablehnen"-Schaltfläche durch Farbe und/oder Größe übermäßig hervorgehoben wird. Es ist wichtig zu beachten, dass alle zitierten Studien nur eine begrenzte Anzahl von minimalen Bedingungen überprüften, die leicht automatisch ausgewertet werden können, was bedeutet, dass der tatsächliche Anteil von Einwilligungsdialogen mit Verstößen aller Wahrscheinlichkeit nach noch höher ist.

Die Gefahren solcher Dark Patterns und Nudging sind in der einschlägigen Literatur gut belegt. Einwilligungsdialoge funktionieren bereits nicht als Medium zur Vermittlung datenschutzkritischer Informationen an Nutzer_innen, selbst wenn diese um ihre Privatsphäre besorgt sind und keine Dark Patterns verwendet werden.#footnote[Bauer/Bravo-Lillo/Fragkaki/Melicher, A comparison of users' perceptions of and willingness to use Google, Facebook, and Google+ single-sign-on functionality, 2013, https://dl.acm.org/doi/10.1145/2517881.2517886] Experimente, welche die Auswirkungen verschiedener Designvariablen in Einwilligungsdialogen auf die Entscheidungen der Nutzer_innen untersuchten, ergaben, dass Nudging, selbst in Form von scheinbar kleinen Details, die Einwilligungsraten stark erhöht.#footnote[Utz/Degeling/Fahl/Schaub/Holz, (Un)informed Consent: Studying GDPR Consent Notices in the Field, 2019, https://dl.acm.org/doi/10.1145/3319535.3354212; Nouwens/Liccardi/Veale/Karger/Kagal, Dark Patterns after the GDPR: Scraping Consent Pop-ups and Demonstrating their Influence, 2020, https://dl.acm.org/doi/10.1145/3313831.3376321] Zum Beispiel führt eine hervorgehobene "Alle akzeptieren"-Schaltfläche zu signifikant höheren Einwilligungsraten, aber gleichzeitig sind sich die Nutzer_innen ihrer Auswirkungen nicht bewusst und bereuen ihre Wahl, nachdem sie über ihre Auswirkungen informiert wurden.#footnote[Machuletz/Böhme, Multiple Purposes, Multiple Problems: A User Study of Consent Dialogs after GDPR, 2020, https://petsymposium.org/popets/2020/popets-2020-0037.pdf]

Andere Forschungen ergaben, dass Webseiten vermeintliche Einwilligungen ohne Interaktion der Nutzer_in oder sogar nach einer ausdrücklichen Ablehnung registrieren, sowie sowie in der Hälfte der Einwilligungsdialoge Nutzer_innen durch vorausgewählte Optionen zur Einwilligung bewegen.#footnote[Matte/Bielova/Santos, Do Cookie Banners Respect my Choice?: Measuring Legal Compliance of Banners from IAB Europe's Transparency and Consent Framework, 2020, https://ieeexplore.ieee.org/document/9152617]

== Reale Risiken für betroffene Personen

Gleichzeitig stellen diese Praktiken erhebliche und sehr reale Risiken für betroffene Personen dar. Tausende von Tracking-Unternehmen weltweit sammeln ständig riesige Mengen an Daten über Nutzer_innen im Web und auf Mobilgeräten und analysieren intime Details über ihr Leben. Eine Analyse selbst deklarierter Datenschutzkennzeichnungen auf Android ergab, dass häufig heruntergeladene Apps – einschließlich Apps, die sich ausdrücklich an Kinder richten – zugeben, hochsensible Daten wie die sexuelle Orientierung oder Gesundheitsinformationen der Nutzer_innen für Tracking- und Werbezwecke zu sammeln und weiterzugeben.#footnote[Altpeter, Beunruhigende Geständnisse: Ein Blick auf den Abschnitt zur Datensicherheit bei Android, 2022, https://www.datenanfragen.de/blog/android-datensicherheit-analyse/] Basierend auf solchen Daten versuchen sie, das Verhalten der Nutzer_innen vorherzusagen, beispielsweise um Nutzer_innen mit Anzeigen zu beeinflussen und zu entscheiden, welche Produkte angezeigt werden und zu welchem Preis. Sie behaupten auch, in der Lage zu sein, die Risiken von Unternehmen einzuschätzen, um sich vor Spam zu schützen, Kreditwürdigkeit zu berechnen oder Betrug zu verhindern.#footnote[Sieben in Altpeter/Sieben, Tracking und Datenschutzrechte, 2023, https://static.dacdn.de/talks/slides/2023-09-08-topio.pdf, Folie 75]

Zusätzlich erstellen Tracker Profile von Nutzer_innen und kategorisieren sie in Segmente, manchmal basierend auf hochsensiblen Schlussfolgerungen wie Gesundheitszustand, religiösen Überzeugungen, sexueller Orientierung, Einkommensniveau und mehr. Um nur einige Beispiele zu nennen: Berichterstattung hat Segmente wie _überdurchschnittlicher Alkohol-Konsum_, _Wunsch abzunehmen_, _plant ein Kind zu adoptieren_, _Diagnose für Leukämie_, _niedriges Einkommen ohne Perspektive_, _konservative Werte_ und sogar _Besuche von Behandlungszentren für sexuellen Missbrauch_ aufgedeckt. Tracker bewerten Nutzer_innen auch nach Kriterien wie _oft durch Werbung beeinflusst_, _unerfahrene Kreditkarten-Kund_innen_, _einsame Wölfe_ und _bekommen einen schlechten Deal aus dem Leben_, um Schwachstellen zu identifizieren.#footnote[Keegan/Eastwood, From "Heavy Purchasers" of Pregnancy Tests to the Depression-Prone: We Found 650,000 Ways Advertisers Label You, 2023, https://themarkup.org/privacy/2023/06/08/from-heavy-purchasers-of-pregnancy-tests-to-the-depression-prone-we-found-650000-ways-advertisers-label-you; Gille/Meineck/Dachwitz, Wie eng uns Datenhändler auf die Pelle rücken, 2023, https://netzpolitik.org/2023/europa-vergleich-wie-eng-uns-datenhaendler-auf-die-pelle-ruecken/] Tracker führen groß angelegte Experimente durch und optimieren systematisch, wie sie Nutzer_innen überzeugen, manipulieren und triggern können.#footnote[Christl, Corporate Surveillance in Everyday Life, 2017, https://crackedlabs.org/en/corporate-surveillance]

Entscheidend ist, dass Tracker für keinen Aspekt dieses Profiling die bürgerliche Identität der Nutzer_innen kennen müssen. Sie sammeln und vergeben eindeutige Identifier, um Nutzer_innen zu verfolgen, und teilen und verknüpfen diese IDs untereinander, um Nutzer_innen über Websites und Apps hinweg genauer zu verfolgen.#footnote[Urban/Tatang/Degeling/Holz/Pohlmann, The Unwanted Sharing Economy: An Analysis of Cookie Syncing and User Transparency under GDPR, 2018, https://arxiv.org/pdf/1811.08660.pdf; Englehardt/Narayanan, Online Tracking: A 1-million-site Measurement and Analysis, 2016, https://dl.acm.org/doi/pdf/10.1145/2976749.2978313; Cyphers/Gebhart, Behind the One-Way Mirror: A Deep Dive Into the Technology of Corporate Surveillance, 2019, https://www.eff.org/files/2019/12/11/behind_the_one-way_mirror-a_deep_dive_into_the_technology_of_corporate_surveillance.pdf] Für Tracker sind diese IDs oft sogar nützlicher als bürgerliche Namen. Schließlich sind Namen nicht eindeutig, während IDs speziell dafür entwickelt wurden, eine einzelne Nutzer_in, ein einzelnes Gerät oder eine einzelne Sitzung präzise zu identifizieren. Wie Zuiderveen Borgesius feststellt, sind viele Unternehmen nicht daran interessiert, einen Namen mit Daten zu verknüpfen, die sie für verhaltensbasiertes Targeting verarbeiten, obwohl sie dies leicht tun könnten.#footnote[Zuiderveen Borgesius, Singling out people without knowing their names – Behavioural targeting, pseudonymous data, and the new Data Protection Regulation, 2016, S. 268]

Angeblich anonymisierte Datensätze sind selten sicher vor Re-Identifizierung. In vielen Fällen reichen schon eine Handvoll scheinbar harmloser Datenpunkte aus, um eine Person eindeutig zu identifizieren.#footnote[vgl. z.~B. Rocher/Hendrickx/de Montjoye, Estimating the success of re-identifications in incomplete datasets using generative models, Nature Communications, 2019, https://www.nature.com/articles/s41467-019-10933-3] Ebenso kann Fingerprinting oft ein Gerät anhand seiner Einstellungen eindeutig identifizieren.#footnote[lschatzkin/Budington/maximillianh/Antaki, About Cover Your Tracks, 2021, https://coveryourtracks.eff.org/about]

Angesichts des oben Gesagten ist es entscheidend, dass das Datenschutzrecht betroffene Personen vor diesen Gefahren schützt. Sein eigentlicher Zweck ist es, Einzelpersonen vor dem Missbrauch ihrer personenbezogenen Daten zu schützen, was ein Grundrecht ist. Tracking-Praktiken, wie sie oben beschrieben wurden, verletzen nicht nur dieses Recht, sondern stellen auch eine erhebliche Bedrohung für die Autonomie und Würde der_des Einzelnen dar. Die verdeckte Anhäufung und Ausbeutung personenbezogener Daten durch Tracking-Mechanismen ermöglichen Manipulation und Diskriminierung und untergraben damit das Wesen der individuellen Freiheit und Selbstbestimmung.

= {{ 'Rechtliche Einordnung' if type === 'complaint' else 'Beschwerdegründe' }} <legal-grounds>

Basierend auf den oben dargestellten Fakten bin ich der Meinung, dass die Verantwortliche gegen das Datenschutzrecht verstoßen hat, wie ich im Folgenden erläutern werde.

== Verstoß gegen Art. 6 Abs. 1 DSGVO: Rechtmäßigkeit der Verarbeitung

Die in @tracking aufgeführten Tracking-Datenübertragungen fallen in den Anwendungsbereich der DSGVO, aber die Verantwortliche hatte keine Rechtsgrundlage für diese Verarbeitung.

=== Übermittlung der Tracking-Daten fällt unter die DSGVO

Durch die Tracking-Datenübertragungen verarbeitete die Verantwortliche meine personenbezogenen Daten auf automatisierte Weise. Dementsprechend fallen sie in den Anwendungsbereich der DSGVO (Art. 2 Abs. 1 DSGVO).

Der Europäische Gerichtshof hat wiederholt und durchgehend betont, dass der Begriff der personenbezogenen Daten weit auszulegen ist#footnote[vgl. z.~B. Europäischer Gerichtshof, Urteil vom 20. Dezember 2017, Rechtssache C-434/16, https://eur-lex.europa.eu/legal-content/DE/TXT/?uri=CELEX:62016CJ0434; Europäischer Gerichtshof, Urteil vom 4. Mai 2023, Rechtssache C-487/21, https://eur-lex.europa.eu/legal-content/DE/TXT/?uri=CELEX:62021CJ0487; Europäischer Gerichtshof, Urteil vom 7. März 2024, Rechtssache C-479/22 P, https://eur-lex.europa.eu/legal-content/DE/TXT/?uri=CELEX:62022CJ0479], auch im Kontext von Online-Werbung und Tracking#footnote[Europäischer Gerichtshof, Urteil vom 7. März 2024, Rechtssache C-604/22, https://eur-lex.europa.eu/legal-content/DE/TXT/?uri=CELEX:62022CJ0604]. Die Definition von "personenbezogenen Daten" in Art. 4 Nr. 1 DSGVO nennt ausdrücklich Online-Kennungen als mögliches Mittel zur Identifizierung. Erwägungsgrund 26 der DSGVO bestätigt weiter: "Um festzustellen, ob eine natürliche Person identifizierbar ist, sollten alle Mittel berücksichtigt werden, die von dem Verantwortlichen oder einer anderen Person nach allgemeinem Ermessen wahrscheinlich genutzt werden, um die natürliche Person direkt oder indirekt zu identifizieren, wie beispielsweise das Aussondern." Es war ausdrücklich die Absicht des Gesetzgebers, klarzustellen, dass die DSGVO im Kontext des Online-Trackings Anwendung findet#footnote[Albrecht/Jotzo, Das neue Datenschutzrecht der EU, 1. Auflage, 2017, Teil 3, Rn. 3]: #quote[Indirekt kann auf Betroffene beispielsweise durch das in ErwGr. 26 DSGVO genannte "Aussondern" geschlossen werden. Auf diese Klarstellung hatte das _Europäische Parlament_ gedrungen, da im Online-Bereich z.B. mithilfe von Cookies, IP-Adressen, Browser-Fingerprints und anderer Techniken von vielen Nutzern Persönlichkeitsprofile erzeugt werden, mit denen sie individuelle Werbung erhalten, ohne dass die Betreiber solcher Werbenetzwerke ihre bürgerlichen Namen bräuchten.]

Daher reicht bereits die bloße Möglichkeit, eine Person anhand eines Datums zu individualisieren oder zu erkennen, für das Vorliegen personenbezogener Daten aus.#footnote[zustimmend: Farinho in Spiecker gen. Döhmann/Papakonstantinou/Hornung/De Hert, General Data Protection Regulation, Art. 4(1) Personal data, 2023, Rn. 21, 24; Zuiderveen Borgesius, Singling out people without knowing their names – Behavioural targeting, pseudonymous data, and the new Data Protection Regulation, Computer Law & Security Review 2016, 256; Artikel-29-Datenschutzgruppe, WP 136: Stellungnahme 4/2007 zum Begriff "personenbezogene Daten", https://ec.europa.eu/justice/article-29/documentation/opinion-recommendation/files/2007/wp136_de.pdf, S. 16; Albrecht/Jotzo, Das neue Datenschutzrecht der EU, 1. Auflage, 2017, Teil 3, Rn. 3; Karg in Simitis/Hornung/Spiecker gen. Döhmann, Datenschutzrecht, 1. Auflage, 2019, Art. 4 Nr. 1 DSGVO, Rn. 49–50; Schantz in Schantz/Wolff, Das neue Datenschutzrecht, 1. Auflage, 2017, Kapitel C.II, Rn. 292–293; Schild in BeckOK Datenschutzrecht, 45. Auflage, 2023, Art. 4 Nr. 1, Rn. 17, 19]

Die von der Verantwortlichen integrierten Tracking-Dienste haben IDs gelesen und/oder gesetzt, die zur Identifizierung meiner Person und meines Geräts verwendet werden. Diese IDs sind speziell darauf ausgelegt, eindeutig zu sein und Kollisionen zu vermeiden, um sicherzustellen, dass sie nur einmal vergeben werden und mich somit präzise identifizieren. Ein übliches ID-Format, das Tracker oft verwenden, sind beispielsweise UUIDs/GUIDs. Diese sind ausdrücklich so spezifiziert, dass sie 'Eindeutigkeit über Raum und Zeit hinweg' garantieren.#footnote[Leach/Mealling/Salz, RFC 4122: A Universally Unique IDentifier (UUID) URN Namespace, 2005, https://datatracker.ietf.org/doc/html/rfc4122] Man müsste 1 Milliarde UUIDv4s pro Sekunde für etwa 86 Jahre generieren, um auch nur eine 50%ige Wahrscheinlichkeit für eine Kollision zu haben.#footnote[Wikipedia-Beitragende, Universally unique identifier, 2024, https://en.wikipedia.org/w/index.php?title=Universally_unique_identifier&oldid=1212321712]

Zusätzlich tauschen Tracker häufig IDs untereinander uns (ein Vorgang, der im Web als "Cookie-Syncing" bezeichnet wird).#footnote[Urban/Tatang/Degeling/Holz/Pohlmann, The Unwanted Sharing Economy: An Analysis of Cookie Syncing and User Transparency under GDPR, 2018, https://arxiv.org/pdf/1811.08660.pdf; Englehardt/Narayanan, Online Tracking: A 1-million-site Measurement and Analysis, 2016, https://dl.acm.org/doi/pdf/10.1145/2976749.2978313; Cyphers/Gebhart, Behind the One-Way Mirror: A Deep Dive Into the Technology of Corporate Surveillance, 2019, https://www.eff.org/files/2019/12/11/behind_the_one-way_mirror-a_deep_dive_into_the_technology_of_corporate_surveillance.pdf] Dieser Prozess ermöglicht es verschiedenen Tracking-Diensten, IDs miteinander zu teilen und abzugleichen, wodurch Daten aus verschiedenen Quellen kombiniert werden können, um ein noch umfassenderes Profil einer Person zu erstellen.

Diese IDs werden dann nicht nur verwendet, um Daten über Einzelpersonen zu sammeln und ihr Verhalten zu verfolgen, sondern beispielsweise auch, um zielgerichtete Werbung zu liefern.

Somit ist offensichtlich, dass der eigentliche Zweck der IDs darin besteht, Nutzer_innen wie in Erwägungsgrund 26 DSGVO erwähnt auszusondern und zu identifizieren.

Selbst wenn die IDs für sich genommen keine personenbezogenen Daten wären, stellen die übermittelten Tracking-Daten als Ganzes zweifelsfrei personenbezogene Daten dar. Eine Verantwortliche muss nicht in der Lage sein, aus einer Information sofort den Namen einer betroffenen Person abzuleiten, damit diese Information personenbezogene Daten darstellt.#footnote[Farinho in Spiecker gen. Döhmann/Papakonstantinou/Hornung/De Hert, General Data Protection Regulation, Art. 4(1) Personal data, 2023, Rn. 20; Purtova, From knowing by name to targeting: the meaning of identification under the GDPR, 2022, https://academic.oup.com/idpl/article/12/3/163/6612144; EU FRA, Handbuch zum europäischen Datenschutzrecht, Ausgabe 2018, Abschnitt 2.1, https://fra.europa.eu/sites/default/files/fra_uploads/fra-coe-edps-2018-handbook-data-protection_de.pdf; Albrecht/Jotzo, Das neue Datenschutzrecht der EU, 1. Auflage, 2017, Teil 3, Rn. 3; Arning/Rothkegel in Taeger/Gabel, DSGVO - BDSG - TTDSG, 4. Auflage, 2022, Art. 4 DSGVO, Rn. 24, 30; Ernst in Paal/Pauly, DS-GVO BDSG, 3. Auflage, 2021, Art. 4 Nr. 1 DSGVO, Rn. 8; Karg in Simitis/Hornung/Spiecker gen. Döhmann, Datenschutzrecht, 1. Auflage, 2019, Art. 4 Nr. 1 DSGVO, Rn. 48–49; Klabunde in Ehmann/Selmayr/Klabunde, DS-GVO, 2. Auflage, 2018, Art. 4 DSGVO Nr. 1, Rn. 18; Schantz in Schantz/Wolff, Das neue Datenschutzrecht, 1. Auflage, 2017, Kapitel C.II, Rn. 291–292; Schild in BeckOK Datenschutzrecht, 45. Auflage, 2023, Art. 4 Nr. 1, Rn. 17; Ziebarth in Sydow/Marsch, DS-GVO/BDSG, 3. Auflage, 2022, Art. 4 Nr. 1 DSGVO, Rn. 14; Karg/Kühn, Datenschutzrechtlicher Rahmen für "Device Fingerprinting" - Das klammheimliche Ende der Anonymität im Internet, ZD 2014, 285, S. 288; Wenhold, Nutzerprofilbildung durch Webtracking, 1. Auflage, 2018, Kapitel E.I.2, S. 130]

Im Kontext von Online-Tracking und -Werbung werden IDs nie allein verarbeitet. Stattdessen werden sie mit anderen Informationen kombiniert, wie Interaktionsdaten, Browserverlauf, Standortdaten, Geräteparametern, Verhaltensmustern und IP-Adressen, um detaillierte Fingerabdrücke und Profile von Nutzer_innen zu erstellen und sie mit personalisierten Anzeigen anzusprechen. Wie in @tracking gezeigt, besteht der Zweck der Tracker, welche die Verantwortliche in die App eingebettet hat, gerade darin, einzelne Nutzer_innen anzusprechen und/oder zu erkennen. In diesem größeren Kontext besteht ein überwältigender Konsens unter Rechtswissenschaftler_innen, dass eine solche Datenverarbeitung in den Anwendungsbereich der DSGVO fällt und personenbezogene Daten darstellt.#footnote[Gola in Gola/Heckmann, Datenschutz-Grundverordnung - Bundesdatenschutzgesetz, 3. Auflage, 2022, Art. 4 Nr. 1 DSGVO, Rn. 23; Klar/Kühling in Kühling/Buchner, DS-GVO/BDSG, 3. Auflage, 2020, Art. 4 Nr. 1 DSGVO, Rn. 36; Schild in BeckOK Datenschutzrecht, 45. Auflage, 2023, Art. 4 Nr. 1, Rn. 20] Dies steht im Einklang mit Erwägungsgrund 30 DSGVO.

Diese Position wird weiterhin durch einen umfangreichen Korpus von Orientierungshilfen und Entscheidungen verschiedener Datenschutzaufsichtsbehörden gestützt. Diese sind im Anhang in @dpa-guidelines-id resp. @dpa-decisions-id aufgeführt.

Schließlich sei erwähnt, dass die Tracking-Unternehmen bei allen in @tracking detaillierten Anfragen die Möglichkeit haben, die übermittelten Tracking-Daten mit der IP-Adresse der Nutzer_in zu verknüpfen. Wie der Europäische Gerichtshof wiederholt entschieden hat, können diese Informationen es ermöglichen, ein Profil dieser Nutzer_in zu erstellen und die konkret betroffene Person tatsächlich zu identifizieren.#footnote[vgl. z.~B. Europäischer Gerichtshof, Urteil vom 7. März 2024, Rechtssache C-604/22, https://eur-lex.europa.eu/legal-content/DE/TXT/?uri=CELEX:62022CJ0604; Europäischer Gerichtshof, Urteil vom 17. Juni 2021, Rechtssache C-597/19, https://eur-lex.europa.eu/legal-content/de/TXT/?uri=CELEX:62019CJ0597; Europäischer Gerichtshof, Urteil vom 19. Oktober 2016, Rechtssache C-582/14, https://eur-lex.europa.eu/legal-content/DE/TXT/?uri=CELEX:62014CJ0582]

Folglich handelt es sich bei den Informationen in den beschriebenen Tracking-Datenübertragungen offenkundig um personenbezogene Daten. Offensichtlich wurden sie auch auf automatisierte Weise verarbeitet und fallen somit in den Anwendungsbereich der DSGVO.

=== Keine Rechtsgrundlage ist für die Übermittlungen anwendbar <no-legal-basis>

Gemäß Art. 6 Abs. 1 DSGVO ist die Verarbeitung personenbezogener Daten nur rechtmäßig, wenn sie sich auf mindestens eine der sechs möglichen Rechtsgrundlagen berufen kann. Für die von der Verantwortlichen durchgeführten Verarbeitungen gibt es aber gerade keine gültige Rechtsgrundlage:

  + Einwilligung (Art. 6 Abs. 1 lit. a DSGVO): Eine Einwilligung kann nur durch eine Erklärung oder durch eine eindeutige bestätigende Handlung erteilt werden (Art. 4 Nr. 11 DSGVO). Erwägungsgrund 32 DSGVO stellt klar, dass Stillschweigen, bereits angekreuzte Kästchen oder Untätigkeit keine Einwilligung darstellen.

    Wie bereits erläutert, erfolgten die oben beschriebenen Übermittlungen ohne jegliche Interaktion. Somit kann dafür unmöglich eine Einwilligung erteilt worden sein. In jedem Fall läge die Beweislast dafür, dass eine Einwilligung erteilt wurde, gemäß Art. 7 Abs. 1 DSGVO bei der Verantwortlichen.
  + Erforderlichkeit für die Erfüllung eines Vertrages (Art. 6 Abs. 1 lit. b DSGVO): Die beschriebenen Datenübermittlungen dienten dem Online-Tracking. Eine solche Verarbeitung ist nicht für die Erfüllung eines Vertrages erforderlich.

    In seinen _Leitlinien 2/2019 zur Verarbeitung personenbezogener Daten gemäß Artikel 6 Absatz 1 Buchstabe b DSGVO im Zusammenhang mit der Erbringung von Online-Diensten für betroffene Personen_ bestätigt der EDSA ausdrücklich, dass Art. 6 Abs. 1 lit. b DSGVO nicht als Rechtsgrundlage für die Verfolgung und Erstellung von Profilen von Nutzer_innen#footnote[EDSA, Leitlinien 2/2019 zur Verarbeitung personenbezogener Daten gemäß Artikel 6 Absatz 1 Buchstabe b DSGVO im Zusammenhang mit der Bereitstellung von Online-Diensten für betroffene Personen, Version 2.0, 2019, https://edpb.europa.eu/sites/default/files/files/file1/edpb_guidelines-art_6-1-b-adopted_after_public_consultation_de.pdf, Rn. 56], verhaltensorientierte Online-Werbung#footnote[ebd., Rn. 51 ff.] oder das Sammeln von Metriken zur "Verbesserung des Dienstes"#footnote[ebd., Rn. 48 ff.] verwendet werden kann.
  + Rechtliche Verpflichtung (Art. 6 Abs. 1 lit. c DSGVO): offensichtlich nicht anwendbar.
  + Erforderlichkeit zum Schutz lebenswichtiger Interessen einer natürlichen Person (Art. 6 Abs. 1 lit. d DSGVO): offensichtlich nicht anwendbar.
  + Erforderlichkeit für die Wahrnehmung einer Aufgabe, die im öffentlichen Interesse liegt (Art. 6 Abs. 1 lit. e DSGVO): offensichtlich nicht anwendbar.
  + Erforderlichkeit zur Wahrung berechtigter Interessen (Art. 6 Abs. 1 lit. f DSGVO): Die Verantwortliche kann sich auch nicht auf ein berechtigtes Interesse an der Verarbeitung berufen. Berechtigte Interessen sind in der Regel keine geeignete Rechtsgrundlage für Tracking.#footnote[vgl. z.~B. Datenschutzkonferenz, Orientierungshilfe der Aufsichtsbehörden für Anbieter:innen von Telemedien ab dem 1. Dezember 2021 (OH Telemedien 2021), Version 1.1, 2022, https://www.datenschutzkonferenz-online.de/media/oh/20221130_OH_Telemedien_2021_Version_1_1.pdf, Abschnitt IV. 5; Der Landesbeauftragte für Datenschutz und Informationsfreiheit Baden-Württemberg, FAQ: Cookies und Tracking durch Betreiber von Webseiten und Hersteller von Smartphone-Apps, Version 2.0.1, 2022, https://www.baden-wuerttemberg.datenschutz.de/wp-content/uploads/2022/03/FAQ-Tracking-online.pdf, Abschnitt A.3.1; Artikel-29-Datenschutzgruppe, WP 217, Stellungnahme 06/2014 zum Begriff des berechtigten Interesses des für die Verarbeitung Verantwortlichen gemäß Artikel 7 der Richtlinie 95/46/EG, https://ec.europa.eu/justice/article-29/documentation/opinion-recommendation/files/2014/wp217_de.pdf, S. 41; Artikel-29-Datenschutzgruppe, WP 203, Opinion 03/2013 on purpose limitation, https://ec.europa.eu/justice/article-29/documentation/opinion-recommendation/files/2013/wp203_en.pdf, S. 46] Es ist nicht ersichtlich, warum das Interesse der Verantwortlichen am Tracking meine Interessen oder Grundrechte und Grundfreiheiten überwiegen sollte.

== Verstoß gegen Art. 25 DSGVO und Art. 5 Abs. 1 lit. c DSGVO: Datenschutz durch Technikgestaltung und durch datenschutzfreundliche Voreinstellungen, Datenminimierung

Die Verantwortliche hat es versäumt, geeignete technische und organisatorische Maßnahmen zu implementieren, um den Datenschutz durch Technikgestaltung und durch datenschutzfreundliche Voreinstellungen gemäß Art. 25 DSGVO zu gewährleisten.

Art. 25 Abs. 1 DSGVO verpflichtet die Verantwortliche, geeignete Maßnahmen sowohl zum Zeitpunkt der Festlegung der Mittel für die Verarbeitung als auch während der Verarbeitung selbst umzusetzen. Dies umfasst Maßnahmen zur wirksamen Umsetzung des Grundsatzes der Datenminimierung gemäß Art. 5 Abs. 1 lit. c DSGVO.#footnote[EDSA, Guidelines 4/2019 on Article 25 Data Protection by Design and by Default, Version 2.0, 2020, https://edpb.europa.eu/sites/default/files/files/file1/edpb_guidelines_201904_dataprotection_by_design_and_by_default_v2.0_en.pdf, Rn. 61] Der EDSA hat bestätigt, dass diese Verpflichtung für alle Verantwortlichen gilt, unabhängig von ihrer Größe oder der Komplexität ihrer Verarbeitungsvorgänge.#footnote[ebd., Rn. 6]

@tracking beschreibt das Tracking, das die App durchgeführt hat. Wie in @context-online-tracking erläutert, birgt das Online-Tracking-Ökosystem schwerwiegende Risiken für die Rechte und Freiheiten der betroffenen Personen, selbst wenn nur scheinbar harmlose Daten verarbeitet werden. Es ist die Pflicht der Verantwortlichen, den aktuellen "Stand der Technik" in ihrer Risikoanalyse zu berücksichtigen und Kenntnis darüber zu haben, wie Technologie Datenschutzrisiken darstellen kann.#footnote[ebd., Rn. 19, 30] Sie hätte sich dieser Risiken bewusst sein müssen, da sie in Literatur, Medien und öffentlicher Debatte weithin dokumentiert und diskutiert werden.

Stattdessen hat sie es versäumt, diese Risiken zu mindern und stattdessen eine unnötige Erhebung und Übermittlung von Daten standardmäßig ermöglicht. Die Verantwortliche hat die oben genannten Tracking-SDKs von Drittanbietern in ihre App integriert und sie so konfiguriert, dass sie ohne jegliche Interaktion der Nutzer_in Tracking-Daten senden.

Die Verantwortliche kann auch nicht argumentieren, dass die SDKs selbst das Tracking standardmäßig aktiviert hätten. Es liegt in der Verantwortung der Verantwortlichen, sicherzustellen, dass Funktionen, die keine Rechtsgrundlage haben oder nicht mit den beabsichtigten Verarbeitungszwecken vereinbar sind, bei der Einbindung von Software Dritter in ihre App deaktiviert sind.#footnote[ebd., Rn. 44]

Wie in @no-legal-basis erläutert, gehen die durch das Tracking gesammelten Daten über das hinaus, was für die Funktionalität der App angemessen und notwendig ist. Sollte die Verantwortliche argumentieren, dass sie bestimmte Statistiken benötigt, um beispielsweise die Leistung ihrer App zu überwachen, hätten weniger granulare, aggregierte oder anonymisierte Daten für diesen Zweck ausgereicht, anstatt die Daten mit eindeutigen Kennungen zu kombinieren, die es der Verantwortlichen und Dritten ermöglichen, mich zu identifizieren.#footnote[ebd., Rn. 49, 75] Sie hat somit mehr Daten erhoben als notwendig und damit gegen den Grundsatz der Datenminimierung gemäß Art. 5 Abs. 1 lit. c DSGVO verstoßen.

Schließlich müssen Nutzer_innen vernünftigerweise nicht erwarten, dass Apps ohne jegliche Interaktion so detaillierte identifizierbare Daten über sie übermitteln.#footnote[ebd., Rn. 70]

== Beweislast <legal-grounds-burden-of-proof>

Als betroffene Person habe ich keine Einblicke in die internen Prozesse und Datenverarbeitungspraktiken der Verantwortlichen oder der Tracking-Unternehmen, welche die Verantwortliche in ihre App integriert hat. Mit dieser Beschwerde habe ich technisch und rechtlich substantiiert dargelegt, warum ich glaube, dass die Verantwortliche gegen meine Datenschutzrechte verstoßen hat.

Die Beweislast dafür, dass ihre Verarbeitung im Einklang mit der DSGVO steht, liegt gemäß Art. 5 Abs. 2 DSGVO bei der Verantwortlichen.#footnote[mit weiteren Nachweisen: Schantz in BeckOK Datenschutzrecht, 45. Auflage, 2023, Art. 5, Rn. 39] Dies wurde auch vom Europäischen Gerichtshof ausdrücklich bestätigt.#footnote[Europäischer Gerichtshof, Urteil vom 24. Februar 2022, Rechtssache C-175/20, https://eur-lex.europa.eu/legal-content/DE/TXT/?uri=CELEX:62020CJ0175]

{% if complaintOptions.nationalEPrivacyLaw === 'TDDDG' %}
== §~25 TDDDG: Schutz der Privatsphäre bei Endeinrichtungen

Zusätzlich zur DSGVO bin ich der Meinung, dass die Verantwortliche auch gegen §~25 TDDDG als Umsetzung von Art. 5 Abs. 3 ePrivacy-Richtlinie in deutsches Recht verstoßen hat.

Wie in @tracking gezeigt, hat die App verschiedene Informationen über das verwendete Gerät an Tracking-Unternehmen gesendet. Um dies zu tun, musste die App die Informationen zwangsläufig aus der Endeinrichtung auslesen#footnote[Schürmann/Guttmann in Auernhammer, DSGVO/BDSG, 8. Auflage, 2023, §~25 TTDSG, Rn. 27, 31, 37; EDSA, Guidelines 2/2023 on Technical Scope of Art. 5(3) of ePrivacy Directive, 2023, https://www.edpb.europa.eu/system/files/2023-11/edpb_guidelines_202302_technical_scope_art_53_eprivacydirective_en.pdf, Rn. 29, 31, 35, 39], wodurch der Anwendungsbereich von §~25 TDDDG eröffnet wird. Anders als die DSGVO erfasst das TDDDG nicht nur personenbezogene Daten, sondern alle Daten, die von der Endeinrichtung einer Endnutzer_in ausgelesen oder darauf gespeichert werden.#footnote[EDSA, Guidelines 2/2023 on Technical Scope of Art. 5(3) of ePrivacy Directive, 2023, https://www.edpb.europa.eu/system/files/2023-11/edpb_guidelines_202302_technical_scope_art_53_eprivacydirective_en.pdf, Rn. 7–12; Schneider in Assion, TTDSG, 2022, §~25 TTDSG, Rn. 23] Das TDDDG enthält auch keine Erheblichkeitsschwelle für die betroffenen Datenarten – jede Information kann in seinen Anwendungsbereich fallen, einschließlich rein technischer Informationen.#footnote[Schürmann/Guttmann in Auernhammer, DSGVO/BDSG, 8. Auflage, 2023, §~25 TTDSG, Rn. 20–23; Burkhardt/Reif/Schwartmann in Schwartmann/Jaspers/Eckhardt, TTDSG, 1. Auflage, 2022, §~25 TTDSG, Rn. 29]

Das Speichern von Informationen oder der Zugriff auf Informationen, die bereits in der Endeinrichtung einer Nutzer_in gespeichert sind, erfordert gemäß §~25 Abs. 1 TDDDG die Einwilligung der Nutzer_in auf der Grundlage von klaren und umfassenden Informationen.

Während das TDDDG in §~25 Abs. 2 TDDDG zwei Ausnahmen von dieser Regel auflistet, ist keine davon in diesem Fall anwendbar:

+ Wie oben dargelegt, wurden die Informationen an Tracking- und/oder Werbeunternehmen gesendet. Daher war der Zweck des Zugriffs auf diese Informationen ausdrücklich _nicht_ die Übertragung einer Nachricht über ein öffentliches Telekommunikationsnetz. Die Ausnahme in §~25 Abs. 2 Nr. 1 TDDDG gilt nur dann, wenn die Übertragung einer Nachricht über ein öffentliches Telekommunikationsnetz ohne die Speicherung der oder den Zugriff auf die betreffenden Informationen überhaupt nicht möglich wäre#footnote[Schürmann/Guttmann in Auernhammer, DSGVO/BDSG, 8. Auflage, 2023, §~25 TTDSG, Rn. 123; Schmitz in Geppert/Schütz, Beck'scher TKG-Kommentar, 5. Auflage, 2023, §~25 TTDSG, Rn. 66; Hanloser in Gierschmann/Baumgartner, TTDSG, 1. Auflage, 2023, §~25 TTDSG, Rn. 94; Nolte in Säcker/Körber, TKG – TTDSG, 4. Auflage, 2023, §~25 TTDSG, Rn. 33], und ist daher hier nicht anwendbar.
+ Ebenso kann sich die Verantwortliche nicht darauf berufen, dass der Zugriff unbedingt erforderlich gewesen wäre, um einen von mir ausdrücklich gewünschten digitalen Dienst bereitzustellen. Die Ausnahme ist eng auszulegen, wobei Tracking und Werbung nicht unbedingt erforderlich sind.#footnote[Artikel-29-Datenschutzgruppe, WP 194, Stellungnahme 04/2012 zur Ausnahme von der Einwilligungspflicht für Cookies, https://ec.europa.eu/justice/article-29/documentation/opinion-recommendation/files/2012/wp194_de.pdf; Datenschutzkonferenz, Orientierungshilfe der Aufsichtsbehörden für Anbieter:innen von Telemedien ab dem 1. Dezember 2021 (OH Telemedien 2021), Version 1.1, 2022, https://www.datenschutzkonferenz-online.de/media/oh/20221130_OH_Telemedien_2021_Version_1_1.pdf, Abschnitt III. 3. c); Der Landesbeauftragte für Datenschutz und Informationsfreiheit Baden-Württemberg, FAQ: Cookies und Tracking durch Betreiber von Webseiten und Hersteller von Smartphone-Apps, Version 2.0.1, 2022, https://www.baden-wuerttemberg.datenschutz.de/wp-content/uploads/2022/03/FAQ-Tracking-online.pdf, Abschnitt A.1.4; Schneider in Assion, TTDSG, 2022, §~25 TTDSG, Rn. 36, 44; Nolte in Säcker/Körber, TKG – TTDSG, 4. Auflage, 2023, §~25 TTDSG, Rn. 37; Burkhardt/Reif/Schwartmann in Schwartmann/Jaspers/Eckhardt, TTDSG, 1. Auflage, 2022, §~25 TTDSG, Rn. 127, 140; Ettig in Taeger/Gabel, DSGVO - BDSG - TTDSG, 4. Auflage, 2022, §~25 TTDSG, Rn. 56] Somit ist auch §~25 Abs. 2 Nr. 2 TDDDG nicht anwendbar.

Die Verantwortliche hat jedoch keine Einwilligung eingeholt, da es überhaupt keine Interaktion mit der App gab. §~25 Abs. 1 TDDDG verweist für die Bedingungen der Einwilligung auf die DSGVO. Daher gilt hier die gleiche Argumentation wie in @no-legal-basis.
{% endif %}

= Anträge und Anregungen

{% if type === 'complaint' %}
In den vorangegangenen Abschnitten habe ich dargelegt, warum ich der Meinung bin, dass die Verantwortliche gegen meine Datenschutzrechte verstoßen hat. Daher wende ich mich nun mit dieser Beschwerde an Sie.

Ich bitte Sie, meine Beschwerde zu untersuchen und die beschriebenen Probleme mittels Ihrer Untersuchungsbefugnisse gemäß Art. 58 Abs. 1 DSGVO zu prüfen.

Ich bitte Sie auch, mich gemäß Art. 77 Abs. 2 DSGVO und Art. 57 Abs. 1 lit. f DSGVO über den Fortgang und das Ergebnis des Beschwerdeverfahrens in dessen Verlauf, spätestens jedoch innerhalb von drei Monaten (vgl. Art. 78 Abs. 2 DSGVO) zu informieren.

Schließlich bitte ich Sie, von allen Aufsichtsmaßnahmen Gebrauch zu machen, die Sie für notwendig erachten, um den Verstoß der Verantwortlichen gegen meine Rechte im Einklang mit Ihren Abhilfebefugnissen gemäß Art. 58 Abs. 2 DSGVO zu mindern. Bitte berücksichtigen Sie dabei, dass die beschriebenen Verstöße aller Wahrscheinlichkeit nach nicht nur mich betreffen, sondern alle Nutzer_innen der App.
{% else %}
In den vorangegangenen Abschnitten habe ich dargelegt, warum ich der Meinung bin, dass die Verantwortliche gegen meine Datenschutzrechte verstoßen hat. Ich bitte Sie daher, diese Angelegenheit zu untersuchen und die beschriebenen Probleme mittels Ihrer Untersuchungsbefugnisse gemäß Art. 58 Abs. 1 DSGVO zu prüfen. Ich bitte Sie auch, von allen Aufsichtsmaßnahmen Gebrauch zu machen, die Sie für notwendig erachten, um den Verstoß der Verantwortlichen gegen meine Rechte im Einklang mit Ihren Abhilfebefugnissen gemäß Art. 58 Abs. 2 DSGVO zu mindern. Bitte berücksichtigen Sie dabei, dass die beschriebenen Verstöße aller Wahrscheinlichkeit nach nicht nur mich betreffen, sondern alle Nutzer_innen der App.

Mir ist bewusst, dass Sie nicht gesetzlich verpflichtet sind, mich über den Fortgang und das Ergebnis des Verfahrens zu informieren, da es sich nicht um eine formelle Beschwerde handelt. Ich würde es dennoch sehr schätzen, wenn Sie dies täten.
{% endif %}

= Abschlussbemerkungen

{% if type === 'complaint' %}
Sie dürfen meine Daten zur Bearbeitung der Beschwerde an die Verantwortliche weitergeben.
{% endif %}

Sollten Sie weitere Informationen von mir benötigen, wenden Sie sich gerne an mich. Sie erreichen mich wie folgt: {{ complaintOptions.complainantContactDetails }}{% if complaintOptions.complainantAgreesToUnencryptedCommunication %}\
Einer unverschlüsselten Kommunikation per E-Mail stimme ich zu.{% endif %}

Vielen Dank im Voraus für Ihre Unterstützung.

// Appendix
#pagebreak()

#counter(heading).update(0)
#set heading(numbering: (..nums) => "A" + nums.pos().map(str).join(".") + ".")

#text(weight: 700, 1.75em)[Appendix]

{% if type === 'complaint' %}
= Ergebnisse "{% if analysis.app.platform === 'Android' %}von TrackerControl{% elif analysis.app.platform === 'iOS' %}des App-Datenschutzberichts{% endif %}" auf meinem Gerät, gefiltert nach DNS-Hostnamen, die von der App kontaktiert wurden <personal-hostnames>

#table(
  columns: (10%, 30%, 60%),
  align: (right, left, left),

  [*\#*], [*Zeit*], [*Hostname*],
  {% for entry in complaintOptions.userNetworkActivity -%}
  [{{ entry.index + 1 }}], [{{ entry.timestamp | dateFormat }}], [{{ entry.hostname }}],
  {% endfor %}
)
{% endif %}

= Orientierungshilfen von Datenschutzaufsichtsbehörden zu personenbezogenen Daten im Kontext des Online-Trackings <dpa-guidelines-id>

Mehrere Datenschutzbehörden haben Orientierungshilfen oder Hinweise zur Verwendung von Cookies und anderen Tracking-Technologien herausgegeben, welche die Verarbeitung von IDs beinhalten, die einer Person eindeutig zugeordnet sind. Diese Leitlinien bestätigen durchweg, dass solche IDs personenbezogene Daten im Sinne der DSGVO sind, insbesondere wenn sie verwendet oder kombiniert werden, um Profile von Einzelpersonen zu erstellen oder sie von anderen zu unterscheiden.

Zum Beispiel erklärt die irische DPC, dass Cookies personenbezogene Daten wie Nutzer_innen-Namen oder eindeutige Kennungen wie Nutzer_innen-IDs und andere Tracking-IDs enthalten können. Die DPC fügt hinzu, dass in Fällen, in denen Cookies Kennungen enthalten, die zur Zielgruppenansprache einer bestimmten Person verwendet werden können, oder wenn aus Cookies und anderen Tracking-Technologien Informationen abgeleitet werden, die zur Zielgruppenansprache oder Profilierung von Einzelpersonen verwendet werden können, dies personenbezogene Daten darstellt und ihre Verarbeitung auch den in der DSGVO festgelegten Regeln unterliegt. Die DPC betont auch, dass Online-Kennungen in der Definition personenbezogener Daten in Art. 4 Nr. 1 DSGVO enthalten sind und dass es nicht darauf ankommt, ob die Verantwortliche im Besitz anderer Informationen ist, die zur Identifizierung einer Person benötigt werden könnten; die Tatsache, dass die Person identifiziert werden kann, selbst mit der Hinzufügung von Informationen, die von einer anderen Organisation gehalten werden, reicht aus, um diese Daten zu personenbezogenen Daten zu machen.#footnote[DPC Ireland, Guidance Note: Cookies and other tracking technologies, 2020, https://www.dataprotection.ie/sites/default/files/uploads/2020-04/Guidance%20note%20on%20cookies%20and%20other%20tracking%20technologies.pdf]

In einem FAQ zu Google Analytics vertritt auch die dänische Datatilsynet ein breites Verständnis von personenbezogenen Daten in Bezug auf Online-Kennungen. Sie erklärt, dass eine eindeutige Kennung es ermöglicht, die Person zu identifizieren, auf die sich die Daten beziehen, auch wenn es nicht möglich ist, der betreffenden Person einen bestimmten Namen oder eine bestimmte Identität zuzuordnen. Sie zitiert die ausdrückliche Erwähnung des Konzepts des "Aussondern" in der DSGVO.#footnote[Datatilsynet, Google Analytics, https://www.datatilsynet.dk/english/google-analytics]

In seiner Stellungnahme zum Zusammenspiel zwischen der ePrivacy-Richtlinie und der DSGVO erwähnt der EDSA Cookies als ein klares Beispiel für Verarbeitungstätigkeiten, die den sachlichen Anwendungsbereich sowohl der ePrivacy-Richtlinie als auch der DSGVO auslösen.#footnote[EDSA, Opinion 5/2019 on the interplay between the ePrivacy Directive and the GDPR, in particular regarding the competence, tasks and powers of data protection authorities, 2019, https://edpb.europa.eu/sites/default/files/files/file1/201905_edpb_opinion_eprivacydir_gdpr_interplay_en_0.pdf]

Ähnlich stellt die deutsche Datenschutzkonferenz in ihren Leitlinien zu Telemedien fest, dass die Verwendung von Cookies und anderen Tracking-Technologien oft die Verarbeitung personenbezogener Daten beinhaltet und somit in den Anwendungsbereich sowohl des TDDDG (dem deutschen Gesetz zur Umsetzung der ePrivacy-Richtlinie) als auch der DSGVO fällt.#footnote[Datenschutzkonferenz, Orientierungshilfe der Aufsichtsbehörden für Anbieter:innen von Telemedien ab dem 1. Dezember 2021 (OH Telemedien 2021), Version 1.1, 2022, https://www.datenschutzkonferenz-online.de/media/oh/20221205_oh_Telemedien_2021_Version_1_1_Vorlage_104_DSK_final.pdf]

= Entscheidungen von Datenschutzaufsichtsbehörden zu personenbezogenen Daten im Kontext des Online-Trackings <dpa-decisions-id>

Einige Datenschutzbehörden haben auch Entscheidungen zu spezifischen Fällen getroffen, welche die Verarbeitung von IDs betreffen, die einer Person eindeutig zugeordnet sind, und bestätigen erneut, dass die Verarbeitung eindeutiger IDs im Kontext des Online-Trackings in den Anwendungsbereich der DSGVO fällt.

Zum Beispiel erließ die schwedische Datenschutzbehörde (IMY) im Juni 2023 eine Entscheidung, in der sie Tele2 Sverige AB und drei andere Webseiten-Betreiberinnen mit einer Geldstrafe belegte, weil sie Google Analytics trotz der EU-Empfehlungen und -Entscheidungen und ohne zusätzliche Schutzmaßnahmen verwendeten.#footnote[Gleichzeitig erließ die IMY auch drei weitere, sehr ähnliche Entscheidungen gegen andere Webseiten: DI-2020-11397 (https://www.imy.se/globalassets/dokument/beslut/2023/beslut-tillsyn-ga-cdon.pdf), DI-2020-11368 (https://www.imy.se/globalassets/dokument/beslut/2023/beslut-tillsyn-ga-coop.pdf), DI-2020-11370 (https://www.imy.se/globalassets/dokument/beslut/2023/beslut-tillsyn-ga-dagens-industri.pdf)] In der Entscheidung erklärt die IMY, dass Netzwerk-/Online-Kennungen zur Identifizierung einer Nutzer_in verwendet werden können, insbesondere wenn sie mit anderen ähnlichen Arten von Informationen kombiniert werden.#footnote[IMY, Beslut efter tillsyn enligt dataskyddsförordningen – Tele2 Sverige AB:s överföring av personuppgifter till tredjeland, DI-2020-11373, 2023, https://www.imy.se/globalassets/dokument/beslut/2023/beslut-tillsyn-ga-tele2.pdf, S. 10] Die IMY betrachtete die von Google Analytics gesammelten Daten, wie eindeutige Kennungen, die in den Cookies `_gads`, `_ga` und `_gid` gespeichert sind, IP-Adressen und andere Informationen im Zusammenhang mit dem Webseitenbesuch und dem Browser der Nutzer_in. Sie betont, dass diese Kennungen mit dem ausdrücklichen Ziel erstellt wurden, einzelne Besucher_innen unterscheiden zu können, wodurch diese identifizierbar werden. Die IMY stellt fest, dass selbst wenn die IDs allein die Einzelpersonen nicht identifizierbar machen würden, die IDs in Kombination mit den anderen übermittelten Daten die Besucher_innen der Webseite noch unterscheidbarer machen. Daher kommen sie zu dem Schluss, dass die übermittelten Daten personenbezogene Daten darstellen. Die IMY erklärt, dass diese Differenzierung an sich ausreicht, um die Besucher_in gemäß Erwägungsgrund 26 DSGVO indirekt identifizierbar zu machen, und dass die Kenntnis des Namens oder der physischen Adresse der Besucher_in nicht erforderlich ist. Sie hält es auch nicht für notwendig, dass die Verantwortliche oder Auftragsverarbeiterin tatsächlich beabsichtigt, die Besucher_in zu identifizieren, und stellt fest, dass die Möglichkeit, dies zu tun, an sich ausreicht, um zu bestimmen, ob es möglich ist, eine Besucher_in zu identifizieren.#footnote[ebd., S. 11]

In ähnlicher Weise erließ die österreichische Datenschutzbehörde (DSB) im Dezember 2021 eine Entscheidung, in der festgestellt wurde, dass eine österreichische Webseite die DSGVO verletzt hatte, indem sie durch die Verwendung von Google Analytics personenbezogene Daten in die USA übermittelte. Die DSB stellt fest, dass die von Google Analytics verwendeten Cookies `_ga`, `_gid` und `cid` eindeutige Kennungen enthielten, die auf den Geräten und Browsern der Nutzer_innen gespeichert wurden, und dass es nur durch diese Kennungen für die Betreiberin der Webseite und Google möglich war, Besucher_innen zu unterscheiden sowie festzustellen, ob sie die Webseite zuvor besucht hatten. Die DSB erläutert ihre Position, dass eine solche Möglichkeit der Individualisierung von Webseiten-Besucher_innen ausreiche, um den Anwendungsbereich des Datenschutzrechts zu eröffnen, und dass es nicht notwendig ist, den Namen der Person herausfinden zu können, wobei sie Erwägungsgrund 26 DSGVO als Begründung anführt.#footnote[Österreichische Datenschutzbehörde, Teilbescheid D155.027 2021-0.586.257, 2021, https://noyb.eu/sites/default/files/2022-01/E-DSB%20-%20Google%20Analytics_DE_bk_0.pdf, S. 27–28] In Bezug auf das Argument der Verantwortlichen und von Google, dass sie die IDs nicht tatsächlich mit einer realen Person in Verbindung bringen wollten, unterstreicht die DSB#footnote[ebd., S. 28]: #quote[Soweit die Beschwerdegegner ins Treffen führen, dass keine "Mittel" verwendet würden, um die hier gegenständlichen Kennnummern mit der Person des Beschwerdeführers in Verbindung zu bringen, ist ihnen neuerlich entgegenzuhalten, dass die Implementierung von Google Analytics auf [der Webseite] eine Aussonderung iSd ErwGr 26 DSGVO _zur Folge hat_. Mit anderen Worten: Wer ein Tool verwendet, welches eine solche Aussonderung gerade erst ermöglicht, kann sich nicht auf den Standpunkt stellen, nach "allgemeinem Ermessen" keine Mittel zu verwenden, um natürliche Personen identifizierbar zu machen.]

Die DSB stellt auch fest, dass diese Kennungen mit anderen Informationen wie Browser-Daten und IP-Adressen kombiniert werden konnten, was die Besucher_innen der Webseite noch identifizierbarer machte, und verweist dabei auf Erwägungsgrund 30 DSGVO. Die DSB weist ferner darauf hin, dass Google Analytics speziell dafür entwickelt wurde, auf möglichst vielen Webseiten implementiert zu werden, um Informationen über deren Besucher_innen zu sammeln. Sie kommen zu dem Schluss, dass die von Google Analytics verarbeiteten Daten personenbezogene Daten darstellten, und betonen, dass die Nichtanwendung der DSGVO auf die von Google Analytics durchgeführte Verarbeitung mit dem Grundrecht auf Datenschutz unvereinbar wäre.#footnote[ebd., S. 29]

Die Entscheidung der DSB wurde später vom österreichischen Bundesverwaltungsgericht im Urteil W245 2252208-1/36E, W245 2252221-1/30E bestätigt.#footnote[https://www.ris.bka.gv.at/Dokumente/Bvwg/BVWGT_20230512_W245_2252208_1_00/BVWGT_20230512_W245_2252208_1_00.pdf]

In einer neueren Entscheidung vom März 2023 stellte die DSB fest, dass auch die Verwendung des Tracking-Pixels von Facebook durch eine österreichische Webseiten-Anbieterin gegen die DSGVO und das _Schrems II_-Urteil des EuGH verstieß. In der Entscheidung folgt die DSB der gleichen Argumentation wie in der Google-Analytics-Entscheidung und zitiert daraus in Bezug auf die Einstufung von Tracking-Daten als personenbezogene Daten.#footnote[Österreichische Datenschutzbehörde, Bescheid D155.028 2022-0.726.643, 2023, https://noyb.eu/sites/default/files/2023-03/Bescheid%20redacted.pdf]

Ebenfalls in Bezug auf Google Analytics, aber auch Google Tag Manager, erließ die finnische Datenschutzbehörde Tietosuojavaltuutetun toimisto im Dezember 2022 eine Entscheidung gegen die öffentlichen Online-Bibliotheksdienste von vier Städten in Finnland. In der Entscheidung wird erwähnt, dass durch diese Tools personenbezogene Daten gesammelt wurden.#footnote[Tietosuojavaltuutetun toimisto, Apulaistietosuojavaltuutetun päätös käsittelyn lainmukaisuutta, käsittelyn turvallisuutta, sisäänrakennettua ja oletusarvoista tietosuojaa, rekisteröityjen informointia ja henkilötietojen siirtoa kolmansiin maihin koskevassa asiassa, 4672/161/22, 2022, https://finlex.fi/fi/viranomaiset/tsv/2022/20221663]

Die CNIL, die französische Datenschutzbehörde, erließ im März 2022 eine Entscheidung, in der sie drei französische Websites anwies, die DSGVO in Bezug auf ihre Verwendung von Google Analytics einzuhalten. Die CNIL erklärt, dass Online-Kennungen wie IP-Adressen oder in Cookies gespeicherte Informationen als Mittel zur Identifizierung einer Nutzer_in verwendet werden könnten, insbesondere wenn sie mit anderen ähnlichen Arten von Informationen kombiniert werden, und zitiert dabei Erwägungsgrund 30 DSGVO. Die CNIL erklärt, dass die Webseiten die Mittel nachweisen müssen, die implementiert wurden, um sicherzustellen, dass die gesammelten Kennungen anonym waren, andernfalls könnten sie nicht als anonym qualifiziert werden. Sie stellen auch fest, dass die von Google Analytics verwendeten IDs eindeutige Kennungen waren, die dazu dienten, zwischen Einzelpersonen zu unterscheiden, und dass diese Kennungen auch mit anderen Informationen kombiniert werden konnten, wie der Adresse der besuchten Webseite, Metadaten zum Browser und Betriebssystem, der Zeit und den Daten des Webseitenbesuchs sowie der IP-Adresse. Die CNIL argumentiert, dass diese Kombination den unterscheidenden Charakter der IDs verstärke und die Besucher_innen identifizierbar mache. Die CNIL ist der Ansicht, dass der Umfang des Rechts auf Datenschutz unangemessenerweise geschmälert würde, wenn anders entschieden würde.#footnote[CNIL, Décision n° […] du […] mettant en demeure […], 2022, https://www.cnil.fr/sites/cnil/files/atoms/files/med_google_analytics_anonymisee.pdf, S. 4]

Die CNIL sanktionierte auch Criteo, ein Online-Werbeunternehmen, im Juni 2023 mit einer Geldstrafe, weil es nicht überprüft hatte, ob die Nutzer_innen, von denen es Daten verarbeitete, ihre Einwilligung gegeben hatten. Die CNIL ist der Ansicht, dass Criteo personenbezogene Daten verarbeitete, angesichts der Anzahl und Vielfalt der gesammelten Daten und der Tatsache, dass sie alle mit einer Kennung verknüpft waren, was es mit angemessenen Mitteln ermöglichte, die natürlichen Personen, auf die sich diese Daten beziehen, wieder zu identifizieren. Die CNIL stellt auch fest, dass die Criteo-Cookie-ID dazu diente, jede Person, deren Daten gesammelt wurden, zu unterscheiden, und dass mit dieser Kennung eine große Menge an Informationen verbunden war, die dazu dienten, das Werbeprofil der Nutzer_in anzureichern. Die CNIL ist der Ansicht, dass selbst wenn Criteo nicht direkt die Identität der mit einer Cookie-ID verbundenen Person hatte, eine Reidentifizierung möglich sein könnte, wenn Criteo auch andere Daten wie die E-Mail-Adresse, die IP-Adresse oder sogar den User Agent (oder gehashte Formen davon) sammelte. Die CNIL kommt zu dem Schluss, dass, solange Criteo in der Lage ist, Einzelpersonen mit angemessenen Mitteln wieder zu identifizieren, die verarbeiteten Daten personenbezogene Daten im Sinne der DSGVO sind.#footnote[CNIL, Délibération SAN-2023-009 du 15 juin 2023, 2023, https://www.legifrance.gouv.fr/cnil/id/CNILTEXT000047707063]

Die norwegische Datatilsynet veröffentlichte im Mai 2021 einen Entscheidungsentwurf, in dem sie Disqus, ein Unternehmen, das eine Plattform für Online-Kommentare bereitstellt, mitteilte, dass es mit einer Geldstrafe wegen unrechtmäßiger Verarbeitung personenbezogener Daten für programmatische Werbung belegt werden würde. Die Datenschutzbehörde erklärt, dass Online-Kennungen wie Cookie-IDs personenbezogene Daten seien, da sie es dem Verantwortlichen ermöglichten, eine Nutzer_in einer Webseite von einer anderen zu unterscheiden und zu überwachen, wie jede Nutzer_in mit der Webseite interagiert, wobei sie Art. 4 Nr. 1 DSGVO und Erwägungsgrund 30 DSGVO zur Unterstützung ihrer Auslegung zitiert.#footnote[Datatilsynet, Advance notification of an administrative fine – Disqus Inc., 20/01801-5, 2021, https://www.datatilsynet.no/contentassets/8311c84c085b424d8d5c55dd4c9e2a4a/advance-notification-of-an-administrative-fine--disqus-inc.pdf, S. 15–16]

Schließlich erließ die Datenschutzaufsichtsbehörde Niedersachsen (LfD NDS) in Deutschland im Mai 2023 eine Entscheidung bezüglich der Verwendung eines "Pay or Okay"-Systems durch Heise, eine deutsche Tech-News-Seite. Die Webseite ließ Nutzer_innen zwischen der Zahlung für ein monatliches Abonnement oder der Zustimmung zur Verarbeitung ihrer Daten für Werbe- und andere Zwecke wählen. Die LfD stellte fest, dass die Anforderungen für die Einholung einer Einwilligung von Heise nicht erfüllt wurden. In der Entscheidung beschreibt die LfD die hohe Anzahl der beobachteten Local-Storage-Objekte, Tracking-Techniken und Drittdienste, die auf der Webseite verwendet werden, und erklärt, dass sie aufgrund dessen keine rechtliche Bewertung jedes einzelnen vornehmen werde. Die LfD stellt fest, dass Heise personenbezogene Daten durch diese Objekte verarbeitete und zitiert beispielsweise, dass Adform ein `cid`-Cookie platzierte, das sie aufgrund des Namens als ID identifizierte.#footnote[Die Landesbeauftrage für den Datenschutz Niedersachsen, Beschwerdeverfahren gegen Verarbeitungen personenbezogener Daten bei der Nutzung der Webseite www.heise.de, 2023, https://noyb.eu/sites/default/files/2023-07/11VerwarnungPurAboModellfinalgeschwrztp_Redacted.pdf, S. 6]
