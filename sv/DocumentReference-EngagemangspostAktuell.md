# Aktuell engagemangspost - EI-on-FHIR: FHIR-API för engagemangsindex v0.1.0

## Exempel DocumentReference: Aktuell engagemangspost

Senast uppdaterad: 2026-11-02 14:32:10+0100

Profil: [Engagemangspost](StructureDefinition-IneraEngagement.md)

**Källsystem**: `urn:oid:1.2.752.29.4.19`/SE0000000000-SYS1

**Ägare**: `urn:oid:1.2.752.29.4.19`/SE0000000000-EI00

**Logisk adress**: `urn:oid:1.2.752.29.4.19`/SE0000000000-VG01

**Senaste innehåll**: 2026-11-02 14:30:00+0100

**identifier**: 7f3c2a10-5b1e-4c8e-9f7a-2d6b8e4a1c33

**status**: Current

**type**: riv:clinicalprocess:healthcond:description

**category**: voo

**subject**: Identifier: `http://electronichealth.se/identifier/personnummer`/191212121212

**date**: 2025-03-11 09:15:00+0100

**custodian**: Identifier: `urn:oid:1.2.752.29.4.19`/SE0000000000-VG01

> **content**

### Attachments

| | |
| :--- | :--- |
| - | **ContentType** |
| * | application/xml |

### Profiles

| | |
| :--- | :--- |
| - | **Value[x]** |
| * | [Kodsystem för hämtningsprotokoll: riv-ta](CodeSystem-IneraRetrievalProtocolCodeSystem.md#IneraRetrievalProtocolCodeSystem-riv-ta)(RIV-TA) |




## Resource Content

```json
{
  "resourceType" : "DocumentReference",
  "id" : "EngagemangspostAktuell",
  "meta" : {
    "lastUpdated" : "2026-11-02T14:32:10+01:00",
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
      "value" : "SE0000000000-EI00"
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
    "valueDateTime" : "2026-11-02T14:30:00+01:00"
  }],
  "identifier" : [{
    "value" : "7f3c2a10-5b1e-4c8e-9f7a-2d6b8e4a1c33"
  }],
  "status" : "current",
  "type" : {
    "coding" : [{
      "system" : "https://fhir.inera.se/ig/engagementindex/CodeSystem/IneraServiceDomainCodeSystem",
      "code" : "riv:clinicalprocess:healthcond:description"
    }]
  },
  "category" : [{
    "coding" : [{
      "system" : "https://fhir.inera.se/ig/engagementindex/CodeSystem/IneraEngagementCategoryCodeSystem",
      "code" : "voo"
    }]
  }],
  "subject" : {
    "identifier" : {
      "system" : "http://electronichealth.se/identifier/personnummer",
      "value" : "191212121212"
    }
  },
  "date" : "2025-03-11T09:15:00+01:00",
  "custodian" : {
    "identifier" : {
      "system" : "urn:oid:1.2.752.29.4.19",
      "value" : "SE0000000000-VG01"
    }
  },
  "content" : [{
    "attachment" : {
      "contentType" : "application/xml"
    },
    "profile" : [{
      "valueCoding" : {
        "system" : "https://fhir.inera.se/ig/engagementindex/CodeSystem/IneraRetrievalProtocolCodeSystem",
        "code" : "riv-ta"
      }
    }]
  }]
}

```
