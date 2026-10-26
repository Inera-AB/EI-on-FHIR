# Sök på innehållets senaste ändring - FHIR-baserat engagemangsindex (FHIR-EI) v0.1.0

## SearchParameter: Sök på innehållets senaste ändring 



## Resource Content

```json
{
  "resourceType" : "SearchParameter",
  "id" : "DocumentReference-content-last-updated",
  "url" : "https://fhir.inera.se/ig/engagementindex/SearchParameter/DocumentReference-content-last-updated",
  "version" : "0.1.0",
  "name" : "ContentLastUpdated",
  "title" : "Sök på innehållets senaste ändring",
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
  "description" : "Filtrerar indexposter på när det kliniska innehållet i källsystemet senast ändrades (extension contentLastUpdated). Ersätter tidsfiltret i FindContent.",
  "jurisdiction" : [{
    "coding" : [{
      "system" : "urn:iso:std:iso:3166",
      "code" : "SE",
      "display" : "Sweden"
    }]
  }],
  "code" : "content-last-updated",
  "base" : ["DocumentReference"],
  "type" : "date",
  "expression" : "DocumentReference.extension('https://fhir.inera.se/ig/engagementindex/StructureDefinition/ContentLastUpdated').value",
  "processingMode" : "normal",
  "comparator" : ["eq", "gt", "ge", "lt", "le"]
}

```
