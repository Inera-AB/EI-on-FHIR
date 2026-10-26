Instance: IneraEngagementIndexServer
InstanceOf: CapabilityStatement
Usage: #definition
Title: "FHIR-EI server"
* insert IneraInstanceMetadata
* url = "https://fhir.inera.se/ig/engagementindex/CapabilityStatement/IneraEngagementIndexServer"
* name = "IneraEngagementIndexServer"
* description = "Krav på FHIR-EI som server: sökning, registrering, prenumeration och massuttag av indexposter."
* kind = #requirements
* instantiates = $backport-server-r4
* fhirVersion = #4.0.1
* format[0] = #json
* format[+] = #xml
* implementationGuide = "https://fhir.inera.se/ig/engagementindex/ImplementationGuide/inera.ei.engagementindex"

* rest[0].mode = #server
* rest[0].documentation = "Alla anrop kräver en åtkomsttoken med åtkomstkontext. Konsumentanrop går via spärr, loggning och filtrering. Se sidan Spärr, loggning och behörighet."
* rest[0].security.description = "Se sidan Spärr, loggning och behörighet."
* rest[0]
  * insert Interaction(transaction, SHALL)
  * interaction[=].documentation = "Producenter registrerar flera poster i en transaction-Bundle. Den registreras helt eller inte alls."

// Index entries
* rest[0].resource[0]
  * type = #EpisodeOfCare
  * supportedProfile = Canonical(IneraEngagementIndexEntry)
  * documentation = "Indexposter. Bara registrerande system (meta.source) får uppdatera eller ta bort en post."
  * versioning = #versioned
  * readHistory = true
  * updateCreate = true
  * conditionalCreate = false
  * conditionalUpdate = true
  * conditionalDelete = #single
  * searchInclude = "EpisodeOfCare:source-endpoint"
  * insert Interaction(read, SHALL)
  * insert Interaction(vread, SHALL)
  * insert Interaction(update, SHALL)
  * interaction[=].documentation = "Villkorad uppdatering på identifier: PUT EpisodeOfCare?identifier=system|value."
  * insert Interaction(delete, SHALL)
  * interaction[=].documentation = "Villkorat borttag på identifier: DELETE EpisodeOfCare?identifier=system|value."
  * insert Interaction(history-instance, SHALL)
  * insert Interaction(search-type, SHALL)
  * insert SearchParam(patient, http://hl7.org/fhir/SearchParameter/clinical-patient, reference, SHALL)
  * searchParam[=].documentation = "Används med modifieraren :identifier, t.ex. patient:identifier=http://electronichealth.se/identifier/personnummer|191212121212."
  * insert SearchParam(type, http://hl7.org/fhir/SearchParameter/EpisodeOfCare-type, token, SHALL)
  * insert SearchParam(organization, http://hl7.org/fhir/SearchParameter/EpisodeOfCare-organization, reference, SHALL)
  * searchParam[=].documentation = "Vårdgivare. Används med modifieraren :identifier och HSA-id."
  * insert SearchParam(identifier, http://hl7.org/fhir/SearchParameter/clinical-identifier, token, SHALL)
  * insert SearchParam(care-unit, https://fhir.inera.se/ig/engagementindex/SearchParameter/EpisodeOfCare-care-unit, token, SHALL)
  * insert SearchParam(most-recent-content, https://fhir.inera.se/ig/engagementindex/SearchParameter/EpisodeOfCare-most-recent-content, date, SHALL)
  * insert SearchParam(source-endpoint, https://fhir.inera.se/ig/engagementindex/SearchParameter/EpisodeOfCare-source-endpoint, reference, SHALL)
  * insert SearchParam(content-profile, https://fhir.inera.se/ig/engagementindex/SearchParameter/EpisodeOfCare-content-profile, uri, SHOULD)
  * insert SearchParam(_lastUpdated, http://hl7.org/fhir/SearchParameter/Resource-lastUpdated, date, SHALL)

// Source system endpoints
* rest[0].resource[+]
  * type = #Endpoint
  * supportedProfile = Canonical(IneraEngagementIndexEndpoint)
  * documentation = "Källsystemens endpoints. Returneras normalt med _include i en sökning på indexposter."
  * insert Interaction(read, SHALL)
  * insert Interaction(search-type, SHALL)
  * insert SearchParam(identifier, http://hl7.org/fhir/SearchParameter/Endpoint-identifier, token, SHALL)

// Subscriptions
* rest[0].resource[+]
  * type = #Subscription
  * supportedProfile = Canonical(IneraEngagementIndexSubscription)
  * documentation = "Prenumerationer enligt R4 Subscriptions Backport. Notiser filtreras på samma sätt som sökningar."
  * extension[0].url = $backport-topic-canonical
  * extension[0].valueCanonical = "https://fhir.inera.se/ig/engagementindex/SubscriptionTopic/indexpost-andrad"
  * insert Interaction(create, SHALL)
  * insert Interaction(read, SHALL)
  * insert Interaction(update, SHALL)
  * insert Interaction(delete, SHALL)
  * insert Interaction(search-type, SHALL)
  * operation[0].name = "status"
  * operation[=].definition = $backport-subscription-status
  * operation[=].extension[0].url = $expectation
  * operation[=].extension[0].valueCode = #SHALL

// Bulk export for system consumers: initial load and resynchronisation
* rest[0].operation[0].name = "export"
* rest[0].operation[=].definition = $bulk-export
* rest[0].operation[=].documentation = "Massuttag för systemkonsumenter, med _type=EpisodeOfCare och _since. Används för grundladdning och återsynk. Vid _since fylls fältet deleted i svarsmanifestet med borttagna poster."
* rest[0].operation[=].extension[0].url = $expectation
* rest[0].operation[=].extension[0].valueCode = #SHALL
