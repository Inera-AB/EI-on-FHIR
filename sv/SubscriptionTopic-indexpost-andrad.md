# Indexpost ändrad - FHIR-baserat engagemangsindex (FHIR-EI) v0.1.0

## SubscriptionTopic: Indexpost ändrad 



## Resource Content

```json
{
  "resourceType" : "SubscriptionTopic",
  "id" : "indexpost-andrad",
  "url" : "https://fhir.inera.se/ig/engagementindex/SubscriptionTopic/indexpost-andrad",
  "version" : "0.1.0",
  "name" : "IndexpostAndrad",
  "title" : "Indexpost ändrad",
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
  "description" : "Triggar när en indexpost skapas, uppdateras eller avregistreras. Avregistrering är en uppdatering till status superseded eller entered-in-error, inte en radering.",
  "jurisdiction" : [{
    "coding" : [{
      "system" : "urn:iso:std:iso:3166",
      "code" : "SE",
      "display" : "Sweden"
    }]
  }],
  "resourceTrigger" : [{
    "description" : "En indexpost skapas, uppdateras eller avregistreras.",
    "resource" : "http://hl7.org/fhir/StructureDefinition/DocumentReference",
    "supportedInteraction" : ["create", "update"]
  }]
}

```
