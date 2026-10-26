# Indragen indexpost - FHIR-baserat engagemangsindex (FHIR-EI) v0.1.0

## Exempel DocumentReference: Indragen indexpost

Senast uppdaterad: 2026-10-22 10:15:41+0200

Profil: [Indexpost (FHIR-EI)](StructureDefinition-IneraIndexEntry.md)

**Producentens endpoint**: [https://tjanstekatalog.example.org/fhir/Endpoint/journal-a](https://tjanstekatalog.example.org/fhir/Endpoint/journal-a)

**Vårdenhet**: `urn:oid:1.2.752.29.4.19`/SE0000000000-VE01

**Registrerande producent**: [https://tjanstekatalog.example.org/fhir/Endpoint/journal-a](https://tjanstekatalog.example.org/fhir/Endpoint/journal-a)

**Registreringsstatus**: withdrawn

**Innehållets senaste ändring**: 2026-10-22 10:15:30+0200

**Orsak till avregistrering**: Avslutat engagemang

**identifier**: `https://tjanstekatalog.example.org/fhir/Endpoint/journal-a`/1a2b3c4d-5e6f-4a7b-8c9d-0e1f2a3b4c5d

**status**: Superseded

**type**: riv:clinicalprocess:healthcond:description

**subject**: Identifier: `http://electronichealth.se/identifier/personnummer`/191212121212

**custodian**: Identifier: `urn:oid:1.2.752.29.4.19`/SE0000000000-VG01

> **content**

### Attachments

| | |
| :--- | :--- |
| - | **Url** |
| * | [https://journal-a.example.org/fhir](https://journal-a.example.org/fhir) |

### Profiles

| | |
| :--- | :--- |
| - | **Value[x]** |
| * | [Kodsystem för kategorier inom tjänstedomän: voo](CodeSystem-IneraEngagementCategoryCodeSystem.md#IneraEngagementCategoryCodeSystem-voo)(voo) |




## Resource Content

```json
{
  "resourceType" : "DocumentReference",
  "id" : "IndexpostIndragen",
  "meta" : {
    "lastUpdated" : "2026-10-22T10:15:41+02:00",
    "profile" : ["https://fhir.inera.se/ig/engagementindex/StructureDefinition/IneraIndexEntry"]
  },
  "extension" : [{
    "url" : "https://fhir.inera.se/ig/engagementindex/StructureDefinition/SourceEndpoint",
    "valueReference" : {
      "reference" : "https://tjanstekatalog.example.org/fhir/Endpoint/journal-a"
    }
  },
  {
    "url" : "https://fhir.inera.se/ig/engagementindex/StructureDefinition/CareUnit",
    "valueIdentifier" : {
      "system" : "urn:oid:1.2.752.29.4.19",
      "value" : "SE0000000000-VE01"
    }
  },
  {
    "url" : "https://fhir.inera.se/ig/engagementindex/StructureDefinition/RegisteringProducer",
    "valueReference" : {
      "reference" : "https://tjanstekatalog.example.org/fhir/Endpoint/journal-a"
    }
  },
  {
    "url" : "https://fhir.inera.se/ig/engagementindex/StructureDefinition/RegistrationStatus",
    "valueCode" : "withdrawn"
  },
  {
    "url" : "https://fhir.inera.se/ig/engagementindex/StructureDefinition/ContentLastUpdated",
    "valueDateTime" : "2026-10-22T10:15:30+02:00"
  },
  {
    "url" : "https://fhir.inera.se/ig/engagementindex/StructureDefinition/DeregistrationReason",
    "valueCodeableConcept" : {
      "coding" : [{
        "system" : "https://fhir.inera.se/ig/engagementindex/CodeSystem/IneraDeregistrationReasonCodeSystem",
        "code" : "ended",
        "display" : "Avslutat engagemang"
      }]
    }
  }],
  "identifier" : [{
    "system" : "https://tjanstekatalog.example.org/fhir/Endpoint/journal-a",
    "value" : "1a2b3c4d-5e6f-4a7b-8c9d-0e1f2a3b4c5d"
  }],
  "status" : "superseded",
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
      "system" : "urn:oid:1.2.752.29.4.19",
      "value" : "SE0000000000-VG01"
    }
  },
  "content" : [{
    "attachment" : {
      "url" : "https://journal-a.example.org/fhir"
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
