# Ofullständigt sökresultat - FHIR-baserat engagemangsindex (FHIR-EI) v0.1.0

## Exempel Bundle: Ofullständigt sökresultat



## Resource Content

```json
{
  "resourceType" : "Bundle",
  "id" : "SokresultatOfullstandigt",
  "type" : "searchset",
  "total" : 1,
  "link" : [{
    "relation" : "self",
    "url" : "https://ei.example.org/fhir/DocumentReference?patient:identifier=http://electronichealth.se/identifier/personnummer|191212121212"
  }],
  "entry" : [{
    "fullUrl" : "https://ei.example.org/fhir/DocumentReference/IndexpostFranLokaliseringstjanst",
    "resource" : {
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
      "text" : {
        "status" : "extensions",
        "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><a name=\"DocumentReference_IndexpostFranLokaliseringstjanst\"> </a><p class=\"res-header-id\"><b>Genererad berättande text: DocumentReference IndexpostFranLokaliseringstjanst</b></p><a name=\"IndexpostFranLokaliseringstjanst\"> </a><a name=\"hcIndexpostFranLokaliseringstjanst\"> </a><div style=\"display: inline-block; background-color: #fbffeb; padding: 6px; margin: 4px; border: 1px solid #8da1b4; border-radius: 5px; line-height: 60%\"><p style=\"margin-bottom: 0px\">Senast uppdaterad: 2026-10-24 11:02:18+0200</p><p style=\"margin-bottom: 0px\">Profil: <a href=\"StructureDefinition-IneraIndexEntry.html\">Indexpost (FHIR-EI)</a></p><p style=\"margin-bottom: 0px\">Tagg: <a href=\"CodeSystem-IneraIndexPopulationMethodCodeSystem.html\">Inera-försörjd cache (Detaljer: Kodsystem för försörjningssätt kod cache = 'Inera-försörjd cache')</a></p></div><p><b>Producentens endpoint</b>: <a href=\"https://tjanstekatalog.example.org/fhir/Endpoint/journal-c\">https://tjanstekatalog.example.org/fhir/Endpoint/journal-c</a></p><p><b>Registrerande producent</b>: <a href=\"https://tjanstekatalog.example.org/fhir/Endpoint/lokaliseringstjanst\">https://tjanstekatalog.example.org/fhir/Endpoint/lokaliseringstjanst</a></p><p><b>Registreringsstatus</b>: active</p><p><b>Källsystem</b>: <code>urn:oid:1.2.752.29.4.19</code>/SE0000000000-SYS3</p><p><b>Innehållets senaste ändring</b>: 2026-10-24 09:47:03+0200</p><p><b>identifier</b>: <code>https://tjanstekatalog.example.org/fhir/Endpoint/lokaliseringstjanst</code>/c1d2e3f4-a5b6-4c7d-8e9f-0a1b2c3d4e5f</p><p><b>status</b>: Current</p><p><b>type</b>: <span title=\"Koder:{https://fhir.inera.se/ig/engagementindex/CodeSystem/IneraServiceDomainCodeSystem riv:clinicalprocess:healthcond:description}\">riv:clinicalprocess:healthcond:description</span></p><p><b>subject</b>: Identifier: <code>http://electronichealth.se/identifier/personnummer</code>/191212121212</p><p><b>custodian</b>: Identifier: <code>urn:oid:2.5.4.97</code>/0000000000</p><blockquote><p><b>content</b></p><h3>Attachments</h3><table class=\"grid\"><tr><td style=\"display: none\">-</td><td><b>Url</b></td></tr><tr><td style=\"display: none\">*</td><td><a href=\"https://journal-c.example.org/fhir\">https://journal-c.example.org/fhir</a></td></tr></table><h3>Profiles</h3><table class=\"grid\"><tr><td style=\"display: none\">-</td><td><b>Value[x]</b></td></tr><tr><td style=\"display: none\">*</td><td><a href=\"CodeSystem-IneraEngagementCategoryCodeSystem.html#IneraEngagementCategoryCodeSystem-voo\">Kodsystem för kategorier inom tjänstedomän: voo</a> (voo)</td></tr></table></blockquote></div>"
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
    },
    "search" : {
      "mode" : "match"
    }
  }],
  "issues" : {
    "resourceType" : "OperationOutcome",
    "id" : "kalla-svarade-inte",
    "text" : {
      "status" : "generated",
      "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><p>Källan svarade inte inom tidsgränsen. Uppgifter kan saknas för vårdgivare 0000000000.</p></div>"
    },
    "issue" : [{
      "severity" : "warning",
      "code" : "incomplete",
      "details" : {
        "text" : "Källan svarade inte inom tidsgränsen. Uppgifter kan saknas för vårdgivaren."
      },
      "diagnostics" : "Vårdgivare 0000000000 (organisationsnummer), endpoint https://tjanstekatalog.example.org/fhir/Endpoint/journal-d"
    }]
  }
}

```
