# Engagemangspost från en FHIR-producent - EI-on-FHIR: FHIR-API för engagemangsindex v0.1.0

## Exempel DocumentReference: Engagemangspost från en FHIR-producent

Senast uppdaterad: 2026-11-12 09:41:27+0100

Profil: [Engagemangspost](StructureDefinition-IneraEngagement.md)

**Källsystem**: `urn:oid:1.2.752.29.4.19`/SE0000000000-SYS1

**Ägare**: `urn:oid:1.2.752.29.4.19`/SE0000000000-EIF0

**Logisk adress**: `urn:oid:1.2.752.29.4.19`/SE0000000000-VG01

**Senaste innehåll**: 2026-11-12 09:40:00+0100

**identifier**: c2d8e6f1-3a47-4b0e-9e21-5f8a7d3b6c04

**status**: Current

**type**: riv:clinicalprocess:healthcond:description

**subject**: Identifier: `http://electronichealth.se/identifier/personnummer`/191212121212

**date**: 2026-11-12 09:41:27+0100

**custodian**: Identifier: `urn:oid:1.2.752.29.4.19`/SE0000000000-VG01

> **content**

### Attachments

| | | |
| :--- | :--- | :--- |
| - | **ContentType** | **Url** |
| * | application/fhir+json | [https://fhir.vg01.example.org/fhir](https://fhir.vg01.example.org/fhir) |

### Profiles

| | |
| :--- | :--- |
| - | **Value[x]** |
| * | [Kodsystem för hämtningsprotokoll: fhir](CodeSystem-IneraRetrievalProtocolCodeSystem.md#IneraRetrievalProtocolCodeSystem-fhir)(FHIR) |




## Resource Content

```json
{
  "resourceType" : "DocumentReference",
  "id" : "EngagemangspostFhir",
  "meta" : {
    "lastUpdated" : "2026-11-12T09:41:27+01:00",
    "profile" : ["https://fhir.inera.se/ig/engagementindex/StructureDefinition/IneraEngagement"]
  },
  "extension" : [{
    "url" : "https://fhir.inera.se/ig/engagementindex/StructureDefinition/SourceSystem",
    "valueIdentifier" : {
      "system" : "urn:oid:1.2.752.29.4.19",
      "value" : "SE0000000000-SYS1"
    }
  },
  {
    "url" : "https://fhir.inera.se/ig/engagementindex/StructureDefinition/Owner",
    "valueIdentifier" : {
      "system" : "urn:oid:1.2.752.29.4.19",
      "value" : "SE0000000000-EIF0"
    }
  },
  {
    "url" : "https://fhir.inera.se/ig/engagementindex/StructureDefinition/LogicalAddress",
    "valueIdentifier" : {
      "system" : "urn:oid:1.2.752.29.4.19",
      "value" : "SE0000000000-VG01"
    }
  },
  {
    "url" : "https://fhir.inera.se/ig/engagementindex/StructureDefinition/MostRecentContent",
    "valueDateTime" : "2026-11-12T09:40:00+01:00"
  }],
  "identifier" : [{
    "value" : "c2d8e6f1-3a47-4b0e-9e21-5f8a7d3b6c04"
  }],
  "status" : "current",
  "type" : {
    "coding" : [{
      "system" : "https://fhir.inera.se/ig/engagementindex/CodeSystem/IneraServiceDomainCodeSystem",
      "code" : "riv:clinicalprocess:healthcond:description"
    }]
  },
  "subject" : {
    "identifier" : {
      "system" : "http://electronichealth.se/identifier/personnummer",
      "value" : "191212121212"
    }
  },
  "date" : "2026-11-12T09:41:27+01:00",
  "custodian" : {
    "identifier" : {
      "system" : "urn:oid:1.2.752.29.4.19",
      "value" : "SE0000000000-VG01"
    }
  },
  "content" : [{
    "attachment" : {
      "contentType" : "application/fhir+json",
      "url" : "https://fhir.vg01.example.org/fhir"
    },
    "profile" : [{
      "valueCoding" : {
        "system" : "https://fhir.inera.se/ig/engagementindex/CodeSystem/IneraRetrievalProtocolCodeSystem",
        "code" : "fhir"
      }
    }]
  }]
}

```
