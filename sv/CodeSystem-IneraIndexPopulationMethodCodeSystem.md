# Kodsystem för försörjningssätt - FHIR-baserat engagemangsindex (FHIR-EI) v0.1.0

## CodeSystem: Kodsystem för försörjningssätt 

Detta kodsystem refereras i definitionen av följande värdemängder:

* [Försörjningssätt](ValueSet-IneraIndexPopulationMethodValueSet.md)

-------

 [Beskrivning av ovanstående tabell(er)](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#terminology). 



## Resource Content

```json
{
  "resourceType" : "CodeSystem",
  "id" : "IneraIndexPopulationMethodCodeSystem",
  "url" : "https://fhir.inera.se/ig/engagementindex/CodeSystem/IneraIndexPopulationMethodCodeSystem",
  "identifier" : [{
    "value" : "IneraIndexPopulationMethodCodeSystem"
  }],
  "version" : "0.1.0",
  "name" : "IneraIndexPopulationMethodCodeSystem",
  "title" : "Kodsystem för försörjningssätt",
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
  "description" : "Hur en indexpost har kommit till. Försörjningen väljs per tjänst; konsumenterna läser posterna på samma sätt oavsett försörjningssätt.",
  "jurisdiction" : [{
    "coding" : [{
      "system" : "urn:iso:std:iso:3166",
      "code" : "SE",
      "display" : "Sweden"
    }]
  }],
  "caseSensitive" : true,
  "content" : "complete",
  "count" : 3,
  "concept" : [{
    "code" : "producer",
    "display" : "Producentregistrering",
    "definition" : "Producenten har registrerat posten, direkt eller via en indexeringsagent."
  },
  {
    "code" : "cache",
    "display" : "Inera-försörjd cache",
    "definition" : "Ineras lokaliseringstjänst har fyllt posten utifrån eHM:s patientindex och en riktad fråga till källan."
  },
  {
    "code" : "mirror",
    "display" : "Spegling av dagens engagemangsindex",
    "definition" : "Övergångsadaptern har speglat posten från dagens engagemangsindex."
  }]
}

```
