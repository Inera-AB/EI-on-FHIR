Dagens tre tjänstekontrakt (FindContent, Update och ProcessNotification) får var sin FHIR R5-motsvarighet. API:et skiljer på tre användningsfall: sökning vid behov, löpande uppdatering via prenumeration och massuttag för avstämning. Alla läs-, skriv-, prenumerations- och exportanrop går genom samma centrala kontroll av behörighet, spärr och loggning; se [Spärr, loggning och behörighet](security.html). De formella kraven finns i [CapabilityStatement för FHIR-EI](CapabilityStatement-IneraIndexServer.html).

| Operation | Aktör | FHIR-interaktion | Motsvarighet idag |
|---|---|---|---|
| Sök indexposter för en patient | Konsument | `GET DocumentReference?patient:identifier=…&type=…` (standard: `status=current`) | FindContent |
| Filtrera på informationsmängd | Konsument | Standardparametrarna `format-code` / `format-canonical` (på `content.profile`) | FindContent med kategori |
| Filtrera på aktualitet | Konsument | Nationell sökparameter `content-last-updated=gt…` | FindContent med tidsfilter |
| Registrera eller uppdatera post | Producent | Villkorad `PUT DocumentReference?identifier=<producent>|<id>`, eller `transaction`-Bundle för flera | Update |
| Avregistrera post | Producent | Villkorad `PUT` med `status` = `superseded` eller `entered-in-error` och `deregistrationReason` | Update med deleteFlag |
| Prenumerera på ändringar | Konsument | R5 `Subscription` på `SubscriptionTopic` `indexpost-andrad`; se [Prenumeration](subscriptions.html) | ProcessNotification |
| Inkrementell avstämning | Konsument | `GET DocumentReference?_lastUpdated=gt…&status=current,superseded,entered-in-error` | Saknas |
| Massuttag | Systemkonsument | Bulk Data `$export` med `_type=DocumentReference` och `_since` | Saknas |
{:.grid}

---

### Sökparametrar

| Parameter | Typ | Element | Kommentar |
|---|---|---|---|
| `patient` | reference | `subject` | Med `:identifier`. Obligatorisk i varje konsumentsökning |
| `type` | token | `type` | Tjänst |
| `status` | token | `status` | Standardvärde `current` |
| `custodian` | reference | `custodian` | Vårdgivare, med `:identifier` |
| `identifier` | token | `identifier` | |
| `format-code` | token | `content.profile` som Coding | Informationsmängd idag |
| `format-canonical` | reference | `content.profile` som canonical | Informationsmängd framåt |
| [`content-last-updated`](SearchParameter-DocumentReference-content-last-updated.html) | date | extension contentLastUpdated | Nationell |
| [`source-endpoint`](SearchParameter-DocumentReference-source-endpoint.html) | reference | extension sourceEndpoint | Nationell |
| `_lastUpdated` | date | `meta.lastUpdated` | Inkrementell avstämning |
{:.grid}

En sökning utan `status` returnerar bara poster med status `current`. Avregistrerade poster returneras bara när status anges explicit.

Patienten är en logisk referens, eftersom indexet inte har några Patient-resurser. Sökningen görs därför med modifieraren `:identifier` och inte som kedjad sökning; se [Mappning till profiler](mappings.html).

Exempel, registrerade poster för en patient inom en tjänst vars innehåll ändrats efter 1 oktober 2026:

```
GET [base]/DocumentReference?patient:identifier=http://electronichealth.se/identifier/personnummer|191212121212
    &type=https://fhir.inera.se/ig/engagementindex/CodeSystem/IneraServiceDomainCodeSystem|riv:clinicalprocess:healthcond:description
    &content-last-updated=gt2026-10-01
```

Svaret visas i exemplet [Sökresultat för en patient](Bundle-SokresultatForPatient.html).

---

### Endpoint

Varje post har exakt en endpoint, som refereras i tjänstekatalogen med extension [sourceEndpoint](StructureDefinition-SourceEndpoint.html). Katalogen är auktoritativ för endpointens egenskaper. Adressen finns också i `content.attachment.url`, så att konsumenten kan anropa källan utan ett extra uppslag.

---

### Villkorad uppdatering

En producent registrerar, uppdaterar och avregistrerar poster med villkorad `PUT` på `identifier`:

```
PUT [base]/DocumentReference?identifier=https://journal-a.example.org/fhir/sid/indexpost|7f3c2a10-5b1e-4c8e-9f7a-2d6b8e4a1c33
```

| Träffar på identifier | Resultat |
|---|---|
| 0 | Posten skapas |
| 1 | Posten uppdateras, om den tillhör anropande producent |
| Fler än 1 | Avvisas med `412 Precondition Failed`; ingen post ändras |
{:.grid}

Posten i kroppen har inget `id`. Flera poster registreras i en `transaction`-Bundle, som i exemplet [Registrering och avregistrering i en transaction](Bundle-RegistreringTransaction.html).

Samtidiga uppdateringar av samma post hanteras med versionsvillkor (`If-Match` på `ETag`) eller med regeln om `contentLastUpdated` under [Händelsemodell och övergång](event-model.html). En producent får inte ändra `identifier` eller `registeringProducer` på en befintlig post.

Interaktionen `delete` stöds inte. Gravstenar rensas av FHIR-EI efter lagringstiden.

### Skrivbehörighet

En producent får endast skapa, uppdatera och avregistrera indexposter som tillhör producentens registrerade identitet. FHIR-EI härleder producentidentiteten från den autentiserade klienten, via en betrodd koppling mellan klientidentitet och producentidentitet. Komponenten kontrollerar att den överensstämmer med postens `registeringProducer` och med namnrymden i `identifier.system`. `meta.source` används aldrig ensamt för behörighetskontroll.
