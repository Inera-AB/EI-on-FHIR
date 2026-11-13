# Sökparameter logical-address - EI-on-FHIR: FHIR-API för engagemangsindex v0.1.0

## SearchParameter: Sökparameter logical-address 



## Resource Content

```json
{
  "resourceType" : "SearchParameter",
  "id" : "DocumentReference-logical-address",
  "url" : "https://fhir.inera.se/ig/engagementindex/SearchParameter/DocumentReference-logical-address",
  "version" : "0.1.0",
  "name" : "LogicalAddress",
  "title" : "Sökparameter logical-address",
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
  "description" : "Söker engagemangsposter på logisk adress (extension logicalAddress), till exempel en vårdgivares HSA-id.",
  "jurisdiction" : [{
    "coding" : [{
      "system" : "urn:iso:std:iso:3166",
      "code" : "SE",
      "display" : "Sweden"
    }]
  }],
  "code" : "logical-address",
  "base" : ["DocumentReference"],
  "type" : "token",
  "expression" : "DocumentReference.extension('https://fhir.inera.se/ig/engagementindex/StructureDefinition/LogicalAddress').value.ofType(Identifier)",
  "processingMode" : "normal"
}

```
