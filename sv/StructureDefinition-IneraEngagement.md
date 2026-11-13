# Engagemangspost - EI-on-FHIR: FHIR-API för engagemangsindex v0.1.0

## Resursprofil: Engagemangspost 

**Användningar:**

* Exempel för denna Profil: [DocumentReference/EngagemangspostAktuell](DocumentReference-EngagemangspostAktuell.md), [DocumentReference/EngagemangspostBorttagen](DocumentReference-EngagemangspostBorttagen.md), [DocumentReference/EngagemangspostFhir](DocumentReference-EngagemangspostFhir.md) and [DocumentReference/EngagemangspostKallsystemSomPuA](DocumentReference-EngagemangspostKallsystemSomPuA.md)
* CapabilityStatements som använder denna Profil: [EI-on-FHIR server](CapabilityStatement-IneraEngagementIndexServer.md)

Du kan också kontrollera [användningar i FHIR IG-statistiken](https://packages2.fhir.org/xig/inera.ei.engagementindex|current/StructureDefinition/IneraEngagement)

### Formella vyer av profilinnehåll

 [Beskrivningsdifferentialer, ögonblicksbilder och andra representationer](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

*  [Tabell med nyckelelement](#tabs-key) 
*  [Differentialtabell](#tabs-diff) 
*  [Ögonblicksbildstabell](#tabs-snap) 
*  [Statistik/referenser](#tabs-summ) 
*  [Alla](#tabs-all) 

#### Terminologibindningar

#### Begränsningar

Denna struktur är härledd från [DocumentReference](http://hl7.org/fhir/R5/documentreference.html) 

#### Terminologibindningar (differential)

#### Begränsningar

#### Terminologibindningar

#### Begränsningar

Denna struktur är härledd från [DocumentReference](http://hl7.org/fhir/R5/documentreference.html) 

 **Vy med nyckelelement** 

#### Terminologibindningar

#### Begränsningar

 **Differentialvy** 

Denna struktur är härledd från [DocumentReference](http://hl7.org/fhir/R5/documentreference.html) 

#### Terminologibindningar (differential)

#### Begränsningar

 **ÖgonblicksbildsvyView** 

#### Terminologibindningar

#### Begränsningar

Denna struktur är härledd från [DocumentReference](http://hl7.org/fhir/R5/documentreference.html) 

 

Andra representationer av profilen: [CSV](../StructureDefinition-IneraEngagement.csv), [Excel](../StructureDefinition-IneraEngagement.xlsx), [Schematron](../StructureDefinition-IneraEngagement.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "IneraEngagement",
  "url" : "https://fhir.inera.se/ig/engagementindex/StructureDefinition/IneraEngagement",
  "identifier" : [{
    "value" : "IneraEngagement"
  }],
  "version" : "0.1.0",
  "name" : "IneraEngagement",
  "title" : "Engagemangspost",
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
  "description" : "En engagemangspost, exponerad som DocumentReference. Posten pekar ut att ett källsystem har information om en patient inom en tjänstedomän, och hur den hämtas: med RIV-TA via tjänsteplattformen och en logisk adress, eller med FHIR från en endpoint. Den bär inget journalinnehåll. Posten kommer antingen från engagemangsindex (EI) eller från EI-on-FHIR:s eget register för FHIR-producenter. En resurs motsvarar en post, utan sammanslagning.",
  "jurisdiction" : [{
    "coding" : [{
      "system" : "urn:iso:std:iso:3166",
      "code" : "SE",
      "display" : "Sweden"
    }]
  }],
  "fhirVersion" : "5.0.0",
  "mapping" : [{
    "identity" : "workflow",
    "uri" : "http://hl7.org/fhir/workflow",
    "name" : "Workflow Pattern"
  },
  {
    "identity" : "w5",
    "uri" : "http://hl7.org/fhir/fivews",
    "name" : "FiveWs Pattern Mapping"
  },
  {
    "identity" : "fhircomposition",
    "uri" : "http://hl7.org/fhir/composition",
    "name" : "FHIR Composition"
  },
  {
    "identity" : "rim",
    "uri" : "http://hl7.org/v3",
    "name" : "RIM Mapping"
  },
  {
    "identity" : "xds",
    "uri" : "http://ihe.net/xds",
    "name" : "XDS metadata equivalent"
  },
  {
    "identity" : "cda",
    "uri" : "http://hl7.org/v3/cda",
    "name" : "CDA (R2)"
  },
  {
    "identity" : "v2",
    "uri" : "http://hl7.org/v2",
    "name" : "HL7 V2 Mapping"
  }],
  "kind" : "resource",
  "abstract" : false,
  "type" : "DocumentReference",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/DocumentReference",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "DocumentReference",
      "path" : "DocumentReference",
      "constraint" : [{
        "key" : "inera-ei-patient-identifier",
        "severity" : "error",
        "human" : "Patienten anges med personnummer eller samordningsnummer.",
        "expression" : "subject.identifier.system = 'http://electronichealth.se/identifier/personnummer' or subject.identifier.system = 'http://electronichealth.se/identifier/samordningsnummer'",
        "source" : "https://fhir.inera.se/ig/engagementindex/StructureDefinition/IneraEngagement"
      },
      {
        "key" : "inera-ei-riv-ta",
        "severity" : "error",
        "human" : "En RIV-TA-post har logisk adress.",
        "expression" : "content.profile.where(value.ofType(Coding).code = 'riv-ta').exists() implies extension('https://fhir.inera.se/ig/engagementindex/StructureDefinition/LogicalAddress').exists()",
        "source" : "https://fhir.inera.se/ig/engagementindex/StructureDefinition/IneraEngagement"
      }]
    },
    {
      "id" : "DocumentReference.meta.lastUpdated",
      "path" : "DocumentReference.meta.lastUpdated",
      "short" : "När posten senast ändrades (updateTime i EI)",
      "min" : 1,
      "mustSupport" : true
    },
    {
      "id" : "DocumentReference.extension",
      "path" : "DocumentReference.extension",
      "slicing" : {
        "discriminator" : [{
          "type" : "value",
          "path" : "url"
        }],
        "ordered" : false,
        "rules" : "open"
      },
      "min" : 2
    },
    {
      "id" : "DocumentReference.extension:logicalAddress",
      "path" : "DocumentReference.extension",
      "sliceName" : "logicalAddress",
      "short" : "Logisk adress. Krävs för RIV-TA, och anges för FHIR när samma källa också svarar på tjänstekontraktet",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "Extension",
        "profile" : ["https://fhir.inera.se/ig/engagementindex/StructureDefinition/LogicalAddress"]
      }],
      "mustSupport" : true
    },
    {
      "id" : "DocumentReference.extension:sourceSystem",
      "path" : "DocumentReference.extension",
      "sliceName" : "sourceSystem",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "Extension",
        "profile" : ["https://fhir.inera.se/ig/engagementindex/StructureDefinition/SourceSystem"]
      }],
      "mustSupport" : true
    },
    {
      "id" : "DocumentReference.extension:mostRecentContent",
      "path" : "DocumentReference.extension",
      "sliceName" : "mostRecentContent",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "Extension",
        "profile" : ["https://fhir.inera.se/ig/engagementindex/StructureDefinition/MostRecentContent"]
      }],
      "mustSupport" : true
    },
    {
      "id" : "DocumentReference.extension:owner",
      "path" : "DocumentReference.extension",
      "sliceName" : "owner",
      "short" : "Var posten förvaltas: EI eller EI-on-FHIR:s register",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "Extension",
        "profile" : ["https://fhir.inera.se/ig/engagementindex/StructureDefinition/Owner"]
      }],
      "mustSupport" : true
    },
    {
      "id" : "DocumentReference.identifier",
      "path" : "DocumentReference.identifier",
      "short" : "Källsystemets id för informationen (businessObjectInstanceIdentifier); unikt tillsammans med sourceSystem",
      "min" : 1,
      "max" : "1",
      "mustSupport" : true
    },
    {
      "id" : "DocumentReference.identifier.value",
      "path" : "DocumentReference.identifier.value",
      "min" : 1,
      "mustSupport" : true
    },
    {
      "id" : "DocumentReference.status",
      "path" : "DocumentReference.status",
      "short" : "current för en registrerad post, superseded för en borttagen post under borttagsloggens lagringstid",
      "mustSupport" : true,
      "binding" : {
        "strength" : "required",
        "valueSet" : "https://fhir.inera.se/ig/engagementindex/ValueSet/IneraEngagementStatusValueSet"
      }
    },
    {
      "id" : "DocumentReference.docStatus",
      "path" : "DocumentReference.docStatus",
      "max" : "0"
    },
    {
      "id" : "DocumentReference.type",
      "path" : "DocumentReference.type",
      "short" : "Tjänstedomän (serviceDomain)",
      "min" : 1,
      "mustSupport" : true,
      "binding" : {
        "strength" : "required",
        "valueSet" : "https://fhir.inera.se/ig/engagementindex/ValueSet/IneraServiceDomainValueSet"
      }
    },
    {
      "id" : "DocumentReference.type.coding",
      "path" : "DocumentReference.type.coding",
      "min" : 1,
      "max" : "1",
      "mustSupport" : true
    },
    {
      "id" : "DocumentReference.type.coding.system",
      "path" : "DocumentReference.type.coding.system",
      "min" : 1,
      "mustSupport" : true
    },
    {
      "id" : "DocumentReference.type.coding.code",
      "path" : "DocumentReference.type.coding.code",
      "min" : 1,
      "mustSupport" : true
    },
    {
      "id" : "DocumentReference.category",
      "path" : "DocumentReference.category",
      "short" : "Kategori inom tjänstedomänen (categorization)",
      "max" : "1",
      "mustSupport" : true,
      "binding" : {
        "strength" : "required",
        "valueSet" : "https://fhir.inera.se/ig/engagementindex/ValueSet/IneraEngagementCategoryValueSet"
      }
    },
    {
      "id" : "DocumentReference.subject",
      "path" : "DocumentReference.subject",
      "short" : "Patienten (registeredResidentIdentification), som logisk referens med personnummer eller samordningsnummer",
      "min" : 1,
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://hl7.org/fhir/StructureDefinition/Patient"]
      }],
      "mustSupport" : true
    },
    {
      "id" : "DocumentReference.subject.reference",
      "path" : "DocumentReference.subject.reference",
      "max" : "0"
    },
    {
      "id" : "DocumentReference.subject.identifier",
      "path" : "DocumentReference.subject.identifier",
      "min" : 1,
      "mustSupport" : true
    },
    {
      "id" : "DocumentReference.subject.identifier.system",
      "path" : "DocumentReference.subject.identifier.system",
      "min" : 1,
      "mustSupport" : true
    },
    {
      "id" : "DocumentReference.subject.identifier.value",
      "path" : "DocumentReference.subject.identifier.value",
      "min" : 1,
      "mustSupport" : true
    },
    {
      "id" : "DocumentReference.context",
      "path" : "DocumentReference.context",
      "max" : "0"
    },
    {
      "id" : "DocumentReference.date",
      "path" : "DocumentReference.date",
      "short" : "När posten skapades (creationTime i EI)",
      "min" : 1,
      "mustSupport" : true
    },
    {
      "id" : "DocumentReference.author",
      "path" : "DocumentReference.author",
      "max" : "0"
    },
    {
      "id" : "DocumentReference.attester",
      "path" : "DocumentReference.attester",
      "max" : "0"
    },
    {
      "id" : "DocumentReference.custodian",
      "path" : "DocumentReference.custodian",
      "short" : "Personuppgiftsansvarig organisation (dataController i EI), som logisk referens med HSA-id",
      "comment" : "I poster från EI ofta vårdgivarens HSA-id, men sedan migreringen från NPÖ:s index godtar EI också källsystemets HSA-id. I poster från EI-on-FHIR:s register är custodian alltid en vårdgivare. En konsument som behöver vårdgivaren, till exempel synken till eHM:s patientindex, kan därför inte lita på custodian i poster från EI.",
      "min" : 1,
      "mustSupport" : true
    },
    {
      "id" : "DocumentReference.custodian.reference",
      "path" : "DocumentReference.custodian.reference",
      "max" : "0"
    },
    {
      "id" : "DocumentReference.custodian.identifier",
      "path" : "DocumentReference.custodian.identifier",
      "min" : 1,
      "mustSupport" : true
    },
    {
      "id" : "DocumentReference.custodian.identifier.system",
      "path" : "DocumentReference.custodian.identifier.system",
      "min" : 1,
      "patternUri" : "urn:oid:1.2.752.29.4.19",
      "mustSupport" : true
    },
    {
      "id" : "DocumentReference.custodian.identifier.value",
      "path" : "DocumentReference.custodian.identifier.value",
      "min" : 1,
      "mustSupport" : true
    },
    {
      "id" : "DocumentReference.relatesTo",
      "path" : "DocumentReference.relatesTo",
      "max" : "0"
    },
    {
      "id" : "DocumentReference.description",
      "path" : "DocumentReference.description",
      "max" : "0"
    },
    {
      "id" : "DocumentReference.securityLabel",
      "path" : "DocumentReference.securityLabel",
      "max" : "0"
    },
    {
      "id" : "DocumentReference.content",
      "path" : "DocumentReference.content",
      "short" : "Hur innehållet hämtas: med RIV-TA via tjänsteplattformen och postens logiska adress, eller med FHIR från endpointen i attachment.url",
      "max" : "1",
      "constraint" : [{
        "key" : "inera-ei-riv-ta-content",
        "severity" : "error",
        "human" : "En RIV-TA-post har innehållstypen application/xml och ingen URL.",
        "expression" : "profile.where(value.ofType(Coding).code = 'riv-ta').exists() implies (attachment.contentType = 'application/xml' and attachment.url.empty())",
        "source" : "https://fhir.inera.se/ig/engagementindex/StructureDefinition/IneraEngagement"
      },
      {
        "key" : "inera-ei-fhir",
        "severity" : "error",
        "human" : "En FHIR-post har innehållstypen application/fhir+json och endpointens bas-URL.",
        "expression" : "profile.where(value.ofType(Coding).code = 'fhir').exists() implies (attachment.contentType = 'application/fhir+json' and attachment.url.exists())",
        "source" : "https://fhir.inera.se/ig/engagementindex/StructureDefinition/IneraEngagement"
      }],
      "mustSupport" : true
    },
    {
      "id" : "DocumentReference.content.attachment.contentType",
      "path" : "DocumentReference.content.attachment.contentType",
      "short" : "application/xml för RIV-TA, application/fhir+json för FHIR",
      "min" : 1,
      "mustSupport" : true
    },
    {
      "id" : "DocumentReference.content.attachment.data",
      "path" : "DocumentReference.content.attachment.data",
      "max" : "0"
    },
    {
      "id" : "DocumentReference.content.attachment.url",
      "path" : "DocumentReference.content.attachment.url",
      "short" : "FHIR-endpointens bas-URL, som den står i tjänstekatalogen. Bara för FHIR",
      "mustSupport" : true
    },
    {
      "id" : "DocumentReference.content.profile",
      "path" : "DocumentReference.content.profile",
      "short" : "Hämtningsprotokoll som Coding: riv-ta eller fhir",
      "min" : 1,
      "max" : "1",
      "mustSupport" : true
    },
    {
      "id" : "DocumentReference.content.profile.value[x]",
      "path" : "DocumentReference.content.profile.value[x]",
      "type" : [{
        "code" : "Coding"
      }],
      "binding" : {
        "strength" : "required",
        "valueSet" : "https://fhir.inera.se/ig/engagementindex/ValueSet/IneraRetrievalProtocolValueSet"
      }
    }]
  }
}

```
