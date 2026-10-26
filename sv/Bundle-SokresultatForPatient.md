# Sökresultat för en patient - FHIR-baserat engagemangsindex (FHIR-EI) v0.1.0

## Exempel Bundle: Sökresultat för en patient



## Resource Content

```json
{
  "resourceType" : "Bundle",
  "id" : "SokresultatForPatient",
  "type" : "searchset",
  "total" : 2,
  "link" : [{
    "relation" : "self",
    "url" : "https://ei.example.org/fhir/DocumentReference?patient:identifier=http://electronichealth.se/identifier/personnummer|191212121212"
  }],
  "entry" : [{
    "fullUrl" : "https://ei.example.org/fhir/DocumentReference/IndexpostFhirProducent",
    "resource" : {
      "resourceType" : "DocumentReference",
      "id" : "IndexpostFhirProducent",
      "meta" : {
        "lastUpdated" : "2026-10-20T14:32:07+02:00",
        "profile" : ["https://fhir.inera.se/ig/engagementindex/StructureDefinition/IneraIndexEntry"]
      },
      "text" : {
        "status" : "extensions",
        "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><a name=\"DocumentReference_IndexpostFhirProducent\"> </a><p class=\"res-header-id\"><b>Genererad berättande text: DocumentReference IndexpostFhirProducent</b></p><a name=\"IndexpostFhirProducent\"> </a><a name=\"hcIndexpostFhirProducent\"> </a><div style=\"display: inline-block; background-color: #d9e0e7; padding: 6px; margin: 4px; border: 1px solid #8da1b4; border-radius: 5px; line-height: 60%\"><p style=\"margin-bottom: 0px\">Senast uppdaterad: 2026-10-20 14:32:07+0200</p><p style=\"margin-bottom: 0px\">Profil: <a href=\"StructureDefinition-IneraIndexEntry.html\">Indexpost (FHIR-EI)</a></p></div><p><b>Producentens endpoint</b>: <a href=\"https://tjanstekatalog.example.org/fhir/Endpoint/journal-a\">https://tjanstekatalog.example.org/fhir/Endpoint/journal-a</a></p><p><b>Vårdenhet</b>: <code>urn:oid:1.2.752.29.4.19</code>/SE0000000000-VE01</p><p><b>Registrerande producent</b>: <a href=\"https://tjanstekatalog.example.org/fhir/Endpoint/journal-a\">https://tjanstekatalog.example.org/fhir/Endpoint/journal-a</a></p><p><b>Registreringsstatus</b>: active</p><p><b>Innehållets senaste ändring</b>: 2026-10-20 14:31:55+0200</p><p><b>identifier</b>: <code>https://tjanstekatalog.example.org/fhir/Endpoint/journal-a</code>/7f3c2a10-5b1e-4c8e-9f7a-2d6b8e4a1c33</p><p><b>status</b>: Current</p><p><b>type</b>: <span title=\"Koder:{https://fhir.inera.se/ig/engagementindex/CodeSystem/IneraServiceDomainCodeSystem riv:clinicalprocess:healthcond:description}, {urn:ietf:rfc:3986 https://example.org/fhir/ImplementationGuide/vardochomsorgsdokumentation}\">riv:clinicalprocess:healthcond:description</span></p><p><b>subject</b>: Identifier: <code>http://electronichealth.se/identifier/personnummer</code>/191212121212</p><p><b>custodian</b>: Identifier: <code>urn:oid:1.2.752.29.4.19</code>/SE0000000000-VG01</p><blockquote><p><b>content</b></p><h3>Attachments</h3><table class=\"grid\"><tr><td style=\"display: none\">-</td><td><b>Url</b></td></tr><tr><td style=\"display: none\">*</td><td><a href=\"https://journal-a.example.org/fhir\">https://journal-a.example.org/fhir</a></td></tr></table><blockquote><p><b>profile</b></p><p><b>value</b>: <a href=\"CodeSystem-IneraEngagementCategoryCodeSystem.html#IneraEngagementCategoryCodeSystem-voo\">Kodsystem för kategorier inom tjänstedomän: voo</a> (voo)</p></blockquote><blockquote><p><b>profile</b></p><p><b>value</b>: <a href=\"http://hl7.org/fhir/R5/composition.html\">Composition</a></p></blockquote></blockquote></div>"
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
    },
    "search" : {
      "mode" : "match"
    }
  },
  {
    "fullUrl" : "https://ei.example.org/fhir/DocumentReference/IndexpostFranAdapter",
    "resource" : {
      "resourceType" : "DocumentReference",
      "id" : "IndexpostFranAdapter",
      "meta" : {
        "lastUpdated" : "2026-10-21T08:05:12+02:00",
        "profile" : ["https://fhir.inera.se/ig/engagementindex/StructureDefinition/IneraIndexEntry"]
      },
      "text" : {
        "status" : "extensions",
        "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><a name=\"DocumentReference_IndexpostFranAdapter\"> </a><p class=\"res-header-id\"><b>Genererad berättande text: DocumentReference IndexpostFranAdapter</b></p><a name=\"IndexpostFranAdapter\"> </a><a name=\"hcIndexpostFranAdapter\"> </a><div style=\"display: inline-block; background-color: #d9e0e7; padding: 6px; margin: 4px; border: 1px solid #8da1b4; border-radius: 5px; line-height: 60%\"><p style=\"margin-bottom: 0px\">Senast uppdaterad: 2026-10-21 08:05:12+0200</p><p style=\"margin-bottom: 0px\">Profil: <a href=\"StructureDefinition-IneraIndexEntry.html\">Indexpost (FHIR-EI)</a></p></div><p><b>Producentens endpoint</b>: <a href=\"https://tjanstekatalog.example.org/fhir/Endpoint/ntjp-getcaredocumentation\">https://tjanstekatalog.example.org/fhir/Endpoint/ntjp-getcaredocumentation</a></p><p><b>Vårdenhet</b>: <code>urn:oid:1.2.752.29.4.19</code>/SE0000000000-VE02</p><p><b>Registrerande producent</b>: <a href=\"https://tjanstekatalog.example.org/fhir/Endpoint/overgangsadapter\">https://tjanstekatalog.example.org/fhir/Endpoint/overgangsadapter</a></p><p><b>Registreringsstatus</b>: active</p><p><b>Logisk adress</b>: <code>urn:oid:1.2.752.29.4.19</code>/SE0000000000-VE02</p><p><b>Källsystem</b>: <code>urn:oid:1.2.752.29.4.19</code>/SE0000000000-SYS2</p><p><b>Innehållets senaste ändring</b>: 2026-10-21 08:04:59+0200</p><p><b>identifier</b>: <code>https://tjanstekatalog.example.org/fhir/Endpoint/overgangsadapter</code>/b5e0d6a4-1f2c-5e7d-8a9b-0c1d2e3f4a5b</p><p><b>status</b>: Current</p><p><b>type</b>: <span title=\"Koder:{https://fhir.inera.se/ig/engagementindex/CodeSystem/IneraServiceDomainCodeSystem riv:clinicalprocess:healthcond:description}\">riv:clinicalprocess:healthcond:description</span></p><p><b>subject</b>: Identifier: <code>http://electronichealth.se/identifier/personnummer</code>/191212121212</p><p><b>custodian</b>: Identifier: <code>urn:oid:1.2.752.29.4.19</code>/SE0000000000-VG02</p><blockquote><p><b>content</b></p><h3>Attachments</h3><table class=\"grid\"><tr><td style=\"display: none\">-</td><td><b>Url</b></td></tr><tr><td style=\"display: none\">*</td><td><a href=\"https://ntjp.example.org/vp/clinicalprocess/healthcond/description/GetCareDocumentation/2/rivtabp21\">https://ntjp.example.org/vp/clinicalprocess/healthcond/description/GetCareDocumentation/2/rivtabp21</a></td></tr></table><h3>Profiles</h3><table class=\"grid\"><tr><td style=\"display: none\">-</td><td><b>Value[x]</b></td></tr><tr><td style=\"display: none\">*</td><td><a href=\"CodeSystem-IneraEngagementCategoryCodeSystem.html#IneraEngagementCategoryCodeSystem-voo\">Kodsystem för kategorier inom tjänstedomän: voo</a> (voo)</td></tr></table></blockquote></div>"
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
    },
    "search" : {
      "mode" : "match"
    }
  }]
}

```
