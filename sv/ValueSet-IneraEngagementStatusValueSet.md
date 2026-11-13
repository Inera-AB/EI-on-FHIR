# Status för engagemangsposter - EI-on-FHIR: FHIR-API för engagemangsindex v0.1.0

## ValueSet: Status för engagemangsposter 

 **References** 

* [Engagemangspost](StructureDefinition-IneraEngagement.md)

### Logisk definition (CLD)

 

### Expansion

-------

 [Beskrivning av ovanstående tabell(er)](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#terminology). 



## Resource Content

```json
{
  "resourceType" : "ValueSet",
  "id" : "IneraEngagementStatusValueSet",
  "url" : "https://fhir.inera.se/ig/engagementindex/ValueSet/IneraEngagementStatusValueSet",
  "identifier" : [{
    "value" : "IneraEngagementStatusValueSet"
  }],
  "version" : "0.1.0",
  "name" : "IneraEngagementStatusValueSet",
  "title" : "Status för engagemangsposter",
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
  "description" : "current för en registrerad post, superseded för en post som har tagits bort och visas under borttagsloggens lagringstid.",
  "jurisdiction" : [{
    "coding" : [{
      "system" : "urn:iso:std:iso:3166",
      "code" : "SE",
      "display" : "Sweden"
    }]
  }],
  "compose" : {
    "include" : [{
      "system" : "http://hl7.org/fhir/document-reference-status",
      "concept" : [{
        "code" : "current"
      },
      {
        "code" : "superseded"
      }]
    }]
  }
}

```
