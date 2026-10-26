Profile: IneraEngagementIndexEndpoint
Parent: Endpoint
Id: IneraEngagementIndexEndpoint
Title: "Källsystemets endpoint (FHIR-EI)"
Description: """
Var informationen som en indexpost pekar på kan hämtas. För ett FHIR-källsystem är adressen källans FHIR-bas.
För ett RIV-TA-källsystem som når FHIR-EI via adaptern är adressen den logiska adress som anges i dagens
engagemangsindex.
"""
* insert IneraMetadata(IneraEngagementIndexEndpoint)

* identifier 1..* MS
* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "system"
* identifier ^slicing.rules = #open
* identifier contains sourceSystem 1..1 MS
* identifier[sourceSystem] ^short = "Källsystemets HSA-id"
* identifier[sourceSystem].system 1..1
* identifier[sourceSystem].system = $hsaid
* identifier[sourceSystem].value 1..1 MS

* status MS
* name MS
* name ^short = "Källsystemets namn"

* connectionType MS
* connectionType from IneraEndpointConnectionTypeValueSet (required)
* connectionType ^short = "hl7-fhir-rest för FHIR-källor, riv-ta för källor som nås via tjänsteplattformen"

* managingOrganization MS
* managingOrganization ^short = "Organisationen som förvaltar källsystemet, som logisk referens med HSA-id"
* managingOrganization.identifier 1..1 MS
* managingOrganization.identifier.system 1..1
* managingOrganization.identifier.system = $hsaid
* managingOrganization.identifier.value 1..1

* payloadType MS
* address MS
* address ^short = "FHIR-bas-URL, eller logisk adress för RIV-TA"
