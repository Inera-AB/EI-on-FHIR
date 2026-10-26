Extension: SourceEndpoint
Id: SourceEndpoint
Title: "Producentens endpoint"
Description: "Producentens åtkomstpunkt, som Endpoint-resurs i tjänstekatalogen. Katalogen är auktoritativ för endpointens egenskaper. Exakt en per indexpost. Motsvarar logicalAddress i dagens engagemangsindex."
Context: DocumentReference
* insert IneraMetadata(SourceEndpoint)
* value[x] 1..1
* value[x] only Reference(Endpoint)

Extension: CareUnit
Id: CareUnit
Title: "Vårdenhet"
Description: "Vårdenheten där informationen finns, som HSA-id. Motsvarar careUnitId i dagens engagemangsindex."
Context: DocumentReference
* insert IneraMetadata(CareUnit)
* value[x] 1..1
* value[x] only Identifier
* valueIdentifier.system 1..1
* valueIdentifier.system = $hsaid
* valueIdentifier.value 1..1

Extension: RegisteringProducer
Id: RegisteringProducer
Title: "Registrerande producent"
Description: "Producenten som registrerade posten, som HSA-id. FHIR-EI kontrollerar värdet mot den autentiserade klientens producentidentitet. Får inte ändras på en befintlig post. Motsvarar owner i dagens engagemangsindex."
Context: DocumentReference
* insert IneraMetadata(RegisteringProducer)
* value[x] 1..1
* value[x] only Identifier
* valueIdentifier.system 1..1
* valueIdentifier.system = $hsaid
* valueIdentifier.value 1..1

Extension: ContentLastUpdated
Id: ContentLastUpdated
Title: "Innehållets senaste ändring"
Description: "När det kliniska innehållet i källsystemet senast ändrades, enligt producenten. Gäller hela posten. Hålls isär från meta.lastUpdated, som anger när indexposten ändrades i FHIR-EI. Motsvarar mostRecentContent i dagens engagemangsindex."
Context: DocumentReference
* insert IneraMetadata(ContentLastUpdated)
* value[x] 1..1
* value[x] only dateTime
* valueDateTime obeys inera-ei-seconds

Invariant: inera-ei-seconds
Description: "Tidpunkten anges med minst sekundprecision och tidszon, så att ordningen mellan händelser för samma post kan avgöras."
Severity: #error
Expression: "$this.toString().length() >= 20"

Extension: RegistrationStatus
Id: RegistrationStatus
Title: "Registreringsstatus"
Description: "Postens exakta livscykeltillstånd: registrerad, indragen eller felregistrerad. Bär den semantik som DocumentReference.status inte kan uttrycka, eftersom basbindningen inte kan utökas."
Context: DocumentReference
* insert IneraMetadata(RegistrationStatus)
* value[x] 1..1
* value[x] only code
* valueCode from IneraIndexRegistrationStatusValueSet (required)

Extension: DeregistrationReason
Id: DeregistrationReason
Title: "Orsak till avregistrering"
Description: "Varför posten avregistrerades: felregistrering, avslutat engagemang, gallring eller avregistrering via övergångsadaptern. Finns om och endast om posten inte är registrerad."
Context: DocumentReference
* insert IneraMetadata(DeregistrationReason)
* value[x] 1..1
* value[x] only CodeableConcept
* valueCodeableConcept from IneraDeregistrationReasonValueSet (required)
