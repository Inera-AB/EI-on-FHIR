// All HSA-ids and system addresses below are fictitious. 191212121212 is a test personnummer.
// No need to set `meta.profile` manually: SUSHI populates it from `InstanceOf`.

Instance: EndpointJournalsystemFhir
InstanceOf: IneraEngagementIndexEndpoint
Title: "Endpoint för ett FHIR-källsystem"
Description: "Ett journalsystem som exponerar informationen med FHIR. Adressen är källans FHIR-bas."
Usage: #example
* identifier[sourceSystem].system = $hsaid
* identifier[sourceSystem].value = "SE0000000000-SYS1"
* status = #active
* name = "Journalsystem A"
* connectionType = $endpoint-connection-type#hl7-fhir-rest "HL7 FHIR"
* managingOrganization.identifier.system = $hsaid
* managingOrganization.identifier.value = "SE0000000000-VG01"
* payloadType = $endpoint-payload-type#any "Any"
* payloadMimeType = #application/fhir+json
* address = "https://journal-a.example.org/fhir"

Instance: EndpointRivTaKallsystem
InstanceOf: IneraEngagementIndexEndpoint
Title: "Endpoint för ett RIV-TA-källsystem"
Description: "Ett källsystem som fortfarande nås via tjänsteplattformen. Adressen är den logiska adressen från dagens engagemangsindex."
Usage: #example
* identifier[sourceSystem].system = $hsaid
* identifier[sourceSystem].value = "SE0000000000-SYS2"
* status = #active
* name = "Journalsystem B"
* connectionType = IneraEndpointConnectionTypeCodeSystem#riv-ta "RIV-TA"
* payloadType = $endpoint-payload-type#any "Any"
* address = "SE0000000000-VE02"

Instance: IndexpostFhirProducent
InstanceOf: IneraEngagementIndexEntry
Title: "Indexpost från ett FHIR-källsystem"
Description: "Journalsystem A har vård- och omsorgsdokumentation om patienten vid vårdenhet VE01, och exponerar den som Composition."
Usage: #example
* meta.lastUpdated = "2026-10-20T14:32:07+02:00"
* extension[sourceEndpoint].valueReference = Reference(EndpointJournalsystemFhir)
* extension[careUnit].valueIdentifier.system = $hsaid
* extension[careUnit].valueIdentifier.value = "SE0000000000-VE01"
* extension[mostRecentContent].valueDateTime = "2026-10-20T14:31:55+02:00"
* extension[contentProfile].valueCanonical = "http://hl7.org/fhir/StructureDefinition/Composition"
* identifier[sourceEntryId].system = "https://journal-a.example.org/fhir/sid/indexpost"
* identifier[sourceEntryId].value = "7f3c2a10-5b1e-4c8e-9f7a-2d6b8e4a1c33"
* status = #active
* type[serviceDomain] = $service-domain#riv:clinicalprocess:healthcond:description
* type[category] = $engagement-category#voo
* patient.identifier.system = $personnummer
* patient.identifier.value = "191212121212"
* managingOrganization.identifier.system = $hsaid
* managingOrganization.identifier.value = "SE0000000000-VG01"

Instance: IndexpostFranAdapter
InstanceOf: IneraEngagementIndexEntry
Title: "Indexpost speglad från dagens engagemangsindex"
Description: "Adaptern har speglat en engagemangspost från ett RIV-TA-källsystem. clinicalProcessInterestId behålls för spårbarhet."
Usage: #example
* meta.lastUpdated = "2026-10-21T08:05:12+02:00"
* extension[sourceEndpoint].valueReference = Reference(EndpointRivTaKallsystem)
* extension[careUnit].valueIdentifier.system = $hsaid
* extension[careUnit].valueIdentifier.value = "SE0000000000-VE02"
* extension[mostRecentContent].valueDateTime = "2026-10-21T08:04:59+02:00"
* identifier[sourceEntryId].system = "https://fhir.inera.se/ig/engagementindex/sid/riv-ta-engagement"
* identifier[sourceEntryId].value = "b5e0d6a4-1f2c-5e7d-8a9b-0c1d2e3f4a5b"
* identifier[clinicalProcessInterestId].value = "e2a1f6c8-3d4b-4a5e-9c7f-1b2d3e4f5a6b"
* status = #active
* type[serviceDomain] = $service-domain#riv:clinicalprocess:healthcond:description
* type[category] = $engagement-category#voo
* patient.identifier.system = $personnummer
* patient.identifier.value = "191212121212"
* managingOrganization.identifier.system = $hsaid
* managingOrganization.identifier.value = "SE0000000000-VG02"

// A producer registers or updates its entries with conditional PUTs in one transaction.
// The entries carry no id: the server resolves each one from its identifier.
Instance: RegistreringTransaction
InstanceOf: Bundle
Title: "Registrering av indexposter i en transaction"
Description: "En producent registrerar en post och tar bort en annan i samma transaction. Bundlen registreras helt eller inte alls."
Usage: #example
* type = #transaction
* entry[0].fullUrl = "urn:uuid:0c9d8f1e-2a3b-4c5d-8e7f-9a0b1c2d3e4f"
* entry[0].resource = RegistreringIndexpost
* entry[0].request.method = #PUT
* entry[0].request.url = "EpisodeOfCare?identifier=https://journal-a.example.org/fhir/sid/indexpost|7f3c2a10-5b1e-4c8e-9f7a-2d6b8e4a1c33"
* entry[1].request.method = #DELETE
* entry[1].request.url = "EpisodeOfCare?identifier=https://journal-a.example.org/fhir/sid/indexpost|1a2b3c4d-5e6f-4a7b-8c9d-0e1f2a3b4c5d"

Instance: RegistreringIndexpost
InstanceOf: IneraEngagementIndexEntry
Usage: #inline
* extension[sourceEndpoint].valueReference.identifier.system = $hsaid
* extension[sourceEndpoint].valueReference.identifier.value = "SE0000000000-SYS1"
* extension[sourceEndpoint].valueReference.type = "Endpoint"
* extension[careUnit].valueIdentifier.system = $hsaid
* extension[careUnit].valueIdentifier.value = "SE0000000000-VE01"
* extension[mostRecentContent].valueDateTime = "2026-10-20T14:31:55+02:00"
* identifier[sourceEntryId].system = "https://journal-a.example.org/fhir/sid/indexpost"
* identifier[sourceEntryId].value = "7f3c2a10-5b1e-4c8e-9f7a-2d6b8e4a1c33"
* status = #active
* type[serviceDomain] = $service-domain#riv:clinicalprocess:healthcond:description
* type[category] = $engagement-category#voo
* patient.identifier.system = $personnummer
* patient.identifier.value = "191212121212"
* managingOrganization.identifier.system = $hsaid
* managingOrganization.identifier.value = "SE0000000000-VG01"

// GET EpisodeOfCare?patient:identifier=http://electronichealth.se/identifier/personnummer|191212121212
//     &_include=EpisodeOfCare:source-endpoint
Instance: SokresultatForPatient
InstanceOf: Bundle
Title: "Sökresultat för en patient"
Description: "Svar på en konsuments sökning efter en patients indexposter, med källsystemens endpoints inkluderade."
Usage: #example
* type = #searchset
* total = 2
* link[0].relation = "self"
* link[0].url = "https://ei.example.org/fhir/EpisodeOfCare?patient:identifier=http://electronichealth.se/identifier/personnummer|191212121212&_include=EpisodeOfCare:source-endpoint"
* entry[0].fullUrl = "https://ei.example.org/fhir/EpisodeOfCare/IndexpostFhirProducent"
* entry[0].resource = IndexpostFhirProducent
* entry[0].search.mode = #match
* entry[1].fullUrl = "https://ei.example.org/fhir/EpisodeOfCare/IndexpostFranAdapter"
* entry[1].resource = IndexpostFranAdapter
* entry[1].search.mode = #match
* entry[2].fullUrl = "https://ei.example.org/fhir/Endpoint/EndpointJournalsystemFhir"
* entry[2].resource = EndpointJournalsystemFhir
* entry[2].search.mode = #include
* entry[3].fullUrl = "https://ei.example.org/fhir/Endpoint/EndpointRivTaKallsystem"
* entry[3].resource = EndpointRivTaKallsystem
* entry[3].search.mode = #include

// The last version of an entry before it is deleted carries the reason. The producer sends this
// with a conditional PUT and then deletes the entry with a conditional DELETE.
Instance: IndexpostMedBorttagsorsak
InstanceOf: IneraEngagementIndexEntry
Title: "Indexpost med orsak till borttag"
Description: "Den sista versionen av en felregistrerad post, innan producenten tar bort den. Versionen finns kvar i postens historik."
Usage: #example
* meta.lastUpdated = "2026-10-22T10:15:41+02:00"
* extension[sourceEndpoint].valueReference = Reference(EndpointJournalsystemFhir)
* extension[careUnit].valueIdentifier.system = $hsaid
* extension[careUnit].valueIdentifier.value = "SE0000000000-VE01"
* extension[mostRecentContent].valueDateTime = "2026-10-22T10:15:30+02:00"
* extension[deletionReason].valueCodeableConcept = IneraDeletionReasonCodeSystem#entered-in-error "Felregistrering"
* identifier[sourceEntryId].system = "https://journal-a.example.org/fhir/sid/indexpost"
* identifier[sourceEntryId].value = "1a2b3c4d-5e6f-4a7b-8c9d-0e1f2a3b4c5d"
* status = #active
* type[serviceDomain] = $service-domain#riv:clinicalprocess:healthcond:description
* type[category] = $engagement-category#voo
* patient.identifier.system = $personnummer
* patient.identifier.value = "191212121212"
* managingOrganization.identifier.system = $hsaid
* managingOrganization.identifier.value = "SE0000000000-VG01"
