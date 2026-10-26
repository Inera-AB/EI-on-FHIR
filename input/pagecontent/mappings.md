Denna sida visar hur fälten i dagens engagemangsindex motsvaras av element i [Indexpost](StructureDefinition-IneraEngagementIndexEntry.html) och [Källsystemets endpoint](StructureDefinition-IneraEngagementIndexEndpoint.html). Adaptern följer mappningen när den speglar dagens index; se [Händelsemodell och övergång](event-model.html).

---

### Engagemangspost → Indexpost

| Fält i engagemangsindex idag | FHIR-element | Kommentar |
|---|---|---|
| registeredResidentIdentification | `EpisodeOfCare.patient.identifier` | Logisk referens med personnummer eller samordningsnummer |
| serviceDomain | `EpisodeOfCare.type[serviceDomain]` | [Tjänstedomäner](CodeSystem-IneraServiceDomainCodeSystem.html) |
| categorization | `EpisodeOfCare.type[category]` | [Kategorier inom tjänstedomän](CodeSystem-IneraEngagementCategoryCodeSystem.html) |
| logicalAddress | Extension [sourceEndpoint](StructureDefinition-SourceEndpoint.html) → `Endpoint.address` | EpisodeOfCare saknar endpoint-element. För RIV-TA-källor är adressen den logiska adressen, för FHIR-källor källans FHIR-bas |
| businessObjectInstanceIdentifier | `EpisodeOfCare.identifier[sourceEntryId]` | Producentens id för posten; nyckel för idempotent uppdatering |
| sourceSystem | `Endpoint.identifier[sourceSystem]` | Källsystemets HSA-id; se avvikelser |
| dataController | `EpisodeOfCare.managingOrganization.identifier` | Vårdgivare (personuppgiftsansvarig), HSA-id |
| careUnitId | Extension [careUnit](StructureDefinition-CareUnit.html) | Vårdenhet, HSA-id |
| owner | `EpisodeOfCare.meta.source` | Registrerande system; styr skrivbehörighet. Sätts av FHIR-EI |
| mostRecentContent | Extension [mostRecentContent](StructureDefinition-MostRecentContent.html) | Senaste ändring av innehållet i källan |
| updateTime / creationTime | `EpisodeOfCare.meta.lastUpdated`, `_history` | Postens egen livscykel |
| clinicalProcessInterestId | `EpisodeOfCare.identifier[clinicalProcessInterestId]` | Behålls för spårbarhet under övergången |
| deleteFlag | `DELETE`-interaktion | Se [Händelsemodell och övergång](event-model.html) |
{:.grid}

`EpisodeOfCare.status` är alltid `active`. Övriga statusvärden används inte för borttag, eftersom borttag måste kunna propageras entydigt.

---

### Avvikelser från specutkastet

Utkastet lämnade några val öppna eller formulerade dem på ett sätt som inte går att uttrycka direkt i FHIR. IG:n har gjort följande val:

| Område | Val i IG:n | Skäl |
|---|---|---|
| sourceSystem | Källsystemets HSA-id ligger på `Endpoint.identifier`, inte i `EpisodeOfCare.identifier.system` | `identifier.system` är en URI och kan inte bära ett HSA-id. Endpoint representerar källsystemets gränssnitt och är den naturliga platsen |
| Identifierare | Skivorna på `identifier` skiljs åt med `type`, inte `system` | Systemet för producentens id skiljer sig mellan källsystem och kan inte användas som diskriminator |
| Sökning på patient | `patient:identifier=` | Utkastets `patient.identifier=` är inte giltig FHIR-söksyntax. Modifieraren `:identifier` är standard i R4 |
| Filter på vårdgivare | Sökparametern heter `organization` | Det är R4:s namn för sökning på `EpisodeOfCare.managingOrganization` |
| Profil-id | `IneraEngagementIndexEntry` i stället för `inera-engagement-index-entry` | Ineras profileringsanvisning: id samma som namn |
| Förbjudna element | `diagnosis`, `referralRequest`, `careManager`, `team`, `account` och `statusHistory` är 0..0 | Principen pekare, inte innehåll |
| mostRecentContent | Minst sekundprecision krävs | Ordningen per post avgörs av tidpunkten |
| Äldre uppdatering | Ignoreras med `200 OK` och oförändrad version | Se [Händelsemodell och övergång](event-model.html) |
| Notisinnehåll | `id-only` är fast, inte bara standard | Säkerhetsavsnittet förutsätter `id-only` för att notiser inte ska läcka spärrad information |
| Sökning utan patient | Avvisas; massuttag sker med `$export` | Indexet är självt skyddsvärd information, och en konsument söker inom en patients vård |
| Borttag vid återsynk | `$export` med `_since` SHALL fylla i `deleted` i manifestet | Bulk Data gör det bara till SHOULD, men återsynken behöver se borttag |
{:.grid}
