# Hämtningsprotokoll - EI-on-FHIR: FHIR-API för engagemangsindex v0.1.0

## ValueSet: Hämtningsprotokoll 

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
  "id" : "IneraRetrievalProtocolValueSet",
  "url" : "https://fhir.inera.se/ig/engagementindex/ValueSet/IneraRetrievalProtocolValueSet",
  "identifier" : [{
    "value" : "IneraRetrievalProtocolValueSet"
  }],
  "version" : "0.1.0",
  "name" : "IneraRetrievalProtocolValueSet",
  "title" : "Hämtningsprotokoll",
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
  "description" : "Alla hämtningsprotokoll för engagemangsposter.",
  "jurisdiction" : [{
    "coding" : [{
      "system" : "urn:iso:std:iso:3166",
      "code" : "SE",
      "display" : "Sweden"
    }]
  }],
  "compose" : {
    "include" : [{
      "system" : "https://fhir.inera.se/ig/engagementindex/CodeSystem/IneraRetrievalProtocolCodeSystem"
    }]
  }
}

```
