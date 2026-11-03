# Indexpost fylld av lokaliseringstjänsten - FHIR-baserat engagemangsindex (FHIR-EI) v0.1.0

## Exempel DocumentReference: Indexpost fylld av lokaliseringstjänsten

Senast uppdaterad: 2026-10-24 11:02:18+0200

Profil: [Indexpost (FHIR-EI)](StructureDefinition-IneraIndexEntry.md)

Tagg: [Inera-försörjd cache (Detaljer: Kodsystem för försörjningssätt kod cache = 'Inera-försörjd cache')](CodeSystem-IneraIndexPopulationMethodCodeSystem.md)

**Producentens endpoint**: [https://tjanstekatalog.example.org/fhir/Endpoint/journal-c](https://tjanstekatalog.example.org/fhir/Endpoint/journal-c)

**Registrerande producent**: [https://tjanstekatalog.example.org/fhir/Endpoint/lokaliseringstjanst](https://tjanstekatalog.example.org/fhir/Endpoint/lokaliseringstjanst)

**Registreringsstatus**: active

**Källsystem**: `urn:oid:1.2.752.29.4.19`/SE0000000000-SYS3

**Innehållets senaste ändring**: 2026-10-24 09:47:03+0200

**identifier**: `https://tjanstekatalog.example.org/fhir/Endpoint/lokaliseringstjanst`/c1d2e3f4-a5b6-4c7d-8e9f-0a1b2c3d4e5f

**status**: Current

**type**: riv:clinicalprocess:healthcond:description

**subject**: Identifier: `http://electronichealth.se/identifier/personnummer`/191212121212

**custodian**: Identifier: `urn:oid:2.5.4.97`/0000000000

> **content**

### Attachments

| | |
| :--- | :--- |
| - | **Url** |
| * | [https://journal-c.example.org/fhir](https://journal-c.example.org/fhir) |

### Profiles

| | |
| :--- | :--- |
| - | **Value[x]** |
| * | [Kodsystem för kategorier inom tjänstedomän: voo](CodeSystem-IneraEngagementCategoryCodeSystem.md#IneraEngagementCategoryCodeSystem-voo)(voo) |




## Resource Content

```json
{
  "resourceType" : "DocumentReference",
  "id" : "IndexpostFranLokaliseringstjanst",
  "meta" : {
    "lastUpdated" : "2026-10-24T11:02:18+02:00",
    "profile" : ["https://fhir.inera.se/ig/engagementindex/StructureDefinition/IneraIndexEntry"],
    "tag" : [{
      "system" : "https://fhir.inera.se/ig/engagementindex/CodeSystem/IneraIndexPopulationMethodCodeSystem",
      "code" : "cache"
    }]
  },
  "extension" : [{
    "url" : "https://fhir.inera.se/ig/engagementindex/StructureDefinition/SourceEndpoint",
    "valueReference" : {
      "reference" : "https://tjanstekatalog.example.org/fhir/Endpoint/journal-c"
    }
  },
  {
    "url" : "https://fhir.inera.se/ig/engagementindex/StructureDefinition/RegisteringProducer",
    "valueReference" : {
      "reference" : "https://tjanstekatalog.example.org/fhir/Endpoint/lokaliseringstjanst"
    }
  },
  {
    "url" : "https://fhir.inera.se/ig/engagementindex/StructureDefinition/RegistrationStatus",
    "valueCode" : "active"
  },
  {
    "url" : "https://fhir.inera.se/ig/engagementindex/StructureDefinition/SourceSystem",
    "valueIdentifier" : {
      "system" : "urn:oid:1.2.752.29.4.19",
      "value" : "SE0000000000-SYS3"
    }
  },
  {
    "url" : "https://fhir.inera.se/ig/engagementindex/StructureDefinition/ContentLastUpdated",
    "valueDateTime" : "2026-10-24T09:47:03+02:00"
  }],
  "identifier" : [{
    "system" : "https://tjanstekatalog.example.org/fhir/Endpoint/lokaliseringstjanst",
    "value" : "c1d2e3f4-a5b6-4c7d-8e9f-0a1b2c3d4e5f"
  }],
  "status" : "current",
  "type" : {
    "coding" : [{
      "system" : "https://fhir.inera.se/ig/engagementindex/CodeSystem/IneraServiceDomainCodeSystem",
      "code" : "riv:clinicalprocess:healthcond:description"
    }]
  },
  "subject" : {
    "type" : "Patient",
    "identifier" : {
      "system" : "http://electronichealth.se/identifier/personnummer",
      "value" : "191212121212"
    }
  },
  "custodian" : {
    "identifier" : {
      "system" : "urn:oid:2.5.4.97",
      "value" : "0000000000"
    }
  },
  "content" : [{
    "attachment" : {
      "url" : "https://journal-c.example.org/fhir"
    },
    "profile" : [{
      "valueCoding" : {
        "system" : "https://fhir.inera.se/ig/engagementindex/CodeSystem/IneraEngagementCategoryCodeSystem",
        "code" : "voo"
      }
    }]
  }]
}

```
