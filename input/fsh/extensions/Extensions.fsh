Extension: SourceEndpoint
Id: SourceEndpoint
Title: "Källsystemets endpoint"
Description: "Var informationen som indexposten pekar på kan hämtas. EpisodeOfCare saknar ett endpoint-element. Motsvarar logicalAddress i dagens engagemangsindex."
Context: EpisodeOfCare
* insert IneraMetadata(SourceEndpoint)
* value[x] 1..1
* value[x] only Reference(IneraEngagementIndexEndpoint)

Extension: CareUnit
Id: CareUnit
Title: "Vårdenhet"
Description: "Vårdenheten där informationen finns, som HSA-id. Motsvarar careUnitId i dagens engagemangsindex."
Context: EpisodeOfCare
* insert IneraMetadata(CareUnit)
* value[x] 1..1
* value[x] only Identifier
* valueIdentifier.system 1..1
* valueIdentifier.system = $hsaid
* valueIdentifier.value 1..1

Extension: MostRecentContent
Id: MostRecentContent
Title: "Senaste innehåll"
Description: "När innehållet i källsystemet senast ändrades. Hålls isär från meta.lastUpdated, som anger när indexposten ändrades. Motsvarar mostRecentContent i dagens engagemangsindex."
Context: EpisodeOfCare
* insert IneraMetadata(MostRecentContent)
* value[x] 1..1
* value[x] only dateTime
* valueDateTime obeys inera-ei-seconds

Invariant: inera-ei-seconds
Description: "Tidpunkten anges med minst sekundprecision och tidszon, så att ordningen mellan händelser för samma post kan avgöras."
Severity: #error
Expression: "$this.toString().length() >= 20"

Extension: ContentProfile
Id: ContentProfile
Title: "Innehållsprofil"
Description: "Canonical för den profil eller bas-resurstyp som källsystemet exponerar informationen med, t.ex. http://hl7.org/fhir/StructureDefinition/Observation. Lövnivån i kodverket för informationsmängder (iteration 3)."
Context: EpisodeOfCare
* insert IneraMetadata(ContentProfile)
* value[x] 1..1
* value[x] only Canonical(StructureDefinition)

Extension: DeletionReason
Id: DeletionReason
Title: "Orsak till borttag"
Description: "Varför indexposten tas bort: felregistrering, avslutat engagemang eller gallring. Sätts på den sista versionen före borttag och följer med i postens historik."
Context: EpisodeOfCare
* insert IneraMetadata(DeletionReason)
* value[x] 1..1
* value[x] only CodeableConcept
* valueCodeableConcept from IneraDeletionReasonValueSet (required)
