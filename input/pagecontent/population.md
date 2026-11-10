Konsumentkontraktet är detsamma för alla tjänster: indexposter enligt [Indexpost](StructureDefinition-IneraIndexEntry.html) och tjänstens tillämpning, samma sökning, prenumeration, livscykel och åtkomstkontroll. Det som kan skilja mellan tjänster är hur posterna fylls och hålls aktuella. IG:n är neutral till det, och tre försörjningssätt är möjliga.

| | Producentregistrering | Inera-försörjd cache | Spegling av dagens engagemangsindex |
|---|---|---|---|
| Registrerande part | Producenten, direkt eller via indexeringsagent | Lokaliseringstjänsten | Övergångsadaptern |
| Underlag för var | Producentens egen registrering | eHM:s patientindex | Dagens engagemangsindex |
| Underlag för vad och när | Producentens registrering enligt tjänstens topics | Riktad fråga till källan, färskhållen med prenumeration eller tidsgräns | Engagemangsposterna |
| Vad som krävs av källan | Registrera ändringar, eller stödja prenumeration för indexeringsagenten | Svara på en enhetlig, billig riktad fråga; helst stödja prenumeration | Inget nytt |
| Hur ett fel visar sig | Saknad post, alltså en tyst lucka | En extra fråga, och om källan inte svarar ett ofullständigt svar | Som i dagens engagemangsindex |
| Typiskt användningsområde | Källor som själva vill och kan hålla indexet aktuellt | Källor med FHIR-stöd, när vårdgivarna bara ska registrera hos eHM | RIV-TA-källor, bland annat bakom EHDS-bryggan |
| `meta.tag` | `producer` | `cache` | `mirror` |
{:.grid}

### Val per tjänst

Tjänsteägaren beslutar, tillsammans med Inera, vilka försörjningssätt tjänsten använder. En tjänst kan kombinera dem per endpoint, till exempel spegling för RIV-TA-källor och Inera-försörjd cache för FHIR-källor. Samma kombination av patient, endpoint och tjänst får bara fyllas med ett försörjningssätt åt gången, så att konsumenterna aldrig ser dubbla poster.

Tjänstens läsmönster begränsar valet. En tjänst vars systemkonsumenter håller en lokal kopia av innehåll aktuell, till exempel läkemedelsordinationer eller uppmärksamhetsinformation, behöver producentregistrering eller spegling. Inera-försörjd cache fylls bara när någon söker. Se läsmönster per tjänst under [Spärr, loggning och behörighet](security.html).

Försörjningssättet framgår av postens `meta.tag` ur [kodsystemet för försörjningssätt](CodeSystem-IneraIndexPopulationMethodCodeSystem.html). FHIR-EI sätter det. Den som felsöker eller stämmer av kan se var en post kommer ifrån; konsumenterna behöver inte bry sig om det.

### Gemensamma regler

| Regel | Innebörd |
|---|---|
| Samma betydelse | `contentLastUpdated` är tidpunkten för den senaste händelse som uppfyller tjänstens topic, oavsett försörjningssätt |
| Samma livscykel | En post dras in med status och `deregistrationReason`, aldrig med radering, och notiser skickas på samma sätt |
| Samma identitetsregler | Den registrerande parten identifieras med sin endpoint i tjänstekatalogen och skriver i sin egen namnrymd; se [REST-interaktioner och sökparametrar](rest-interactions.html) |
| Synliga fel | Ett känt fel i försörjningen redovisas som ett ofullständigt svar, inte som en tom träfflista; se [Förväntade svar](expected-responses.html) |
{:.grid}

---

### Producentregistrering

Producenten registrerar själv eller via en indexeringsagent.

| Väg | För vem | Vad producenten behöver |
|---|---|---|
| Direkt registrering | Producenter som själva vill hantera indexet | Upptäcka ändringar enligt tjänstens topics, skicka villkorad `PUT` och sköta omförsök, ordning och avregistrering; se [REST-interaktioner och sökparametrar](rest-interactions.html) |
| Indexeringsagent | Producenter med en FHIR-server | Stöd för FHIR Subscriptions och tjänstens topics; inget annat |
{:.grid}

#### Indexeringsagenten

Agenten låter en producent bidra till indexet med enbart standard-FHIR. Indexlogiken implementeras en gång, i agenten, i stället för hos varje producent.

1. Producentens FHIR-server stöder tjänstens `SubscriptionTopic`, en per informationsmängd. Det är standard i R5 och finns för R4 via Subscriptions Backport. Vilka topics en tjänst har står i tjänstens IG; se [Indexposten](information-model.html).
2. Agenten prenumererar med `content = empty` eller `id-only`. Notisens `focus` och `additionalContext` (i `SubscriptionStatus.notificationEvent`) pekar på resursen och patienten, så agenten läser aldrig journalinnehållet.
3. Agenten översätter varje händelse till en indexpost, enligt tabellen nedan.
4. Agenten sköter det som är svårt att få rätt hos varje producent: omförsök tills FHIR-EI kvitterat, ordning per post, avregistrering, kön för ej levererbara händelser och avstämning per dag.

| Element i indexposten | Källa |
|---|---|
| `type`, `content.profile` | Vilket topic händelsen gäller |
| `subject` | Patienten i notisens `additionalContext` |
| `sourceEndpoint`, `registeringProducer`, `identifier.system` | Producentens endpoint i tjänstekatalogen, ur agentens konfiguration |
| `custodian`, `careUnit` | Agentens konfiguration per producent, eller resursens förvaltare och författare |
| `contentLastUpdated` | Händelsens `timestamp` |
{:.grid}

En agent kan tjäna flera producenter, till exempel en per region eller plattform, och kan placeras nära producenten, som EHDS-bryggans proxy mot tjänsteplattformen. Den autentiserar sig med en token bunden till producentens endpoint i tjänstekatalogen, till exempel enligt SMART Backend Services, så att FHIR-EI:s kontroller av identitet och namnrymd gäller som för en direkt registrering.

Avregistrering kräver att agenten vet när informationen inte längre finns hos producenten. Det kräver antingen att tjänstens topics också uttrycker det, eller att agenten stämmer av mot producenten; se [Öppna frågor](open-issues.html).

---

### Inera-försörjd cache

eHM:s patientindex är auktoritativt för var patienten har vårdrelationer. Ineras lokaliseringstjänst bygger tjänstens indexposter som en cache: den fyller dem lat genom riktade frågor till källorna och håller dem färska med prenumerationer, eller med en tidsgräns där källan saknar stöd för prenumeration. Vårdgivarna registrerar bara hos eHM. Ett fel i försörjningen leder till en extra fråga till källan, inte till en tyst lucka.

Läsning när cacheposten saknas eller är inaktuell:

1. Lokaliseringstjänsten slår upp patientens vårdgivare (organisationsnummer) och journalsystem i eHM:s patientindex.
2. Den slår upp vårdgivarnas endpoints för tjänsten i tjänstekatalogen.
3. Den ställer en riktad fråga till de endpoints som saknas i cachen eller är inaktuella, parallellt, med en tidsgräns och med användarens kontext. Svaret anger vilka informationsmängder som finns för patienten och när de senast ändrades.
4. Den skriver eller uppdaterar indexposterna. En endpoint som uppger att den inte har något för patienten inom tjänsten får sin post indragen med `deregistrationReason` `not-at-source`.
5. FHIR-EI svarar konsumenten. Källor som inte svarade inom tidsgränsen redovisas som ett ofullständigt svar, som i exemplet [Ofullständigt sökresultat](Bundle-SokresultatOfullstandigt.html).

Färskhållning efter första läsningen:

| Källans förmåga | Färskhållning |
|---|---|
| Stöder prenumeration | Lokaliseringstjänsten prenumererar på tjänstens topics för hela endpointen med `id-only`. En notis markerar cacheposten som inaktuell eller uppdaterar `contentLastUpdated`. Luckor i händelseräknaren upptäcks med `$status` och hämtas med `$events`; vid behov ställs den riktade frågan igen |
| Saknar prenumeration | Cacheposten blir inaktuell när tidsgränsen löper ut, och nästa läsning går via den riktade frågan |
{:.grid}

| Element i indexposten | Källa |
|---|---|
| `custodian` | Vårdgivarens organisationsnummer ur eHM:s patientindex |
| `sourceSystem` | Journalsystemet ur eHM:s patientindex |
| `sourceEndpoint`, `content.attachment.url` | Vårdgivarens endpoint för tjänsten i tjänstekatalogen |
| `registeringProducer`, `identifier.system` | Lokaliseringstjänstens egen endpoint i tjänstekatalogen |
| `content.profile`, `contentLastUpdated` | Den riktade frågans svar |
| `careUnit` | Den riktade frågans svar, om det anger vårdenhet; annars utelämnas den |
{:.grid}

Se exemplet [Indexpost fylld av lokaliseringstjänsten](DocumentReference-IndexpostFranLokaliseringstjanst.html).

Den riktade frågan är inte fastställd. Två varianter är möjliga: en egen operation (till exempel `$inventory`, som då definieras i denna IG) eller en `batch`-Bundle med `GET [Resurs]?patient=…&_summary=count` per resurstyp. Frågan är en åtkomst till uppgifter om patienten och ska prövas och loggas hos källan. När en sökning utlöser frågan ställs den med användarens kontext, så att källan prövar och loggar mot användaren. Vid färskhållning finns ingen användare, och frågan och prenumerationen hos källan sker i systemkontext. RIV-TA-källor kan inte svara på frågan utan att hämta innehåll, och försörjs därför med spegling.

Begränsningar:

- eHM:s patientindex anger vårdgivare och journalsystem, inte vårdenhet. Om den riktade frågan inte heller anger vårdenhet saknar posten `careUnit`, och inre spärr kan då inte prövas utifrån indexet; se [Spärr, loggning och behörighet](security.html).
- Första visningen för en patient blir en fan-out till alla källor hos patientens vårdgivare.
- Kvaliteten och täckningsgraden i eHM:s patientindex blir en beroendepunkt som Inera inte styr.
- Lokaliseringstjänsten är den enda försörjningskomponenten i läsflödet. Den skriver via skriv-API:et, och åtkomstlagret anropar den före sökningen i indexkärnan; se [Roller och ansvar](roles-and-responsibilities.html).

---

### Spegling av dagens engagemangsindex

Övergångsadaptern speglar dagens engagemangsindex till FHIR-EI per tjänstedomän. Det är försörjningssättet för RIV-TA-källor, som inte kan svara på en riktad fråga utan att hämta innehåll, bland annat källor bakom EHDS-bryggan.

Adaptern speglar utan egen affärslogik. Ansvaret för att indexposterna är korrekta ligger därför kvar hos källorna, genom deras registrering i dagens engagemangsindex. Adapterns konfiguration per tjänstedomän anger om den ska spegla tjänsten och om dess poster ska dras in. Adaptern skriver aldrig till dagens engagemangsindex.

#### Mappning av Update

Engagemangsposter för samma patient, logiska adress och tjänstedomän slås ihop till en indexpost, med dagens kategorier som informationsmängder. Varje indexpost blir en villkorad `PUT` i en `transaction`, med fältmappningen under [Mappning till profiler](mappings.html).

| Fält | Regel |
|---|---|
| `identifier` | System = adapterns endpoint-URL, som för alla registrerande parter. Värdet bildas deterministiskt ur patient, logisk adress och tjänstedomän, så att samma kombination alltid ger samma post |
| `sourceEndpoint`, `content.attachment.url` | Endpoint och adress enligt adressregistret nedan |
| `logicalAddress` | logicalAddress från engagemangsposterna |
| `sourceSystem` | sourceSystem från de ingående engagemangsposterna |
| `contentLastUpdated` | Den senaste mostRecentContent bland de ingående engagemangsposterna |
| `content.profile[category]` | En Coding per kategori bland de ingående engagemangsposterna |
| Avregistrering | deleteFlag på den sista ingående engagemangsposten ger status `superseded`, `registrationStatus` `withdrawn` och `deregistrationReason` `transition-adapter`, eftersom dagens kontrakt inte bär någon orsak |
| `registeringProducer` | Adapterns egen endpoint i tjänstekatalogen |
| `custodian` | Vårdgivaren, bestämd enligt nästa avsnitt |
{:.grid}

Se exemplet [Indexpost speglad av övergångsadaptern](DocumentReference-IndexpostFranAdapter.html).

#### Vårdgivare i speglade poster

dataController ska ange personuppgiftsansvarig organisation, men sedan 2015 godtas källsystemets HSA-id i fältet. Adaptern mappar därför inte dataController rakt till `custodian`. Spärrkontrollen, kontrollen mot tjänstekatalogen och härledningen av eHM:s patientindex förutsätter alla att `custodian` är en vårdgivare. Adaptern bestämmer vårdgivaren i tur och ordning:

1. dataController, om det är en vårdgivare i tjänstekatalogen.
2. Den logiska adressens organisation i tjänstekatalogen, eller den vårdgivare den hör till via `partOf`.
3. Adapterns vårdgivarregister, för källsystem som bara betjänar en vårdgivare.

Går vårdgivaren inte att bestämma registrerar adaptern inte posten. Den läggs i kön för manuell hantering, och andelen sådana poster ingår i avstämningen före läge 2; se [Händelsemodell och övergång](event-model.html). Bakgrunden står under [Rättslig grund och ändamål](legal-basis.html).

#### Adressregister i adaptern

Tjänstekatalogen har ingen endpoint per logisk adress. Där är den logiska adressen en organisations HSA-id, och organisationen listar sina endpoints i `Organization.endpoint`. Tjänstekatalogen har inte heller TAK:s uppgift om vilken logisk adress och vilket tjänstekontrakt som routas till vilken producent. Adaptern håller därför ett eget adressregister, byggt genom att samköra TAK med tjänstekatalogen:

| Nyckel | Värde |
|---|---|
| Logisk adress och tjänstedomän (via tjänstekontrakt i TAK) | Endpoint i tjänstekatalogen som posten ska peka på |
{:.grid}

Två varianter är möjliga för värdet:

1. **Tjänsteplattformens endpoint för tjänstekontraktet.** Konsumenten anropar tjänsteplattformen med RIV-TA och anger postens `logicalAddress`.
2. **EHDS-bryggans FHIR-yta för vårdgivaren** (`/fhir/{vg-hsa-id}/`). Konsumenten hämtar informationen med FHIR, och bryggan översätter till RIV-TA. Bryggan använder vårdgivarens HSA-id som logisk adress, medan dagens engagemangsposter kan ha vårdenhetens eller källsystemets. Det måste stämmas av mot TAK innan varianten används.

Samma tanke finns i EHDS-bryggan, som håller ett eget register från vårdgivare till endpoint.

#### Överlämning

När en källa går från spegling till producentregistrering eller Inera-försörjd cache för en tjänst får dess poster en ny registrerande part, och ofta en ny endpoint. Adressregistret markerar då kombinationen av källsystem och tjänstedomän som överlämnad. Adaptern drar in sina poster för kombinationen med `deregistrationReason` `transition-adapter` och slutar spegla den. Annars skulle konsumenterna se två poster för samma information. Prenumeranter ser en avregistrering och en ny registrering. Om det behövs en operation som flyttar ägarskapet i stället är en [öppen fråga](open-issues.html).
