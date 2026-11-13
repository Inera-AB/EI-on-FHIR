# Sökparameter source-system - EI-on-FHIR: FHIR-API för engagemangsindex v0.1.0

## SearchParameter: Sökparameter source-system 



## Resource Content

```json
{
  "resourceType" : "SearchParameter",
  "id" : "DocumentReference-source-system",
  "url" : "https://fhir.inera.se/ig/engagementindex/SearchParameter/DocumentReference-source-system",
  "version" : "0.1.0",
  "name" : "SourceSystem",
  "title" : "Sökparameter source-system",
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
  "description" : "Söker engagemangsposter på källsystem (extension sourceSystem).",
  "jurisdiction" : [{
    "coding" : [{
      "system" : "urn:iso:std:iso:3166",
      "code" : "SE",
      "display" : "Sweden"
    }]
  }],
  "code" : "source-system",
  "base" : ["DocumentReference"],
  "type" : "token",
  "expression" : "DocumentReference.extension('https://fhir.inera.se/ig/engagementindex/StructureDefinition/SourceSystem').value.ofType(Identifier)",
  "processingMode" : "normal"
}

```
