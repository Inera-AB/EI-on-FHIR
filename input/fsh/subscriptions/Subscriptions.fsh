Instance: indexpost-andrad
InstanceOf: SubscriptionTopic
Usage: #definition
Title: "Indexpost ändrad"
* insert IneraInstanceMetadata
* url = "https://fhir.inera.se/ig/engagementindex/SubscriptionTopic/indexpost-andrad"
* name = "IndexpostAndrad"
* description = "Triggar när en indexpost skapas, uppdateras eller avregistreras. Avregistrering är en uppdatering till status superseded eller entered-in-error, inte en radering."
// Deregistration is an update, and tombstones are purged without notice after their retention time,
// so only create and update trigger.
* resourceTrigger.description = "En indexpost skapas, uppdateras eller avregistreras."
* resourceTrigger.resource = "http://hl7.org/fhir/StructureDefinition/DocumentReference"
* resourceTrigger.supportedInteraction[0] = #create
* resourceTrigger.supportedInteraction[+] = #update
* canFilterBy[0].description = "Patienten, med modifieraren identifier."
* canFilterBy[=].resource = "http://hl7.org/fhir/StructureDefinition/DocumentReference"
* canFilterBy[=].filterParameter = "patient"
* canFilterBy[=].filterDefinition = "http://hl7.org/fhir/SearchParameter/clinical-patient"
* canFilterBy[=].modifier[0] = #identifier
* canFilterBy[+].description = "Tjänsten."
* canFilterBy[=].resource = "http://hl7.org/fhir/StructureDefinition/DocumentReference"
* canFilterBy[=].filterParameter = "type"
* canFilterBy[=].filterDefinition = "http://hl7.org/fhir/SearchParameter/clinical-type"
* canFilterBy[+].description = "Vårdgivaren, med modifieraren identifier."
* canFilterBy[=].resource = "http://hl7.org/fhir/StructureDefinition/DocumentReference"
* canFilterBy[=].filterParameter = "custodian"
* canFilterBy[=].filterDefinition = "http://hl7.org/fhir/SearchParameter/DocumentReference-custodian"
* canFilterBy[=].modifier[0] = #identifier
* notificationShape.resource = "http://hl7.org/fhir/StructureDefinition/DocumentReference"

Profile: IneraIndexSubscription
Parent: Subscription
Id: IneraIndexSubscription
Title: "Prenumeration på indexposter (FHIR-EI)"
Description: """
En konsuments prenumeration på ändrade indexposter, på topic `indexpost-andrad`. Prenumerationen kan
filtreras på patient, tjänst och vårdgivare. Notiser bär bara id för ändrade poster, så att de inte bär
mer patientinformation än nödvändigt.
"""
* insert IneraMetadata(IneraIndexSubscription)
* topic = "https://fhir.inera.se/ig/engagementindex/SubscriptionTopic/indexpost-andrad"
* filterBy MS
* filterBy.filterParameter MS
* filterBy.modifier MS
* filterBy.value MS
* channelType MS
* endpoint MS
* heartbeatPeriod MS
// id-only: a notification only says that an entry changed; the consumer reads it through the
// same access control as a search, which keeps notifications from leaking blocked information.
* content = #id-only
* content MS
