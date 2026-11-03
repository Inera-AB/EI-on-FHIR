# Roller och ansvar - FHIR-baserat engagemangsindex (FHIR-EI) v0.1.0

## Roller och ansvar

Åtta roller deltar i [användningsfallen](use-cases.md), plus de tjänster för spärr, loggning och säkerhet som FHIR-EI anropar.

| | |
| :--- | :--- |
| FHIR-EI | Lagrar indexposter. Är sin egen åtkomstkontrollpunkt: kontrollerar behörighet och spärrar, filtrerar och loggar alla anrop. Auktoriserar producenternas skrivningar mot den autentiserade producentidentiteten. Skickar notiser till prenumeranter och håller händelselogg och gravstenar under sina lagringstider |
| Producent | Håller informationen och exponerar den via en endpoint. Vid producentregistrering registrerar, uppdaterar och avregistrerar den också indexposter, själv eller via indexeringsagent, och försöker igen tills FHIR-EI kvitterat. Identifieras med sin endpoint i tjänstekatalogen |
| Övergångsadapter | Speglar dagens engagemangsindex till FHIR-EI per tjänstedomän, utan egen affärslogik, och gör grundladdningen. Skriver inte tillbaka till dagens index. Har ombudsroll och håller ett adressregister från logisk adress och tjänstedomän till endpoint |
| Indexeringsagent | Prenumererar på tjänsternas topics hos producenternas FHIR-servrar och registrerar indexposter på producenternas vägnar; se[Försörjning av indexet](population.md) |
| Lokaliseringstjänst | Fyller indexet som en cache utifrån eHM:s patientindex och riktade frågor till källorna, och håller det färskt med prenumerationer eller tidsgräns. Har ombudsroll inom de vårdgivare eHM:s patientindex anger |
| Konsument | Söker i eller prenumererar på indexet för en patient, inom sitt uppdrag och syfte. Stämmer av efter avbrott. Hämtar informationen från producenternas endpoints |
| Systemkonsument | Gör massuttag för grundladdning och återsynk, till exempel en framtida synk till eHM:s patientindex |
| Tjänsteägare | Publicerar tjänstens tillämpning av indexprofilen, tjänstens topics och den registrerande partens skyldigheter i tjänstens IG. Beslutar tillsammans med Inera om tjänstens försörjningssätt |

Tjänstekatalogen är auktoritativ för producenternas endpoints, och för vilka vårdgivare som listar dem.

### Förväntningar

| | |
| :--- | :--- |
| FHIR-EI | SHALL uppfylla[CapabilityStatement för FHIR-EI](CapabilityStatement-IneraIndexServer.md) |
| Registrerande part | SHALL registrera poster som uppfyller[Indexpost](StructureDefinition-IneraIndexEntry.md)och tjänstens tillämpning, med villkorad uppdatering på`identifier` |
| Registrerande part | SHALL avregistrera med villkorad uppdatering till status`superseded`eller`entered-in-error`och ange`deregistrationReason`; aldrig med delete |
| Registrerande part | SHALL NOT ändra`identifier`eller`registeringProducer`på en befintlig post |
| Registrerande part | SHALL använda sin endpoint-URL i tjänstekatalogen som`identifier.system`och`registeringProducer` |
| Registrerande part | SHALL ange`logicalAddress`när endpointen adresseras med logisk adress |
| Registrerande part | SHALL försöka igen tills FHIR-EI kvitterat, och lägga ej levererbara händelser i en kö för manuell hantering |
| Konsument | SHALL skicka åtkomstkontext i varje anrop; se[Spärr, loggning och behörighet](security.md) |
| Konsument | SHALL deduplicera notiser och ignorera en notis om en äldre version än den den redan har; se[Händelsemodell och övergång](event-model.md) |
| Konsument | SHALL ignorera kodningar i`type`och`content.profile`som den inte förstår |
| Konsument | SHALL kunna visa att uppgifter kan saknas när sökresultatet innehåller en`OperationOutcome`; se[Förväntade svar](expected-responses.md) |
| Lokaliseringstjänst | SHALL bekräfta en inaktuell cachepost mot källan innan den lämnas ut, och SHALL redovisa källor som inte svarat som ett ofullständigt svar |
| Tjänsteägare | SHALL publicera tillämpningen som en profil med[Indexpost](StructureDefinition-IneraIndexEntry.md)som förälder |
| Tjänsteägare | SHALL publicera en`SubscriptionTopic`per informationsmängd som anger vad som räknas som en ändring, och SHOULD ange producentens skyldigheter med extensionen`obligation`; se[Indexposten](information-model.md) |
| Producent | SHALL NOT sluta uppdatera dagens engagemangsindex för en tjänst förrän tjänstens konsumenter läser FHIR-EI; se[Händelsemodell och övergång](event-model.md) |
| Registrerande part | MAY märka en post med säkerhetsetiketter i`meta.security`, till exempel`NOPAT`; se[Spärr, loggning och behörighet](security.md) |

### Ansvar under övergången

Ansvaret för att indexposterna är korrekta följer försörjningssättet. Vid producentregistrering ligger det hos producenten. Vid spegling ligger det kvar hos källorna, genom deras registrering i dagens engagemangsindex, eftersom adaptern speglar utan egen affärslogik. Vid Inera-försörjd cache ligger ansvaret för cachen hos Inera, medan vårdgivarna ansvarar för sin registrering hos eHM och källorna för sina svar på den riktade frågan.

