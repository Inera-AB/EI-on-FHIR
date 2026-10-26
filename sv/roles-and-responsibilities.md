# Roller och ansvar - FHIR-baserat engagemangsindex (FHIR-EI) v0.1.0

## Roller och ansvar

Sex roller deltar i [användningsfallen](use-cases.md), plus de tjänster för spärr, loggning och säkerhet som FHIR-EI anropar.

| | |
| :--- | :--- |
| FHIR-EI | Lagrar indexposter. Är sin egen åtkomstkontrollpunkt: kontrollerar behörighet och spärrar, filtrerar och loggar alla anrop. Auktoriserar producenternas skrivningar mot den autentiserade producentidentiteten. Skickar notiser till prenumeranter och håller händelselogg och gravstenar under sina lagringstider |
| Producent | Registrerar, uppdaterar och avregistrerar indexposter, så att indexet speglar vilken information producenten håller. Identifieras med sin endpoint i tjänstekatalogen. Försöker igen tills FHIR-EI kvitterat |
| Övergångsadapter | Speglar dagens engagemangsindex till FHIR-EI utan egen affärslogik, gör grundladdningen och skriver tillbaka FHIR-registrerade poster till dagens index. Har ombudsroll och håller ett adressregister från logisk adress och tjänstedomän till endpoint |
| Konsument | Söker i eller prenumererar på indexet för en patient, inom sitt uppdrag och syfte. Stämmer av efter avbrott. Hämtar informationen från producenternas endpoints |
| Systemkonsument | Gör massuttag för grundladdning och återsynk, till exempel en framtida synk till eHM:s patientindex |
| Tjänsteägare | Publicerar tjänstens tillämpning av indexprofilen i tjänstens IG |

Tjänstekatalogen är auktoritativ för producenternas endpoints, och för vilka vårdgivare som listar dem.

### Förväntningar

| | |
| :--- | :--- |
| FHIR-EI | SHALL uppfylla[CapabilityStatement för FHIR-EI](CapabilityStatement-IneraIndexServer.md) |
| Producent | SHALL registrera poster som uppfyller[Indexpost](StructureDefinition-IneraIndexEntry.md)och tjänstens tillämpning, med villkorad uppdatering på`identifier` |
| Producent | SHALL avregistrera med villkorad uppdatering till status`superseded`eller`entered-in-error`och ange`deregistrationReason`; aldrig med delete |
| Producent | SHALL NOT ändra`identifier`eller`registeringProducer`på en befintlig post |
| Producent | SHALL använda sin endpoint-URL i tjänstekatalogen som`identifier.system`och`registeringProducer` |
| Producent | SHALL ange`logicalAddress`när endpointen adresseras med logisk adress |
| Producent | SHALL försöka igen tills FHIR-EI kvitterat, och lägga ej levererbara händelser i en kö för manuell hantering |
| Konsument | SHALL skicka åtkomstkontext i varje anrop; se[Spärr, loggning och behörighet](security.md) |
| Konsument | SHALL deduplicera notiser och ignorera en notis om en äldre version än den den redan har; se[Händelsemodell och övergång](event-model.md) |
| Konsument | SHALL ignorera kodningar i`type`och`content.profile`som den inte förstår |
| Tjänsteägare | SHALL publicera tillämpningen som en profil med[Indexpost](StructureDefinition-IneraIndexEntry.md)som förälder |

### Ansvar under övergången

Adaptern speglar dagens engagemangsindex utan egen affärslogik. Ansvaret för att indexposterna är korrekta ligger därför kvar hos producenterna, genom deras registrering i dagens engagemangsindex.

