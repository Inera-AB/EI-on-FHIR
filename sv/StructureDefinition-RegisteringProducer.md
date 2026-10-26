# Registrerande producent - FHIR-baserat engagemangsindex (FHIR-EI) v0.1.0

## Extension: Registrerande producent 

**Context of Use**

**Usage info**

**Användningar:**

* Använd denna Extension: [Indexpost (FHIR-EI)](StructureDefinition-IneraIndexEntry.md)
* Exempel för denna Extension: [Bundle/RegistreringTransaction](Bundle-RegistreringTransaction.md), [Bundle/SokresultatForPatient](Bundle-SokresultatForPatient.md), [DocumentReference/IndexpostFhirProducent](DocumentReference-IndexpostFhirProducent.md), [DocumentReference/IndexpostFranAdapter](DocumentReference-IndexpostFranAdapter.md) and [DocumentReference/IndexpostIndragen](DocumentReference-IndexpostIndragen.md)

Du kan också kontrollera [användningar i FHIR IG-statistiken](https://packages2.fhir.org/xig/inera.ei.engagementindex|current/StructureDefinition/RegisteringProducer)

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

 

Andra representationer av profilen: [CSV](../StructureDefinition-RegisteringProducer.csv), [Excel](../StructureDefinition-RegisteringProducer.xlsx), [Schematron](../StructureDefinition-RegisteringProducer.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "RegisteringProducer",
  "extension" : [{
    "url" : "http://hl7.org/fhir/StructureDefinition/structuredefinition-type-characteristics",
    "valueCode" : "can-bind"
  }],
  "url" : "https://fhir.inera.se/ig/engagementindex/StructureDefinition/RegisteringProducer",
  "identifier" : [{
    "value" : "RegisteringProducer"
  }],
  "version" : "0.1.0",
  "name" : "RegisteringProducer",
  "title" : "Registrerande producent",
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
  "description" : "Producentens identitet: den Endpoint i tjänstekatalogen som den autentiserade klienten är bunden till, som absolut referens. För en direktansluten producent är det samma endpoint som i sourceEndpoint. Referensen är också producentens namnrymd i identifier.system. FHIR-EI kontrollerar värdet mot den autentiserade klienten. Får inte ändras på en befintlig post. Motsvarar owner i dagens engagemangsindex.",
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
      "short" : "Registrerande producent",
      "definition" : "Producentens identitet: den Endpoint i tjänstekatalogen som den autentiserade klienten är bunden till, som absolut referens. För en direktansluten producent är det samma endpoint som i sourceEndpoint. Referensen är också producentens namnrymd i identifier.system. FHIR-EI kontrollerar värdet mot den autentiserade klienten. Får inte ändras på en befintlig post. Motsvarar owner i dagens engagemangsindex."
    },
    {
      "id" : "Extension.extension",
      "path" : "Extension.extension",
      "max" : "0"
    },
    {
      "id" : "Extension.url",
      "path" : "Extension.url",
      "fixedUri" : "https://fhir.inera.se/ig/engagementindex/StructureDefinition/RegisteringProducer"
    },
    {
      "id" : "Extension.value[x]",
      "path" : "Extension.value[x]",
      "min" : 1,
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://hl7.org/fhir/StructureDefinition/Endpoint"]
      }]
    },
    {
      "id" : "Extension.value[x].reference",
      "path" : "Extension.value[x].reference",
      "short" : "Absolut URL till producentens Endpoint i tjänstekatalogen",
      "min" : 1
    }]
  }
}

```
