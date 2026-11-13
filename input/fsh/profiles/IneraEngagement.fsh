// One engagement post in today's engagement index (EI), exposed read-only as an R4
// DocumentReference. One resource per post, no merging, in the pointer style of NHS
// England's National Record Locator. See the page Engagemangsposten for the field mapping.
Profile: IneraEngagement
Parent: DocumentReference
Id: IneraEngagement
Title: "Engagemangspost"
Description: "En post i engagemangsindex (EI), exponerad som DocumentReference. Posten pekar ut att ett källsystem har information om en patient inom en tjänstedomän, och vilken logisk adress som ska användas för att hämta den. Den bär inget journalinnehåll. API:et skapar en resurs per engagemangspost, utan att slå ihop poster."
* insert IneraMetadata(IneraEngagement)
* obeys inera-ei-patient-identifier

* meta.lastUpdated 1..1 MS
* meta.lastUpdated ^short = "När posten senast ändrades i EI (updateTime)"

* extension contains
    LogicalAddress named logicalAddress 1..1 MS and
    SourceSystem named sourceSystem 1..1 MS and
    MostRecentContent named mostRecentContent 0..1 MS and
    Owner named owner 0..1 MS

* masterIdentifier 0..0
* identifier 1..1 MS
* identifier ^short = "Källsystemets id för informationen (businessObjectInstanceIdentifier); unikt tillsammans med sourceSystem"
* identifier.value 1..1 MS

* status MS
* status from IneraEngagementStatusValueSet (required)
* status ^short = "current för en post som finns i EI, superseded för en borttagen post under borttagsloggens lagringstid"
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
* date ^short = "När posten skapades i EI (creationTime)"

* author 0..0
* authenticator 0..0

* custodian 1..1 MS
* custodian only Reference(Organization)
* custodian ^short = "Personuppgiftsansvarig organisation enligt EI (dataController), som logisk referens med HSA-id"
* custodian ^comment = "Ofta vårdgivarens HSA-id, men sedan migreringen från NPÖ:s index godtar EI också källsystemets HSA-id. En konsument som behöver vårdgivaren, till exempel synken till eHM:s patientindex, kan därför inte lita på att custodian är en vårdgivare."
* custodian.reference 0..0
* custodian.identifier 1..1 MS
* custodian.identifier.system 1..1 MS
* custodian.identifier.system = $hsaid
* custodian.identifier.value 1..1 MS

* relatesTo 0..0
* description 0..0
* securityLabel 0..0

* content 1..1 MS
* content ^short = "Innehållet hämtas med RIV-TA via tjänsteplattformen, med postens logiska adress och ett tjänstekontrakt i postens tjänstedomän"
* content.attachment.contentType 1..1 MS
* content.attachment.contentType = #application/xml
* content.attachment.data 0..0
* content.attachment.url 0..0
* content.format 0..0

* context 0..0

Invariant: inera-ei-patient-identifier
Description: "Patienten anges med personnummer eller samordningsnummer."
Expression: "subject.identifier.system = 'http://electronichealth.se/identifier/personnummer' or subject.identifier.system = 'http://electronichealth.se/identifier/samordningsnummer'"
Severity: #error
