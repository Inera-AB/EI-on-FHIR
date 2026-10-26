# Logisk adress - FHIR-baserat engagemangsindex (FHIR-EI) v0.1.0

## Extension: Logisk adress 

**Context of Use**

**Usage info**

**Användningar:**

* Använd denna Extension: [Indexpost (FHIR-EI)](StructureDefinition-IneraIndexEntry.md)
* Exempel för denna Extension: [Bundle/SokresultatForPatient](Bundle-SokresultatForPatient.md) and [DocumentReference/IndexpostFranAdapter](DocumentReference-IndexpostFranAdapter.md)

Du kan också kontrollera [användningar i FHIR IG-statistiken](https://packages2.fhir.org/xig/inera.ei.engagementindex|current/StructureDefinition/LogicalAddress)

### Formella vyer av extensioninnehåll

 [Beskrivningsdifferentialer, ögonblicksbilder och andra representationer](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

*  [Differentialtabell](#tabs-diff) 
*  [Ögonblicksbildstabell](#tabs-snap) 
*  [Statistik/referenser](#tabs-summ) 
*  [Alla](#tabs-all) 

Denna struktur är härledd från [Extension](http://hl7.org/fhir/R5/extensibility.html#Extension) 

#### Terminologibindningar

#### Begränsningar

Denna struktur är härledd från [Extension](http://hl7.org/fhir/R5/extensibility.html#Extension) 

 **Differentialvy** 

Denna struktur är härledd från [Extension](http://hl7.org/fhir/R5/extensibility.html#Extension) 

 **Ögonblicksbildsvy** 

#### Terminologibindningar

#### Begränsningar

Denna struktur är härledd från [Extension](http://hl7.org/fhir/R5/extensibility.html#Extension) 

 

Andra representationer av profilen: [CSV](../StructureDefinition-LogicalAddress.csv), [Excel](../StructureDefinition-LogicalAddress.xlsx), [Schematron](../StructureDefinition-LogicalAddress.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "LogicalAddress",
  "extension" : [{
    "url" : "http://hl7.org/fhir/StructureDefinition/structuredefinition-type-characteristics",
    "valueCode" : "can-bind"
  }],
  "url" : "https://fhir.inera.se/ig/engagementindex/StructureDefinition/LogicalAddress",
  "identifier" : [{
    "value" : "LogicalAddress"
  }],
  "version" : "0.1.0",
  "name" : "LogicalAddress",
  "title" : "Logisk adress",
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
  "description" : "Den logiska adress som konsumenten anger när den hämtar informationen via tjänsteplattformen, som HSA-id. Krävs när endpointen adresseras med logisk adress, som för RIV-TA-källor; annars utelämnas den. I tjänstekatalogen är den logiska adressen en organisations HSA-id. Motsvarar logicalAddress i dagens engagemangsindex.",
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
      "short" : "Logisk adress",
      "definition" : "Den logiska adress som konsumenten anger när den hämtar informationen via tjänsteplattformen, som HSA-id. Krävs när endpointen adresseras med logisk adress, som för RIV-TA-källor; annars utelämnas den. I tjänstekatalogen är den logiska adressen en organisations HSA-id. Motsvarar logicalAddress i dagens engagemangsindex."
    },
    {
      "id" : "Extension.extension",
      "path" : "Extension.extension",
      "max" : "0"
    },
    {
      "id" : "Extension.url",
      "path" : "Extension.url",
      "fixedUri" : "https://fhir.inera.se/ig/engagementindex/StructureDefinition/LogicalAddress"
    },
    {
      "id" : "Extension.value[x]",
      "path" : "Extension.value[x]",
      "min" : 1,
      "type" : [{
        "code" : "Identifier"
      }]
    },
    {
      "id" : "Extension.value[x].system",
      "path" : "Extension.value[x].system",
      "min" : 1,
      "patternUri" : "urn:oid:1.2.752.29.4.19"
    },
    {
      "id" : "Extension.value[x].value",
      "path" : "Extension.value[x].value",
      "min" : 1
    }]
  }
}

```
