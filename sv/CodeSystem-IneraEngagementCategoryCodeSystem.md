# Kodsystem för kategorier inom tjänstedomän - FHIR-baserat engagemangsindex (FHIR-EI) v0.1.0

## CodeSystem: Kodsystem för kategorier inom tjänstedomän 

Detta kodsystem refereras i definitionen av följande värdemängder:

* [Kategorier inom tjänstedomän](ValueSet-IneraEngagementCategoryValueSet.md)

-------

 [Beskrivning av ovanstående tabell(er)](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#terminology). 



## Resource Content

```json
{
  "resourceType" : "CodeSystem",
  "id" : "IneraEngagementCategoryCodeSystem",
  "url" : "https://fhir.inera.se/ig/engagementindex/CodeSystem/IneraEngagementCategoryCodeSystem",
  "identifier" : [{
    "value" : "IneraEngagementCategoryCodeSystem"
  }],
  "version" : "0.1.0",
  "name" : "IneraEngagementCategoryCodeSystem",
  "title" : "Kodsystem för kategorier inom tjänstedomän",
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
  "description" : "Kategorier inom en tjänstedomän, som anger informationsmängd i FHIR-EI under övergången till profil-canonicals. Motsvarar categorization i dagens engagemangsindex. Utdrag; den fullständiga förteckningen förvaltas tillsammans med tjänstedomänerna.",
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
    "code" : "voo",
    "display" : "voo",
    "definition" : "Kategorin voo inom tjänstedomänen riv:clinicalprocess:healthcond:description."
  }]
}

```
