Instance: IneraEngagementIndexServer
InstanceOf: CapabilityStatement
Usage: #definition
Title: "EI-on-FHIR server"
* insert IneraInstanceMetadata
* url = "https://fhir.inera.se/ig/engagementindex/CapabilityStatement/IneraEngagementIndexServer"
* name = "IneraEngagementIndexServer"
* description = "Krav på EI-on-FHIR som server: läsning och sökning av engagemangsposter från EI och från EI-on-FHIR:s register, registrering i registret för FHIR-producenter, och massuttag med Bulk Data."
* kind = #requirements
* fhirVersion = #4.0.1
* format[0] = #json
* implementationGuide = "https://fhir.inera.se/ig/engagementindex/ImplementationGuide/inera.ei.engagementindex"

* rest[0].mode = #server
* rest[0].documentation = "API ovanpå engagemangsindex, för Ineras interna stödtjänster och för FHIR-producenter. Poster från EI är skrivskyddade; FHIR-producenter skriver bara i EI-on-FHIR:s register. Varje anrop autentiseras som ett system och loggas. Se sidan Säkerhet och loggning."
* rest[0].security.service = http://terminology.hl7.org/CodeSystem/restful-security-service#SMART-on-FHIR
* rest[0].security.description = "SMART Backend Services med systembehörigheter och tre klientroller: stödtjänst, synktjänst och producent. Sökning utan patient och massuttag kräver behörighet för synk; skrivning kräver behörighet som producent."

* rest[0].resource[0]
  * type = #DocumentReference
  * profile = Canonical(IneraEngagement)
  * documentation = "Engagemangsposter från EI och från EI-on-FHIR:s register, i samma sökresultat. En sökning utan status returnerar bara poster med status current. En sökning måste ange subject:identifier, utom för klienter med behörighet för synk. En producent skriver med villkorad update på identifier och tar bort med delete; villkoret och borttaget gäller bara producentens egna poster i registret."
  * versioning = #no-version
  * conditionalCreate = false
  * conditionalUpdate = true
  * conditionalDelete = #not-supported
  * updateCreate = false
  * insert Interaction(read, SHALL)
  * insert Interaction(search-type, SHALL)
  * insert Interaction(update, SHALL)
  * interaction[=].documentation = "Villkorad update: PUT DocumentReference?identifier=[värde]. Skapar posten om producenten inte har någon post med identifieraren, annars uppdateras den."
  * insert Interaction(delete, SHALL)
  * interaction[=].documentation = "DELETE DocumentReference/[id] för en post i registret. Posten visas därefter med status superseded under borttagsloggens lagringstid."
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
  * insert SearchParam(format, http://hl7.org/fhir/SearchParameter/DocumentReference-format, token, SHOULD)
  * searchParam[=].documentation = "Hämtningsprotokoll, riv-ta eller fhir-r4."
  * insert SearchParam(identifier, http://hl7.org/fhir/SearchParameter/clinical-identifier, token, SHALL)
  * searchParam[=].documentation = "För producentens villkorade update."
  * insert SearchParam(_id, http://hl7.org/fhir/SearchParameter/Resource-id, token, SHOULD)

* rest[0].operation[0].name = "export"
* rest[0].operation[=].definition = "http://hl7.org/fhir/uv/bulkdata/OperationDefinition/export"
* rest[0].operation[=].documentation = "Massuttag på systemnivå med _type=DocumentReference och _since, för grundladdning och återsynk. Ett _since-uttag innehåller borttagna poster under borttagsloggens lagringstid."
* rest[0].operation[=].extension[0].url = $expectation
* rest[0].operation[=].extension[0].valueCode = #SHALL
