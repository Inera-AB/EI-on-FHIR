# Orsak till avregistrering - FHIR-baserat engagemangsindex (FHIR-EI) v0.1.0

## Extension: Orsak till avregistrering 

**Context of Use**

**Usage info**

**Användningar:**

* Använd denna Extension: [Indexpost (FHIR-EI)](StructureDefinition-IneraIndexEntry.md)
* Exempel för denna Extension: [Bundle/RegistreringTransaction](Bundle-RegistreringTransaction.md) and [DocumentReference/IndexpostIndragen](DocumentReference-IndexpostIndragen.md)

Du kan också kontrollera [användningar i FHIR IG-statistiken](https://packages2.fhir.org/xig/inera.ei.engagementindex|current/StructureDefinition/DeregistrationReason)

### Formella vyer av extensioninnehåll

 [Beskrivningsdifferentialer, ögonblicksbilder och andra representationer](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

*  [Differentialtabell](#tabs-diff) 
*  [Ögonblicksbildstabell](#tabs-snap) 
*  [Statistik/referenser](#tabs-summ) 
*  [Alla](#tabs-all) 

Denna struktur är härledd från [Extension](http://hl7.org/fhir/R5/extensibility.html#Extension) 

#### Terminologibindningar (differential)

#### Terminologibindningar

#### Begränsningar

Denna struktur är härledd från [Extension](http://hl7.org/fhir/R5/extensibility.html#Extension) 

 **Differentialvy** 

Denna struktur är härledd från [Extension](http://hl7.org/fhir/R5/extensibility.html#Extension) 

#### Terminologibindningar (differential)

 **Ögonblicksbildsvy** 

#### Terminologibindningar

#### Begränsningar

Denna struktur är härledd från [Extension](http://hl7.org/fhir/R5/extensibility.html#Extension) 

 

Andra representationer av profilen: [CSV](../StructureDefinition-DeregistrationReason.csv), [Excel](../StructureDefinition-DeregistrationReason.xlsx), [Schematron](../StructureDefinition-DeregistrationReason.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "DeregistrationReason",
  "extension" : [{
    "url" : "http://hl7.org/fhir/StructureDefinition/structuredefinition-type-characteristics",
    "valueCode" : "can-bind"
  }],
  "url" : "https://fhir.inera.se/ig/engagementindex/StructureDefinition/DeregistrationReason",
  "identifier" : [{
    "value" : "DeregistrationReason"
  }],
  "version" : "0.1.0",
  "name" : "DeregistrationReason",
  "title" : "Orsak till avregistrering",
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
  "description" : "Varför posten avregistrerades: felregistrering, avslutat engagemang, gallring eller avregistrering via övergångsadaptern. Finns om och endast om posten inte är registrerad.",
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
      "short" : "Orsak till avregistrering",
      "definition" : "Varför posten avregistrerades: felregistrering, avslutat engagemang, gallring eller avregistrering via övergångsadaptern. Finns om och endast om posten inte är registrerad."
    },
    {
      "id" : "Extension.extension",
      "path" : "Extension.extension",
      "max" : "0"
    },
    {
      "id" : "Extension.url",
      "path" : "Extension.url",
      "fixedUri" : "https://fhir.inera.se/ig/engagementindex/StructureDefinition/DeregistrationReason"
    },
    {
      "id" : "Extension.value[x]",
      "path" : "Extension.value[x]",
      "min" : 1,
      "type" : [{
        "code" : "CodeableConcept"
      }],
      "binding" : {
        "strength" : "required",
        "valueSet" : "https://fhir.inera.se/ig/engagementindex/ValueSet/IneraDeregistrationReasonValueSet"
      }
    }]
  }
}

```
