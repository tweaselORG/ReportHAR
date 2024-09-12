#import "style.typ": tweaselStyle
#show: tweaselStyle

// Title page
#align(center)[
  #v(120pt)

  #block(text(weight: 700, 2.5em, [
    {% if type === 'complaint' %}
      Complaint under the GDPR{% if complaintOptions.nationalEPrivacyLaw %} and {{ complaintOptions.nationalEPrivacyLaw }}{% endif %}
    {% else %}
      Informal suggestion for investigation
    {% endif %}
  ]))

  #v(30pt)

  _filed by_ \
  {{ complaintOptions.complainantAddress }} \
  (complainant, hereinafter: "I")

  _against_ \
  the controller for the {{ analysis.app.platform }} app "{{ analysis.app.name }}", assumed to be \
  {{ complaintOptions.controllerAddress }} \
  (respondent, hereinafter: "the controller")

  _on_ \
  {{ complaintOptions.date | dateFormat(false) }}

  _regarding_ \
  Art.~6(1) GDPR (lawfulness of processing), Art.~25 GDPR (data protection by design and by default), Art.~5(1)(c) GDPR (data minimisation)
  {%- if complaintOptions.nationalEPrivacyLaw -%}
    ,
    {% if complaintOptions.nationalEPrivacyLaw === 'TDDDG' -%}
      §~25 TDDDG (privacy protection for terminal equipment)
    {% endif %}
  {% endif %}

  _under the reference_ \
  {{ complaintOptions.reference }} \
  (please mention when replying)
]

#pagebreak()

// Main content
= Introduction

{% if type === 'complaint' %}
I am hereby filing a complaint under Art. 77(1) GDPR regarding the {{ analysis.app.platform }} app "{{ analysis.app.name }}" (hereinafter: "the app").

As far as I can tell, the app is operated by {{ complaintOptions.controllerAddress }}.#footnote[{{ complaintOptions.controllerAddressSourceUrl | safe }}] I am thus assuming them to be the app's controller. Should this assumption be incorrect, my complaint is directed against the actual controller of the app.

I am a user of the app on my personal {{ analysis.app.platform }} device. The {{ analysis.app.platform }} device is only used by me personally.{% if complaintOptions.userDeviceAppStore and complaintOptions.loggedIntoAppStore %} I have installed the app through the {{ complaintOptions.userDeviceAppStore }}. I am logged into the {{ complaintOptions.userDeviceAppStore }} with my personal account.{% endif %}

{% if complaintOptions.deviceHasRegisteredSimCard %}My {{ analysis.app.platform }} device has a SIM card installed that is registered to my name.{% endif %}
{% else %}
I am hereby asking you to investigate the {{ analysis.app.platform }} app "{{ analysis.app.name }}" (hereinafter: "the app").

As far as I can tell, the app is operated by {{ complaintOptions.controllerAddress }}.#footnote[{{ complaintOptions.controllerAddressSourceUrl | safe }}] I am thus assuming them to be the app's controller. Should this assumption be incorrect, my request is directed against the actual controller of the app.
{% endif %}

= Facts

== Preliminary remarks

To understand how the app is processing my data, I used the tools of the tweasel project#footnote[https://docs.tweasel.org/], operated by Datenanfragen.de e.~V., to perform an automated analysis of the app's network traffic. The analysis was performed on {{ initialAnalysis.date | dateFormat }} on version {{ initialAnalysis.app.version }} of the app, {% if analysis.app.store %}downloaded from the {{ analysis.app.store }}, {% endif %}running on {{ initialAnalysis.app.platform }} {{ initialAnalysis.platformVersion }}.

During this analysis, the app was run _without any user input_ (i.e. there was no interaction with the app at all) and its network traffic was recorded. The recorded traffic was then analyzed for tracking and similar data transmissions. Based on that, the tweasel tools produced a technical report.

Both this technical report and the traffic recording are attached as evidence and were part of my communication with the controller. The report also contains a detailed description of the methodology used for the analysis and its basis in mobile privacy research.

Through the analysis, I unfortunately had to find out that the app performs tracking (as explained in @tracking) which I believe to be in violation of the GDPR {% if complaintOptions.nationalEPrivacyLaw %} and {{ complaintOptions.nationalEPrivacyLaw }}{% endif %} (as explained in @legal-grounds).

On {{ complaintOptions.noticeDate | dateFormat(false) }}, I sent a notice to the controller making them aware of the violations I discovered and giving them the opportunity to remedy them.

In the interest of avoiding unnecessary work for the data protection authorities, the controller, and myself, I gave the controller a voluntary grace period of 60 days to bring their app in line with applicable data protection law. I also informed them that I planned on filing a complaint otherwise.

{% if complaintOptions.controllerResponse === "none" %}
  I have not received any response from the controller.
{% elif complaintOptions.controllerResponse === "denial" %}
  I have received a response from the controller in which they deny there being any violations in their app. I am providing an in-depth technical and legal argument as to why I do believe the controller is violating the GDPR {% if complaintOptions.nationalEPrivacyLaw %} and {{ complaintOptions.nationalEPrivacyLaw }}{% endif %} below.
{% elif complaintOptions.controllerResponse === "broken-promise" %}
  I have received a response from the controller in which they agreed to remedy the violations I discovered. However, as I will explain below, they have not actually done so.
{% endif %}

I am attaching my notice to the controller{% if complaintOptions.controllerResponse !== "none" %} as well as any communication I have received from them in this matter{% endif %}.

On {{ analysis.date | dateFormat }}, {% if complaintOptions.controllerResponse === "none" %}and thus after the expiration of the voluntary grace period{% else %}after the controller had responded{% endif %}, I retested the app using the tweasel tools. The analysis was performed on version {{ analysis.app.version }} of the app, {% if analysis.app.store %}downloaded from the {{ analysis.app.store }}, {% endif %}running on {{ analysis.app.platform }} {{ analysis.platformVersion }}. Unfortunately, I had to find that the app still performs tracking in violation of the GDPR {% if complaintOptions.nationalEPrivacyLaw %} and {{ complaintOptions.nationalEPrivacyLaw }}{% endif %}. Both this second technical report and the traffic recording are also attached.

{% if type === 'complaint' %}
To verify that the tracking also affects me, I used {% if analysis.app.platform === 'Android' %}the "TrackerControl" app#footnote[https://trackercontrol.org/#network-traffic-analysis]{% elif analysis.app.platform === 'iOS' %}the "App Privacy Report" feature#footnote[https://support.apple.com/en-gb/HT212958]{% endif %} on my personal {{ analysis.app.platform }} device. This confirmed that the app also contacts those tracking servers on my own device.#footnote[Recording a phone's network traffic requires rooting the device and making severe configuration changes. Doing this is not feasible or advised for devices that are in actual day-to-day use. That is why the tweasel project provides public infrastructure for doing such testing on devices/emulators that are only used for this purpose. However, logging a list of DNS hostnames contacted by an app is possible without such severe procedures {% if analysis.app.platform === 'Android' %}by installing the "TrackerControl" app{% elif analysis.app.platform === 'iOS' %}using the "App Privacy Report" feature integrated directly into iOS{% endif %}.\
\
While the results from this log don't allow for inspecting the actual data that was transmitted, they do prove that the app contacted the same tracking servers. In combination with the technical report by the tweasel project, for which the request content was actually analysed, this provides a very strong indication that I am affected by the same tracking. As I will elaborate on in @legal-grounds-burden-of-proof, the controller has the burden of proving that their processing is in line with the GDPR. It would thus be on them to produce evidence for disproving the conclusion I am drawing here.] I have attached the evidence for this in @personal-hostnames[Appendix]
{% endif %}

== Tracking without interaction <tracking>

In this section, I am detailing the tracking data transmissions that the app performed. I am only including transmissions from the second technical report from the tweasel project from {{ analysis.date | dateFormat(false) }}. All these transmissions thus occurred {% if complaintOptions.controllerResponse === "none" %}*at least 60 days after* I informed the controller of the violations I had initially discovered and gave them the opportunity to remedy them{% else %}after the controller had responded to my notice{% endif %}.

{% if type === 'complaint' %}
Additionally, I am only including transmissions to servers for which the log of {% if analysis.app.platform === 'Android' %}the "TrackerControl" app{% elif analysis.app.platform === 'iOS' %}the "App Privacy Report"{% endif %} confirmed that the app also contacts them on my personal device, as explained above. It is thus safe to assume that all these transmissions also affect me personally.
{% endif %}

It further bears repeating that, as guaranteed by the analysis methodology, the tracking transmissions described here all occurred *without any interaction* with the app or any potential consent dialog.

{% for adapterSlug, adapterResult in findings %}
== {{ adapterResult.adapter.name }}

The app sent {{ adapterResult.requests.length }} request(s) to the tracker "{{ adapterResult.adapter.name }}", operated by "{{ adapterResult.adapter.tracker.name }}".

{% if adapterResult.adapter.tracker.description %}
{{ t("tracker-descriptions", adapterResult.adapter.tracker.description) | trackharMl | safe }}
{% endif %}

{% if adapterResult.adapter.description %}
{{ t("tracker-descriptions", adapterResult.adapter.description) | trackharMl | safe }}
{% endif %}

Through these requests, at least the following information was transmitted:

#table(
  columns: (33.3333%, 66.6666%),

  [*Data type*], [*Transmitted value(s)*],
  {% for property, value in adapterResult.receivedData -%}
  [{{ t("properties", property) }}], [{{ value | join(', ') | code }}],
  {% endfor %}
)

The full content of this request and the method used for decoding the request and extracting this information is documented in the attached technical report.
{% endfor %}

= Context: Online tracking <context-online-tracking>

The tracking practices employed in the app by the controller are part of a broader ecosystem of online tracking that has become pervasive across the web and mobile apps. Extensive research has again and again revealed ubiquitous violations of and a prevalent disregard for data protection law in this context. The vast amounts of personal data collected through such tracking activities are fed into an opaque and shadowy system consisting of thousands of companies, posing very real dangers to users.

== Habitual violations of data protection law

Studies looking into tracking that happens without consent have proven how common tracking is, even before there was any user interaction at all.

On the web, research found between 49~% and 75~% of websites using tracking before the user interacted with a consent prompt or even after explicitly rejecting it.#footnote[Trevisan/Traverso/Bassi/Mellia, 4 Years of EU Cookie Law: Results and Lessons Learned, 2019, https://petsymposium.org/popets/2019/popets-2019-0023.pdf; Papadogiannakis/Papadopoulos/Kourtellis/Markatos, User Tracking in the Post-cookie Era: How Websites Bypass GDPR Consent to Track Users, 2021, https://dl.acm.org/doi/10.1145/3442381.3450056]

Studies analyzing apps on Android and iOS found similar results, reporting around 75~% of apps contacting trackers without consent and between 55~% and 72~% of apps sharing unique device identifiers like the device ID.#footnote[Kollnig/Shuba/Binns/Van Kleek/Shadbolt, Are iPhones Really Better for Privacy? A Comparative Study of iOS and Android Apps, 2022, https://petsymposium.org/popets/2022/popets-2022-0033.pdf; Altpeter, Informed Consent? A Study of "Consent Dialogs" on Android and iOS, 2022, https://benjamin-altpeter.de/doc/thesis-consent-dialogs.pdf] In fact, apps transfer more personal data to trackers before obtaining consent than afterwards.#footnote[Koch/Altpeter/Johns, The OK Is Not Enough: A Large Scale Study of Consent Dialogs in Smartphone Applications, 2023, https://www.usenix.org/system/files/usenixsecurity23-koch.pdf; Altpeter, Informed Consent? A Study of "Consent Dialogs" on Android and iOS, 2022, https://benjamin-altpeter.de/doc/thesis-consent-dialogs.pdf] Developers are frequently not aware of their obligations under data protection law or misunderstand them.#footnote[Tin Nguyen/Backes/Marnau/Stock, Share First, Ask Later (or Never?) Studying Violations of GDPR’s Explicit Consent in Android Apps, 2021, https://www.usenix.org/system/files/sec21-nguyen.pdf]

Websites and apps that do try to acquire users' consent, typically employ dark patterns and nudging to trick users into giving consent even if they don't actually want to do so. Multiple studies across the web and mobile found that around 90~% of consent dialogs employed at least one dark pattern that is explicitly explained to be infringing the GDPR's conditions for consent in publications by data protection authorities.#footnote[Koch/Altpeter/Johns, The OK Is Not Enough: A Large Scale Study of Consent Dialogs in Smartphone Applications, 2023, https://www.usenix.org/system/files/usenixsecurity23-koch.pdf; Altpeter, Informed Consent? A Study of "Consent Dialogs" on Android and iOS, 2022, https://benjamin-altpeter.de/doc/thesis-consent-dialogs.pdf; Nouwens/Liccardi/Veale/Karger/Kagal, Dark Patterns after the GDPR: Scraping Consent Pop-ups and Demonstrating their Influence, 2020, https://dl.acm.org/doi/10.1145/3313831.3376321] These dark patterns include making refusing consent harder than giving it, and overly highlighting the "accept" button compared to the "reject" button by color and/or size. It is important to note that all cited studies only observed a limited set of minimal conditions that are easy to evaluate automatically, meaning that the actual percentage of consent dialogs with violations is in all likelihood even higher.

The dangers of such dark patterns and nudging are well established in relevant literature. Consent dialogs already do not work as a medium for conveying privacy-critical information to users, even when those users are concerned about their privacy and no dark patterns are used.#footnote[Bauer/Bravo-Lillo/Fragkaki/Melicher, A comparison of users' perceptions of and willingness to use Google, Facebook, and Google+ single-sign-on functionality, 2013, https://dl.acm.org/doi/10.1145/2517881.2517886] Experiments investigating the effect of various design variables in consent dialogs on user choices found that nudging, even in the form of seemingly small details, heavily increases consent rates.#footnote[Utz/Degeling/Fahl/Schaub/Holz, (Un)informed Consent: Studying GDPR Consent Notices in the Field, 2019, https://dl.acm.org/doi/10.1145/3319535.3354212; Nouwens/Liccardi/Veale/Karger/Kagal, Dark Patterns after the GDPR: Scraping Consent Pop-ups and Demonstrating their Influence, 2020, https://dl.acm.org/doi/10.1145/3313831.3376321] For example, a highlighted "accept all" button results in significantly higher consent rates but at the same time users are not aware of its effects and regret their choice after being informed of those effects.#footnote[Machuletz/Böhme, Multiple Purposes, Multiple Problems: A User Study of Consent Dialogs after GDPR, 2020, https://petsymposium.org/popets/2020/popets-2020-0037.pdf]

Other research found websites registering supposed consent without user interaction or even after an explicit opt-out, as well as preselected options in half of consent dialogs.#footnote[Matte/Bielova/Santos, Do Cookie Banners Respect my Choice?: Measuring Legal Compliance of Banners from IAB Europe's Transparency and Consent Framework, 2020, https://ieeexplore.ieee.org/document/9152617]

== Real risks for data subjects

At the same time, these practices pose significant and very real risks to data subjects. Thousands of tracking companies worldwide constantly collect vast amounts of data on users on the web and on mobile and analyze intimate details about their lives. An analysis of self-declared privacy labels on Android found often downloaded apps, including apps explicitly aimed at children, admitting to collecting and sharing highly sensitive data like the user’s sexual orientation or health information for tracking and advertising purposes.#footnote[Altpeter, Worrying confessions: A look at data safety labels on Android, 2022, https://www.datarequests.org/blog/android-data-safety-labels-analysis/] Based on such data, they try to predict users' behaviours for example to target and influence users with ads and decide which products to display and at what price. They also claim to be able to assess companies' risks to protect against spam, compute credit scores, or prevent fraud.#footnote[Sieben in Altpeter/Sieben, Tracking und Datenschutzrechte, 2023, https://static.dacdn.de/talks/slides/2023-09-08-topio.pdf, slide 75]

Additionally, trackers build profiles on users, categorizing them into segments, sometimes based on highly sensitive inferences like health conditions, religious beliefs, sexual orientation, income level, and more. To give just a few examples, reporting has found segments such as _heavy alcohol consumers_, _desire to lose weight_, _planning to adopt a child_, _diagnosis for leukemia_, _low income without perspective_, _conservative values_, and even _visits to sexual abuse treatment centers_. Trackers also score users on criteria like _often influenced by ads_, _inexperienced credit card users_, _lone wolves_, and _getting a raw deal out of life_ to identify vulnerabilities.#footnote[Keegan/Eastwood, From "Heavy Purchasers" of Pregnancy Tests to the Depression-Prone: We Found 650,000 Ways Advertisers Label You, 2023, https://themarkup.org/privacy/2023/06/08/from-heavy-purchasers-of-pregnancy-tests-to-the-depression-prone-we-found-650000-ways-advertisers-label-you; Gille/Meineck/Dachwitz, Wie eng uns Datenhändler auf die Pelle rücken, 2023, https://netzpolitik.org/2023/europa-vergleich-wie-eng-uns-datenhaendler-auf-die-pelle-ruecken/] Trackers conduct large-scale experiments, systematically optimizing how to persuade, manipulate, and trigger users.#footnote[Christl, Corporate Surveillance in Everyday Life, 2017, https://crackedlabs.org/en/corporate-surveillance]

Crucially, trackers don't need to know users' legal identities for any of this profiling. They collect and assign unique identifiers to track users, and share and link IDs among each other in order to more precisely follow users across websites and apps.#footnote[Urban/Tatang/Degeling/Holz/Pohlmann, The Unwanted Sharing Economy: An Analysis of Cookie Syncing and User Transparency under GDPR, 2018, https://arxiv.org/pdf/1811.08660.pdf; Englehardt/Narayanan, Online Tracking: A 1-million-site Measurement and Analysis, 2016, https://dl.acm.org/doi/pdf/10.1145/2976749.2978313; Cyphers/Gebhart, Behind the One-Way Mirror: A Deep Dive Into the Technology of Corporate Surveillance, 2019, https://www.eff.org/files/2019/12/11/behind_the_one-way_mirror-a_deep_dive_into_the_technology_of_corporate_surveillance.pdf] For trackers, these IDs are often even more useful than legal names. After all, names are not unique whereas IDs are specifically designed to precisely identify a single user, device, or session. As Zuiderveen Borgesius points out, "Many companies are not interested in tying a name to data they process for behavioural targeting, even though they could easily do so."#footnote[Zuiderveen Borgesius, Singling out people without knowing their names – Behavioural targeting, pseudonymous data, and the new Data Protection Regulation, 2016, p. 268]

Supposedly anonymized datasets are rarely safe against re-identification. In many cases, even a handful of seemingly benign data points are enough to uniquely identify a person.#footnote[cf. e.g. Rocher/Hendrickx/de Montjoye, Estimating the success of re-identifications in incomplete datasets using generative models, Nature Communications, 2019, https://www.nature.com/articles/s41467-019-10933-3] Similarly, fingerprinting can often uniquely identify a device using its settings.#footnote[lschatzkin/Budington/maximillianh/Antaki, About Cover Your Tracks, 2021, https://coveryourtracks.eff.org/about]

Given the above, it is crucial that data protection law protects data subjects against these dangers. Its very purpose is to safeguard individuals from the misuse of their personal data, which is a fundamental right. Tracking practices, as outlined, not only infringe upon this right but also pose a significant threat to the autonomy and dignity of individuals. The covert accumulation and exploitation of personal data through tracking mechanisms enable manipulation and discrimination, undermining the essence of individual freedom and self-determination.

= {{ 'Grounds for the complaint' if type === 'complaint' else 'Legal grounds' }} <legal-grounds>

Based on the facts presented above, I am of the opinion that the controller has violated data protection law, as I will explain in the following.

== Violation of Art. 6(1) GDPR: Lawfulness of processing

The tracking data transmissions listed in @tracking fall within the scope of the GDPR but the controller had no legal basis for this processing.

=== Transmission of tracking data falls under the GDPR

Through the tracking data transmissions, the controller processed my personal data by automated means. Accordingly, they fall within the scope of the GDPR (Art. 2(1) GDPR).

The European Court of Justice has repeatedly and consistently stressed that the concept of personal data is to be interpreted broadly#footnote[cf. e.g. European Court of Justice, Judgment of 20 December 2017, Case C-434/16, https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:62016CJ0434; European Court of Justice, Judgment of 4 May 2023, Case C-487/21, https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:62021CJ0487; European Court of Justice, Judgment of 7 March 2024, Case C-479/22 P, https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:62022CJ0479], including in the context of online advertising and tracking#footnote[European Court of Justice, Judgment of 7 March 2024, Case C-604/22, https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:62022CJ0604]. The definition of "personal data" in Article 4(1) of the GDPR explicitly lists online identifiers as a possible means of identification. Recital 26 of the GDPR further confirms: "To determine whether a natural person is identifiable, all means should be considered that could likely be used by the controller or any other person, according to general estimates, to directly or indirectly identify the natural person, such as singling out." It was specifically the legilature's intention to make it clear that the GDPR applies in the context of online tracking#footnote[Albrecht/Jotzo, Das neue Datenschutzrecht der EU, 1. edition, 2017, Part 3, mn. 3 (translated)]: #quote[Data subjects can be indirectly inferred for example through 'singling out' as mentioned in Recital 26 GDPR. The _European Parliament_ had pushed for this clarification, since in the online world, for example with the help of cookies, IP addresses, browser fingerprints and other techniques, personality profiles are generated for many users by which they receive individual advertising without the operators of such advertising networks needing their civil names.]

Therefore, the mere possibility of individualizing or recognizing an individual based on a piece of data suffices for the presence of personal data.#footnote[in agreement: Farinho in Spiecker gen. Döhmann/Papakonstantinou/Hornung/De Hert, General Data Protection Regulation, Art. 4(1) Personal data, 2023, mn. 21, 24; Zuiderveen Borgesius, Singling out people without knowing their names – Behavioural targeting, pseudonymous data, and the new Data Protection Regulation, Computer Law & Security Review 2016, 256; Article 29 Data Protection Working Party, WP 136: Opinion 4/2007 on the concept of personal data, https://ec.europa.eu/justice/article-29/documentation/opinion-recommendation/files/2007/wp136_en.pdf, p. 14; Albrecht/Jotzo, Das neue Datenschutzrecht der EU, 1. edition, 2017, Part 3, mn. 3; Karg in Simitis/Hornung/Spiecker gen. Döhmann, Datenschutzrecht, 1. edition, 2019, Art. 4 Nr. 1 DSGVO, mn. 49–50; Schantz in Schantz/Wolff, Das neue Datenschutzrecht, 1. edition, 2017, chapter C.II, mn. 292–293; Schild in BeckOK Datenschutzrecht, 45. edition, 2023, Art. 4 Nr. 1, mn. 17, 19]

The tracking services integrated by the controller have all read and/or set IDs that are used to identify me and my device. These IDs are specifically designed to be unique and avoid collisions, ensuring that they will only ever be assigned once and thus precisely identify me. For example, one common ID format that trackers often use are UUIDs/GUIDs. Those are explicitly specified to "guarantee uniqueness across space and time."#footnote[Leach/Mealling/Salz, RFC 4122: A Universally Unique IDentifier (UUID) URN Namespace, 2005, https://datatracker.ietf.org/doc/html/rfc4122] One would have to generate 1 billion UUIDv4s per second for about 86 years to have even just a 50~% probability of a collision.#footnote[Wikipedia contributors, Universally unique identifier, 2024, https://en.wikipedia.org/w/index.php?title=Universally_unique_identifier&oldid=1212321712]

Additionally, trackers commonly share IDs among each other (a process referred to as "cookie syncing" on the web).#footnote[Urban/Tatang/Degeling/Holz/Pohlmann, The Unwanted Sharing Economy: An Analysis of Cookie Syncing and User Transparency under GDPR, 2018, https://arxiv.org/pdf/1811.08660.pdf; Englehardt/Narayanan, Online Tracking: A 1-million-site Measurement and Analysis, 2016, https://dl.acm.org/doi/pdf/10.1145/2976749.2978313; Cyphers/Gebhart, Behind the One-Way Mirror: A Deep Dive Into the Technology of Corporate Surveillance, 2019, https://www.eff.org/files/2019/12/11/behind_the_one-way_mirror-a_deep_dive_into_the_technology_of_corporate_surveillance.pdf] This process allows different tracking services to share and match IDs with each other, thereby combining data from various sources to create an even more comprehensive profile of an individual.

These IDs are then used not only to collect data about individuals and track their behaviour, but for example also to deliver targeted advertisements.

As such, it is apparent that the IDs' very purpose is to single out users as referred to in Recital 26 GDPR and identify them.

Even if the IDs themselves were not personal data on their own, the transmitted tracking data as whole unequivocally constitutes personal data. A controller does not need to be able to immediately infer a data subject's name from some information for that information to be personal data.#footnote[Farinho in Spiecker gen. Döhmann/Papakonstantinou/Hornung/De Hert, General Data Protection Regulation, Art. 4(1) Personal data, 2023, mn. 20; Purtova, From knowing by name to targeting: the meaning of identification under the GDPR, 2022, https://academic.oup.com/idpl/article/12/3/163/6612144; EU FRA, Handbook on European data protection law, 2018 edition, section 2.1, https://fra.europa.eu/sites/default/files/fra_uploads/fra-coe-edps-2018-handbook-data-protection_en.pdf; Albrecht/Jotzo, Das neue Datenschutzrecht der EU, 1. edition, 2017, Part 3, mn. 3; Arning/Rothkegel in Taeger/Gabel, DSGVO - BDSG - TTDSG, 4. edition, 2022, Art. 4 DSGVO, mn. 24, 30; Ernst in Paal/Pauly, DS-GVO BDSG, 3. edition, 2021, Art. 4 Nr. 1 DSGVO, mn. 8; Karg in Simitis/Hornung/Spiecker gen. Döhmann, Datenschutzrecht, 1. edition, 2019, Art. 4 Nr. 1 DSGVO, mn. 48–49; Klabunde in Ehmann/Selmayr/Klabunde, DS-GVO, 2. edition, 2018, Art. 4 DSGVO Nr. 1, mn. 18; Schantz in Schantz/Wolff, Das neue Datenschutzrecht, 1. edition, 2017, chapter C.II, mn. 291–292; Schild in BeckOK Datenschutzrecht, 45. edition, 2023, Art. 4 Nr. 1, mn. 17; Ziebarth in Sydow/Marsch, DS-GVO/BDSG, 3. edition, 2022, Art. 4 Nr. 1 DSGVO, mn. 14; Karg/Kühn, Datenschutzrechtlicher Rahmen für "Device Fingerprinting" - Das klammheimliche Ende der Anonymität im Internet, ZD 2014, 285, p. 288; Wenhold, Nutzerprofilbildung durch Webtracking, 1. edition, 2018, chapter E.I.2, p. 130]

In the context of online tracking and advertising, IDs are never processed on their own. Instead, they are combined with other information, such as interaction data, browsing history, location data, device parameters, behavioral patterns, and IP addresses, to create detailed fingerprints and profiles of users and target them with personalized ads. As shown in @tracking, the very purpose of the trackers that the controller embedded into the app is to target and/or recognize individual users. In this larger context, there is an overwhelming consensus among legal scholars that such data processing falls under the scope of the GDPR and constitutes personal data.#footnote[Gola in Gola/Heckmann, Datenschutz-Grundverordnung - Bundesdatenschutzgesetz, 3. edition, 2022, Art. 4 Nr. 1 DSGVO, mn. 23; Klar/Kühling in Kühling/Buchner, DS-GVO/BDSG, 3. edition, 2020, Art. 4 Nr. 1 DSGVO, mn. 36; Schild in BeckOK Datenschutzrecht, 45. edition, 2023, Art. 4 Nr. 1, mn. 20] This is in line with Recital 30 GDPR.

This position is further supported by a large corpus of guidelines and decisions by various data protection authorities. These are outlined in the Appendix in @dpa-guidelines-id and @dpa-decisions-id, respectively.

Finally, it bears mention that in all of the requests detailed in @tracking, the tracking company has the option to associate the transmitted tracking data with the user's IP address. As the European Court of Justice has repeatedly ruled, that information may make it possible to create a profile of that user and actually identify the person specifically concerned by such information.#footnote[cf. e.g. European Court of Justice, Judgment of 7 March 2024, Case C-604/22, https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:62022CJ0604; European Court of Justice, Judgment of 17 June 2021, Case C-597/19, https://eur-lex.europa.eu/legal-content/en/TXT/?uri=CELEX:62019CJ0597; European Court of Justice, Judgment of 19 October 2016, Case C-582/14, https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:62014CJ0582]

As a result, the information in the described tracking data transmissions is evidently personal data. Clearly, it was also processed by automated means and thus falls under the scope of the GDPR.

=== No legal basis is applicable for the transmissions <no-legal-basis>

As per Art. 6(1) GDPR, the processing of personal data is only lawful if one of six possible legal bases is applicable. However, there is no possible valid legal basis for the processing carried out by the controller:

  + Consent (Art. 6(1)(a) GDPR): Consent can only be given by a statement or by a clear affirmative action (Art. 4(11) GDPR). Recital 32 GDPR clarifies that silence, pre-ticked boxes or inactivity do not constitute consent.

    As already explained, the transmissions detailed above happened without any interaction whatsoever. Thus, consent cannot possibly have been given for them. In any case, the burden of proving that consent has been given would be on the controller according to Art. 7(1) GDPR.
  + Necessity for performance of a contract (Art. 6(1)(b) GDPR): The described data transmissions were for the purposes of online tracking. Such processing is not necessary for the performance of a contract.

    In its _Guidelines 2/2019 on the processing of personal data under Article 6(1)(b) GDPR in the context of the provision of online services to data subjects_, the EDPB explicitly confirms that Art. 6(1)(b) GDPR cannot be used as a legal basis for tracking and profiling users#footnote[EDPB, Guidelines 2/2019 on the processing of personal data under Article 6(1)(b) GDPR in the context of the provision of online services to data subjects, Version 2.0, 2019, https://edpb.europa.eu/sites/default/files/files/file1/edpb_guidelines-art_6-1-b-adopted_after_public_consultation_en.pdf, mn. 56], online behavioural advertising#footnote[ibid., mn. 51 et seq.], or collecting metrics for "service improvement"#footnote[ibid., mn. 48 et seq.].
  + Legal obligation (Art. 6(1)(c) GDPR): obviously not applicable.
  + Necessity for protection of natural person's vital interests (Art. 6(1)(d) GDPR): obviously not applicable.
  + Necessity for performance of a task carried out in the public interest (Art. 6(1)(e) GDPR): obviously not applicable.
  + Necessity for purposes of legitimate interests (Art. 6(1)(f) GDPR): The controller also cannot claim a legitimate interest in the processing. Legitimate interests are typically not a suitable legal basis for tracking.#footnote[cf. e.g. Datenschutzkonferenz, Orientierungshilfe der Aufsichtsbehörden für Anbieter:innen von Telemedien ab dem 1. Dezember 2021 (OH Telemedien 2021), Version 1.1, 2022, https://www.datenschutzkonferenz-online.de/media/oh/20221130_OH_Telemedien_2021_Version_1_1.pdf, Section IV. 5; Der Landesbeauftragte für Datenschutz und Informationsfreiheit Baden-Württemberg, FAQ: Cookies und Tracking durch Betreiber von Webseiten und Hersteller von Smartphone-Apps, Version 2.0.1, 2022, https://www.baden-wuerttemberg.datenschutz.de/wp-content/uploads/2022/03/FAQ-Tracking-online.pdf, Section A.3.1; Article 29 Data Protection Working Party, WP 217, Opinion 06/2014 on the notion of legitimate interests of the data controller under Article 7 of Directive 95/46/EC, https://ec.europa.eu/justice/article-29/documentation/opinion-recommendation/files/2014/wp217_en.pdf, p. 32; Article 29 Data Protection Working Party, WP 203, Opinion 03/2013 on purpose limitation, https://ec.europa.eu/justice/article-29/documentation/opinion-recommendation/files/2013/wp203_en.pdf, p. 46] It is not apparent why the controller's interest in tracking would outweigh my interests and fundamental rights and freedoms.

== Violation of Art. 25 GDPR and Art. 5(1)(c) GDPR: Data protection by design and by default, data minimisation

The controller has failed to implement appropriate technical and organisational measures to ensure data protection by design and by default as required by Art. 25 GDPR.

Art. 25(1) GDPR requires the controller to implement appropriate measures at the time of determining the means of processing as well as during the processing itself. This includes measures to effectively implement the data minimisation principle as per Art. 5(1)(c) GDPR.#footnote[EDPB, Guidelines 4/2019 on Article 25 Data Protection by Design and by Default, Version 2.0, 2020, https://edpb.europa.eu/sites/default/files/files/file1/edpb_guidelines_201904_dataprotection_by_design_and_by_default_v2.0_en.pdf, mn. 61] The EDPB has confirmed that this obligation applies to all controllers, regardless of their size or the complexity of their processing operations.#footnote[ibid., mn. 6]

@tracking details the tracking that the app has performed. As explained in @context-online-tracking, the online tracking ecosystem presents severe risks to the rights and freedoms of data subjects, even if only seemingly benign data is being processed. It is the controller's obligation to take the current 'state of the art' into account in their risk analysis and have knowledge of how technology can present data protection risks. #footnote[ibid., mn. 19, 30] They should have been aware of these risks as they are widely documented and discussed in literature, media, and public debate.

However, they have failed to mitigate these risks, instead enabling unnecessary collection and transmission of data by default. The controller has included the above mentioned third-party tracking SDKs into their app and configured them to send tracking payloads without any user interaction.

The controller cannot argue that the SDKs themselves configured the tracking to be enabled by default, either. It is the controller's responsiblity to make sure that functions that do not have a legal basis or are not compatible with the intended purposes of processing are switched off when including third-party software in their app. #footnote[ibid., mn. 44]

As explained in @no-legal-basis, the data collected through the tracking goes beyond what is adequate and necessary for the app's functionality. If the controller should argue that they need certain statistics for example to monitor the performance of their app, less granular, aggregated, or anonymized data would have sufficed for this purpose instead of combining the data with unique identifiers that allow the controller and third-parties to identify me.#footnote[ibid., mn. 49, 75] They have thus collected more data than is necessary, violating the principle of data minimisation as prescribed by Art. 5(1)(c) GDPR.

Finally, users cannot reasonably expect that apps transmit such detailed identifiable data about them without any interaction.#footnote[ibid., mn. 70]

== Burden of proof <legal-grounds-burden-of-proof>

As a data subject, I have no insights into the internal processes and data processing practices of either the controller or the tracking companies the controller has integrated into their app. Through this complaint, I have materially substantiated why I believe that the controller has violated my data protection rights on a technical and legal basis.

The burden of proof that their processing is in line with the GDPR falls on the controller as per Art. 5(2) GDPR.#footnote[with additional references: Schantz in BeckOK Datenschutzrecht, 45. edition, 2023, Art. 5, mn. 39] It was further explicitly confirmed by the European Court of Justice.#footnote[European Court of Justice, Judgment of 24 February 2022, Case C-175/20, https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:62020CJ0175]

{% if complaintOptions.nationalEPrivacyLaw === 'TDDDG' %}
== §~25 TDDDG: Privacy protection for terminal equipment

In addition to the GDPR, I believe that the controller has also violated §~25 TDDDG as the transposition of Art. 5(3) ePrivacy Directive into German law.

As shown in @tracking, the app has sent various information relating to the used device to tracking companies. In order to do so, the app inevitably had to read the information from the terminal equipment#footnote[Schürmann/Guttmann in Auernhammer, DSGVO/BDSG, 8. edition, 2023, §~25 TTDSG, mn. 27, 31, 37; EDPB, Guidelines 2/2023 on Technical Scope of Art. 5(3) of ePrivacy Directive, 2023, https://www.edpb.europa.eu/system/files/2023-11/edpb_guidelines_202302_technical_scope_art_53_eprivacydirective_en.pdf, mn. 29, 31, 35, 39], thus opening the scope of §~25 TDDDG. Unlike the GDPR, the TDDDG doesn't just cover personal data but any data that is read from or stored on an end user's terminal equipment.#footnote[EDPB, Guidelines 2/2023 on Technical Scope of Art. 5(3) of ePrivacy Directive, 2023, https://www.edpb.europa.eu/system/files/2023-11/edpb_guidelines_202302_technical_scope_art_53_eprivacydirective_en.pdf, mn. 7–12; Schneider in Assion, TTDSG, 2022, §~25 TTDSG, mn. 23] The TDDDG does not include any significance threshold on the types of data concerned, either—any information can fall within its scope, including purely technical information.#footnote[Schürmann/Guttmann in Auernhammer, DSGVO/BDSG, 8. edition, 2023, §~25 TTDSG, mn. 20–23; Burkhardt/Reif/Schwartmann in Schwartmann/Jaspers/Eckhardt, TTDSG, 1. edition, 2022, §~25 TTDSG, mn. 29]

The storing of information, or the gaining of access to information already stored in the terminal equipment of a user requires the user's consent on the basis of clear and comprehensive information according to §~25(1) TDDDG.

While the TDDDG does list two exceptions to that rule in §~25(2) TDDDG, neither of them is applicable in this case:

+ As set out above, the information was sent to tracking and/or advertising companies. As such, the purpose of accessing this information was expressly _not_ the transmission of a message over a public telecommunications network. The exception in §~25(2)(1) TDDDG only applies where the transmission of a message over a public telecommunications network would not be possible at all without the storing of or the access to the concerned information#footnote[Schürmann/Guttmann in Auernhammer, DSGVO/BDSG, 8. edition, 2023, §~25 TTDSG, mn. 123; Schmitz in Geppert/Schütz, Beck'scher TKG-Kommentar, 5. edition, 2023, §~25 TTDSG, mn. 66; Hanloser in  Gierschmann/Baumgartner, TTDSG, 1. edition, 2023, §~25 TTDSG, mn. 94; Nolte in Säcker/Körber, TKG – TTDSG, 4. edition, 2023, §~25 TTDSG, mn. 33], and is thus not applicable here.
+ Likewise, the controller cannot claim that the access was absolutely necessary to provide a digital service expressly requested by me. The exception has to be interpreted narrowly, with tracking and advertising not being strictly necessary.#footnote[Article 29 Data Protection Working Party, WP 194, Opinion 04/2012 on Cookie Consent Exemption, https://ec.europa.eu/justice/article-29/documentation/opinion-recommendation/files/2012/wp194_en.pdf; Datenschutzkonferenz, Orientierungshilfe der Aufsichtsbehörden für Anbieter:innen von Telemedien ab dem 1. Dezember 2021 (OH Telemedien 2021), Version 1.1, 2022, https://www.datenschutzkonferenz-online.de/media/oh/20221130_OH_Telemedien_2021_Version_1_1.pdf, Section III. 3. c); Der Landesbeauftragte für Datenschutz und Informationsfreiheit Baden-Württemberg, FAQ: Cookies und Tracking durch Betreiber von Webseiten und Hersteller von Smartphone-Apps, Version 2.0.1, 2022, https://www.baden-wuerttemberg.datenschutz.de/wp-content/uploads/2022/03/FAQ-Tracking-online.pdf, Section A.1.4; Schneider in Assion, TTDSG, 2022, § 25 TTDSG, mn. 36, 44; Nolte in Säcker/Körber, TKG – TTDSG, 4. edition, 2023, §~25 TTDSG, mn. 37; Burkhardt/Reif/Schwartmann in Schwartmann/Jaspers/Eckhardt, TTDSG, 1. edition, 2022, §~25 TTDSG, mn. 127, 140; Ettig in Taeger/Gabel, DSGVO - BDSG - TTDSG, 4. edition, 2022, § 25 TTDSG, mn. 56] Thus, §~25(2)(2) TDDDG is not applicable either.

However, the controller has not obtained consent as there was no interaction with the app at all. §~25(1) TDDDG defers to the GDPR for conditions on consent. As such, the same reasoning as in @no-legal-basis applies here as well.
{% endif %}

= Requests and suggestions

{% if type === 'complaint' %}
In the previous sections, I have explained why I believe that the controller has violated my data protection rights. Therefore, I am now addressing this complaint to you.

I ask you to investigate my complaint and to examine the described issues by means of your investigative powers according to Art. 58(1) GDPR.

I also ask you to inform me about the progress and outcome of the complaint procedure according to Art. 77(2) GDPR and Art. 57(1)(f) GDPR during the course of the complaint procedure, but at the latest within three months (cf. Art. 78(2) GDPR).

I finally ask you to make use of any supervisory measures that you deem necessary to mitigate the controller's violation of my rights in line with your corrective powers as per Art. 58(2) GDPR. In doing so, please consider that the described violations in all likelihood do not just apply to me, but to all users of the app.
{% else %}
In the previous sections, I have explained why I believe that the controller has violated my data protection rights. I am therefore asking you to investigate this matter and to examine the described issues by means of your investigative powers according to Art. 58(1) GDPR. I am also asking you to make use of any supervisory measures that you deem necessary to mitigate the controller's violation of my rights in line with your corrective powers as per Art. 58(2) GDPR. In doing so, please consider that the described violations in all likelihood do not just apply to me, but to all users of the app.

While I am aware that you are not legally required to inform me about the progress and outcome of the procedure as this is not a formal complaint, I would nonetheless appreciate if you did.
{% endif %}

= Concluding remarks

{% if type === 'complaint' %}
You may share my data with the controller for the purpose of processing the complaint.
{% endif %}

If you need any more details, please feel free to contact me. You can reach me as follows: {{ complaintOptions.complainantContactDetails }}{% if complaintOptions.complainantAgreesToUnencryptedCommunication %}\
I agree to being contacted via unencrypted email.{% endif %}

Thank you in advance for your assistance.

// Appendix
#pagebreak()

#counter(heading).update(0)
#set heading(numbering: (..nums) => "A" + nums.pos().map(str).join(".") + ".")

#text(weight: 700, 1.75em)[Appendix]

{% if type === 'complaint' %}
= Results from "{% if analysis.app.platform === 'Android' %}TrackerControl{% elif analysis.app.platform === 'iOS' %}App Privacy Report{% endif %}" on my device, filtered to DNS hostnames contacted by the app <personal-hostnames>

#table(
  columns: (10%, 30%, 60%),
  align: (right, left, left),

  [*\#*], [*Time*], [*Hostname*],
  {% for entry in complaintOptions.userNetworkActivity -%}
  [{{ entry.index + 1 }}], [{{ entry.timestamp | dateFormat }}], [{{ entry.hostname }}],
  {% endfor %}
)
{% endif %}

= DPA guidelines regarding personal data in the context of online tracking <dpa-guidelines-id>

Several DPAs have issued guidelines or guidance notes on the use of cookies and other tracking technologies which involve the processing of IDs that are uniquely assigned to a person. These guidelines universally confirm that such IDs are personal data under the GDPR, especially when they are used or combined to create profiles of individuals or to single them out from others.

For example, the DPC Ireland explains that cookies can include personal data such as usernames or unique identifiers like user IDs and other tracking IDs. The DPC adds that where cookies contain identifiers that may be used to target a specific individual, or where information is derived from cookies and other tracking technologies that may be used to target or profile individuals, this will constitute personal data and its processing is also subject to the rules set out in the GDPR. The DPC also emphasizes that online identifiers are included in the definition of personal data in Article 4(1) of the GDPR, and that it does not matter whether the controller is in possession of other information that may be needed to identify an individual; the fact that the person may be identified, even with the addition of information held by another organisation, is sufficient to make this data personal data.#footnote[DPC Ireland, Guidance Note: Cookies and other tracking technologies, 2020, https://www.dataprotection.ie/sites/default/files/uploads/2020-04/Guidance%20note%20on%20cookies%20and%20other%20tracking%20technologies.pdf]

In an FAQ on Google Analytics, the Danish Datatilsynet also adopts a broad understanding of personal data in relation to online identifiers. It states that a unique identifier makes it possible to identify the individual to whom the data relates, even if it is not possible to assign a specific name or identity to the person concerned. It cites the GDPR's explicit mention of the "singling out" concept.#footnote[Datatilsynet, Google Analytics, https://www.datatilsynet.dk/english/google-analytics]

In its opinion on the interplay between the ePrivacy Directive and the GDPR, the EDPB mentions cookies as a clear example of processing activities which trigger the material scope of both the ePrivacy Directive and the GDPR.#footnote[EDPB, Opinion 5/2019 on the interplay between the ePrivacy Directive and the GDPR, in particular regarding the competence, tasks and powers of data protection authorities, 2019, https://edpb.europa.eu/sites/default/files/files/file1/201905_edpb_opinion_eprivacydir_gdpr_interplay_en_0.pdf]

Similarly, in its guidelines on telemedia, the German Datenschutzkonferenz states that the use of cookies and other tracking technologies often involves the processing of personal data and thus fall within the scope of both the TDDDG (the German law implementing the ePrivacy Directive) and the GDPR.#footnote[Datenschutzkonferenz, Orientierungshilfe der Aufsichtsbehörden für Anbieter:innen von Telemedien ab dem 1. Dezember 2021 (OH Telemedien 2021), Version 1.1, 2022, https://www.datenschutzkonferenz-online.de/media/oh/20221205_oh_Telemedien_2021_Version_1_1_Vorlage_104_DSK_final.pdf]

= DPA decisions regarding personal data in the context of online tracking <dpa-decisions-id>

Some DPAs have also issued decisions on specific cases involving the processing of IDs that are uniquely assigned to a person, again confirming that the processing of unique IDs in the context of online tracking falls under the scope of the GDPR.

For example, the Swedish DPA (IMY) issued a decision in June 2023, fining Tele2 Sverige AB and three other website providers for using Google Analytics despite the EU recommendations and decisions and without implementing additional safeguards.#footnote[At the same time, the IMY also issued three additional, very similar decisions, against other websites: DI-2020-11397 (https://www.imy.se/globalassets/dokument/beslut/2023/beslut-tillsyn-ga-cdon.pdf), DI-2020-11368 (https://www.imy.se/globalassets/dokument/beslut/2023/beslut-tillsyn-ga-coop.pdf), DI-2020-11370 (https://www.imy.se/globalassets/dokument/beslut/2023/beslut-tillsyn-ga-dagens-industri.pdf)] In the decision, the IMY explains that network/online identifiers can be used to identify a user, especially when combined with other similar types of information.#footnote[IMY, Beslut efter tillsyn enligt dataskyddsförordningen – Tele2 Sverige AB:s överföring av personuppgifter till tredjeland, DI-2020-11373, 2023, https://www.imy.se/globalassets/dokument/beslut/2023/beslut-tillsyn-ga-tele2.pdf, p. 10] The IMY considered the data collected by Google Analytics, such as unique identifiers stored in the cookies `_gads`, `_ga`, and `_gid`, IP addresses, and other information related to the website visit and user's browser. They highlight that these identifiers were created with the express aim of being able to distinguish individual visitors, thus making them identifiable. The IMY notes that even if the IDs alone did not make individual identifiable, the IDs in combination with the other transmitted data makes website visitors even more distinguishable. As such, they conclude that the transmitted data information constitutes personal data. The IMY explains that this differentiation is in itself sufficient to make the visitor indirectly identifiable in accordance with Recital 26 GDPR and that knowledge of the visitor's name or physical address is not required. They also do not consider it necessary that the controller or processor actually intends to identify the visitor, noting that the possibility of doing so is in itself sufficient to determine whether it is possible to identify a visitor.#footnote[ibid., p. 11]

Similarly, the Austrian DPA (DSB) issued a decision in December 2021, finding that an Austrian website violated the GDPR by transferring personal data to the US by using Google Analytics. The DSB notes that the cookies used by Google Analytics, `_ga`, `_gid`, and `cid`, contained unique identifiers that were stored on the users' devices and browsers, and that only through these identifiers was it possible for the website operator and Google to distinguish visitors as well as determine whether they had visited the website before. The DSB explains its position that such a possibility of individualizing website visitors was sufficient to open the scope of data protection law and that being able to find out the person's name was not necessary, citing Recital 26 GDPR as justification.#footnote[Österreichische Datenschutzbehörde, Teilbescheid D155.027 2021-0.586.257, 2021, https://noyb.eu/sites/default/files/2022-01/E-DSB%20-%20Google%20Analytics_DE_bk_0.pdf, p. 27–28] With regards to the controller's and Google's argument that they didn't actually intend to associate the IDs with an actual person, the DSB underlines#footnote([ibid., p. 28 (translated)]): #quote[Insofar as the defendants argue that no 'means' are used to link the identification numbers in question here to the person of the complainant, it must be reiterated that the implementation of Google Analytics on [the website] _results in_ a singling out within the meaning of Recital 26 GDPR. In other words: Those who use a tool that only enables such singling out _in the first place_, cannot take the position that they do not 'reasonably' use any means to make natural persons identifiable.]

The DSB also notes that these identifiers could combined with other information, such as browser data and IP addresses, which made the website visitors even more identifiable, referring to Recital 30 GDPR. The DSB further points out that Google Analytics was specifically designed to be implemented on as many websites as possible, in order to collect information about website visitors. They conclude that the data processed by Google Analytics constituted personal data and stress that not applying the GDPR to the processing done by Google Analytics would run afoul of the fundamental right to data protection.#footnote[ibid., p. 29]

The DSB's decision was later confirmed by the Austrian Federal Administrative Court in judgement W245 2252208-1/36E, W245 2252221-1/30E#footnote[https://www.ris.bka.gv.at/Dokumente/Bvwg/BVWGT_20230512_W245_2252208_1_00/BVWGT_20230512_W245_2252208_1_00.pdf].

In a more recent decision in March 2023, the DSB found that the use of Facebook's tracking pixel by an Austrian website provider also violated the GDPR and the ECJ's _Schrems II_ judgement. In the decision, the DSB follows the same argument as in the Google Analytics decision, quoting from it with regards to the classification of tracking data as personal data.#footnote[Österreichische Datenschutzbehörde, Bescheid D155.028 2022-0.726.643, 2023, https://noyb.eu/sites/default/files/2023-03/Bescheid%20redacted.pdf]

Again concerning Google Analytics but also Google Tag Manager, Tietosuojavaltuutetun toimisto, the Finish DPA, issued a decision in December 2022 against the public library online services of four cities in Finland. The decision mentions that personal data was collected through those tools.#footnote[Tietosuojavaltuutetun toimisto, Apulaistietosuojavaltuutetun päätös käsittelyn lainmukaisuutta, käsittelyn turvallisuutta, sisäänrakennettua ja oletusarvoista tietosuojaa, rekisteröityjen informointia ja henkilötietojen siirtoa kolmansiin maihin koskevassa asiassa, 4672/161/22, 2022, https://finlex.fi/fi/viranomaiset/tsv/2022/20221663]

The CNIL, the French DPA, issued a decision in March 2022, ordering three French websites to comply with the GDPR in relation to their use of Google Analytics. The CNIL explains that online identifiers, such as IP addresses or information stored in cookies, could be used as a means of identifying a user, especially when combined with other similar types of information, citing Recital 30 GDPR. The CNIL explains that the websites had to demonstrate the means implemented to ensure that the identifiers collected were anonymous, otherwise they could not be qualified as anonymous. They also note that the IDs used by Google Analytics were unique identifiers that were intended to differentiate between individuals and that these identifiers could also be combined with other information, such as the address of the site visited, metadata relating to the browser and operating system, the time and data relating to the visit to the website, and the IP address. The CNIL argues that this combination reinforced their distinguishing nature and made the visitors identifiable. The CNIL believes that the scope of the right to data protection would be diminished if this were decided otherwise.#footnote[CNIL, Décision n° […] du […] mettant en demeure […], 2022, https://www.cnil.fr/sites/cnil/files/atoms/files/med_google_analytics_anonymisee.pdf, p. 4]

The CNIL also sanctioned Criteo, an online advertising company, with a fine in June 2023 for failing to verify that users from whom it processed data had given their consent. The CNIL considers that Criteo processed personal data, given the number and diversity of the data collected and the fact that they were all linked to an identifier, which made it possible, with reasonable means, to re-identify the natural persons to whom this data relates. The CNIL also notes that the Criteo cookie ID was intended to distinguish each individual whose data it collected and that a large amount of information intended to enrich the user's advertising profile was associated with this identifier. The CNIL believes that even if Criteo did not directly have the identity of the person associated with a cookie ID, reidentification could be possible if Criteo also collected other data such as the email address, the IP address, or even the user agent (or hashed forms thereof). The CNIL concludes that as long as Criteo is able to re-identify individuals using reasonable means, the processed data is personal data under the GDPR.#footnote[CNIL, Délibération SAN-2023-009 du 15 juin 2023, 2023, https://www.legifrance.gouv.fr/cnil/id/CNILTEXT000047707063]

The Norwegian Datatilsynet published a draft decision in May 2021, notifying Disqus, a company that provides a platform for online comments, that it would be fined for unlawfully processing personal data for programmatic advertising. The DPA states that online identifiers, such as cookie IDs, were personal data, as they enabled the controller to distinguish one website user from another, and to monitor how each user interacts with the website, citing Art. 4(1) GDPR and Recital 30 GDPR to support its interpretation.#footnote[Datatilsynet, Advance notification of an administrative fine – Disqus Inc., 20/01801-5, 2021, https://www.datatilsynet.no/contentassets/8311c84c085b424d8d5c55dd4c9e2a4a/advance-notification-of-an-administrative-fine--disqus-inc.pdf, p. 15–16]

Finally, the DPA of Lower Saxony in Germany (LfD NDS) issued a decision in May 2023 concerning the use of a "pay or okay" system by Heise, a German tech news site. The site made users choose between paying for a monthly subscription or agreeing to their data being processed for advertising and other purposes. The LfD found that the requirements for obtaining consent were not fulfilled by Heise. In the decision, the LfD describes the high number of observed local storage objects, tracking techniques and third-party services used on the site, explaining that they will not provide a legal assessment of each one as a result. The LfD notes that Heise processed personal data through these objects, citing for example that Adform placed a `cid` cookie, which they determined to be an ID based on the name.#footnote[Die Landesbeauftrage für den Datenschutz Niedersachsen, Beschwerdeverfahren gegen Verarbeitungen personenbezogener Daten bei der Nutzung der Webseite www.heise.de, 2023, https://noyb.eu/sites/default/files/2023-07/11VerwarnungPurAboModellfinalgeschwrztp_Redacted.pdf, p. 6]
