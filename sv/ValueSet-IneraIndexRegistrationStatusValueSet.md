# Registreringsstatus för indexposter - FHIR-baserat engagemangsindex (FHIR-EI) v0.1.0

## ValueSet: Registreringsstatus för indexposter 

 **References** 

* [Registreringsstatus](StructureDefinition-RegistrationStatus.md)

### Logisk definition (CLD)

 

### Expansion

-------

 [Beskrivning av ovanstående tabell(er)](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#terminology). 



## Resource Content

```json
{
  "resourceType" : "ValueSet",
  "id" : "IneraIndexRegistrationStatusValueSet",
  "url" : "https://fhir.inera.se/ig/engagementindex/ValueSet/IneraIndexRegistrationStatusValueSet",
  "identifier" : [{
    "value" : "IneraIndexRegistrationStatusValueSet"
  }],
  "version" : "0.1.0",
  "name" : "IneraIndexRegistrationStatusValueSet",
  "title" : "Registreringsstatus för indexposter",
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
  "description" : "Alla livscykeltillstånd för en indexpost.",
  "jurisdiction" : [{
    "coding" : [{
      "system" : "urn:iso:std:iso:3166",
      "code" : "SE",
      "display" : "Sweden"
    }]
  }],
  "compose" : {
    "include" : [{
      "system" : "https://fhir.inera.se/ig/engagementindex/CodeSystem/IneraIndexRegistrationStatusCodeSystem"
    }]
  }
}

```
