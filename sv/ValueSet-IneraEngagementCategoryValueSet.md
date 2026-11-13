# Kategorier inom tjänstedomän - EI-on-FHIR: FHIR-API för engagemangsindex v0.1.0

## ValueSet: Kategorier inom tjänstedomän 

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
  "date" : "2026-11-13",
  "publisher" : "Inera AB",
  "contact" : [{
    "name" : "Inera AB",
    "telecom" : [{
      "system" : "url",
      "value" : "https://www.inera.se"
    }]
  }],
  "description" : "Alla kategorier i kodsystemet för kategorier inom tjänstedomän.",
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
