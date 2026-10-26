# Prenumeration på indexposter (FHIR-EI) - FHIR-baserat engagemangsindex (FHIR-EI) v0.1.0

## Resursprofil: Prenumeration på indexposter (FHIR-EI) 

**Användningar:**

* Exempel för denna Profil: [Subscription/PrenumerationForPatient](Subscription-PrenumerationForPatient.md)
* CapabilityStatements som använder denna Profil: [FHIR-EI server](CapabilityStatement-IneraIndexServer.md)

Du kan också kontrollera [användningar i FHIR IG-statistiken](https://packages2.fhir.org/xig/inera.ei.engagementindex|current/StructureDefinition/IneraIndexSubscription)

### Formella vyer av profilinnehåll

 [Beskrivningsdifferentialer, ögonblicksbilder och andra representationer](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

*  [Tabell med nyckelelement](#tabs-key) 
*  [Differentialtabell](#tabs-diff) 
*  [Ögonblicksbildstabell](#tabs-snap) 
*  [Statistik/referenser](#tabs-summ) 
*  [Alla](#tabs-all) 

#### Terminologibindningar

#### Begränsningar

Denna struktur är härledd från [Subscription](http://hl7.org/fhir/R5/subscription.html) 

#### Terminologibindningar

#### Begränsningar

Denna struktur är härledd från [Subscription](http://hl7.org/fhir/R5/subscription.html) 

 **Vy med nyckelelement** 

#### Terminologibindningar

#### Begränsningar

 **Differentialvy** 

Denna struktur är härledd från [Subscription](http://hl7.org/fhir/R5/subscription.html) 

 **ÖgonblicksbildsvyView** 

#### Terminologibindningar

#### Begränsningar

Denna struktur är härledd från [Subscription](http://hl7.org/fhir/R5/subscription.html) 

 

Andra representationer av profilen: [CSV](../StructureDefinition-IneraIndexSubscription.csv), [Excel](../StructureDefinition-IneraIndexSubscription.xlsx), [Schematron](../StructureDefinition-IneraIndexSubscription.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "IneraIndexSubscription",
  "url" : "https://fhir.inera.se/ig/engagementindex/StructureDefinition/IneraIndexSubscription",
  "identifier" : [{
    "value" : "IneraIndexSubscription"
  }],
  "version" : "0.1.0",
  "name" : "IneraIndexSubscription",
  "title" : "Prenumeration på indexposter (FHIR-EI)",
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
  "description" : "En konsuments prenumeration på ändrade indexposter, på topic `indexpost-andrad`. Prenumerationen kan\nfiltreras på patient, tjänst och vårdgivare. Notiser bär bara id för ändrade poster, så att de inte bär\nmer patientinformation än nödvändigt.",
  "jurisdiction" : [{
    "coding" : [{
      "system" : "urn:iso:std:iso:3166",
      "code" : "SE",
      "display" : "Sweden"
    }]
  }],
  "fhirVersion" : "5.0.0",
  "mapping" : [{
    "identity" : "w5",
    "uri" : "http://hl7.org/fhir/fivews",
    "name" : "FiveWs Pattern Mapping"
  },
  {
    "identity" : "rim",
    "uri" : "http://hl7.org/v3",
    "name" : "RIM Mapping"
  }],
  "kind" : "resource",
  "abstract" : false,
  "type" : "Subscription",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Subscription",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "Subscription",
      "path" : "Subscription"
    },
    {
      "id" : "Subscription.topic",
      "path" : "Subscription.topic",
      "patternCanonical" : "https://fhir.inera.se/ig/engagementindex/SubscriptionTopic/indexpost-andrad"
    },
    {
      "id" : "Subscription.filterBy",
      "path" : "Subscription.filterBy",
      "mustSupport" : true
    },
    {
      "id" : "Subscription.filterBy.filterParameter",
      "path" : "Subscription.filterBy.filterParameter",
      "mustSupport" : true
    },
    {
      "id" : "Subscription.filterBy.modifier",
      "path" : "Subscription.filterBy.modifier",
      "mustSupport" : true
    },
    {
      "id" : "Subscription.filterBy.value",
      "path" : "Subscription.filterBy.value",
      "mustSupport" : true
    },
    {
      "id" : "Subscription.channelType",
      "path" : "Subscription.channelType",
      "mustSupport" : true
    },
    {
      "id" : "Subscription.endpoint",
      "path" : "Subscription.endpoint",
      "mustSupport" : true
    },
    {
      "id" : "Subscription.heartbeatPeriod",
      "path" : "Subscription.heartbeatPeriod",
      "mustSupport" : true
    },
    {
      "id" : "Subscription.content",
      "path" : "Subscription.content",
      "patternCode" : "id-only",
      "mustSupport" : true
    }]
  }
}

```
