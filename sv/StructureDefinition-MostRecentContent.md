# Senaste innehåll - EI-on-FHIR: FHIR-API för engagemangsindex v0.1.0

## Extension: Senaste innehåll 

**Context of Use**

**Usage info**

**Användningar:**

* Använd denna Extension: [Engagemangspost](StructureDefinition-IneraEngagement.md)
* Exempel för denna Extension: [Bundle/SokresultatForPatient](Bundle-SokresultatForPatient.md), [DocumentReference/EngagemangspostAktuell](DocumentReference-EngagemangspostAktuell.md) and [DocumentReference/EngagemangspostFhir](DocumentReference-EngagemangspostFhir.md)

Du kan också kontrollera [användningar i FHIR IG-statistiken](https://packages2.fhir.org/xig/inera.ei.engagementindex|current/StructureDefinition/MostRecentContent)

### Formella vyer av extensioninnehåll

 [Beskrivningsdifferentialer, ögonblicksbilder och andra representationer](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

*  [Differentialtabell](#tabs-diff) 
*  [Ögonblicksbildstabell](#tabs-snap) 
*  [Statistik/referenser](#tabs-summ) 
*  [Alla](#tabs-all) 

Denna struktur är härledd från [Extension](http://hl7.org/fhir/R5/extensibility.html#Extension) 

#### Begränsningar

Denna struktur är härledd från [Extension](http://hl7.org/fhir/R5/extensibility.html#Extension) 

 **Differentialvy** 

Denna struktur är härledd från [Extension](http://hl7.org/fhir/R5/extensibility.html#Extension) 

 **Ögonblicksbildsvy** 

#### Begränsningar

Denna struktur är härledd från [Extension](http://hl7.org/fhir/R5/extensibility.html#Extension) 

 

Andra representationer av profilen: [CSV](../StructureDefinition-MostRecentContent.csv), [Excel](../StructureDefinition-MostRecentContent.xlsx), [Schematron](../StructureDefinition-MostRecentContent.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "MostRecentContent",
  "extension" : [{
    "url" : "http://hl7.org/fhir/StructureDefinition/structuredefinition-type-characteristics",
    "valueCode" : "can-bind"
  }],
  "url" : "https://fhir.inera.se/ig/engagementindex/StructureDefinition/MostRecentContent",
  "identifier" : [{
    "value" : "MostRecentContent"
  }],
  "version" : "0.1.0",
  "name" : "MostRecentContent",
  "title" : "Senaste innehåll",
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
  "description" : "När informationen hos källsystemet senast ändrades, enligt källsystemet (mostRecentContent i EI). Skiljer sig från meta.lastUpdated, som anger när posten senast ändrades i EI.",
  "jurisdiction" : [{
    "coding" : [{
      "system" : "urn:iso:std:iso:3166",
      "code" : "SE",
      "display" : "Sweden"
    }]
  }],
  "fhirVersion" : "5.0.0",
  "mapping" : [{
    "identity" : "rim",
    "uri" : "http://hl7.org/v3",
    "name" : "RIM Mapping"
  }],
  "kind" : "complex-type",
  "abstract" : false,
  "context" : [{
    "type" : "element",
    "expression" : "DocumentReference"
  }],
  "type" : "Extension",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Extension",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "Extension",
      "path" : "Extension",
      "short" : "Senaste innehåll",
      "definition" : "När informationen hos källsystemet senast ändrades, enligt källsystemet (mostRecentContent i EI). Skiljer sig från meta.lastUpdated, som anger när posten senast ändrades i EI."
    },
    {
      "id" : "Extension.extension",
      "path" : "Extension.extension",
      "max" : "0"
    },
    {
      "id" : "Extension.url",
      "path" : "Extension.url",
      "fixedUri" : "https://fhir.inera.se/ig/engagementindex/StructureDefinition/MostRecentContent"
    },
    {
      "id" : "Extension.value[x]",
      "path" : "Extension.value[x]",
      "min" : 1,
      "type" : [{
        "code" : "dateTime"
      }]
    }]
  }
}

```
