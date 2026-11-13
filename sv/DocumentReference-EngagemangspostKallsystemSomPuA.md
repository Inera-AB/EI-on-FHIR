# Engagemangspost med källsystemet som personuppgiftsansvarig - EI-on-FHIR: FHIR-API för engagemangsindex v0.1.0

## Exempel DocumentReference: Engagemangspost med källsystemet som personuppgiftsansvarig

Senast uppdaterad: 2026-10-28 08:01:44+0100

Profil: [Engagemangspost](StructureDefinition-IneraEngagement.md)

**Källsystem**: `urn:oid:1.2.752.29.4.19`/SE0000000000-SYS2

**Ägare**: `urn:oid:1.2.752.29.4.19`/SE0000000000-EI00

**Logisk adress**: `urn:oid:1.2.752.29.4.19`/SE0000000000-VE02

**identifier**: BOI-2024-000118

**status**: Current

**type**: riv:clinicalprocess:activityprescription:actoutcome

**subject**: Identifier: `http://electronichealth.se/identifier/personnummer`/191212121212

**date**: 2024-06-03 10:20:00+0200

**custodian**: Identifier: `urn:oid:1.2.752.29.4.19`/SE0000000000-SYS2

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
  "id" : "EngagemangspostKallsystemSomPuA",
  "meta" : {
    "lastUpdated" : "2026-10-28T08:01:44+01:00",
    "profile" : ["https://fhir.inera.se/ig/engagementindex/StructureDefinition/IneraEngagement"]
  },
  "extension" : [{
    "url" : "https://fhir.inera.se/ig/engagementindex/StructureDefinition/SourceSystem",
    "valueIdentifier" : {
      "system" : "urn:oid:1.2.752.29.4.19",
      "value" : "SE0000000000-SYS2"
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
      "value" : "SE0000000000-VE02"
    }
  }],
  "identifier" : [{
    "value" : "BOI-2024-000118"
  }],
  "status" : "current",
  "type" : {
    "coding" : [{
      "system" : "https://fhir.inera.se/ig/engagementindex/CodeSystem/IneraServiceDomainCodeSystem",
      "code" : "riv:clinicalprocess:activityprescription:actoutcome"
    }]
  },
  "subject" : {
    "identifier" : {
      "system" : "http://electronichealth.se/identifier/personnummer",
      "value" : "191212121212"
    }
  },
  "date" : "2024-06-03T10:20:00+02:00",
  "custodian" : {
    "identifier" : {
      "system" : "urn:oid:1.2.752.29.4.19",
      "value" : "SE0000000000-SYS2"
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
