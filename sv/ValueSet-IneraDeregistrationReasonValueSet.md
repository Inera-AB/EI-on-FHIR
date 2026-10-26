# Orsaker till avregistrering - FHIR-baserat engagemangsindex (FHIR-EI) v0.1.0

## ValueSet: Orsaker till avregistrering 

 **References** 

* [Orsak till avregistrering](StructureDefinition-DeregistrationReason.md)

### Logisk definition (CLD)

 

### Expansion

-------

 [Beskrivning av ovanstående tabell(er)](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#terminology). 



## Resource Content

```json
{
  "resourceType" : "ValueSet",
  "id" : "IneraDeregistrationReasonValueSet",
  "url" : "https://fhir.inera.se/ig/engagementindex/ValueSet/IneraDeregistrationReasonValueSet",
  "identifier" : [{
    "value" : "IneraDeregistrationReasonValueSet"
  }],
  "version" : "0.1.0",
  "name" : "IneraDeregistrationReasonValueSet",
  "title" : "Orsaker till avregistrering",
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
  "description" : "Alla orsaker till avregistrering av en indexpost.",
  "jurisdiction" : [{
    "coding" : [{
      "system" : "urn:iso:std:iso:3166",
      "code" : "SE",
      "display" : "Sweden"
    }]
  }],
  "compose" : {
    "include" : [{
      "system" : "https://fhir.inera.se/ig/engagementindex/CodeSystem/IneraDeregistrationReasonCodeSystem"
    }]
  }
}

```
