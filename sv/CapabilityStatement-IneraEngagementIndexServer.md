# EI-on-FHIR server - EI-on-FHIR: FHIR-API för engagemangsindex v0.1.0

## CapabilityStatement: EI-on-FHIR server 

 [Rå OpenAPI-Swagger-definitionsfil](../IneraEngagementIndexServer.openapi.json) | [Ladda ner](../IneraEngagementIndexServer.openapi.json) 



## Resource Content

```json
{
  "resourceType" : "CapabilityStatement",
  "id" : "IneraEngagementIndexServer",
  "url" : "https://fhir.inera.se/ig/engagementindex/CapabilityStatement/IneraEngagementIndexServer",
  "version" : "0.1.0",
  "name" : "IneraEngagementIndexServer",
  "title" : "EI-on-FHIR server",
  "status" : "draft",
  "experimental" : false,
  "date" : "2026-11-13",
  "publisher" : "Inera AB",
  "contact" : [{
    "name" : "Inera AB",
    "telecom" : [{
      "system" : "url",
      "value" : "https://www.inera.se"
    }]
  }],
  "description" : "Krav på EI-on-FHIR som server: läsning och sökning av engagemangsposter från EI och från EI-on-FHIR:s register, registrering i registret för FHIR-producenter. Massuttag med Bulk Data $export krävs i text på IG-sidan API, eftersom Bulk Data Access bara finns för R4.",
  "jurisdiction" : [{
    "coding" : [{
      "system" : "urn:iso:std:iso:3166",
      "code" : "SE",
      "display" : "Sweden"
    }]
  }],
  "kind" : "requirements",
  "fhirVersion" : "5.0.0",
  "format" : ["json"],
  "implementationGuide" : ["https://fhir.inera.se/ig/engagementindex/ImplementationGuide/inera.ei.engagementindex"],
  "rest" : [{
    "mode" : "server",
    "documentation" : "API ovanpå engagemangsindex, för Ineras interna stödtjänster och för FHIR-producenter. Poster från EI är skrivskyddade; FHIR-producenter skriver bara i EI-on-FHIR:s register. Varje anrop autentiseras som ett system och loggas. Se sidan Säkerhet och loggning.",
    "security" : {
      "description" : "SMART Backend Services med systembehörigheter och tre klientroller: stödtjänst, synktjänst och producent. Sökning utan patient och massuttag kräver behörighet för synk; skrivning kräver behörighet som producent."
    },
    "resource" : [{
      "type" : "DocumentReference",
      "profile" : "https://fhir.inera.se/ig/engagementindex/StructureDefinition/IneraEngagement",
      "documentation" : "Engagemangsposter från EI och från EI-on-FHIR:s register, i samma sökresultat. En sökning utan status returnerar bara poster med status current. En sökning måste ange subject:identifier, utom för klienter med behörighet för synk. En producent skriver med villkorad update på identifier och tar bort med delete; villkoret och borttaget gäller bara producentens egna poster i registret.",
      "interaction" : [{
        "extension" : [{
          "url" : "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation",
          "valueCode" : "SHALL"
        }],
        "code" : "read"
      },
      {
        "extension" : [{
          "url" : "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation",
          "valueCode" : "SHALL"
        }],
        "code" : "search-type"
      },
      {
        "extension" : [{
          "url" : "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation",
          "valueCode" : "SHALL"
        }],
        "code" : "update",
        "documentation" : "Villkorad update: PUT DocumentReference?identifier=[värde]. Skapar posten om producenten inte har någon post med identifieraren, annars uppdateras den."
      },
      {
        "extension" : [{
          "url" : "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation",
          "valueCode" : "SHALL"
        }],
        "code" : "delete",
        "documentation" : "DELETE DocumentReference/[id] för en post i registret. Posten visas därefter med status superseded under borttagsloggens lagringstid."
      }],
      "versioning" : "no-version",
      "updateCreate" : false,
      "conditionalCreate" : false,
      "conditionalUpdate" : true,
      "conditionalDelete" : "not-supported",
      "searchParam" : [{
        "extension" : [{
          "url" : "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation",
          "valueCode" : "SHALL"
        }],
        "name" : "subject",
        "definition" : "http://hl7.org/fhir/SearchParameter/DocumentReference-subject",
        "type" : "reference",
        "documentation" : "Med modifieraren :identifier, till exempel subject:identifier=http://electronichealth.se/identifier/personnummer|191212121212."
      },
      {
        "extension" : [{
          "url" : "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation",
          "valueCode" : "SHALL"
        }],
        "name" : "type",
        "definition" : "http://hl7.org/fhir/SearchParameter/clinical-type",
        "type" : "token"
      },
      {
        "extension" : [{
          "url" : "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation",
          "valueCode" : "SHALL"
        }],
        "name" : "logical-address",
        "definition" : "https://fhir.inera.se/ig/engagementindex/SearchParameter/DocumentReference-logical-address",
        "type" : "token"
      },
      {
        "extension" : [{
          "url" : "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation",
          "valueCode" : "SHALL"
        }],
        "name" : "status",
        "definition" : "http://hl7.org/fhir/SearchParameter/DocumentReference-status",
        "type" : "token",
        "documentation" : "Standardvärde current. Borttagna poster returneras bara när status=superseded anges."
      },
      {
        "extension" : [{
          "url" : "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation",
          "valueCode" : "SHALL"
        }],
        "name" : "_lastUpdated",
        "definition" : "http://hl7.org/fhir/SearchParameter/Resource-lastUpdated",
        "type" : "date",
        "documentation" : "Inkrementell synk, tillsammans med status=current,superseded och _sort=_lastUpdated."
      },
      {
        "extension" : [{
          "url" : "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation",
          "valueCode" : "SHOULD"
        }],
        "name" : "category",
        "definition" : "http://hl7.org/fhir/SearchParameter/DocumentReference-category",
        "type" : "token"
      },
      {
        "extension" : [{
          "url" : "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation",
          "valueCode" : "SHOULD"
        }],
        "name" : "custodian",
        "definition" : "http://hl7.org/fhir/SearchParameter/DocumentReference-custodian",
        "type" : "reference",
        "documentation" : "Med modifieraren :identifier och HSA-id."
      },
      {
        "extension" : [{
          "url" : "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation",
          "valueCode" : "SHOULD"
        }],
        "name" : "source-system",
        "definition" : "https://fhir.inera.se/ig/engagementindex/SearchParameter/DocumentReference-source-system",
        "type" : "token"
      },
      {
        "extension" : [{
          "url" : "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation",
          "valueCode" : "SHOULD"
        }],
        "name" : "format-code",
        "definition" : "http://hl7.org/fhir/SearchParameter/DocumentReference-format-code",
        "type" : "token",
        "documentation" : "Hämtningsprotokoll, riv-ta eller fhir."
      },
      {
        "extension" : [{
          "url" : "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation",
          "valueCode" : "SHALL"
        }],
        "name" : "identifier",
        "definition" : "http://hl7.org/fhir/SearchParameter/clinical-identifier",
        "type" : "token",
        "documentation" : "För producentens villkorade update."
      },
      {
        "extension" : [{
          "url" : "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation",
          "valueCode" : "SHOULD"
        }],
        "name" : "_id",
        "definition" : "http://hl7.org/fhir/SearchParameter/Resource-id",
        "type" : "token"
      }]
    }]
  }]
}

```
