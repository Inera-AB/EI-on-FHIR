Instance: IneraEngagementIndexServer
InstanceOf: CapabilityStatement
Usage: #definition
Title: "EI-on-FHIR server"
* insert IneraInstanceMetadata
* url = "https://fhir.inera.se/ig/engagementindex/CapabilityStatement/IneraEngagementIndexServer"
* name = "IneraEngagementIndexServer"
* description = "Krav på EI-on-FHIR som server: läsning och sökning av engagemangsposter och massuttag med Bulk Data. API:et är skrivskyddat."
* kind = #requirements
* fhirVersion = #4.0.1
* format[0] = #json
* implementationGuide = "https://fhir.inera.se/ig/engagementindex/ImplementationGuide/inera.ei.engagementindex"

* rest[0].mode = #server
* rest[0].documentation = "Skrivskyddat API ovanpå engagemangsindex, för Ineras interna stödtjänster. Varje anrop autentiseras som ett system och loggas. Se sidan Säkerhet och loggning."
* rest[0].security.service = http://terminology.hl7.org/CodeSystem/restful-security-service#SMART-on-FHIR
* rest[0].security.description = "SMART Backend Services med systembehörigheter. Sökning utan patient och massuttag kräver behörighet för synk."

* rest[0].resource[0]
  * type = #DocumentReference
  * profile = Canonical(IneraEngagement)
  * documentation = "Engagemangsposter. En sökning utan status returnerar bara poster med status current. En sökning måste ange subject:identifier, utom för klienter med behörighet för synk."
  * insert Interaction(read, SHALL)
  * insert Interaction(search-type, SHALL)
  * insert SearchParam(subject, http://hl7.org/fhir/SearchParameter/DocumentReference-subject, reference, SHALL)
  * searchParam[=].documentation = "Med modifieraren :identifier, till exempel subject:identifier=http://electronichealth.se/identifier/personnummer|191212121212."
  * insert SearchParam(type, http://hl7.org/fhir/SearchParameter/clinical-type, token, SHALL)
  * insert SearchParam(logical-address, https://fhir.inera.se/ig/engagementindex/SearchParameter/DocumentReference-logical-address, token, SHALL)
  * insert SearchParam(status, http://hl7.org/fhir/SearchParameter/DocumentReference-status, token, SHALL)
  * searchParam[=].documentation = "Standardvärde current. Borttagna poster returneras bara när status=superseded anges."
  * insert SearchParam(_lastUpdated, http://hl7.org/fhir/SearchParameter/Resource-lastUpdated, date, SHALL)
  * searchParam[=].documentation = "Inkrementell synk, tillsammans med status=current,superseded och _sort=_lastUpdated."
  * insert SearchParam(category, http://hl7.org/fhir/SearchParameter/DocumentReference-category, token, SHOULD)
  * insert SearchParam(custodian, http://hl7.org/fhir/SearchParameter/DocumentReference-custodian, reference, SHOULD)
  * searchParam[=].documentation = "Med modifieraren :identifier och HSA-id."
  * insert SearchParam(source-system, https://fhir.inera.se/ig/engagementindex/SearchParameter/DocumentReference-source-system, token, SHOULD)
  * insert SearchParam(_id, http://hl7.org/fhir/SearchParameter/Resource-id, token, SHOULD)

* rest[0].operation[0].name = "export"
* rest[0].operation[=].definition = "http://hl7.org/fhir/uv/bulkdata/OperationDefinition/export"
* rest[0].operation[=].documentation = "Massuttag på systemnivå med _type=DocumentReference och _since, för grundladdning och återsynk. Ett _since-uttag innehåller borttagna poster under borttagsloggens lagringstid."
* rest[0].operation[=].extension[0].url = $expectation
* rest[0].operation[=].extension[0].valueCode = #SHALL
