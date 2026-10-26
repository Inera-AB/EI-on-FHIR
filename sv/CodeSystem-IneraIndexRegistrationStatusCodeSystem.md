# Kodsystem för registreringsstatus - FHIR-baserat engagemangsindex (FHIR-EI) v0.1.0

## CodeSystem: Kodsystem för registreringsstatus 

Detta kodsystem refereras i definitionen av följande värdemängder:

* [Registreringsstatus för indexposter](ValueSet-IneraIndexRegistrationStatusValueSet.md)

-------

 [Beskrivning av ovanstående tabell(er)](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#terminology). 



## Resource Content

```json
{
  "resourceType" : "CodeSystem",
  "id" : "IneraIndexRegistrationStatusCodeSystem",
  "url" : "https://fhir.inera.se/ig/engagementindex/CodeSystem/IneraIndexRegistrationStatusCodeSystem",
  "identifier" : [{
    "value" : "IneraIndexRegistrationStatusCodeSystem"
  }],
  "version" : "0.1.0",
  "name" : "IneraIndexRegistrationStatusCodeSystem",
  "title" : "Kodsystem för registreringsstatus",
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
  "description" : "En indexposts livscykeltillstånd. Varje kod motsvarar ett värde i DocumentReference.status.",
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
    "code" : "active",
    "display" : "Registrerad",
    "definition" : "Informationen finns tillgänglig hos producenten. Basstatus current."
  },
  {
    "code" : "withdrawn",
    "display" : "Indragen",
    "definition" : "Producenten har avsiktligt och varaktigt dragit tillbaka posten. Basstatus superseded."
  },
  {
    "code" : "entered-in-error",
    "display" : "Felregistrerad",
    "definition" : "Posten skulle aldrig ha funnits. Basstatus entered-in-error."
  }]
}

```
