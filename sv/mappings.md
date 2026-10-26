# Mappning till profiler - FHIR-baserat engagemangsindex (FHIR-EI) v0.1.0

## Mappning till profiler

Denna sida visar hur den logiska modellen för indexposten motsvaras av element i [Indexpost](StructureDefinition-IneraIndexEntry.md) och av fälten i dagens engagemangsindex. Övergångsadaptern följer mappningen när den speglar dagens index; se [Händelsemodell och övergång](event-model.md).

-------

### Logisk modell → Indexpost

| | | |
| :--- | :--- | :--- |
| Identitet | `identifier`, stabil och producentbunden:`system`= producentens endpoint-URL i tjänstekatalogen,`value`= producentens id för posten | businessObjectInstanceIdentifier |
| Patient | `subject`→ Patient, som logisk referens med`identifier`(personnummer, samordningsnummer) | registeredResidentIdentification |
| Tjänst | `type`: tjänstedomän under övergången, IG:ns canonical därefter | serviceDomain |
| Informationsmängder | `content.profile`: dagens kategori som Coding, profilens canonical därefter | categorization |
| Endpoint | Extension[sourceEndpoint](StructureDefinition-SourceEndpoint.md)→ Endpoint i tjänstekatalogen, en per post;`content.attachment.url`= endpointens adress | logicalAddress, via adapterns adressregister |
| Logisk adress | Extension[logicalAddress](StructureDefinition-LogicalAddress.md)(HSA-id), när endpointen adresseras med logisk adress | logicalAddress |
| Källsystem | Extension[sourceSystem](StructureDefinition-SourceSystem.md)(HSA-id), satt av övergångsadaptern | sourceSystem |
| Vårdgivare | `custodian`, som logisk referens med HSA-id | dataController |
| Vårdenhet | Extension[careUnit](StructureDefinition-CareUnit.md)(HSA-id) | careUnitId |
| Registrerande producent | Extension[registeringProducer](StructureDefinition-RegisteringProducer.md): absolut referens till producentens Endpoint i tjänstekatalogen; kontrolleras av FHIR-EI mot autentiserad klient | owner |
| Innehållets senaste ändring | Extension[contentLastUpdated](StructureDefinition-ContentLastUpdated.md)(dateTime) | mostRecentContent |
| Postens senaste ändring | `meta.lastUpdated`,`_history` | updateTime, creationTime |
| Status | `status`+ extensions[registrationStatus](StructureDefinition-RegistrationStatus.md)och[deregistrationReason](StructureDefinition-DeregistrationReason.md) | deleteFlag |

`meta.source` används bara för spårbarhet. Konsumenter känner igen indexposter på `meta.profile`.

-------

### Val i IG:n

Specen lämnade några detaljer öppna eller formulerade dem på ett sätt som inte går att uttrycka direkt i FHIR. IG:n har gjort följande val:

| | | |
| :--- | :--- | :--- |
| Sökning på patient | `patient:identifier=`i stället för kedjad`patient.identifier=` | Indexet har inga Patient-resurser; patienten är en logisk referens. En kedjad sökning kräver att referensen kan lösas upp till en Patient i FHIR-EI. Modifieraren`:identifier`söker direkt på referensens identifierare. Profilen kräver`subject.type = Patient`, så att servern kan avgöra att referensen gäller en patient |
| Vårdgivare i sökning och filter | `custodian:identifier=` | Samma skäl: vårdgivaren är en logisk referens |
| HSA-id-system | `urn:oid:1.2.752.29.4.19`, som i HL7 Swedens basprofiler och tjänstekatalogen. FHIR-EI SHALL även ta emot RIV-TA:s`urn:oid:1.2.752.129.2.1.4.1`och lagra värdet med basprofilernas system | Samma identifierarrymd har två OID:er. Specen ska bygga på svenska basprofiler, och EHDS-bryggan behandlar redan båda som samma rymd |
| Profil-id | `IneraIndexEntry`i stället för`inera-index-entry` | Ineras profileringsanvisning: id samma som namn |
| Förbjudna element | `description`,`event`,`bodySite`,`context`,`basedOn`,`attester`och`content.attachment.data`är 0..0 | Principen pekare, inte innehåll |
| Tjänstens kodning | Minst en av`type.coding[serviceDomain]`och`type.coding[implementationGuide]` | En kodning per generation, och tjänsten är obligatorisk |
| Innehållets senaste ändring | Minst sekundprecision krävs | Ordningen per post avgörs av tidpunkten |
| Äldre uppdatering | Ignoreras med`200 OK`och oförändrad version | Specen säger att den ignoreras; ett felsvar skulle få en producent med minst-en-leverans att försöka igen |
| Notisinnehåll | `id-only`är fast, inte bara standard | Säkerhetsavsnittet förutsätter`id-only`för att notiser inte ska läcka spärrad information |
| Orsak vid adapteravregistrering | Koden`transition-adapter` | Specen anger att adaptern sätter en egen kod |

