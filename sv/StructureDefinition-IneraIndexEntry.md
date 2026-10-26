# Indexpost (FHIR-EI) - FHIR-baserat engagemangsindex (FHIR-EI) v0.1.0

## Resursprofil: Indexpost (FHIR-EI) 

**Användningar:**

* Exempel för denna Profil: [DocumentReference/IndexpostFhirProducent](DocumentReference-IndexpostFhirProducent.md), [DocumentReference/IndexpostFranAdapter](DocumentReference-IndexpostFranAdapter.md) and [DocumentReference/IndexpostIndragen](DocumentReference-IndexpostIndragen.md)
* CapabilityStatements som använder denna Profil: [FHIR-EI server](CapabilityStatement-IneraIndexServer.md)

Du kan också kontrollera [användningar i FHIR IG-statistiken](https://packages2.fhir.org/xig/inera.ei.engagementindex|current/StructureDefinition/IneraIndexEntry)

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

 

Andra representationer av profilen: [CSV](../StructureDefinition-IneraIndexEntry.csv), [Excel](../StructureDefinition-IneraIndexEntry.xlsx), [Schematron](../StructureDefinition-IneraIndexEntry.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "IneraIndexEntry",
  "url" : "https://fhir.inera.se/ig/engagementindex/StructureDefinition/IneraIndexEntry",
  "identifier" : [{
    "value" : "IneraIndexEntry"
  }],
  "version" : "0.1.0",
  "name" : "IneraIndexEntry",
  "title" : "Indexpost (FHIR-EI)",
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
  "description" : "Gemensam indexpost. Anger att en producent via en endpoint har information om en patient inom en tjänst.\nDet finns en post per patient × endpoint × tjänst. Posten kan bära flera informationsmängder, och tidpunkten\nför senaste ändring av innehållet gäller hela posten.\n\nPosten är en pekare, inte innehåll. Varje tjänst publicerar sin tillämpning som en profil av denna profil, i\ntjänstens IG, och bestämmer där om informationsmängder och tidpunkt för senaste ändring är obligatoriska.",
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
        "key" : "inera-ei-status-map",
        "severity" : "error",
        "human" : "Basstatus följer registrationStatus: active ↔ current, withdrawn ↔ superseded, entered-in-error ↔ entered-in-error.",
        "expression" : "(extension('https://fhir.inera.se/ig/engagementindex/StructureDefinition/RegistrationStatus').where(value = 'active').exists() implies status = 'current') and (extension('https://fhir.inera.se/ig/engagementindex/StructureDefinition/RegistrationStatus').where(value = 'withdrawn').exists() implies status = 'superseded') and (extension('https://fhir.inera.se/ig/engagementindex/StructureDefinition/RegistrationStatus').where(value = 'entered-in-error').exists() implies status = 'entered-in-error')",
        "source" : "https://fhir.inera.se/ig/engagementindex/StructureDefinition/IneraIndexEntry"
      },
      {
        "key" : "inera-ei-deregistration",
        "severity" : "error",
        "human" : "deregistrationReason finns om och endast om registrationStatus inte är active.",
        "expression" : "extension('https://fhir.inera.se/ig/engagementindex/StructureDefinition/DeregistrationReason').exists() = extension('https://fhir.inera.se/ig/engagementindex/StructureDefinition/RegistrationStatus').where(value != 'active').exists()",
        "source" : "https://fhir.inera.se/ig/engagementindex/StructureDefinition/IneraIndexEntry"
      },
      {
        "key" : "inera-ei-producer-namespace",
        "severity" : "error",
        "human" : "Minst en identifierare har producentens namnrymd: identifier.system är samma URL som referensen i registeringProducer.",
        "expression" : "identifier.system contains extension('https://fhir.inera.se/ig/engagementindex/StructureDefinition/RegisteringProducer').value.reference",
        "source" : "https://fhir.inera.se/ig/engagementindex/StructureDefinition/IneraIndexEntry"
      }]
    },
    {
      "id" : "DocumentReference.meta.source",
      "path" : "DocumentReference.meta.source",
      "short" : "Används bara för spårbarhet, aldrig för behörighet"
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
      "min" : 4
    },
    {
      "id" : "DocumentReference.extension:sourceEndpoint",
      "path" : "DocumentReference.extension",
      "sliceName" : "sourceEndpoint",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "Extension",
        "profile" : ["https://fhir.inera.se/ig/engagementindex/StructureDefinition/SourceEndpoint"]
      }],
      "mustSupport" : true
    },
    {
      "id" : "DocumentReference.extension:careUnit",
      "path" : "DocumentReference.extension",
      "sliceName" : "careUnit",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "Extension",
        "profile" : ["https://fhir.inera.se/ig/engagementindex/StructureDefinition/CareUnit"]
      }],
      "mustSupport" : true
    },
    {
      "id" : "DocumentReference.extension:registeringProducer",
      "path" : "DocumentReference.extension",
      "sliceName" : "registeringProducer",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "Extension",
        "profile" : ["https://fhir.inera.se/ig/engagementindex/StructureDefinition/RegisteringProducer"]
      }],
      "mustSupport" : true
    },
    {
      "id" : "DocumentReference.extension:logicalAddress",
      "path" : "DocumentReference.extension",
      "sliceName" : "logicalAddress",
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
      "min" : 0,
      "max" : "*",
      "type" : [{
        "code" : "Extension",
        "profile" : ["https://fhir.inera.se/ig/engagementindex/StructureDefinition/SourceSystem"]
      }],
      "mustSupport" : true
    },
    {
      "id" : "DocumentReference.extension:contentLastUpdated",
      "path" : "DocumentReference.extension",
      "sliceName" : "contentLastUpdated",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "Extension",
        "profile" : ["https://fhir.inera.se/ig/engagementindex/StructureDefinition/ContentLastUpdated"]
      }],
      "mustSupport" : true
    },
    {
      "id" : "DocumentReference.extension:registrationStatus",
      "path" : "DocumentReference.extension",
      "sliceName" : "registrationStatus",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "Extension",
        "profile" : ["https://fhir.inera.se/ig/engagementindex/StructureDefinition/RegistrationStatus"]
      }],
      "mustSupport" : true
    },
    {
      "id" : "DocumentReference.extension:deregistrationReason",
      "path" : "DocumentReference.extension",
      "sliceName" : "deregistrationReason",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "Extension",
        "profile" : ["https://fhir.inera.se/ig/engagementindex/StructureDefinition/DeregistrationReason"]
      }],
      "mustSupport" : true
    },
    {
      "id" : "DocumentReference.identifier",
      "path" : "DocumentReference.identifier",
      "short" : "Producentens id för posten; nyckel för villkorad uppdatering",
      "min" : 1,
      "mustSupport" : true
    },
    {
      "id" : "DocumentReference.identifier.system",
      "path" : "DocumentReference.identifier.system",
      "short" : "Producentens namnrymd: samma URL som registeringProducer",
      "min" : 1,
      "mustSupport" : true
    },
    {
      "id" : "DocumentReference.identifier.value",
      "path" : "DocumentReference.identifier.value",
      "short" : "Producentens id för posten",
      "min" : 1,
      "mustSupport" : true
    },
    {
      "id" : "DocumentReference.basedOn",
      "path" : "DocumentReference.basedOn",
      "max" : "0"
    },
    {
      "id" : "DocumentReference.status",
      "path" : "DocumentReference.status",
      "short" : "current | superseded | entered-in-error; exakt tillstånd i registrationStatus",
      "mustSupport" : true
    },
    {
      "id" : "DocumentReference.type",
      "path" : "DocumentReference.type",
      "short" : "Tjänst: tjänstedomän under övergången, IG:ns canonical därefter",
      "min" : 1,
      "constraint" : [{
        "key" : "inera-ei-service-coding",
        "severity" : "error",
        "human" : "Tjänsten anges med tjänstedomän, IG:ns canonical eller båda.",
        "expression" : "coding.where(system = 'https://fhir.inera.se/ig/engagementindex/CodeSystem/IneraServiceDomainCodeSystem' or system = 'urn:ietf:rfc:3986').exists()",
        "source" : "https://fhir.inera.se/ig/engagementindex/StructureDefinition/IneraIndexEntry"
      }],
      "mustSupport" : true
    },
    {
      "id" : "DocumentReference.type.coding",
      "path" : "DocumentReference.type.coding",
      "slicing" : {
        "discriminator" : [{
          "type" : "value",
          "path" : "system"
        }],
        "rules" : "open"
      },
      "min" : 1,
      "mustSupport" : true
    },
    {
      "id" : "DocumentReference.type.coding:serviceDomain",
      "path" : "DocumentReference.type.coding",
      "sliceName" : "serviceDomain",
      "short" : "Tjänstedomän (idag)",
      "min" : 0,
      "max" : "1",
      "mustSupport" : true,
      "binding" : {
        "strength" : "required",
        "valueSet" : "https://fhir.inera.se/ig/engagementindex/ValueSet/IneraServiceDomainValueSet"
      }
    },
    {
      "id" : "DocumentReference.type.coding:serviceDomain.system",
      "path" : "DocumentReference.type.coding.system",
      "min" : 1,
      "patternUri" : "https://fhir.inera.se/ig/engagementindex/CodeSystem/IneraServiceDomainCodeSystem"
    },
    {
      "id" : "DocumentReference.type.coding:serviceDomain.code",
      "path" : "DocumentReference.type.coding.code",
      "min" : 1
    },
    {
      "id" : "DocumentReference.type.coding:implementationGuide",
      "path" : "DocumentReference.type.coding",
      "sliceName" : "implementationGuide",
      "short" : "IG:ns canonical (framåt)",
      "min" : 0,
      "max" : "1",
      "mustSupport" : true
    },
    {
      "id" : "DocumentReference.type.coding:implementationGuide.system",
      "path" : "DocumentReference.type.coding.system",
      "min" : 1,
      "patternUri" : "urn:ietf:rfc:3986"
    },
    {
      "id" : "DocumentReference.type.coding:implementationGuide.code",
      "path" : "DocumentReference.type.coding.code",
      "min" : 1
    },
    {
      "id" : "DocumentReference.subject",
      "path" : "DocumentReference.subject",
      "short" : "Patienten, som logisk referens med personnummer eller samordningsnummer",
      "min" : 1,
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://hl7.org/fhir/StructureDefinition/Patient"]
      }],
      "mustSupport" : true
    },
    {
      "id" : "DocumentReference.subject.type",
      "path" : "DocumentReference.subject.type",
      "min" : 1,
      "patternUri" : "Patient"
    },
    {
      "id" : "DocumentReference.subject.identifier",
      "path" : "DocumentReference.subject.identifier",
      "min" : 1,
      "constraint" : [{
        "key" : "inera-ei-patient-identifier",
        "severity" : "error",
        "human" : "Patienten identifieras med personnummer eller samordningsnummer.",
        "expression" : "system = 'http://electronichealth.se/identifier/personnummer' or system = 'http://electronichealth.se/identifier/samordningsnummer'",
        "source" : "https://fhir.inera.se/ig/engagementindex/StructureDefinition/IneraIndexEntry"
      }],
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
      "id" : "DocumentReference.event",
      "path" : "DocumentReference.event",
      "max" : "0"
    },
    {
      "id" : "DocumentReference.bodySite",
      "path" : "DocumentReference.bodySite",
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
      "short" : "Vårdgivare (personuppgiftsansvarig), som logisk referens med HSA-id",
      "min" : 1,
      "mustSupport" : true
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
      "patternUri" : "urn:oid:1.2.752.29.4.19"
    },
    {
      "id" : "DocumentReference.custodian.identifier.value",
      "path" : "DocumentReference.custodian.identifier.value",
      "min" : 1,
      "mustSupport" : true
    },
    {
      "id" : "DocumentReference.description",
      "path" : "DocumentReference.description",
      "max" : "0"
    },
    {
      "id" : "DocumentReference.content",
      "path" : "DocumentReference.content",
      "max" : "1",
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
      "short" : "Endpointens adress, så att konsumenten kan anropa källan utan ett extra uppslag",
      "min" : 1,
      "mustSupport" : true
    },
    {
      "id" : "DocumentReference.content.profile",
      "path" : "DocumentReference.content.profile",
      "slicing" : {
        "discriminator" : [{
          "type" : "type",
          "path" : "value"
        }],
        "rules" : "open"
      },
      "short" : "Informationsmängder inom tjänsten",
      "mustSupport" : true
    },
    {
      "id" : "DocumentReference.content.profile:category",
      "path" : "DocumentReference.content.profile",
      "sliceName" : "category",
      "short" : "Kategori inom tjänstedomänen (idag)",
      "min" : 0,
      "max" : "*",
      "mustSupport" : true
    },
    {
      "id" : "DocumentReference.content.profile:category.value[x]",
      "path" : "DocumentReference.content.profile.value[x]",
      "type" : [{
        "code" : "Coding"
      }],
      "binding" : {
        "strength" : "required",
        "valueSet" : "https://fhir.inera.se/ig/engagementindex/ValueSet/IneraEngagementCategoryValueSet"
      }
    },
    {
      "id" : "DocumentReference.content.profile:category.value[x].system",
      "path" : "DocumentReference.content.profile.value[x].system",
      "min" : 1
    },
    {
      "id" : "DocumentReference.content.profile:category.value[x].code",
      "path" : "DocumentReference.content.profile.value[x].code",
      "min" : 1
    },
    {
      "id" : "DocumentReference.content.profile:contentProfile",
      "path" : "DocumentReference.content.profile",
      "sliceName" : "contentProfile",
      "short" : "Profilens canonical, eller bas-resurstypens (framåt)",
      "min" : 0,
      "max" : "*",
      "mustSupport" : true
    },
    {
      "id" : "DocumentReference.content.profile:contentProfile.value[x]",
      "path" : "DocumentReference.content.profile.value[x]",
      "type" : [{
        "code" : "canonical"
      }]
    }]
  }
}

```
