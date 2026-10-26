# Sök på producentens endpoint - FHIR-baserat engagemangsindex (FHIR-EI) v0.1.0

## SearchParameter: Sök på producentens endpoint 



## Resource Content

```json
{
  "resourceType" : "SearchParameter",
  "id" : "DocumentReference-source-endpoint",
  "url" : "https://fhir.inera.se/ig/engagementindex/SearchParameter/DocumentReference-source-endpoint",
  "version" : "0.1.0",
  "name" : "SourceEndpoint",
  "title" : "Sök på producentens endpoint",
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
  "description" : "Producentens endpoint i tjänstekatalogen (extension sourceEndpoint).",
  "jurisdiction" : [{
    "coding" : [{
      "system" : "urn:iso:std:iso:3166",
      "code" : "SE",
      "display" : "Sweden"
    }]
  }],
  "code" : "source-endpoint",
  "base" : ["DocumentReference"],
  "type" : "reference",
  "expression" : "DocumentReference.extension('https://fhir.inera.se/ig/engagementindex/StructureDefinition/SourceEndpoint').value",
  "processingMode" : "normal",
  "target" : ["Endpoint"]
}

```
