Dagens tre tjänstekontrakt (FindContent, Update och ProcessNotification) får var sin FHIR-motsvarighet. Alla konsumentanrop går via spärr, logg och filtrering; se [Spärr, loggning och behörighet](security.html). De formella kraven finns i [CapabilityStatement för FHIR-EI](CapabilityStatement-IneraEngagementIndexServer.html).

| Operation | Aktör | FHIR-interaktion | Motsvarighet idag |
|---|---|---|---|
| Sök indexposter för en patient | Konsument | `GET EpisodeOfCare?patient:identifier=…&type=…&_include=EpisodeOfCare:source-endpoint` | FindContent |
| Filtrera på aktualitet | Konsument | Sökparametern `most-recent-content=gt…` | FindContent med tidsfilter |
| Registrera eller uppdatera post | Producent | Villkorad `PUT EpisodeOfCare?identifier=…`, eller `transaction`-Bundle för flera | Update |
| Ta bort post | Producent | Villkorad `DELETE EpisodeOfCare?identifier=…` | Update med deleteFlag |
| Prenumerera på ändringar | Konsument | `Subscription` enligt R4 Subscriptions Backport; se [Prenumeration](subscriptions.html) | ProcessNotification |
| Massuttag | Systemkonsument | Bulk Data `$export` med `_type=EpisodeOfCare` och `_since` | Saknas |
{:.grid}

---

### Sökparametrar för EpisodeOfCare

| Parameter | Typ | Element | Krav |
|---|---|---|---|
| `patient` | reference | `patient` | SHALL, med `:identifier` |
| `type` | token | `type` | SHALL |
| `organization` | reference | `managingOrganization` | SHALL, med `:identifier` |
| `identifier` | token | `identifier` | SHALL |
| [`care-unit`](SearchParameter-EpisodeOfCare-care-unit.html) | token | extension careUnit | SHALL |
| [`most-recent-content`](SearchParameter-EpisodeOfCare-most-recent-content.html) | date | extension mostRecentContent | SHALL |
| [`source-endpoint`](SearchParameter-EpisodeOfCare-source-endpoint.html) | reference | extension sourceEndpoint | SHALL, främst för `_include` |
| [`content-profile`](SearchParameter-EpisodeOfCare-content-profile.html) | uri | extension contentProfile | SHOULD |
| `_lastUpdated` | date | `meta.lastUpdated` | SHALL |
{:.grid}

En konsument SHALL ange `patient:identifier` i varje sökning. FHIR-EI svarar inte på sökningar som inte är avgränsade till en patient; massuttag sker med `$export`.

Exempel, alla poster för en patient inom en tjänstedomän som ändrats efter 1 oktober 2026, med endpoints:

```
GET [base]/EpisodeOfCare?patient:identifier=http://electronichealth.se/identifier/personnummer|191212121212
    &type=https://fhir.inera.se/ig/engagementindex/CodeSystem/IneraServiceDomainCodeSystem|riv:clinicalprocess:healthcond:description
    &most-recent-content=gt2026-10-01
    &_include=EpisodeOfCare:source-endpoint
```

Svaret visas i exemplet [Sökresultat för en patient](Bundle-SokresultatForPatient.html).

---

### Registrering

En producent registrerar och uppdaterar poster med villkorad `PUT` på `identifier[sourceEntryId]`:

```
PUT [base]/EpisodeOfCare?identifier=https://journal-a.example.org/fhir/sid/indexpost|7f3c2a10-5b1e-4c8e-9f7a-2d6b8e4a1c33
```

Posten i kroppen har inget `id`. Finns ingen post med identifieraren skapas den (`201 Created`); finns en uppdateras den (`200 OK`). Flera poster registreras i en `transaction`-Bundle, som i exemplet [Registrering av indexposter i en transaction](Bundle-RegistreringTransaction.html).

Producenten anger källsystemets endpoint som logisk referens med källsystemets HSA-id (`valueReference.identifier`). FHIR-EI löser referensen till den registrerade [Endpoint](StructureDefinition-IneraEngagementIndexEndpoint.html)-resursen och lagrar en litteral referens, så att `_include` fungerar. Endpoints registreras när källsystemet ansluts.

En producent får bara skriva poster där den själv är registrerande system (`meta.source`). FHIR-EI sätter `meta.source` från klientens identitet i åtkomsttoken och ignorerar värdet i kroppen.
