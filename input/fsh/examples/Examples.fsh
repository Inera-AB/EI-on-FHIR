// All HSA-ids and addresses below are fictitious. 191212121212 is a test personnummer.
// No need to set `meta.profile` manually: SUSHI populates it from `InstanceOf`.

RuleSet: TestPatient
* subject.type = "Patient"
* subject.identifier.system = $personnummer
* subject.identifier.value = "191212121212"

RuleSet: TestCustodian(vg)
* custodian.identifier.system = $hsaid
* custodian.identifier.value = "{vg}"

Instance: IndexpostFhirProducent
InstanceOf: IneraIndexEntry
Title: "Registrerad indexpost från en FHIR-producent"
Description: "Journalsystem A har vård- och omsorgsdokumentation om patienten. Tjänsten anges med både tjänstedomän och IG-canonical, och informationsmängden med både kategori och profil-canonical."
Usage: #example
* meta.lastUpdated = "2026-10-20T14:32:07+02:00"
* meta.tag[populationMethod] = $population-method#producer
* extension[sourceEndpoint].valueReference = Reference(https://tjanstekatalog.example.org/fhir/Endpoint/journal-a)
* extension[careUnit].valueIdentifier.system = $hsaid
* extension[careUnit].valueIdentifier.value = "SE0000000000-VE01"
* extension[registeringProducer].valueReference.reference = "https://tjanstekatalog.example.org/fhir/Endpoint/journal-a"
* extension[contentLastUpdated].valueDateTime = "2026-10-20T14:31:55+02:00"
* extension[registrationStatus].valueCode = #active
* identifier.system = "https://tjanstekatalog.example.org/fhir/Endpoint/journal-a"
* identifier.value = "7f3c2a10-5b1e-4c8e-9f7a-2d6b8e4a1c33"
* status = #current
* type.coding[serviceDomain] = $service-domain#riv:clinicalprocess:healthcond:description
* type.coding[implementationGuide] = urn:ietf:rfc:3986#https://example.org/fhir/ImplementationGuide/vardochomsorgsdokumentation
* insert TestPatient
* insert TestCustodian(SE0000000000-VG01)
* content.attachment.url = "https://journal-a.example.org/fhir"
* content.profile[category].valueCoding = $engagement-category#voo
* content.profile[contentProfile].valueCanonical = "http://hl7.org/fhir/StructureDefinition/Composition"

Instance: IndexpostEjForPatient
InstanceOf: IneraIndexEntry
Title: "Indexpost som inte visas för patient eller närstående"
Description: "Producenten har märkt posten med säkerhetsetiketten NOPAT. FHIR-EI lämnar inte ut den vid patientens direktåtkomst eller till ombud och vårdnadshavare, men vid sammanhållen journalföring prövas den som vanligt."
Usage: #example
* meta.lastUpdated = "2026-10-23T09:12:40+02:00"
* meta.tag[populationMethod] = $population-method#producer
* meta.security = http://terminology.hl7.org/CodeSystem/v3-ActCode#NOPAT
* extension[sourceEndpoint].valueReference = Reference(https://tjanstekatalog.example.org/fhir/Endpoint/journal-a)
* extension[careUnit].valueIdentifier.system = $hsaid
* extension[careUnit].valueIdentifier.value = "SE0000000000-VE03"
* extension[registeringProducer].valueReference.reference = "https://tjanstekatalog.example.org/fhir/Endpoint/journal-a"
* extension[contentLastUpdated].valueDateTime = "2026-10-23T09:12:31+02:00"
* extension[registrationStatus].valueCode = #active
* identifier.system = "https://tjanstekatalog.example.org/fhir/Endpoint/journal-a"
* identifier.value = "3c4d5e6f-7a8b-4c9d-8e0f-1a2b3c4d5e6f"
* status = #current
* type.coding[serviceDomain] = $service-domain#riv:clinicalprocess:healthcond:description
* type.coding[implementationGuide] = urn:ietf:rfc:3986#https://example.org/fhir/ImplementationGuide/vardochomsorgsdokumentation
* insert TestPatient
* insert TestCustodian(SE0000000000-VG01)
* content.attachment.url = "https://journal-a.example.org/fhir"
* content.profile[category].valueCoding = $engagement-category#voo
* content.profile[contentProfile].valueCanonical = "http://hl7.org/fhir/StructureDefinition/Composition"

Instance: IndexpostFranAdapter
InstanceOf: IneraIndexEntry
Title: "Indexpost speglad av övergångsadaptern"
Description: "Adaptern har slagit ihop dagens engagemangsposter för samma patient, logiska adress och tjänstedomän till en indexpost, med dagens kategori som informationsmängd. Endpointen är tjänsteplattformens endpoint för tjänstekontraktet, enligt adapterns adressregister, och den logiska adressen anges separat. Registrerande producent är adaptern, och källsystemet behålls."
Usage: #example
* meta.lastUpdated = "2026-10-21T08:05:12+02:00"
* meta.tag[populationMethod] = $population-method#mirror
* extension[sourceEndpoint].valueReference = Reference(https://tjanstekatalog.example.org/fhir/Endpoint/ntjp-getcaredocumentation)
* extension[careUnit].valueIdentifier.system = $hsaid
* extension[careUnit].valueIdentifier.value = "SE0000000000-VE02"
* extension[registeringProducer].valueReference.reference = "https://tjanstekatalog.example.org/fhir/Endpoint/overgangsadapter"
* extension[logicalAddress].valueIdentifier.system = $hsaid
* extension[logicalAddress].valueIdentifier.value = "SE0000000000-VE02"
* extension[sourceSystem].valueIdentifier.system = $hsaid
* extension[sourceSystem].valueIdentifier.value = "SE0000000000-SYS2"
* extension[contentLastUpdated].valueDateTime = "2026-10-21T08:04:59+02:00"
* extension[registrationStatus].valueCode = #active
* identifier.system = "https://tjanstekatalog.example.org/fhir/Endpoint/overgangsadapter"
* identifier.value = "b5e0d6a4-1f2c-5e7d-8a9b-0c1d2e3f4a5b"
* status = #current
* type.coding[serviceDomain] = $service-domain#riv:clinicalprocess:healthcond:description
* insert TestPatient
* insert TestCustodian(SE0000000000-VG02)
* content.attachment.url = "https://ntjp.example.org/vp/clinicalprocess/healthcond/description/GetCareDocumentation/2/rivtabp21"
* content.profile[category].valueCoding = $engagement-category#voo

Instance: IndexpostIndragen
InstanceOf: IneraIndexEntry
Title: "Indragen indexpost"
Description: "Producenten har dragit tillbaka posten eftersom engagemanget är avslutat. Posten ligger kvar som gravsten under gravstenarnas lagringstid och syns vid avstämning och export, men inte i en standardsökning."
Usage: #example
* meta.lastUpdated = "2026-10-22T10:15:41+02:00"
* meta.tag[populationMethod] = $population-method#producer
* extension[sourceEndpoint].valueReference = Reference(https://tjanstekatalog.example.org/fhir/Endpoint/journal-a)
* extension[careUnit].valueIdentifier.system = $hsaid
* extension[careUnit].valueIdentifier.value = "SE0000000000-VE01"
* extension[registeringProducer].valueReference.reference = "https://tjanstekatalog.example.org/fhir/Endpoint/journal-a"
* extension[contentLastUpdated].valueDateTime = "2026-10-22T10:15:30+02:00"
* extension[registrationStatus].valueCode = #withdrawn
* extension[deregistrationReason].valueCodeableConcept = IneraDeregistrationReasonCodeSystem#ended "Avslutat engagemang"
* identifier.system = "https://tjanstekatalog.example.org/fhir/Endpoint/journal-a"
* identifier.value = "1a2b3c4d-5e6f-4a7b-8c9d-0e1f2a3b4c5d"
* status = #superseded
* type.coding[serviceDomain] = $service-domain#riv:clinicalprocess:healthcond:description
* insert TestPatient
* insert TestCustodian(SE0000000000-VG01)
* content.attachment.url = "https://journal-a.example.org/fhir"
* content.profile[category].valueCoding = $engagement-category#voo

// Populated by Inera's locator from eHM's patient index and a targeted query to the source. The
// patient index gives the care provider by organisation number and the record system, but not the
// care unit, so the entry has no careUnit.
Instance: IndexpostFranLokaliseringstjanst
InstanceOf: IneraIndexEntry
Title: "Indexpost fylld av lokaliseringstjänsten"
Description: "Lokaliseringstjänsten har slagit upp patientens vårdgivare i eHM:s patientindex och ställt en riktad fråga till journalsystem C. Vårdgivaren anges med organisationsnummer, och vårdenhet saknas eftersom patientindexet inte anger den."
Usage: #example
* meta.lastUpdated = "2026-10-24T11:02:18+02:00"
* meta.tag[populationMethod] = $population-method#cache
* extension[sourceEndpoint].valueReference = Reference(https://tjanstekatalog.example.org/fhir/Endpoint/journal-c)
* extension[registeringProducer].valueReference.reference = "https://tjanstekatalog.example.org/fhir/Endpoint/lokaliseringstjanst"
* extension[sourceSystem].valueIdentifier.system = $hsaid
* extension[sourceSystem].valueIdentifier.value = "SE0000000000-SYS3"
* extension[contentLastUpdated].valueDateTime = "2026-10-24T09:47:03+02:00"
* extension[registrationStatus].valueCode = #active
* identifier.system = "https://tjanstekatalog.example.org/fhir/Endpoint/lokaliseringstjanst"
* identifier.value = "c1d2e3f4-a5b6-4c7d-8e9f-0a1b2c3d4e5f"
* status = #current
* type.coding[serviceDomain] = $service-domain#riv:clinicalprocess:healthcond:description
* insert TestPatient
* custodian.identifier.system = $orgnr
* custodian.identifier.value = "0000000000"
* content.attachment.url = "https://journal-c.example.org/fhir"
* content.profile[category].valueCoding = $engagement-category#voo

// GET DocumentReference?patient:identifier=… against a service populated as an Inera cache, where one
// source did not answer the targeted query in time.
Instance: SokresultatOfullstandigt
InstanceOf: Bundle
Title: "Ofullständigt sökresultat"
Description: "Svar på en sökning där en källa inte svarade på lokaliseringstjänstens riktade fråga inom tidsgränsen. Bundlen innehåller de poster som gick att bekräfta, och en OperationOutcome i Bundle.issues anger vilken källa som saknas, så att konsumenten kan visa att uppgifter kan saknas."
Usage: #example
* type = #searchset
* total = 1
* link[0].relation = #self
* link[0].url = "https://ei.example.org/fhir/DocumentReference?patient:identifier=http://electronichealth.se/identifier/personnummer|191212121212"
* entry[0].fullUrl = "https://ei.example.org/fhir/DocumentReference/IndexpostFranLokaliseringstjanst"
* entry[0].resource = IndexpostFranLokaliseringstjanst
* entry[0].search.mode = #match
* issues = KallaSvaradeInte

Instance: KallaSvaradeInte
InstanceOf: OperationOutcome
Usage: #inline
* id = "kalla-svarade-inte"
* text.status = #generated
* text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\"><p>Källan svarade inte inom tidsgränsen. Uppgifter kan saknas för vårdgivare 0000000000.</p></div>"
* issue[0].severity = #warning
* issue[0].code = #incomplete
* issue[0].details.text = "Källan svarade inte inom tidsgränsen. Uppgifter kan saknas för vårdgivaren."
* issue[0].diagnostics = "Vårdgivare 0000000000 (organisationsnummer), endpoint https://tjanstekatalog.example.org/fhir/Endpoint/journal-d"

// A producer registers and deregisters its entries with conditional PUTs in one transaction.
// The entries carry no id: the server resolves each one from its identifier.
Instance: RegistreringTransaction
InstanceOf: Bundle
Title: "Registrering och avregistrering i en transaction"
Description: "En producent registrerar en post och avregistrerar en felregistrerad post i samma transaction. Bundlen registreras helt eller inte alls."
Usage: #example
* type = #transaction
* entry[0].fullUrl = "urn:uuid:0c9d8f1e-2a3b-4c5d-8e7f-9a0b1c2d3e4f"
* entry[0].resource = RegistreringIndexpost
* entry[0].request.method = #PUT
* entry[0].request.url = "DocumentReference?identifier=https://tjanstekatalog.example.org/fhir/Endpoint/journal-a|7f3c2a10-5b1e-4c8e-9f7a-2d6b8e4a1c33"
* entry[1].fullUrl = "urn:uuid:5e6f7a8b-9c0d-4e1f-8a2b-3c4d5e6f7a8b"
* entry[1].resource = AvregistreringIndexpost
* entry[1].request.method = #PUT
* entry[1].request.url = "DocumentReference?identifier=https://tjanstekatalog.example.org/fhir/Endpoint/journal-a|9d8c7b6a-5f4e-4d3c-8b2a-1f0e9d8c7b6a"

Instance: RegistreringIndexpost
InstanceOf: IneraIndexEntry
Usage: #inline
* extension[sourceEndpoint].valueReference = Reference(https://tjanstekatalog.example.org/fhir/Endpoint/journal-a)
* extension[careUnit].valueIdentifier.system = $hsaid
* extension[careUnit].valueIdentifier.value = "SE0000000000-VE01"
* extension[registeringProducer].valueReference.reference = "https://tjanstekatalog.example.org/fhir/Endpoint/journal-a"
* extension[contentLastUpdated].valueDateTime = "2026-10-20T14:31:55+02:00"
* extension[registrationStatus].valueCode = #active
* identifier.system = "https://tjanstekatalog.example.org/fhir/Endpoint/journal-a"
* identifier.value = "7f3c2a10-5b1e-4c8e-9f7a-2d6b8e4a1c33"
* status = #current
* type.coding[serviceDomain] = $service-domain#riv:clinicalprocess:healthcond:description
* insert TestPatient
* insert TestCustodian(SE0000000000-VG01)
* content.attachment.url = "https://journal-a.example.org/fhir"
* content.profile[category].valueCoding = $engagement-category#voo

Instance: AvregistreringIndexpost
InstanceOf: IneraIndexEntry
Usage: #inline
* extension[sourceEndpoint].valueReference = Reference(https://tjanstekatalog.example.org/fhir/Endpoint/journal-a)
* extension[careUnit].valueIdentifier.system = $hsaid
* extension[careUnit].valueIdentifier.value = "SE0000000000-VE01"
* extension[registeringProducer].valueReference.reference = "https://tjanstekatalog.example.org/fhir/Endpoint/journal-a"
* extension[contentLastUpdated].valueDateTime = "2026-10-20T14:31:55+02:00"
* extension[registrationStatus].valueCode = #entered-in-error
* extension[deregistrationReason].valueCodeableConcept = IneraDeregistrationReasonCodeSystem#entered-in-error "Felregistrering"
* identifier.system = "https://tjanstekatalog.example.org/fhir/Endpoint/journal-a"
* identifier.value = "9d8c7b6a-5f4e-4d3c-8b2a-1f0e9d8c7b6a"
* status = #entered-in-error
* type.coding[serviceDomain] = $service-domain#riv:clinicalprocess:healthcond:description
* insert TestPatient
* insert TestCustodian(SE0000000000-VG01)
* content.attachment.url = "https://journal-a.example.org/fhir"

// GET DocumentReference?patient:identifier=http://electronichealth.se/identifier/personnummer|191212121212
Instance: SokresultatForPatient
InstanceOf: Bundle
Title: "Sökresultat för en patient"
Description: "Svar på en konsuments sökning efter en patients indexposter. Utan status-parameter returneras bara registrerade poster, så den indragna posten finns inte med."
Usage: #example
* type = #searchset
* total = 2
* link[0].relation = #self
* link[0].url = "https://ei.example.org/fhir/DocumentReference?patient:identifier=http://electronichealth.se/identifier/personnummer|191212121212"
* entry[0].fullUrl = "https://ei.example.org/fhir/DocumentReference/IndexpostFhirProducent"
* entry[0].resource = IndexpostFhirProducent
* entry[0].search.mode = #match
* entry[1].fullUrl = "https://ei.example.org/fhir/DocumentReference/IndexpostFranAdapter"
* entry[1].resource = IndexpostFranAdapter
* entry[1].search.mode = #match

Instance: PrenumerationForPatient
InstanceOf: IneraIndexSubscription
Title: "Prenumeration på en patients indexposter"
Description: "En konsument prenumererar på ändrade indexposter för en patient inom en tjänst."
Usage: #example
* status = #requested
* reason = "Visa aktuell översikt över patientens information"
* filterBy[0].resourceType = "http://hl7.org/fhir/StructureDefinition/DocumentReference"
* filterBy[0].filterParameter = "patient"
* filterBy[0].modifier = #identifier
* filterBy[0].value = "http://electronichealth.se/identifier/personnummer|191212121212"
* filterBy[1].resourceType = "http://hl7.org/fhir/StructureDefinition/DocumentReference"
* filterBy[1].filterParameter = "type"
* filterBy[1].value = "https://fhir.inera.se/ig/engagementindex/CodeSystem/IneraServiceDomainCodeSystem|riv:clinicalprocess:healthcond:description"
* channelType = http://terminology.hl7.org/CodeSystem/subscription-channel-type#rest-hook
* endpoint = "https://konsument.example.org/fhir/notifieringar"
* heartbeatPeriod = 3600
* contentType = #application/fhir+json
