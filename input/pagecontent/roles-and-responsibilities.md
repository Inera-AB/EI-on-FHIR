Åtta roller deltar i [användningsfallen](use-cases.html), plus de tjänster för spärr, loggning och säkerhet som FHIR-EI anropar. FHIR-EI självt består av två komponenter; se [Komponenter](#komponenter) nedan.

| Roll | Ansvar |
|---|---|
| FHIR-EI | Lagrar indexposter. Är sin egen åtkomstkontrollpunkt vid läsning i användarkontext: kontrollerar spärr, samtycke och syfte, filtrerar och loggar. Prövar systemets behörighet och loggar vid anrop i systemkontext. Auktoriserar de registrerande parternas skrivningar mot den autentiserade identiteten. Skickar notiser till prenumeranter och håller händelselogg och gravstenar under sina lagringstider |
| Producent | Håller informationen och exponerar den via en endpoint. Vid producentregistrering registrerar, uppdaterar och avregistrerar den också indexposter, själv eller via indexeringsagent, och försöker igen tills FHIR-EI kvitterat. Identifieras med sin endpoint i tjänstekatalogen |
| Övergångsadapter | Speglar dagens engagemangsindex till FHIR-EI per tjänstedomän, utan egen affärslogik, och gör grundladdningen. Skriver inte tillbaka till dagens index. Har ombudsroll och håller ett adressregister från logisk adress och tjänstedomän till endpoint |
| Indexeringsagent | Prenumererar på tjänsternas topics hos producenternas FHIR-servrar och registrerar indexposter på producenternas vägnar; se [Försörjning av indexet](population.html) |
| Lokaliseringstjänst | Fyller indexet som en cache utifrån eHM:s patientindex och riktade frågor till källorna, och håller det färskt med prenumerationer eller tidsgräns. Har ombudsroll inom de vårdgivare eHM:s patientindex anger |
| Konsument | Söker i indexet i användarkontext, för en användare och inom dennes uppdrag och syfte. Kan också prenumerera och stämma av efter avbrott, i systemkontext. Hämtar informationen från producenternas endpoints |
| Systemkonsument | Läser i systemkontext: gör massuttag för grundladdning och återsynk, till exempel en framtida synk till eHM:s patientindex, eller håller en lokal kopia av innehåll aktuell. Prövar och loggar per användare när informationen visas |
| Tjänsteägare | Publicerar tjänstens tillämpning av indexprofilen, tjänstens topics och den registrerande partens skyldigheter i tjänstens IG. Beslutar tillsammans med Inera om tjänstens försörjningssätt |
{:.grid}

Tjänstekatalogen är auktoritativ för producenternas endpoints, och för vilka vårdgivare som listar dem.

### Komponenter

FHIR-EI delas efter [åtkomstlägena](security.html), så att varje del kan förstås, testas och förvaltas för sig:

| Komponent | Ansvar | Åtkomstläge |
|---|---|---|
| Indexkärna | Lagrar indexposterna. Skriv-API med livscykel och skrivbehörighet, händelselogg, prenumerationer, inkrementell avstämning och massuttag | Systemkontext |
| Åtkomstlager | Sökning och läsning i användarkontext: spärr, samtycke, syfte, fullmakt, säkerhetsetiketter och loggning. Anropar lokaliseringstjänsten före sökningen i kärnan, för tjänster med Inera-försörjd cache | Användarkontext |
| Försörjningskomponenter | Indexeringsagent, lokaliseringstjänst och övergångsadapter: registrerande parter som skriver via kärnans skriv-API | Systemkontext mot kärnan |
{:.grid}

- Kärnan har ingen logik för spärr, samtycke eller syfte. Den motsvarar i stort NHS Englands National Record Locator, med prenumerationer tillagda. I NRL ansvarar konsumenten för att användaren har rätt att ta del av informationen; FHIR-EI lägger den prövningen i åtkomstlagret.
- Åtkomstlagrets prövning är densamma som EHDS-bryggan och framtida åtkomst till innehåll behöver. Den bör därför bygga på en gemensam beslutstjänst och inte vara specifik för indexet; se [Öppna frågor](open-issues.html).
- Försörjningskomponenterna skriver bara via skriv-API:et, aldrig direkt i kärnan. Kärnan förblir neutral till försörjningen, och en komponent kan läggas till eller avvecklas per tjänst, som övergångsadaptern när övergången är klar.
- Lokaliseringstjänsten är den enda försörjningskomponenten i läsflödet. Åtkomstlagret anropar den med användarens kontext före sökningen i kärnan, och källor som inte svarar inom tidsgränsen redovisas som ett ofullständigt svar.

### Förväntningar

| Roll | Förväntning |
|---|---|
| FHIR-EI | SHALL uppfylla [CapabilityStatement för FHIR-EI](CapabilityStatement-IneraIndexServer.html) |
| Registrerande part | SHALL registrera poster som uppfyller [Indexpost](StructureDefinition-IneraIndexEntry.html) och tjänstens tillämpning, med villkorad uppdatering på `identifier` |
| Registrerande part | SHALL avregistrera med villkorad uppdatering till status `superseded` eller `entered-in-error` och ange `deregistrationReason`; aldrig med delete |
| Registrerande part | SHALL NOT ändra `identifier` eller `registeringProducer` på en befintlig post |
| Registrerande part | SHALL använda sin endpoint-URL i tjänstekatalogen som `identifier.system` och `registeringProducer` |
| Registrerande part | SHALL ange `logicalAddress` när endpointen adresseras med logisk adress |
| Registrerande part | SHALL försöka igen tills FHIR-EI kvitterat, och lägga ej levererbara händelser i en kö för manuell hantering |
| Konsument | SHALL söka och läsa i användarkontext, med åtkomstkontext i varje anrop, när svaret ska visas för en användare; se [Spärr, loggning och behörighet](security.html) |
| Systemkonsument | SHALL pröva och logga per användare när information som den tagit emot i systemkontext visas för en användare |
| Konsument | SHALL deduplicera notiser och ignorera en notis om en äldre version än den den redan har; se [Händelsemodell och övergång](event-model.html) |
| Konsument | SHALL ignorera kodningar i `type` och `content.profile` som den inte förstår |
| Konsument | SHALL kunna visa att uppgifter kan saknas när sökresultatet innehåller en `OperationOutcome`; se [Förväntade svar](expected-responses.html) |
| Lokaliseringstjänst | SHALL bekräfta en inaktuell cachepost mot källan innan den lämnas ut, och SHALL redovisa källor som inte svarat som ett ofullständigt svar |
| Lokaliseringstjänst | SHALL ställa den riktade frågan med användarens kontext när en sökning utlöser den, och SHALL skriva indexposter via skriv-API:et |
| Tjänsteägare | SHALL publicera tillämpningen som en profil med [Indexpost](StructureDefinition-IneraIndexEntry.html) som förälder |
| Tjänsteägare | SHALL publicera en `SubscriptionTopic` per informationsmängd som anger vad som räknas som en ändring, och SHOULD ange producentens skyldigheter med extensionen `obligation`; se [Indexposten](information-model.html) |
| Producent | SHALL NOT sluta uppdatera dagens engagemangsindex för en tjänst förrän tjänstens konsumenter läser FHIR-EI; se [Händelsemodell och övergång](event-model.html) |
| Registrerande part | MAY märka en post med säkerhetsetiketter i `meta.security`, till exempel `NOPAT`; se [Spärr, loggning och behörighet](security.html) |
{:.grid}

### Ansvar under övergången

Ansvaret för att indexposterna är korrekta följer försörjningssättet. Vid producentregistrering ligger det hos producenten. Vid spegling ligger det kvar hos källorna, genom deras registrering i dagens engagemangsindex, eftersom adaptern speglar utan egen affärslogik. Vid Inera-försörjd cache ligger ansvaret för cachen hos Inera, medan vårdgivarna ansvarar för sin registrering hos eHM och källorna för sina svar på den riktade frågan.
