// One engagement post, exposed as an R5 DocumentReference in the pointer style of NHS
// England's National Record Locator. A post comes either from today's engagement index (EI),
// read-only, or from EI-on-FHIR's own register, where FHIR producers write. One resource per
// post, no merging. See the page Engagemangsposten for the field mapping.
Profile: IneraEngagement
Parent: DocumentReference
Id: IneraEngagement
Title: "Engagemangspost"
Description: "En engagemangspost, exponerad som DocumentReference. Posten pekar ut att ett källsystem har information om en patient inom en tjänstedomän, och hur den hämtas: med RIV-TA via tjänsteplattformen och en logisk adress, eller med FHIR från en endpoint. Den bär inget journalinnehåll. Posten kommer antingen från engagemangsindex (EI) eller från EI-on-FHIR:s eget register för FHIR-producenter. En resurs motsvarar en post, utan sammanslagning."
* insert IneraMetadata(IneraEngagement)
* obeys inera-ei-patient-identifier and inera-ei-riv-ta

* meta.lastUpdated 1..1 MS
* meta.lastUpdated ^short = "När posten senast ändrades (updateTime i EI)"

* extension contains
    LogicalAddress named logicalAddress 0..1 MS and
    SourceSystem named sourceSystem 1..1 MS and
    MostRecentContent named mostRecentContent 0..1 MS and
    Owner named owner 1..1 MS
* extension[logicalAddress] ^short = "Logisk adress. Krävs för RIV-TA, och anges för FHIR när samma källa också svarar på tjänstekontraktet"
* extension[owner] ^short = "Var posten förvaltas: EI eller EI-on-FHIR:s register"

* identifier 1..1 MS
* identifier ^short = "Källsystemets id för informationen (businessObjectInstanceIdentifier); unikt tillsammans med sourceSystem"
* identifier.value 1..1 MS

* status MS
* status from IneraEngagementStatusValueSet (required)
* status ^short = "current för en registrerad post, superseded för en borttagen post under borttagsloggens lagringstid"
* docStatus 0..0

* type 1..1 MS
* type from IneraServiceDomainValueSet (required)
* type ^short = "Tjänstedomän (serviceDomain)"
* type.coding 1..1 MS
* type.coding.system 1..1 MS
* type.coding.code 1..1 MS

* category 0..1 MS
* category from IneraEngagementCategoryValueSet (required)
* category ^short = "Kategori inom tjänstedomänen (categorization)"

* subject 1..1 MS
* subject only Reference(Patient)
* subject ^short = "Patienten (registeredResidentIdentification), som logisk referens med personnummer eller samordningsnummer"
* subject.reference 0..0
* subject.identifier 1..1 MS
* subject.identifier.system 1..1 MS
* subject.identifier.value 1..1 MS

* date 1..1 MS
* date ^short = "När posten skapades (creationTime i EI)"

* author 0..0
* attester 0..0

* custodian 1..1 MS
* custodian only Reference(Organization)
* custodian ^short = "Personuppgiftsansvarig organisation (dataController i EI), som logisk referens med HSA-id"
* custodian ^comment = "I poster från EI ofta vårdgivarens HSA-id, men sedan migreringen från NPÖ:s index godtar EI också källsystemets HSA-id. I poster från EI-on-FHIR:s register är custodian alltid en vårdgivare. En konsument som behöver vårdgivaren, till exempel synken till eHM:s patientindex, kan därför inte lita på custodian i poster från EI."
* custodian.reference 0..0
* custodian.identifier 1..1 MS
* custodian.identifier.system 1..1 MS
* custodian.identifier.system = $hsaid
* custodian.identifier.value 1..1 MS

* relatesTo 0..0
* description 0..0
* securityLabel 0..0

* content 1..1 MS
* content ^short = "Hur innehållet hämtas: med RIV-TA via tjänsteplattformen och postens logiska adress, eller med FHIR från endpointen i attachment.url"
* content obeys inera-ei-riv-ta-content and inera-ei-fhir
* content.profile 1..1 MS
* content.profile.value[x] only Coding
* content.profile.valueCoding from IneraRetrievalProtocolValueSet (required)
* content.profile ^short = "Hämtningsprotokoll som Coding: riv-ta eller fhir"
* content.attachment.contentType 1..1 MS
* content.attachment.contentType ^short = "application/xml för RIV-TA, application/fhir+json för FHIR"
* content.attachment.data 0..0
* content.attachment.url 0..1 MS
* content.attachment.url ^short = "FHIR-endpointens bas-URL, som den står i tjänstekatalogen. Bara för FHIR"

* context 0..0

Invariant: inera-ei-patient-identifier
Description: "Patienten anges med personnummer eller samordningsnummer."
Expression: "subject.identifier.system = 'http://electronichealth.se/identifier/personnummer' or subject.identifier.system = 'http://electronichealth.se/identifier/samordningsnummer'"
Severity: #error

Invariant: inera-ei-riv-ta
Description: "En RIV-TA-post har logisk adress."
Expression: "content.profile.where(value.ofType(Coding).code = 'riv-ta').exists() implies extension('https://fhir.inera.se/ig/engagementindex/StructureDefinition/LogicalAddress').exists()"
Severity: #error

Invariant: inera-ei-riv-ta-content
Description: "En RIV-TA-post har innehållstypen application/xml och ingen URL."
Expression: "profile.where(value.ofType(Coding).code = 'riv-ta').exists() implies (attachment.contentType = 'application/xml' and attachment.url.empty())"
Severity: #error

Invariant: inera-ei-fhir
Description: "En FHIR-post har innehållstypen application/fhir+json och endpointens bas-URL."
Expression: "profile.where(value.ofType(Coding).code = 'fhir').exists() implies (attachment.contentType = 'application/fhir+json' and attachment.url.exists())"
Severity: #error
