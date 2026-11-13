# Borttagen engagemangspost - EI-on-FHIR: FHIR-API för engagemangsindex v0.1.0

## Exempel DocumentReference: Borttagen engagemangspost

Senast uppdaterad: 2026-11-05 16:45:02+0100

Profil: [Engagemangspost](StructureDefinition-IneraEngagement.md)

**Källsystem**: `urn:oid:1.2.752.29.4.19`/SE0000000000-SYS3

**Ägare**: `urn:oid:1.2.752.29.4.19`/SE0000000000-EI00

**Logisk adress**: `urn:oid:1.2.752.29.4.19`/SE0000000000-VG03

**identifier**: a91d4e77-0c2f-4b19-8d55-3e6f0b7c2a90

**status**: Superseded

**type**: riv:clinicalprocess:healthcond:description

**category**: voo

**subject**: Identifier: `http://electronichealth.se/identifier/personnummer`/191212121212

**date**: 2023-09-19 13:05:00+0200

**custodian**: Identifier: `urn:oid:1.2.752.29.4.19`/SE0000000000-VG03

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
  "id" : "EngagemangspostBorttagen",
  "meta" : {
    "lastUpdated" : "2026-11-05T16:45:02+01:00",
    "profile" : ["https://fhir.inera.se/ig/engagementindex/StructureDefinition/IneraEngagement"]
  },
  "extension" : [{
    "url" : "https://fhir.inera.se/ig/engagementindex/StructureDefinition/SourceSystem",
    "valueIdentifier" : {
      "system" : "urn:oid:1.2.752.29.4.19",
      "value" : "SE0000000000-SYS3"
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
      "value" : "SE0000000000-VG03"
    }
  }],
  "identifier" : [{
    "value" : "a91d4e77-0c2f-4b19-8d55-3e6f0b7c2a90"
  }],
  "status" : "superseded",
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
  "date" : "2023-09-19T13:05:00+02:00",
  "custodian" : {
    "identifier" : {
      "system" : "urn:oid:1.2.752.29.4.19",
      "value" : "SE0000000000-VG03"
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
