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
Description: "Producentens identitet: den Endpoint i tjänstekatalogen som den autentiserade klienten är bunden till, som absolut referens. För en direktansluten producent är det samma endpoint som i sourceEndpoint. Referensen är också producentens namnrymd i identifier.system. FHIR-EI kontrollerar värdet mot den autentiserade klienten. Får inte ändras på en befintlig post. Motsvarar owner i dagens engagemangsindex."
Context: DocumentReference
* insert IneraMetadata(RegisteringProducer)
* value[x] 1..1
* value[x] only Reference(Endpoint)
* valueReference.reference 1..1
* valueReference.reference ^short = "Absolut URL till producentens Endpoint i tjänstekatalogen"

Extension: LogicalAddress
Id: LogicalAddress
Title: "Logisk adress"
Description: "Den logiska adress som konsumenten anger när den hämtar informationen via tjänsteplattformen, som HSA-id. Krävs när endpointen adresseras med logisk adress, som för RIV-TA-källor; annars utelämnas den. I tjänstekatalogen är den logiska adressen en organisations HSA-id. Motsvarar logicalAddress i dagens engagemangsindex."
Context: DocumentReference
* insert IneraMetadata(LogicalAddress)
* value[x] 1..1
* value[x] only Identifier
* valueIdentifier.system 1..1
* valueIdentifier.system = $hsaid
* valueIdentifier.value 1..1

Extension: SourceSystem
Id: SourceSystem
Title: "Källsystem"
Description: "Källsystemet enligt dagens engagemangsindex, som HSA-id. Sätts av övergångsadaptern, eftersom registrerande producent då är adaptern och inte källsystemet. En post kan ha flera källsystem när adaptern slår ihop engagemangsposter. Motsvarar sourceSystem i dagens engagemangsindex."
Context: DocumentReference
* insert IneraMetadata(SourceSystem)
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
