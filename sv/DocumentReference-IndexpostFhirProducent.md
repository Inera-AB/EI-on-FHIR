# Registrerad indexpost från en FHIR-producent - FHIR-baserat engagemangsindex (FHIR-EI) v0.1.0

## Exempel DocumentReference: Registrerad indexpost från en FHIR-producent

Senast uppdaterad: 2026-10-20 14:32:07+0200

Profil: [Indexpost (FHIR-EI)](StructureDefinition-IneraIndexEntry.md)

**Producentens endpoint**: [https://tjanstekatalog.example.org/fhir/Endpoint/journal-a](https://tjanstekatalog.example.org/fhir/Endpoint/journal-a)

**Vårdenhet**: `urn:oid:1.2.752.29.4.19`/SE0000000000-VE01

**Registrerande producent**: [https://tjanstekatalog.example.org/fhir/Endpoint/journal-a](https://tjanstekatalog.example.org/fhir/Endpoint/journal-a)

**Registreringsstatus**: active

**Innehållets senaste ändring**: 2026-10-20 14:31:55+0200

**identifier**: `https://tjanstekatalog.example.org/fhir/Endpoint/journal-a`/7f3c2a10-5b1e-4c8e-9f7a-2d6b8e4a1c33

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
  "id" : "IndexpostFhirProducent",
  "meta" : {
    "lastUpdated" : "2026-10-20T14:32:07+02:00",
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
    "valueCode" : "active"
  },
  {
    "url" : "https://fhir.inera.se/ig/engagementindex/StructureDefinition/ContentLastUpdated",
    "valueDateTime" : "2026-10-20T14:31:55+02:00"
  }],
  "identifier" : [{
    "system" : "https://tjanstekatalog.example.org/fhir/Endpoint/journal-a",
    "value" : "7f3c2a10-5b1e-4c8e-9f7a-2d6b8e4a1c33"
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
