# Indexpost speglad av övergångsadaptern - FHIR-baserat engagemangsindex (FHIR-EI) v0.1.0

## Exempel DocumentReference: Indexpost speglad av övergångsadaptern

Senast uppdaterad: 2026-10-21 08:05:12+0200

Profil: [Indexpost (FHIR-EI)](StructureDefinition-IneraIndexEntry.md)

**Producentens endpoint**: [https://tjanstekatalog.example.org/fhir/Endpoint/ntjp-getcaredocumentation](https://tjanstekatalog.example.org/fhir/Endpoint/ntjp-getcaredocumentation)

**Vårdenhet**: `urn:oid:1.2.752.29.4.19`/SE0000000000-VE02

**Registrerande producent**: [https://tjanstekatalog.example.org/fhir/Endpoint/overgangsadapter](https://tjanstekatalog.example.org/fhir/Endpoint/overgangsadapter)

**Registreringsstatus**: active

**Logisk adress**: `urn:oid:1.2.752.29.4.19`/SE0000000000-VE02

**Källsystem**: `urn:oid:1.2.752.29.4.19`/SE0000000000-SYS2

**Innehållets senaste ändring**: 2026-10-21 08:04:59+0200

**identifier**: `https://tjanstekatalog.example.org/fhir/Endpoint/overgangsadapter`/b5e0d6a4-1f2c-5e7d-8a9b-0c1d2e3f4a5b

**status**: Current

**type**: riv:clinicalprocess:healthcond:description

**subject**: Identifier: `http://electronichealth.se/identifier/personnummer`/191212121212

**custodian**: Identifier: `urn:oid:1.2.752.29.4.19`/SE0000000000-VG02

> **content**

### Attachments

| | |
| :--- | :--- |
| - | **Url** |
| * | [https://ntjp.example.org/vp/clinicalprocess/healthcond/description/GetCareDocumentation/2/rivtabp21](https://ntjp.example.org/vp/clinicalprocess/healthcond/description/GetCareDocumentation/2/rivtabp21) |

### Profiles

| | |
| :--- | :--- |
| - | **Value[x]** |
| * | [Kodsystem för kategorier inom tjänstedomän: voo](CodeSystem-IneraEngagementCategoryCodeSystem.md#IneraEngagementCategoryCodeSystem-voo)(voo) |




## Resource Content

```json
{
  "resourceType" : "DocumentReference",
  "id" : "IndexpostFranAdapter",
  "meta" : {
    "lastUpdated" : "2026-10-21T08:05:12+02:00",
    "profile" : ["https://fhir.inera.se/ig/engagementindex/StructureDefinition/IneraIndexEntry"]
  },
  "extension" : [{
    "url" : "https://fhir.inera.se/ig/engagementindex/StructureDefinition/SourceEndpoint",
    "valueReference" : {
      "reference" : "https://tjanstekatalog.example.org/fhir/Endpoint/ntjp-getcaredocumentation"
    }
  },
  {
    "url" : "https://fhir.inera.se/ig/engagementindex/StructureDefinition/CareUnit",
    "valueIdentifier" : {
      "system" : "urn:oid:1.2.752.29.4.19",
      "value" : "SE0000000000-VE02"
    }
  },
  {
    "url" : "https://fhir.inera.se/ig/engagementindex/StructureDefinition/RegisteringProducer",
    "valueReference" : {
      "reference" : "https://tjanstekatalog.example.org/fhir/Endpoint/overgangsadapter"
    }
  },
  {
    "url" : "https://fhir.inera.se/ig/engagementindex/StructureDefinition/RegistrationStatus",
    "valueCode" : "active"
  },
  {
    "url" : "https://fhir.inera.se/ig/engagementindex/StructureDefinition/LogicalAddress",
    "valueIdentifier" : {
      "system" : "urn:oid:1.2.752.29.4.19",
      "value" : "SE0000000000-VE02"
    }
  },
  {
    "url" : "https://fhir.inera.se/ig/engagementindex/StructureDefinition/SourceSystem",
    "valueIdentifier" : {
      "system" : "urn:oid:1.2.752.29.4.19",
      "value" : "SE0000000000-SYS2"
    }
  },
  {
    "url" : "https://fhir.inera.se/ig/engagementindex/StructureDefinition/ContentLastUpdated",
    "valueDateTime" : "2026-10-21T08:04:59+02:00"
  }],
  "identifier" : [{
    "system" : "https://tjanstekatalog.example.org/fhir/Endpoint/overgangsadapter",
    "value" : "b5e0d6a4-1f2c-5e7d-8a9b-0c1d2e3f4a5b"
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
      "system" : "urn:oid:1.2.752.29.4.19",
      "value" : "SE0000000000-VG02"
    }
  },
  "content" : [{
    "attachment" : {
      "url" : "https://ntjp.example.org/vp/clinicalprocess/healthcond/description/GetCareDocumentation/2/rivtabp21"
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
