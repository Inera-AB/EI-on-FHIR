Fem roller deltar i [användningsfallen](use-cases.html), plus de tjänster för spärr, loggning och säkerhet som FHIR-EI anropar.

| Roll | Ansvar |
|---|---|
| FHIR-EI | Lagrar indexposter och källsystemens endpoints. Är sin egen åtkomstkontrollpunkt: kontrollerar spärrar, filtrerar och loggar alla konsumentanrop. Auktoriserar producenternas skrivningar. Skickar notiser till prenumeranter |
| Producent | Registrerar, uppdaterar och tar bort indexposter för sitt källsystem, så att indexet speglar vilken information källsystemet håller. Försöker igen tills FHIR-EI kvitterat |
| Adapter | Under övergången: speglar dagens engagemangsindex till FHIR-EI, gör grundladdningen och skriver tillbaka FHIR-registrerade poster till dagens index |
| Konsument | Söker i eller prenumererar på indexet för en patient, inom sitt uppdrag och syfte. Hämtar informationen från källsystemen |
| Systemkonsument | Gör massuttag för grundladdning och återsynk, till exempel en framtida synk till eHM:s patientindex |
{:.grid}

### Förväntningar

| Roll | Förväntning |
|---|---|
| FHIR-EI | SHALL uppfylla [CapabilityStatement för FHIR-EI](CapabilityStatement-IneraEngagementIndexServer.html) |
| Producent | SHALL registrera poster som uppfyller [Indexpost](StructureDefinition-IneraEngagementIndexEntry.html), med villkorad uppdatering och villkorat borttag på `identifier` |
| Producent | SHALL ange `mostRecentContent` med minst sekundprecision, så att ordningen per post kan avgöras |
| Producent | SHALL försöka igen tills FHIR-EI kvitterat, och lägga ej levererbara händelser i en kö för manuell hantering |
| Konsument | SHALL skicka åtkomstkontext i varje anrop; se [Spärr, loggning och behörighet](security.html) |
| Konsument | SHALL kunna hantera alla kodningsnivåer i `type` som den inte förstår genom att ignorera dem |
| Adapter | SHALL mappa Update till villkorad `PUT` eller `DELETE` i en `transaction`; se [Händelsemodell och övergång](event-model.html) |
{:.grid}

Vem som svarar för att en indexpost är korrekt när den härrör från adaptern är en [öppen fråga](open-issues.html).
