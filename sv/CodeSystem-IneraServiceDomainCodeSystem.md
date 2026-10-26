# Kodsystem för tjänstedomäner - FHIR-baserat engagemangsindex (FHIR-EI) v0.1.0

## CodeSystem: Kodsystem för tjänstedomäner 

Detta kodsystem refereras i definitionen av följande värdemängder:

* [Tjänstedomäner](ValueSet-IneraServiceDomainValueSet.md)

-------

 [Beskrivning av ovanstående tabell(er)](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#terminology). 



## Resource Content

```json
{
  "resourceType" : "CodeSystem",
  "id" : "IneraServiceDomainCodeSystem",
  "url" : "https://fhir.inera.se/ig/engagementindex/CodeSystem/IneraServiceDomainCodeSystem",
  "identifier" : [{
    "value" : "IneraServiceDomainCodeSystem"
  }],
  "version" : "0.1.0",
  "name" : "IneraServiceDomainCodeSystem",
  "title" : "Kodsystem för tjänstedomäner",
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
  "description" : "Tjänstedomäner, som anger tjänst i FHIR-EI under övergången till IG-canonicals. Utdrag; den fullständiga förteckningen förvaltas i Ineras förteckning över tjänstedomäner.",
  "jurisdiction" : [{
    "coding" : [{
      "system" : "urn:iso:std:iso:3166",
      "code" : "SE",
      "display" : "Sweden"
    }]
  }],
  "caseSensitive" : true,
  "content" : "fragment",
  "concept" : [{
    "code" : "riv:clinicalprocess:healthcond:description",
    "display" : "riv:clinicalprocess:healthcond:description",
    "definition" : "Tjänstedomänen riv:clinicalprocess:healthcond:description."
  }]
}

```
