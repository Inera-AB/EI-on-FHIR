# Kodsystem för hämtningsprotokoll - EI-on-FHIR: FHIR-API för engagemangsindex v0.1.0

## CodeSystem: Kodsystem för hämtningsprotokoll 

Detta kodsystem refereras i definitionen av följande värdemängder:

* [Hämtningsprotokoll](ValueSet-IneraRetrievalProtocolValueSet.md)

-------

 [Beskrivning av ovanstående tabell(er)](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#terminology). 



## Resource Content

```json
{
  "resourceType" : "CodeSystem",
  "id" : "IneraRetrievalProtocolCodeSystem",
  "url" : "https://fhir.inera.se/ig/engagementindex/CodeSystem/IneraRetrievalProtocolCodeSystem",
  "identifier" : [{
    "value" : "IneraRetrievalProtocolCodeSystem"
  }],
  "version" : "0.1.0",
  "name" : "IneraRetrievalProtocolCodeSystem",
  "title" : "Kodsystem för hämtningsprotokoll",
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
  "description" : "Hur en konsument hämtar den information som en engagemangspost pekar ut.",
  "jurisdiction" : [{
    "coding" : [{
      "system" : "urn:iso:std:iso:3166",
      "code" : "SE",
      "display" : "Sweden"
    }]
  }],
  "caseSensitive" : true,
  "content" : "complete",
  "count" : 2,
  "concept" : [{
    "code" : "riv-ta",
    "display" : "RIV-TA",
    "definition" : "Ett tjänstekontrakt i postens tjänstedomän, via tjänsteplattformen och postens logiska adress."
  },
  {
    "code" : "fhir",
    "display" : "FHIR",
    "definition" : "FHIR-API:t på den endpoint som anges i postens attachment.url, i den FHIR-version som tjänstens IG anger."
  }]
}

```
