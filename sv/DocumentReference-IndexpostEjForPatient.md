# Indexpost som inte visas för patient eller närstående - FHIR-baserat engagemangsindex (FHIR-EI) v0.1.0

## Exempel DocumentReference: Indexpost som inte visas för patient eller närstående

Senast uppdaterad: 2026-10-23 09:12:40+0200

Profil: [Indexpost (FHIR-EI)](StructureDefinition-IneraIndexEntry.md)

Säkerhetsetikett: [no disclosure to patient, family or caregivers without attending provider's authorization (Detaljer: ActCode kod NOPAT = 'no disclosure to patient, family or caregivers without attending provider's authorization')](http://terminology.hl7.org/7.4.0/CodeSystem-v3-ActCode.html)

**Producentens endpoint**: [https://tjanstekatalog.example.org/fhir/Endpoint/journal-a](https://tjanstekatalog.example.org/fhir/Endpoint/journal-a)

**Vårdenhet**: `urn:oid:1.2.752.29.4.19`/SE0000000000-VE03

**Registrerande producent**: [https://tjanstekatalog.example.org/fhir/Endpoint/journal-a](https://tjanstekatalog.example.org/fhir/Endpoint/journal-a)

**Registreringsstatus**: active

**Innehållets senaste ändring**: 2026-10-23 09:12:31+0200

**identifier**: `https://tjanstekatalog.example.org/fhir/Endpoint/journal-a`/3c4d5e6f-7a8b-4c9d-8e0f-1a2b3c4d5e6f

**status**: Current

**type**: riv:clinicalprocess:healthcond:description

**subject**: Identifier: `http://electronichealth.se/identifier/personnummer`/191212121212

**custodian**: Identifier: `urn:oid:1.2.752.29.4.19`/SE0000000000-VG01

> **content**

### Attachments

| | |
| :--- | :--- |
| - | **Url** |
| * | [https://journal-a.example.org/fhir](https://journal-a.example.org/fhir) |

> **profile****value**: [Kodsystem för kategorier inom tjänstedomän: voo](CodeSystem-IneraEngagementCategoryCodeSystem.md#IneraEngagementCategoryCodeSystem-voo) (voo)

> **profile****value**: [Composition](http://hl7.org/fhir/R5/composition.html)



## Resource Content

```json
{
  "resourceType" : "DocumentReference",
  "id" : "IndexpostEjForPatient",
  "meta" : {
    "lastUpdated" : "2026-10-23T09:12:40+02:00",
    "profile" : ["https://fhir.inera.se/ig/engagementindex/StructureDefinition/IneraIndexEntry"],
    "security" : [{
      "system" : "http://terminology.hl7.org/CodeSystem/v3-ActCode",
      "code" : "NOPAT"
    }]
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
      "value" : "SE0000000000-VE03"
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
    "valueCode" : "active"
  },
  {
    "url" : "https://fhir.inera.se/ig/engagementindex/StructureDefinition/ContentLastUpdated",
    "valueDateTime" : "2026-10-23T09:12:31+02:00"
  }],
  "identifier" : [{
    "system" : "https://tjanstekatalog.example.org/fhir/Endpoint/journal-a",
    "value" : "3c4d5e6f-7a8b-4c9d-8e0f-1a2b3c4d5e6f"
  }],
  "status" : "current",
  "type" : {
    "coding" : [{
      "system" : "https://fhir.inera.se/ig/engagementindex/CodeSystem/IneraServiceDomainCodeSystem",
      "code" : "riv:clinicalprocess:healthcond:description"
    },
    {
      "system" : "urn:ietf:rfc:3986",
      "code" : "https://example.org/fhir/ImplementationGuide/vardochomsorgsdokumentation"
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
    },
    {
      "valueCanonical" : "http://hl7.org/fhir/StructureDefinition/Composition"
    }]
  }]
}

```
