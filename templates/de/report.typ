#import "style.typ": tweaselStyle
#show: tweaselStyle

#text(weight: 700, 1.75em)[Technischer Bericht: Analyse der {{ analysis.app.platform }}-App "{{ analysis.app.name }}" ({{ analysis.app.version }})]

= Einleitung

Dieser Bericht führt die Ergebnisse und Methodik einer automatisierten Analyse auf Tracking und ähnliche Datenübertragungen aus, welche durch das Tweasel-Projekt, betrieben vom Datenanfragen.de e.~V., für die {{ analysis.app.platform }}-App "{{ analysis.app.name }}"{% if analysis.app.url %}#footnote[{{ analysis.app.url | safe }}]{% endif %} (App-ID: {{ analysis.app.id | code }}, im Folgenden: "die App") durchgeführt wurde.

= Ergebnisse

Während der Analyse wurde der von der App initiierte Netzwerkverkehr aufgezeichnet. Insgesamt wurden zwischen {{ harEntries[0].startTime | dateFormat }} und {{ harEntries[harEntries.length - 1].startTime | dateFormat }} {{ harEntries.length }} Anfragen aufgezeichnet. Der aufgezeichnete Traffic ist als HAR-Datei angehängt{% if analysis.harMd5 %} (MD5-Prüfsumme der HAR-Datei: {{ analysis.harMd5 | code }}){% endif %}, einem Standardformat, das von HTTP(S)-Debuggingtools zum Exportieren gesammelter Anfragen verwendet wird.#footnote[#link("http://www.softwareishard.com/blog/har-12-spec/")] HAR-Dateien können beispielsweise mit Firefox oder Chrome angezeigt werden.#footnote[https://docs.tweasel.org/background/har-tutorial/] Der Inhalt des aufgezeichneten Verkehrs ist auch in @har2pdf[Anhang] wiedergegeben.

== Netzwerkverkehr ohne Interaktion

Die in diesem Abschnitt beschriebenen Anfragen erfolgten *ohne jegliche Interaktion* mit der App oder etwaigen Einwilligungsdialogen.

Insgesamt wurden {{ trackHarResult.length }} Anfragen erkannt, die Daten an {{ findings | length }} Tracker übermittelten, ohne dass eine Interaktion stattfand.

{% for adapterSlug, adapterResult in findings %}
=== {{ adapterResult.adapter.name }}

Die App hat die folgenden {{ adapterResult.requests.length }} Anfrage(n) an den Tracker "{{ adapterResult.adapter.name }}", betrieben von "{{ adapterResult.adapter.tracker.name }}" gesendet. Details zur Dekodierung der Anfragen an diesen Tracker und die Begründung für die Einordnung der übermittelten Informationen finden sich in der Dokumentation im Tweasel-Tracker-Wiki.#footnote[Die Dokumentation für "{{ adapterResult.adapter.name }}" ist verfügbar unter: #link("https://trackers.tweasel.org/t/{{ adapterSlug | safe }}")]

{% for request in adapterResult.requests %}
{% set harEntry = harEntries[request.harIndex] %}
==== {{ harEntry.request.method | code }}-Anfrage an {{ harEntry.request.host | code }} ({{ harEntry.startTime | timeFormat }})

Am {{ harEntry.startTime | dateFormat }} sendete die App eine {{ harEntry.request.method | code }}-Anfrage an {{ harEntry.request.host | code }}. Diese Anfrage ist in @har2pdf-e{{ request.harIndex | safe }}[Anhang] wiedergegeben.

Die folgenden Informationen wurden als durch diese Anfrage übermittelt erkannt:

{% for transmission in request.transmissions -%}
+ {{ t("properties", transmission.property) }} (übermittelt als {{ transmission.path | code }} mit dem Wert {{ transmission.value | code }})
{% endfor %}
{% endfor %}
{% endfor %}

= Methodik

Die Analyse wurde am {{ analysis.date | dateFormat }} an Version {{ analysis.app.version }} der App durchgeführt{% if analysis.app.store %}, heruntergeladen aus: {{ analysis.app.store }}{% endif %}.

== Analyseumgebung

Der Traffic wurde auf dem folgenden {% if analysis.deviceType === 'emulator' %}Emulator{% else %}Gerät{% endif %} aufgezeichnet:

#table(
  columns: (auto, auto),
  [*Betriebssystem*], [{{ analysis.app.platform }} {{ analysis.platformVersion }}],
  {% if analysis.platformBuildString %}[*Build-String*], [{{ analysis.platformBuildString }}],{% endif %}
  {% if analysis.deviceManufacturer %}[*Hersteller*], [{{ analysis.deviceManufacturer }}],{% endif %}
  {% if analysis.deviceModel %}[*Modell*], [{{ analysis.deviceModel }}],{% endif %}
)

Die Analyse wurde mit den folgenden Versionen der Tools und Bibliotheken durchgeführt:

#table(
  columns: (auto, auto),
  [*Tool*], [*Version*],
  {% for tool, version in analysis.dependencies -%}
  [{{ tool | code }}], [{{ version }}],
  {% endfor %}
)

== Analyseschritte

Zur Erfassung, Aufzeichnung und Analyse der Daten wurde die Tweasel-Toolchain#footnote[Eine Übersicht der Tools findet sich hier: #link("https://docs.tweasel.org")] verwendet.

Die `appstraction`-Bibliothek#footnote[#link("https://github.com/tweaselORG/appstraction")] wurde verwendet, um das Gerät zu steuern und die Umgebung einzurichten, in der die App läuft. Sie ermöglicht es, App-Einstellungen zu ändern und auszulesen sowie Apps zu installieren, zu entfernen und zu starten. {% if analysis.app.platform === 'Android' -%}
Sie verwendet die Android Debug Bridge (`adb`)#footnote[#link("https://developer.android.com/tools/adb")], um das Gerät zu steuern und Informationen über die in Android integrierte USB-Debugging-API auszulesen. Das Gerät wurde vor Beginn der Analyse gerootet, und `adb` wurde verwendet, um eine Root-Shell zu öffnen, um Systemfunktionen zu manipulieren. Wo Android keine zugängliche API bereitstellt, verwendet `appstraction` das Instrumentierungs-Toolkit Frida#footnote[#link("https://frida.re/")], das sich in die Funktionen einer App hooken kann, während der Prozess läuft, und auf dessen Ausführungskontext zugreifen kann. `appstraction` enthält Skripte, um sich in Systemfunktionen hooken, z.~B. um den Inhalt der Zwischenablage zu setzen.
{% elif analysis.app.platform === 'iOS' -%}
Dazu greift sie über eine USB-Verbindung und unter Verwendung der `pymobiledevice3`-Bibliothek#footnote[#link("https://github.com/doronz88/pymobiledevice3/")] auf den `lockdownd`-Dienst von iOS zu. Dies wird u.a. verwendet, um Apps zu installieren und Systeminformationen auszulesen. Das Gerät wurde gejailbreakt und ein SSH-Server auf dem Gerät installiert, um über eine Remote-Shell auf erweiterte Funktionen zuzugreifen, was auch den Root-Zugriff auf das Gerät ermöglicht. Interne System- und App-APIs werden über das Instrumentierungs-Toolkit Frida#footnote[#link("https://frida.re/")] genutzt, das sich in die Funktionen einer App hooked, während der Prozess läuft, und auf dessen Ausführungskontext zugreift.
{%- endif %}

Für die Analyse wurde die App auf dem Gerät gestartet und 60 Sekunden lang laufen gelassen. Während dieser Zeit wurde keinerlei Eingabe auf dem Gerät oder in der App vorgenommen, d.h. es konnten keine Steuerelemente, Schaltflächen, Eingabefelder usw. angeklickt oder anderweitig bedient werden. Der Netzwerkverkehr der App wurde von der `cyanoacrylate`-Bibliothek#footnote[#link("https://github.com/tweaselORG/cyanoacrylate")] unter Verwendung des Machine-in-the-Middle (MITM)-Proxys `mitmproxy`#footnote[#link("https://mitmproxy.org/")] aufgezeichnet. {% if analysis.app.platform === 'Android' -%}
Auf dem Gerät wurde der Netzwerkverkehr über einen WireGuard#footnote[#link("https://www.wireguard.com/")]-VPN-Tunnel zu `mitmproxy` geleitet, der so konfiguriert war, dass nur der Netzwerkverkehr der zu testenden App getunnelt wurde. Um TLS-verschlüsselten Verkehr zu entschlüsseln, wurde die von `mitmproxy` generierte Certificate-Authority auf dem Gerät platziert und als vertrauenswürdig konfiguriert. Das Certificate-Pinning wurde mit dem HTTP-Toolkit-Certificate-Unpinning-Skript für Frida#footnote[#link("https://httptoolkit.com/blog/frida-certificate-pinning/")] umgangen.
{% elif analysis.app.platform === 'iOS' -%}
Auf dem Gerät wurde der Netzwerkverkehr über den in iOS integrierten HTTP-Proxy zu `mitmproxy` geleitet, der über die Systemeinstellungen konfiguriert wurde. Der Proxy erlaubt keine Unterscheidung des Netzwerkverkehrs nach der verursachenden App. Um TLS-verschlüsselten Verkehr zu entschlüsseln, wurde die von `mitmproxy` generierte Certificate-Authority auf dem Gerät platziert und als vertrauenswürdig konfiguriert. Das Certificate-Pinning wurde mit SSL Kill Switch 2#footnote[#link("https://julioverne.github.io/description.html?id=com.julioverne.sslkillswitch2")] umgangen.
{%- endif %}

Die übertragenen Tracking-Daten wurden mit TrackHAR#footnote[#link("https://github.com/tweaselORG/TrackHAR")] identifiziert, das grundsätzlich sowohl ein traditionelles Indikator-Matching als auch einen adapterbasierten Matching-Ansatz unterstützt. Das Indikator-Matching identifiziert übertragene Daten, indem es den aufgezeichneten Netzwerkverkehr auf bekannte Zeichenfolgen überprüft. Für diese Analyse wurden jedoch nur die Adapter verwendet, bei denen es sich um Schemata handelt, wie bestimmte Anfragen für jeden kontaktierten Endpunkt dekodiert und interpretiert werden. Diese Adapter sind das Ergebnis früherer Forschung, und die Begründung, warum ein Datentyp einem Wert zugeordnet wird, ist mit dem Adapter dokumentiert und in diesem Bericht angegeben. Adapterbasiertes Matching kann nur Datenübertragungen finden, die an bereits bekannte Endpunkte gegangen sind, und kann keine unerwarteten Übertragungen finden.

Weitere technische Details zu den Methoden der Tweasel-Toolchain und Anleitungen zur unabhängigen Reproduktion der Ergebnisse finden sich in der Tweasel-Dokumentation.#footnote(link("https://docs.tweasel.org/background/architechture"))

// Appendix
#pagebreak()

#counter(heading).update(0)
#set heading(numbering: (..nums) => "A" + nums.pos().map(str).join(".") + ".")

#text(weight: 700, 1.75em)[Appendix]

= Aufgezeichneter Traffic <har2pdf>

Nachfolgend findet sich eine Wiedergabe der aufgezeichneten Netzwerkanfragen, die im Bericht erwähnt werden, wie sie in der angehängten HAR-Datei gespeichert sind. Es werden nur Anfragen gezeigt, alle Antworten sind ausgelassen. Binäre Anfrageinhalte werden als Hexdump dargestellt. Anfrageinhalte, die länger als 4.096 Bytes sind, werden abgeschnitten. Der vollständige aufgezeichnete Datenverkehr mit allen Anfragen und einschließlich Antworten und vollständigem Anfrageinhalt kann in der angehängten HAR-Datei eingesehen werden.

#include "har.typ"
