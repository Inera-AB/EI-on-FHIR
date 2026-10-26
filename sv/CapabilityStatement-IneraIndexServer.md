# FHIR-EI server - FHIR-baserat engagemangsindex (FHIR-EI) v0.1.0

## CapabilityStatement: FHIR-EI server 

 [Rå OpenAPI-Swagger-definitionsfil](../IneraIndexServer.openapi.json) | [Ladda ner](../IneraIndexServer.openapi.json) 



## Resource Content

```json
{
  "resourceType" : "CapabilityStatement",
  "id" : "IneraIndexServer",
  "url" : "https://fhir.inera.se/ig/engagementindex/CapabilityStatement/IneraIndexServer",
  "version" : "0.1.0",
  "name" : "IneraIndexServer",
  "title" : "FHIR-EI server",
  "status" : "draft",
  "experimental" : false,
  "date" : "2026-10-26",
  "publisher" : "Inera AB",
  "contact" : [{
    "name" : "Inera AB",
    "telecom" : [{
      "system" : "url",
      "value" : "https://www.inera.se"
    }]
  }],
  "description" : "Krav på FHIR-EI som server: sökning, registrering och avregistrering, prenumeration, inkrementell avstämning och massuttag av indexposter.",
  "jurisdiction" : [{
    "coding" : [{
      "system" : "urn:iso:std:iso:3166",
      "code" : "SE",
      "display" : "Sweden"
    }]
  }],
  "kind" : "requirements",
  "fhirVersion" : "5.0.0",
  "format" : ["json", "xml"],
  "implementationGuide" : ["https://fhir.inera.se/ig/engagementindex/ImplementationGuide/inera.ei.engagementindex"],
  "rest" : [{
    "mode" : "server",
    "documentation" : "Alla läs-, skriv-, prenumerations- och exportanrop går genom samma centrala kontroll av behörighet, spärr och loggning. Se sidan Spärr, loggning och behörighet.",
    "security" : {
      "description" : "Se sidan Spärr, loggning och behörighet."
    },
    "resource" : [{
      "type" : "DocumentReference",
      "profile" : "https://fhir.inera.se/ig/engagementindex/StructureDefinition/IneraIndexEntry",
      "documentation" : "Indexposter. En producent får bara skapa, uppdatera och avregistrera poster som tillhör dess registrerade identitet. Avregistrering sker med villkorad uppdatering, aldrig med delete. En sökning utan status-parameter returnerar bara poster med status current.",
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
        "code" : "vread"
      },
      {
        "extension" : [{
          "url" : "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation",
          "valueCode" : "SHALL"
        }],
        "code" : "update",
        "documentation" : "Villkorad uppdatering på identifier: PUT DocumentReference?identifier=system|value."
      },
      {
        "extension" : [{
          "url" : "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation",
          "valueCode" : "SHALL"
        }],
        "code" : "history-instance"
      },
      {
        "extension" : [{
          "url" : "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation",
          "valueCode" : "SHALL"
        }],
        "code" : "search-type"
      }],
      "versioning" : "versioned",
      "readHistory" : true,
      "updateCreate" : true,
      "conditionalCreate" : false,
      "conditionalUpdate" : true,
      "conditionalDelete" : "not-supported",
      "searchParam" : [{
        "extension" : [{
          "url" : "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation",
          "valueCode" : "SHALL"
        }],
        "name" : "patient",
        "definition" : "http://hl7.org/fhir/SearchParameter/clinical-patient",
        "type" : "reference",
        "documentation" : "Med modifieraren :identifier, t.ex. patient:identifier=http://electronichealth.se/identifier/personnummer|191212121212."
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
        "name" : "status",
        "definition" : "http://hl7.org/fhir/SearchParameter/DocumentReference-status",
        "type" : "token",
        "documentation" : "Standardvärde current. Avregistrerade poster returneras bara när status anges explicit."
      },
      {
        "extension" : [{
          "url" : "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation",
          "valueCode" : "SHALL"
        }],
        "name" : "custodian",
        "definition" : "http://hl7.org/fhir/SearchParameter/DocumentReference-custodian",
        "type" : "reference",
        "documentation" : "Vårdgivare, med modifieraren :identifier och HSA-id."
      },
      {
        "extension" : [{
          "url" : "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation",
          "valueCode" : "SHALL"
        }],
        "name" : "identifier",
        "definition" : "http://hl7.org/fhir/SearchParameter/clinical-identifier",
        "type" : "token"
      },
      {
        "extension" : [{
          "url" : "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation",
          "valueCode" : "SHALL"
        }],
        "name" : "format-code",
        "definition" : "http://hl7.org/fhir/SearchParameter/DocumentReference-format-code",
        "type" : "token",
        "documentation" : "Informationsmängd som kategori (content.profile som Coding)."
      },
      {
        "extension" : [{
          "url" : "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation",
          "valueCode" : "SHALL"
        }],
        "name" : "format-canonical",
        "definition" : "http://hl7.org/fhir/SearchParameter/DocumentReference-format-canonical",
        "type" : "reference",
        "documentation" : "Informationsmängd som profil-canonical (content.profile som canonical)."
      },
      {
        "extension" : [{
          "url" : "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation",
          "valueCode" : "SHALL"
        }],
        "name" : "content-last-updated",
        "definition" : "https://fhir.inera.se/ig/engagementindex/SearchParameter/DocumentReference-content-last-updated",
        "type" : "date"
      },
      {
        "extension" : [{
          "url" : "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation",
          "valueCode" : "SHALL"
        }],
        "name" : "source-endpoint",
        "definition" : "https://fhir.inera.se/ig/engagementindex/SearchParameter/DocumentReference-source-endpoint",
        "type" : "reference"
      },
      {
        "extension" : [{
          "url" : "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation",
          "valueCode" : "SHALL"
        }],
        "name" : "_lastUpdated",
        "definition" : "http://hl7.org/fhir/SearchParameter/Resource-lastUpdated",
        "type" : "date",
        "documentation" : "Inkrementell avstämning, tillsammans med status=current,superseded,entered-in-error."
      }]
    },
    {
      "type" : "Subscription",
      "profile" : "https://fhir.inera.se/ig/engagementindex/StructureDefinition/IneraIndexSubscription",
      "documentation" : "Topic-baserade prenumerationer på topic indexpost-andrad. Notiser filtreras på samma sätt som sökningar.",
      "interaction" : [{
        "extension" : [{
          "url" : "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation",
          "valueCode" : "SHALL"
        }],
        "code" : "create"
      },
      {
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
        "code" : "update"
      },
      {
        "extension" : [{
          "url" : "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation",
          "valueCode" : "SHALL"
        }],
        "code" : "delete"
      },
      {
        "extension" : [{
          "url" : "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation",
          "valueCode" : "SHALL"
        }],
        "code" : "search-type"
      }],
      "operation" : [{
        "extension" : [{
          "url" : "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation",
          "valueCode" : "SHALL"
        }],
        "name" : "status",
        "definition" : "http://hl7.org/fhir/OperationDefinition/Subscription-status"
      },
      {
        "extension" : [{
          "url" : "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation",
          "valueCode" : "SHALL"
        }],
        "name" : "events",
        "definition" : "http://hl7.org/fhir/OperationDefinition/Subscription-events"
      }]
    },
    {
      "type" : "SubscriptionTopic",
      "documentation" : "Servern exponerar topic indexpost-andrad.",
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
      }]
    }],
    "interaction" : [{
      "extension" : [{
        "url" : "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation",
        "valueCode" : "SHALL"
      }],
      "code" : "transaction",
      "documentation" : "Producenter registrerar och avregistrerar flera poster i en transaction-Bundle. Den registreras helt eller inte alls."
    }]
  }]
}

```
