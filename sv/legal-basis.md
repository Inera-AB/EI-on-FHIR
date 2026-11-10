# Rättslig grund och ändamål - FHIR-baserat engagemangsindex (FHIR-EI) v0.1.0

## Rättslig grund och ändamål

Dagens engagemangsindex vilar på en juridisk tolkning som Arkitekturledningens säkerhetsgrupp (AL-S) tog fram 2013 och stämde av 2014. Den står i kapitel 4 i tjänstedomänens TKB, Informationssäkerhet och juridik. FHIR-EI går på flera punkter utöver den, främst genom [åtkomstlägena](security.md) och [försörjningssätten](population.md), och de punkterna behöver en ny bedömning innan de tas i drift.

### Dagens tolkning

| | |
| :--- | :--- |
| Personuppgiftsansvar | Lagring i engagemangsindex är en vårdgivares behandling av personuppgifter enligt patientdatalagen 1:1. Varje vårdgivare är personuppgiftsansvarig för sina egna uppgifter. Inera är personuppgiftsbiträde och får bara behandla indexet enligt vårdgivarnas instruktioner |
| Skyddsvärde | Uppgifterna är patientuppgifter, och indexet är ett personregister. De är inte klinisk information men kan röja vårdbehov, till exempel att en patient har en bokad tid hos en psykologmottagning |
| Åtkomst | Uppgifterna är inte åtkomliga för någon vårdgivare. Indexet är en teknisk del som anslutna tjänster använder för att söka snabbare, och lagstödet för att visa informationen finns i tjänsten |
| Ändamål | Uppgifterna får bara användas för att få fram den logiska adressen för anrop av en tjänst inom postens tjänstedomän. De får inte sökas ut eller bearbetas för något annat ändamål, och inte lagras för senare bearbetning eller adressering. FindContent är begränsat till aggregerande tjänster |
| Notiser | En mottagare av ProcessNotification ska kasta posterna när anropen är gjorda. Bara det nationella engagemangsindexet får lagra dem, inte ett regionalt index. Skälet är att prenumerationsmaskerna är grövre än vad personuppgiftsbiträdesavtal och tjänsteavtal reglerar, till exempel per vårdgivare |
| Personuppgiftsansvarig i posten | Varje post anger personuppgiftsansvarig organisation i dataController. Ett källsystem som betjänar flera vårdgivare registrerar poster som om varje vårdgivare hade ett eget källsystem. Sedan migreringen från NPÖ:s index 2015 godtas ändå källsystemets HSA-id i fältet, med spårbarhet till vårdgivaren via manuella rutiner |
| Ändrad användning | Varje ändring av hur indexet används stäms av med säkerhetsansvarig och jurist och därefter med säkerhetsrådet (motsvarande AL-S). Varje tjänsts TKB ska beskriva hur tjänsten använder indexet, så att kravet på öppenhet i GDPR uppfylls |

### Det FHIR-EI går utöver

| | | |
| :--- | :--- | :--- |
| Åtkomstlagret lämnar ut poster till användare efter prövning av spärr, samtycke och syfte | Indexet är inte åtkomligt för någon vårdgivare | Om utlämnande till en användare ryms i ändamålet när prövningen görs i FHIR-EI |
| Konsumenter som NPÖ och 1177 läser direkt, inte via en aggregerande tjänst | FindContent är begränsat till aggregerande tjänster | Vilka konsumenter som får läsa, per tjänst |
| Prenumeration, avstämning och deduplicering mot senast sedda version | Notiser kastas när anropen är gjorda | Vad en systemkonsument får spara, och hur länge |
| Massuttag och lokala kopior av innehåll | Ingen lagring för senare bearbetning | Ändamål och rättslig grund per systemkonsument |
| Härledning av eHM:s patientindex | Bara adressuppslag | Stöd i lagstiftningen om eHM:s patientindex |
| Inera-försörjd cache, där lokaliseringstjänsten frågar källorna | Inera behandlar bara enligt vårdgivarnas instruktioner | Om Inera kan få en instruktion som täcker frågorna, eller behöver en annan roll |
| Parallell försörjning i övergångens läge 1 | Ett nationellt index | Om en andra kopia av indexet under övergången ryms i nuvarande instruktioner |

### Vägar framåt

Två vägar är möjliga:

1. **Behålla dagens tolkning.**FHIR-EI används då som dagens engagemangsindex: bara aggregerande tjänster läser, åtkomstlagret lämnar inte ut poster till användare, och systemkonsumenter kastar posterna efter anropen. Massuttag, lokala kopior, härledning av eHM:s patientindex och Inera-försörjd cache faller bort eller kräver var för sig ett nytt beslut.
1. **En ny ansvarsfördelning med ett uttalat ändamål för FHIR-EI.**Alternativ att utreda är att Inera blir personuppgiftsansvarig för indexet, ett gemensamt personuppgiftsansvar, eller stöd i lagstiftningen om eHM:s patientindex (promemorian S2026/01360). Prövningen per användare och syfte i åtkomstlagret är det som kan göra den bredare användningen försvarbar.

Designen beskriver väg 2 men gör den inte till en förutsättning. Varje användning som går utöver dagens tolkning stäms av med säkerhetsrådet innan den tas i drift, och övergångens lägen har det som villkor; se [Händelsemodell och övergång](event-model.md).

### Ändamål per tjänst

Tjänstens IG beskriver hur tjänsten använder indexet. Det motsvarar kravet att varje TKB beskriver användningen av engagemangsindex. Beskrivningen anger:

* vilka konsumenter som läser, och i vilket åtkomstläge
* för vilket ändamål, till exempel att hitta källor att anropa för visning i NPÖ
* vad en systemkonsument sparar, och hur länge

Ändamålsbeskrivningen är ett villkor för läge 1 i övergången.

### Vad en systemkonsument får spara

Utgångsläget är dagens regel: en systemkonsument använder posterna för att anropa källorna och sparar dem inte därefter. Det som leveransgarantin kräver får sparas för deduplicering och avstämning: postens id och version och notisens händelsenummer. Allt utöver det, som posternas innehåll, massuttag eller lokala kopior av journalinnehåll, kräver att tjänstens ändamålsbeskrivning medger det och att systemkonsumenten har egen rättslig grund.

