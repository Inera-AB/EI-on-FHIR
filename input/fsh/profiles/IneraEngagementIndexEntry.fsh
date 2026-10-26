// Naming convention: [prefix][concept] in PascalCase, per Inera's profiling guidance.
Profile: IneraEngagementIndexEntry
Parent: EpisodeOfCare
Id: IneraEngagementIndexEntry
Title: "Indexpost (FHIR-EI)"
Description: """
En indexpost i FHIR-EI. Posten är en pekare: den anger att ett källsystem håller information av en viss
informationsmängd om en patient hos en viss vårdgivare och vårdenhet, och när innehållet i källsystemet
senast ändrades. Det finns en post per patient × vårdenhet × källsystem × informationsmängd.

Posten bär aldrig journalinnehåll. Element i EpisodeOfCare som skulle kunna bära sådant innehåll är därför
förbjudna.
"""
* insert IneraMetadata(IneraEngagementIndexEntry)

// Two points in time are kept apart: the entry's own lifecycle (meta.lastUpdated, _history)
// and the last change of the content in the source system (extension mostRecentContent).
* meta.lastUpdated MS
* meta.lastUpdated ^short = "När indexposten senast ändrades (sätts av FHIR-EI)"
* meta.source MS
* meta.source ^short = "Registrerande system (sätts av FHIR-EI)"
* meta.source ^definition = "Systemet som registrerade posten. FHIR-EI sätter värdet utifrån klientens identitet i åtkomsttoken. Bara registrerande system får uppdatera eller ta bort posten."

* extension contains
    SourceEndpoint named sourceEndpoint 1..1 MS and
    CareUnit named careUnit 1..1 MS and
    MostRecentContent named mostRecentContent 1..1 MS and
    ContentProfile named contentProfile 0..* MS and
    DeletionReason named deletionReason 0..1 MS

// Identifier slices are told apart by type rather than system: the system of the producer's own
// identifier differs between source systems, so it cannot discriminate.
* identifier 1..* MS
* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "type"
* identifier ^slicing.rules = #open
* identifier ^short = "Identifierare för indexposten"
* identifier contains
    sourceEntryId 1..1 MS and
    clinicalProcessInterestId 0..1 MS
* identifier[sourceEntryId] ^short = "Producentens id för posten; nyckel för idempotent uppdatering"
* identifier[sourceEntryId] ^definition = "Producentens id för indexposten. System och värde är tillsammans unika för posten och används som villkor vid uppdatering och borttag. Motsvarar businessObjectInstanceIdentifier i dagens engagemangsindex."
* identifier[sourceEntryId].type = IneraEngagementIndexIdentifierTypeCodeSystem#source-entry-id
* identifier[sourceEntryId].system 1..1 MS
* identifier[sourceEntryId].system ^short = "Namnrymd som är unik för källsystemet"
* identifier[sourceEntryId].value 1..1 MS
* identifier[clinicalProcessInterestId] ^short = "clinicalProcessInterestId från dagens engagemangsindex"
* identifier[clinicalProcessInterestId] ^definition = "Behålls för spårbarhet under övergången från dagens engagemangsindex."
* identifier[clinicalProcessInterestId].type = IneraEngagementIndexIdentifierTypeCodeSystem#clinical-process-interest-id
* identifier[clinicalProcessInterestId].system 1..1
* identifier[clinicalProcessInterestId].system = "https://fhir.inera.se/ig/engagementindex/sid/clinical-process-interest-id"
* identifier[clinicalProcessInterestId].value 1..1

// Deletions are propagated with the DELETE interaction only, so status carries no other value.
* status = #active
* status MS
* status ^short = "Alltid active; borttag sker med DELETE"
* statusHistory 0..0

// The information set is coded on several levels at once. Levels are added, never replaced, so a
// consumer that only understands service domains keeps working through the transition.
* type 1..* MS
* type ^slicing.discriminator.type = #value
* type ^slicing.discriminator.path = "coding.system"
* type ^slicing.rules = #open
* type ^short = "Informationsmängd"
* type contains
    serviceDomain 1..1 MS and
    category 0..1 MS and
    implementationGuide 0..* MS
* type[serviceDomain] ^short = "Tjänstedomän (iteration 1)"
* type[serviceDomain] from IneraServiceDomainValueSet (required)
* type[serviceDomain].coding 1..1
* type[serviceDomain].coding.system 1..1
* type[serviceDomain].coding.system = $service-domain
* type[serviceDomain].coding.code 1..1
* type[category] ^short = "Kategori inom tjänstedomänen (iteration 1)"
* type[category] from IneraEngagementCategoryValueSet (required)
* type[category].coding 1..1
* type[category].coding.system 1..1
* type[category].coding.system = $engagement-category
* type[category].coding.code 1..1
* type[implementationGuide] ^short = "Canonical för en IG (iteration 2)"
* type[implementationGuide].coding 1..1
* type[implementationGuide].coding.system 1..1
* type[implementationGuide].coding.system = "urn:ietf:rfc:3986"
* type[implementationGuide].coding.code 1..1
* type[implementationGuide].coding.code ^short = "IG:ns canonical"

// The index holds no Patient resources; the patient is a logical reference.
* patient MS
* patient ^short = "Patienten, som logisk referens med personnummer eller samordningsnummer"
* patient.identifier 1..1 MS
* patient.identifier.system 1..1 MS
* patient.identifier.value 1..1 MS
* patient.identifier obeys inera-ei-patient-identifier

* managingOrganization 1..1 MS
* managingOrganization ^short = "Vårdgivare (personuppgiftsansvarig), som logisk referens med HSA-id"
* managingOrganization.identifier 1..1 MS
* managingOrganization.identifier.system 1..1
* managingOrganization.identifier.system = $hsaid
* managingOrganization.identifier.value 1..1 MS

// Pointers, not content: elements that could carry clinical or administrative content are prohibited.
* diagnosis 0..0
* referralRequest 0..0
* careManager 0..0
* team 0..0
* account 0..0

Invariant: inera-ei-patient-identifier
Description: "Patienten identifieras med personnummer eller samordningsnummer."
Severity: #error
Expression: "system = 'http://electronichealth.se/identifier/personnummer' or system = 'http://electronichealth.se/identifier/samordningsnummer'"
