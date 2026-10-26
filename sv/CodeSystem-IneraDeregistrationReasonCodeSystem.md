# Kodsystem för orsaker till avregistrering - FHIR-baserat engagemangsindex (FHIR-EI) v0.1.0

## CodeSystem: Kodsystem för orsaker till avregistrering 

Detta kodsystem refereras i definitionen av följande värdemängder:

* [Orsaker till avregistrering](ValueSet-IneraDeregistrationReasonValueSet.md)

-------

 [Beskrivning av ovanstående tabell(er)](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#terminology). 



## Resource Content

```json
{
  "resourceType" : "CodeSystem",
  "id" : "IneraDeregistrationReasonCodeSystem",
  "url" : "https://fhir.inera.se/ig/engagementindex/CodeSystem/IneraDeregistrationReasonCodeSystem",
  "identifier" : [{
    "value" : "IneraDeregistrationReasonCodeSystem"
  }],
  "version" : "0.1.0",
  "name" : "IneraDeregistrationReasonCodeSystem",
  "title" : "Kodsystem för orsaker till avregistrering",
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
  "description" : "Varför en indexpost avregistreras. Orsaken avgör hur mottagare, till exempel ett tunt index, ska hantera avregistreringen.",
  "jurisdiction" : [{
    "coding" : [{
      "system" : "urn:iso:std:iso:3166",
      "code" : "SE",
      "display" : "Sweden"
    }]
  }],
  "caseSensitive" : true,
  "content" : "complete",
  "count" : 4,
  "concept" : [{
    "code" : "entered-in-error",
    "display" : "Felregistrering",
    "definition" : "Posten skulle aldrig ha registrerats. Används med registreringsstatus entered-in-error."
  },
  {
    "code" : "ended",
    "display" : "Avslutat engagemang",
    "definition" : "Producenten håller inte längre information om patienten inom tjänsten. Används med registreringsstatus withdrawn."
  },
  {
    "code" : "purged",
    "display" : "Gallring",
    "definition" : "Informationen har gallrats hos producenten. Används med registreringsstatus withdrawn."
  },
  {
    "code" : "transition-adapter",
    "display" : "Avregistrering via övergångsadapter",
    "definition" : "Posten avregistrerades i dagens engagemangsindex, vars kontrakt inte bär någon orsak. Används med registreringsstatus withdrawn."
  }]
}

```
