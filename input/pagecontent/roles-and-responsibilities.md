Sex roller deltar i [användningsfallen](use-cases.html), plus de tjänster för spärr, loggning och säkerhet som FHIR-EI anropar.

| Roll | Ansvar |
|---|---|
| FHIR-EI | Lagrar indexposter. Är sin egen åtkomstkontrollpunkt: kontrollerar behörighet och spärrar, filtrerar och loggar alla anrop. Auktoriserar producenternas skrivningar mot den autentiserade producentidentiteten. Skickar notiser till prenumeranter och håller händelselogg och gravstenar under sina lagringstider |
| Producent | Registrerar, uppdaterar och avregistrerar indexposter, så att indexet speglar vilken information producenten håller. Försöker igen tills FHIR-EI kvitterat |
| Övergångsadapter | Speglar dagens engagemangsindex till FHIR-EI utan egen affärslogik, gör grundladdningen och skriver tillbaka FHIR-registrerade poster till dagens index |
| Konsument | Söker i eller prenumererar på indexet för en patient, inom sitt uppdrag och syfte. Stämmer av efter avbrott. Hämtar informationen från producenternas endpoints |
| Systemkonsument | Gör massuttag för grundladdning och återsynk, till exempel en framtida synk till eHM:s patientindex |
| Tjänsteägare | Publicerar tjänstens tillämpning av indexprofilen i tjänstens IG |
{:.grid}

Tjänstekatalogen är auktoritativ för producenternas endpoints.

### Förväntningar

| Roll | Förväntning |
|---|---|
| FHIR-EI | SHALL uppfylla [CapabilityStatement för FHIR-EI](CapabilityStatement-IneraIndexServer.html) |
| Producent | SHALL registrera poster som uppfyller [Indexpost](StructureDefinition-IneraIndexEntry.html) och tjänstens tillämpning, med villkorad uppdatering på `identifier` |
| Producent | SHALL avregistrera med villkorad uppdatering till status `superseded` eller `entered-in-error` och ange `deregistrationReason`; aldrig med delete |
| Producent | SHALL NOT ändra `identifier` eller `registeringProducer` på en befintlig post |
| Producent | SHALL försöka igen tills FHIR-EI kvitterat, och lägga ej levererbara händelser i en kö för manuell hantering |
| Konsument | SHALL skicka åtkomstkontext i varje anrop; se [Spärr, loggning och behörighet](security.html) |
| Konsument | SHALL deduplicera notiser och ignorera en notis om en äldre version än den den redan har; se [Händelsemodell och övergång](event-model.html) |
| Konsument | SHALL ignorera kodningar i `type` och `content.profile` som den inte förstår |
| Tjänsteägare | SHALL publicera tillämpningen som en profil med [Indexpost](StructureDefinition-IneraIndexEntry.html) som förälder |
{:.grid}

### Ansvar under övergången

Adaptern speglar dagens engagemangsindex utan egen affärslogik. Ansvaret för att indexposterna är korrekta ligger därför kvar hos producenterna, genom deras registrering i dagens engagemangsindex.
