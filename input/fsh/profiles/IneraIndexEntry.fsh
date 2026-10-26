// Naming convention: [prefix][concept] in PascalCase, per Inera's profiling guidance.
Profile: IneraIndexEntry
Parent: DocumentReference
Id: IneraIndexEntry
Title: "Indexpost (FHIR-EI)"
Description: """
Gemensam indexpost. Anger att en producent via en endpoint har information om en patient inom en tjänst.
Det finns en post per patient × endpoint × tjänst. Posten kan bära flera informationsmängder, och tidpunkten
för senaste ändring av innehållet gäller hela posten.

Posten är en pekare, inte innehåll. Varje tjänst publicerar sin tillämpning som en profil av denna profil, i
tjänstens IG, och bestämmer där om informationsmängder och tidpunkt för senaste ändring är obligatoriska.
"""
* insert IneraMetadata(IneraIndexEntry)

* meta.source ^short = "Används bara för spårbarhet, aldrig för behörighet"

* extension contains
    SourceEndpoint named sourceEndpoint 1..1 MS and
    CareUnit named careUnit 1..1 MS and
    RegisteringProducer named registeringProducer 1..1 MS and
    ContentLastUpdated named contentLastUpdated 0..1 MS and
    RegistrationStatus named registrationStatus 1..1 MS and
    DeregistrationReason named deregistrationReason 0..1 MS

// Identity: stable and bound to the producer. The producer may not change it on an existing entry.
* identifier 1..* MS
* identifier ^short = "Producentens id för posten; nyckel för villkorad uppdatering"
* identifier.system 1..1 MS
* identifier.system ^short = "Producentens namnrymd"
* identifier.value 1..1 MS
* identifier.value ^short = "Producentens id för posten"

// The base status has a required binding that cannot be extended. The exact lifecycle state is
// carried by the registrationStatus extension; the invariants keep the two consistent.
* status MS
* status ^short = "current | superseded | entered-in-error; exakt tillstånd i registrationStatus"
* obeys inera-ei-status-map and inera-ei-deregistration

// Service: one coding per generation, so that consumers that only understand service domains keep
// working through the transition.
* type 1..1 MS
* type ^short = "Tjänst: tjänstedomän under övergången, IG:ns canonical därefter"
* type obeys inera-ei-service-coding
* type.coding 1..* MS
* type.coding ^slicing.discriminator.type = #value
* type.coding ^slicing.discriminator.path = "system"
* type.coding ^slicing.rules = #open
* type.coding contains
    serviceDomain 0..1 MS and
    implementationGuide 0..1 MS
* type.coding[serviceDomain] ^short = "Tjänstedomän (idag)"
* type.coding[serviceDomain] from IneraServiceDomainValueSet (required)
* type.coding[serviceDomain].system 1..1
* type.coding[serviceDomain].system = $service-domain
* type.coding[serviceDomain].code 1..1
* type.coding[implementationGuide] ^short = "IG:ns canonical (framåt)"
* type.coding[implementationGuide].system 1..1
* type.coding[implementationGuide].system = "urn:ietf:rfc:3986"
* type.coding[implementationGuide].code 1..1

// The index holds no Patient resources; the patient is a logical reference. Reference.type lets a
// server evaluate the patient search parameter without resolving the reference.
* subject 1..1 MS
* subject only Reference(Patient)
* subject ^short = "Patienten, som logisk referens med personnummer eller samordningsnummer"
* subject.type 1..1
* subject.type = "Patient"
* subject.identifier 1..1 MS
* subject.identifier.system 1..1 MS
* subject.identifier.value 1..1 MS
* subject.identifier obeys inera-ei-patient-identifier

* custodian 1..1 MS
* custodian ^short = "Vårdgivare (personuppgiftsansvarig), som logisk referens med HSA-id"
* custodian.identifier 1..1 MS
* custodian.identifier.system 1..1
* custodian.identifier.system = $hsaid
* custodian.identifier.value 1..1 MS

* content 1..1 MS
* content.attachment.url 1..1 MS
* content.attachment.url ^short = "Endpointens adress, så att konsumenten kan anropa källan utan ett extra uppslag"
// Pointers, not content: the entry never embeds clinical content.
* content.attachment.data 0..0

// Information sets: today's category as a Coding, the profile's canonical going forward.
// The cardinality is set by each service's application profile.
* content.profile MS
* content.profile ^short = "Informationsmängder inom tjänsten"
* content.profile ^slicing.discriminator.type = #type
* content.profile ^slicing.discriminator.path = "value"
* content.profile ^slicing.rules = #open
* content.profile contains
    category 0..* MS and
    contentProfile 0..* MS
* content.profile[category] ^short = "Kategori inom tjänstedomänen (idag)"
* content.profile[category].value[x] only Coding
* content.profile[category].valueCoding from IneraEngagementCategoryValueSet (required)
* content.profile[category].valueCoding.system 1..1
* content.profile[category].valueCoding.code 1..1
* content.profile[contentProfile] ^short = "Profilens canonical, eller bas-resurstypens (framåt)"
* content.profile[contentProfile].value[x] only canonical

// Pointers, not content: elements that would describe the clinical content are prohibited.
* description 0..0
* event 0..0
* bodySite 0..0
* context 0..0
* basedOn 0..0
* attester 0..0

Invariant: inera-ei-status-map
Description: "Basstatus följer registrationStatus: active ↔ current, withdrawn ↔ superseded, entered-in-error ↔ entered-in-error."
Severity: #error
Expression: "(extension('https://fhir.inera.se/ig/engagementindex/StructureDefinition/RegistrationStatus').where(value = 'active').exists() implies status = 'current') and (extension('https://fhir.inera.se/ig/engagementindex/StructureDefinition/RegistrationStatus').where(value = 'withdrawn').exists() implies status = 'superseded') and (extension('https://fhir.inera.se/ig/engagementindex/StructureDefinition/RegistrationStatus').where(value = 'entered-in-error').exists() implies status = 'entered-in-error')"

Invariant: inera-ei-deregistration
Description: "deregistrationReason finns om och endast om registrationStatus inte är active."
Severity: #error
Expression: "extension('https://fhir.inera.se/ig/engagementindex/StructureDefinition/DeregistrationReason').exists() = extension('https://fhir.inera.se/ig/engagementindex/StructureDefinition/RegistrationStatus').where(value != 'active').exists()"

Invariant: inera-ei-service-coding
Description: "Tjänsten anges med tjänstedomän, IG:ns canonical eller båda."
Severity: #error
Expression: "coding.where(system = 'https://fhir.inera.se/ig/engagementindex/CodeSystem/IneraServiceDomainCodeSystem' or system = 'urn:ietf:rfc:3986').exists()"

Invariant: inera-ei-patient-identifier
Description: "Patienten identifieras med personnummer eller samordningsnummer."
Severity: #error
Expression: "system = 'http://electronichealth.se/identifier/personnummer' or system = 'http://electronichealth.se/identifier/samordningsnummer'"
