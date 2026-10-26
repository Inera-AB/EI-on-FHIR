# Innehållets senaste ändring - FHIR-baserat engagemangsindex (FHIR-EI) v0.1.0

## Extension: Innehållets senaste ändring 

**Context of Use**

**Usage info**

**Användningar:**

* Använd denna Extension: [Indexpost (FHIR-EI)](StructureDefinition-IneraIndexEntry.md)
* Exempel för denna Extension: [Bundle/RegistreringTransaction](Bundle-RegistreringTransaction.md), [Bundle/SokresultatForPatient](Bundle-SokresultatForPatient.md), [DocumentReference/IndexpostFhirProducent](DocumentReference-IndexpostFhirProducent.md), [DocumentReference/IndexpostFranAdapter](DocumentReference-IndexpostFranAdapter.md) and [DocumentReference/IndexpostIndragen](DocumentReference-IndexpostIndragen.md)
* Sökparametrar som använder denna Extension: [Sök på innehållets senaste ändring](SearchParameter-DocumentReference-content-last-updated.md)

Du kan också kontrollera [användningar i FHIR IG-statistiken](https://packages2.fhir.org/xig/inera.ei.engagementindex|current/StructureDefinition/ContentLastUpdated)

### Formella vyer av extensioninnehåll

 [Beskrivningsdifferentialer, ögonblicksbilder och andra representationer](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

*  [Differentialtabell](#tabs-diff) 
*  [Ögonblicksbildstabell](#tabs-snap) 
*  [Statistik/referenser](#tabs-summ) 
*  [Alla](#tabs-all) 

Denna struktur är härledd från [Extension](http://hl7.org/fhir/R5/extensibility.html#Extension) 

#### Begränsningar

#### Begränsningar

Denna struktur är härledd från [Extension](http://hl7.org/fhir/R5/extensibility.html#Extension) 

 **Differentialvy** 

Denna struktur är härledd från [Extension](http://hl7.org/fhir/R5/extensibility.html#Extension) 

#### Begränsningar

 **Ögonblicksbildsvy** 

#### Begränsningar

Denna struktur är härledd från [Extension](http://hl7.org/fhir/R5/extensibility.html#Extension) 

 

Andra representationer av profilen: [CSV](../StructureDefinition-ContentLastUpdated.csv), [Excel](../StructureDefinition-ContentLastUpdated.xlsx), [Schematron](../StructureDefinition-ContentLastUpdated.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "ContentLastUpdated",
  "extension" : [{
    "url" : "http://hl7.org/fhir/StructureDefinition/structuredefinition-type-characteristics",
    "valueCode" : "can-bind"
  }],
  "url" : "https://fhir.inera.se/ig/engagementindex/StructureDefinition/ContentLastUpdated",
  "identifier" : [{
    "value" : "ContentLastUpdated"
  }],
  "version" : "0.1.0",
  "name" : "ContentLastUpdated",
  "title" : "Innehållets senaste ändring",
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
  "description" : "När det kliniska innehållet i källsystemet senast ändrades, enligt producenten. Gäller hela posten. Hålls isär från meta.lastUpdated, som anger när indexposten ändrades i FHIR-EI. Motsvarar mostRecentContent i dagens engagemangsindex.",
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
      "short" : "Innehållets senaste ändring",
      "definition" : "När det kliniska innehållet i källsystemet senast ändrades, enligt producenten. Gäller hela posten. Hålls isär från meta.lastUpdated, som anger när indexposten ändrades i FHIR-EI. Motsvarar mostRecentContent i dagens engagemangsindex."
    },
    {
      "id" : "Extension.extension",
      "path" : "Extension.extension",
      "max" : "0"
    },
    {
      "id" : "Extension.url",
      "path" : "Extension.url",
      "fixedUri" : "https://fhir.inera.se/ig/engagementindex/StructureDefinition/ContentLastUpdated"
    },
    {
      "id" : "Extension.value[x]",
      "path" : "Extension.value[x]",
      "min" : 1,
      "type" : [{
        "code" : "dateTime"
      }],
      "constraint" : [{
        "key" : "inera-ei-seconds",
        "severity" : "error",
        "human" : "Tidpunkten anges med minst sekundprecision och tidszon, så att ordningen mellan händelser för samma post kan avgöras.",
        "expression" : "$this.toString().length() >= 20",
        "source" : "https://fhir.inera.se/ig/engagementindex/StructureDefinition/ContentLastUpdated"
      }]
    }]
  }
}

```
