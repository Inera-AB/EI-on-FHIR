# Kategorier inom tjänstedomän - FHIR-baserat engagemangsindex (FHIR-EI) v0.1.0

## ValueSet: Kategorier inom tjänstedomän 

 **References** 

* [Indexpost (FHIR-EI)](StructureDefinition-IneraIndexEntry.md)

### Logisk definition (CLD)

 

### Expansion

-------

 [Beskrivning av ovanstående tabell(er)](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#terminology). 



## Resource Content

```json
{
  "resourceType" : "ValueSet",
  "id" : "IneraEngagementCategoryValueSet",
  "url" : "https://fhir.inera.se/ig/engagementindex/ValueSet/IneraEngagementCategoryValueSet",
  "identifier" : [{
    "value" : "IneraEngagementCategoryValueSet"
  }],
  "version" : "0.1.0",
  "name" : "IneraEngagementCategoryValueSet",
  "title" : "Kategorier inom tjänstedomän",
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
  "description" : "Alla kategorier i kodverket för kategorier inom tjänstedomän.",
  "jurisdiction" : [{
    "coding" : [{
      "system" : "urn:iso:std:iso:3166",
      "code" : "SE",
      "display" : "Sweden"
    }]
  }],
  "compose" : {
    "include" : [{
      "system" : "https://fhir.inera.se/ig/engagementindex/CodeSystem/IneraEngagementCategoryCodeSystem"
    }]
  }
}

```
