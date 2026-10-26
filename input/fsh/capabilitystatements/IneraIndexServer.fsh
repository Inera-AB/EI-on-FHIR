Instance: IneraIndexServer
InstanceOf: CapabilityStatement
Usage: #definition
Title: "FHIR-EI server"
* insert IneraInstanceMetadata
* url = "https://fhir.inera.se/ig/engagementindex/CapabilityStatement/IneraIndexServer"
* name = "IneraIndexServer"
* description = "Krav på FHIR-EI som server: sökning, registrering och avregistrering, prenumeration, inkrementell avstämning och massuttag av indexposter."
* kind = #requirements
* fhirVersion = #5.0.0
* format[0] = #json
* format[+] = #xml
* implementationGuide = "https://fhir.inera.se/ig/engagementindex/ImplementationGuide/inera.ei.engagementindex"

* rest[0].mode = #server
* rest[0].documentation = "Alla läs-, skriv-, prenumerations- och exportanrop går genom samma centrala kontroll av behörighet, spärr och loggning. Se sidan Spärr, loggning och behörighet."
* rest[0].security.description = "Se sidan Spärr, loggning och behörighet."
* rest[0]
  * insert Interaction(transaction, SHALL)
  * interaction[=].documentation = "Producenter registrerar och avregistrerar flera poster i en transaction-Bundle. Den registreras helt eller inte alls."

// Index entries
* rest[0].resource[0]
  * type = #DocumentReference
  * profile = Canonical(IneraIndexEntry)
  * documentation = "Indexposter. En producent får bara skapa, uppdatera och avregistrera poster som tillhör dess registrerade identitet. Avregistrering sker med villkorad uppdatering, aldrig med delete. En sökning utan status-parameter returnerar bara poster med status current."
  * versioning = #versioned
  * readHistory = true
  * updateCreate = true
  * conditionalCreate = false
  * conditionalUpdate = true
  * conditionalDelete = #not-supported
  * insert Interaction(read, SHALL)
  * insert Interaction(vread, SHALL)
  * insert Interaction(update, SHALL)
  * interaction[=].documentation = "Villkorad uppdatering på identifier: PUT DocumentReference?identifier=system|value."
  * insert Interaction(history-instance, SHALL)
  * insert Interaction(search-type, SHALL)
  * insert SearchParam(patient, http://hl7.org/fhir/SearchParameter/clinical-patient, reference, SHALL)
  * searchParam[=].documentation = "Med modifieraren :identifier, t.ex. patient:identifier=http://electronichealth.se/identifier/personnummer|191212121212."
  * insert SearchParam(type, http://hl7.org/fhir/SearchParameter/clinical-type, token, SHALL)
  * insert SearchParam(status, http://hl7.org/fhir/SearchParameter/DocumentReference-status, token, SHALL)
  * searchParam[=].documentation = "Standardvärde current. Avregistrerade poster returneras bara när status anges explicit."
  * insert SearchParam(custodian, http://hl7.org/fhir/SearchParameter/DocumentReference-custodian, reference, SHALL)
  * searchParam[=].documentation = "Vårdgivare, med modifieraren :identifier och HSA-id."
  * insert SearchParam(identifier, http://hl7.org/fhir/SearchParameter/clinical-identifier, token, SHALL)
  * insert SearchParam(format-code, http://hl7.org/fhir/SearchParameter/DocumentReference-format-code, token, SHALL)
  * searchParam[=].documentation = "Informationsmängd som kategori (content.profile som Coding)."
  * insert SearchParam(format-canonical, http://hl7.org/fhir/SearchParameter/DocumentReference-format-canonical, reference, SHALL)
  * searchParam[=].documentation = "Informationsmängd som profil-canonical (content.profile som canonical)."
  * insert SearchParam(content-last-updated, https://fhir.inera.se/ig/engagementindex/SearchParameter/DocumentReference-content-last-updated, date, SHALL)
  * insert SearchParam(source-endpoint, https://fhir.inera.se/ig/engagementindex/SearchParameter/DocumentReference-source-endpoint, reference, SHALL)
  * insert SearchParam(_lastUpdated, http://hl7.org/fhir/SearchParameter/Resource-lastUpdated, date, SHALL)
  * searchParam[=].documentation = "Inkrementell avstämning, tillsammans med status=current,superseded,entered-in-error."

// Subscriptions
* rest[0].resource[+]
  * type = #Subscription
  * profile = Canonical(IneraIndexSubscription)
  * documentation = "Topic-baserade prenumerationer på topic indexpost-andrad. Notiser filtreras på samma sätt som sökningar."
  * insert Interaction(create, SHALL)
  * insert Interaction(read, SHALL)
  * insert Interaction(update, SHALL)
  * insert Interaction(delete, SHALL)
  * insert Interaction(search-type, SHALL)
  * operation[0].name = "status"
  * operation[=].definition = "http://hl7.org/fhir/OperationDefinition/Subscription-status"
  * operation[=].extension[0].url = $expectation
  * operation[=].extension[0].valueCode = #SHALL
  * operation[+].name = "events"
  * operation[=].definition = "http://hl7.org/fhir/OperationDefinition/Subscription-events"
  * operation[=].extension[0].url = $expectation
  * operation[=].extension[0].valueCode = #SHALL

* rest[0].resource[+]
  * type = #SubscriptionTopic
  * documentation = "Servern exponerar topic indexpost-andrad."
  * insert Interaction(read, SHALL)
  * insert Interaction(search-type, SHALL)
