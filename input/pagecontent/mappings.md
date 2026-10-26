Denna sida visar hur den logiska modellen för indexposten motsvaras av element i [Indexpost](StructureDefinition-IneraIndexEntry.html) och av fälten i dagens engagemangsindex. Övergångsadaptern följer mappningen när den speglar dagens index; se [Händelsemodell och övergång](event-model.html).

---

### Logisk modell → Indexpost

| Element | FHIR R5 DocumentReference | Dagens engagemangsindex |
|---|---|---|
| Identitet | `identifier`, stabil och producentbunden: `system` = producentens namnrymd, `value` = producentens id för posten | businessObjectInstanceIdentifier, sourceSystem |
| Patient | `subject` → Patient, som logisk referens med `identifier` (personnummer, samordningsnummer) | registeredResidentIdentification |
| Tjänst | `type`: tjänstedomän under övergången, IG:ns canonical därefter | serviceDomain |
| Informationsmängder | `content.profile`: dagens kategori som Coding, profilens canonical därefter | categorization |
| Endpoint | Extension [sourceEndpoint](StructureDefinition-SourceEndpoint.html) → Endpoint i tjänstekatalogen, en per post; `content.attachment.url` = endpointens adress | logicalAddress |
| Vårdgivare | `custodian`, som logisk referens med HSA-id | dataController |
| Vårdenhet | Extension [careUnit](StructureDefinition-CareUnit.html) (HSA-id) | careUnitId |
| Registrerande producent | Extension [registeringProducer](StructureDefinition-RegisteringProducer.html) (HSA-id); sätts och kontrolleras av FHIR-EI mot autentiserad klient | owner |
| Innehållets senaste ändring | Extension [contentLastUpdated](StructureDefinition-ContentLastUpdated.html) (dateTime) | mostRecentContent |
| Postens senaste ändring | `meta.lastUpdated`, `_history` | updateTime, creationTime |
| Status | `status` + extensions [registrationStatus](StructureDefinition-RegistrationStatus.html) och [deregistrationReason](StructureDefinition-DeregistrationReason.html) | deleteFlag |
{:.grid}

`meta.source` används bara för spårbarhet. Konsumenter känner igen indexposter på `meta.profile`.

---

### Val i IG:n

Specen lämnade några detaljer öppna eller formulerade dem på ett sätt som inte går att uttrycka direkt i FHIR. IG:n har gjort följande val:

| Område | Val i IG:n | Skäl |
|---|---|---|
| Sökning på patient | `patient:identifier=` i stället för kedjad `patient.identifier=` | Indexet har inga Patient-resurser; patienten är en logisk referens. En kedjad sökning kräver att referensen kan lösas upp till en Patient i FHIR-EI. Modifieraren `:identifier` söker direkt på referensens identifierare. Profilen kräver `subject.type = Patient`, så att servern kan avgöra att referensen gäller en patient |
| Vårdgivare i sökning och filter | `custodian:identifier=` | Samma skäl: vårdgivaren är en logisk referens |
| Registrerande producent | `valueIdentifier` med producentens HSA-id | Specen angav inte datatyp |
| Profil-id | `IneraIndexEntry` i stället för `inera-index-entry` | Ineras profileringsanvisning: id samma som namn |
| Förbjudna element | `description`, `event`, `bodySite`, `context`, `basedOn`, `attester` och `content.attachment.data` är 0..0 | Principen pekare, inte innehåll |
| Tjänstens kodning | Minst en av `type.coding[serviceDomain]` och `type.coding[implementationGuide]` | En kodning per generation, och tjänsten är obligatorisk |
| Innehållets senaste ändring | Minst sekundprecision krävs | Ordningen per post avgörs av tidpunkten |
| Äldre uppdatering | Ignoreras med `200 OK` och oförändrad version | Specen säger att den ignoreras; ett felsvar skulle få en producent med minst-en-leverans att försöka igen |
| Notisinnehåll | `id-only` är fast, inte bara standard | Säkerhetsavsnittet förutsätter `id-only` för att notiser inte ska läcka spärrad information |
| Orsak vid adapteravregistrering | Koden `transition-adapter` | Specen anger att adaptern sätter en egen kod |
{:.grid}
