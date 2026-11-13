En engagemangspost blir en resurs enligt profilen [Engagemangspost](StructureDefinition-IneraEngagement.html), en profil av `DocumentReference`. API:et slår inte ihop poster: varje post blir en resurs, och varje resurs motsvarar en post.

Posten är en pekare, som i NHS Englands National Record Locator. Den säger att ett källsystem har information om en patient inom en tjänstedomän, och hur informationen hämtas. Den bär inget journalinnehåll.

### Två ursprung, två hämtningsprotokoll

| | Post från EI | Post från EI-on-FHIR:s register |
|---|---|---|
| Registreras av | Källa som implementerar tjänstekontraktet, med Update i EI | Källa som implementerar tjänstens FHIR-IG, med `PUT` i EI-on-FHIR |
| Skrivbar via API:et | Nej | Ja, av den producent som äger posten |
| `content.format` | `riv-ta` | `fhir-r4` |
| `content.attachment` | `contentType` `application/xml`, ingen URL | `contentType` `application/fhir+json`, `url` = FHIR-endpointens bas-URL |
| Extension `logicalAddress` | Krävs | Anges om källan också svarar på tjänstekontraktet |
| `custodian` | dataController, som kan vara källsystemets HSA-id | Alltid en vårdgivare |
| Extension `owner` | Det nationella EI | EI-on-FHIR |
{:.grid}

`type` är samma tjänstedomänkod oavsett ursprung. En konsument söker på tjänsten en gång och får båda slagen av poster. Den som bara kan ett protokoll filtrerar med sökparametern `format`.

### När samma källa har båda gränssnitten

En vårdgivare kan ha en källa som svarar både på tjänstekontraktet och på tjänstens FHIR-IG, och som därför har en post i EI och en i registret. Två poster med samma patient, `type` och `logicalAddress` är två vägar till samma information, inte en dubblett:

- En konsument som kan FHIR, till exempel EHDS-bryggan, använder FHIR-posten och hoppar över RIV-TA-anropet för samma patient, tjänstedomän och logiska adress.
- Övriga konsumenter använder RIV-TA-posten.
- Synken till eHM:s patientindex slår ändå ihop poster per patient, vårdgivare och journalsystem, så de två vägarna ger en uppgift där.

Därför ska en FHIR-producent som också svarar på tjänstekontraktet ange samma logiska adress i sin post som i EI. Utan den kan posterna bara matchas på vårdgivare, och i poster från EI är vårdgivaren inte alltid känd.

En källa som går över helt från tjänstekontraktet till FHIR registrerar först sina poster i EI-on-FHIR, och slutar sedan med Update i EI. Annars uppstår ett glapp där engagemanget inte syns. En källa som bara har FHIR syns inte för dagens konsumenter som läser EI med FindContent, men de kan inte heller anropa den.

### Mappning från EI

| Fält i EI | Element i Engagemangspost | Kommentar |
|---|---|---|
| registeredResidentIdentification | `subject.identifier` | Personnummer eller samordningsnummer, med systemen `http://electronichealth.se/identifier/personnummer` och `…/samordningsnummer` |
| serviceDomain | `type` | Kod ur [kodsystemet för tjänstedomäner](CodeSystem-IneraServiceDomainCodeSystem.html) |
| categorization | `category` | Kod ur [kodsystemet för kategorier](CodeSystem-IneraEngagementCategoryCodeSystem.html) |
| logicalAddress | Extension [logicalAddress](StructureDefinition-LogicalAddress.html) | HSA-id |
| businessObjectInstanceIdentifier | `identifier.value` | Källsystemets id för informationen; unikt tillsammans med sourceSystem |
| sourceSystem | Extension [sourceSystem](StructureDefinition-SourceSystem.html) | HSA-id |
| dataController | `custodian.identifier` | HSA-id. Se nedan |
| owner | Extension [owner](StructureDefinition-Owner.html) | HSA-id |
| mostRecentContent | Extension [mostRecentContent](StructureDefinition-MostRecentContent.html) | När informationen ändrades hos källsystemet |
| creationTime | `date` | När posten skapades |
| updateTime | `meta.lastUpdated` | När posten senast ändrades |
| Borttagen post | `status` = `superseded` | Bara under borttagsloggens lagringstid; se [API](api.html) |
| – | `status` = `current` | Posten är registrerad |
| – | `id` | Stabilt, härlett ur EI:s nyckel för posten. Konsumenter ska inte tolka det |
| – | `content.format`, `content.attachment.contentType` | Alltid `riv-ta` och `application/xml` |
{:.grid}

En FHIR-producent fyller i samma element direkt. API:et sätter `id`, `owner`, `date` och `meta.lastUpdated`, och producenten utelämnar dem när den registrerar.

### Identifierare

EI anger HSA-id med RIV-TA:s OID `1.2.752.129.2.1.4.1`. API:et anger det med systemet `urn:oid:1.2.752.29.4.19`, som HL7 Swedens basprofiler och tjänstekatalogen, och tar emot båda i sökningar. Personnummer och samordningsnummer anges med OID:er i EI och med HL7 Swedens URI:er i API:et, som i EHDS-bryggan.

### Tidpunkter

EI:s tidsstämplar saknar tidszon. API:et tolkar dem som svensk tid och anger dem med tidszon, till exempel `2026-11-02T14:32:10+01:00`.

### Vårdgivaren i custodian

dataController ska ange personuppgiftsansvarig organisation, men sedan migreringen från NPÖ:s index 2015 godtar EI också källsystemets HSA-id i fältet. I poster från EI är `custodian` därför inte alltid en vårdgivare, och API:et återger fältet som det står i EI. I poster från registret kräver API:et att `custodian` är en vårdgivare. En konsument som behöver vårdgivaren, som synken till eHM:s patientindex, får slå upp den för poster från EI; se [Synk till eHM:s patientindex](ehm-sync.html) och exemplet [Engagemangspost med källsystemet som personuppgiftsansvarig](DocumentReference-EngagemangspostKallsystemSomPuA.html).

### Exempel

- [Aktuell engagemangspost](DocumentReference-EngagemangspostAktuell.html), från EI
- [Engagemangspost från en FHIR-producent](DocumentReference-EngagemangspostFhir.html), samma källa och logiska adress som föregående
- [Engagemangspost med källsystemet som personuppgiftsansvarig](DocumentReference-EngagemangspostKallsystemSomPuA.html)
- [Borttagen engagemangspost](DocumentReference-EngagemangspostBorttagen.html)
