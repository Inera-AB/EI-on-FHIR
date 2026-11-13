En engagemangspost i EI blir en resurs enligt profilen [Engagemangspost](StructureDefinition-IneraEngagement.html), en profil av `DocumentReference`. API:et slår inte ihop poster: varje post i EI blir en resurs, och varje resurs motsvarar en post.

Posten är en pekare, som i NHS Englands National Record Locator. Den säger att ett källsystem har information om en patient inom en tjänstedomän, och vilken logisk adress som ska användas för att hämta den. Den bär inget journalinnehåll. Till skillnad från NRL pekar posten inte ut innehållet med en URL, utan med logisk adress och tjänstedomän, som konsumenten använder mot tjänsteplattformen.

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
| creationTime | `date` | När posten skapades i EI |
| updateTime | `meta.lastUpdated` | När posten senast ändrades i EI |
| Borttagen post | `status` = `superseded` | Bara under borttagsloggens lagringstid; se [API](api.html) |
| – | `status` = `current` | Posten finns i EI |
| – | `id` | Stabilt, härlett ur EI:s nyckel för posten. Konsumenter ska inte tolka det |
| – | `content.attachment.contentType` | Alltid `application/xml`: innehållet hämtas med RIV-TA |
{:.grid}

### Identifierare

EI anger HSA-id med RIV-TA:s OID `1.2.752.129.2.1.4.1`. API:et anger det med systemet `urn:oid:1.2.752.29.4.19`, som HL7 Swedens basprofiler och tjänstekatalogen, och tar emot båda i sökningar. Personnummer och samordningsnummer anges med OID:er i EI och med HL7 Swedens URI:er i API:et, som i EHDS-bryggan.

### Tidpunkter

EI:s tidsstämplar saknar tidszon. API:et tolkar dem som svensk tid och anger dem med tidszon, till exempel `2026-11-02T14:32:10+01:00`.

### Vårdgivaren i custodian

dataController ska ange personuppgiftsansvarig organisation, men sedan migreringen från NPÖ:s index 2015 godtar EI också källsystemets HSA-id i fältet. `custodian` är därför inte alltid en vårdgivare. API:et återger fältet som det står i EI. En konsument som behöver vårdgivaren, som synken till eHM:s patientindex, får slå upp den; se [Synk till eHM:s patientindex](ehm-sync.html) och exemplet [Engagemangspost med källsystemet som personuppgiftsansvarig](DocumentReference-EngagemangspostKallsystemSomPuA.html).

### Exempel

- [Aktuell engagemangspost](DocumentReference-EngagemangspostAktuell.html)
- [Engagemangspost med källsystemet som personuppgiftsansvarig](DocumentReference-EngagemangspostKallsystemSomPuA.html)
- [Borttagen engagemangspost](DocumentReference-EngagemangspostBorttagen.html)
