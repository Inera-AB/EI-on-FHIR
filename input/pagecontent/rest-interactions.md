Dagens tre tjänstekontrakt (FindContent, Update och ProcessNotification) får var sin FHIR R5-motsvarighet. API:et skiljer på tre användningsfall: sökning vid behov, löpande uppdatering via prenumeration och massuttag för avstämning. Alla anrop autentiseras och loggas. Vad FHIR-EI prövar beror på anropets åtkomstläge, användarkontext eller systemkontext; se [Spärr, loggning och behörighet](security.html). De formella kraven finns i [CapabilityStatement för FHIR-EI](CapabilityStatement-IneraIndexServer.html).

| Operation | Aktör | FHIR-interaktion | Åtkomstläge | Motsvarighet idag |
|---|---|---|---|---|
| Sök indexposter för en patient | Konsument | `GET DocumentReference?patient:identifier=…&type=…` (standard: `status=current`) | Användarkontext | FindContent |
| Filtrera på informationsmängd | Konsument | Standardparametrarna `format-code` / `format-canonical` (på `content.profile`) | Användarkontext | FindContent med kategori |
| Filtrera på aktualitet | Konsument | Nationell sökparameter `content-last-updated=gt…` | Användarkontext | FindContent med tidsfilter |
| Registrera eller uppdatera post | Registrerande part | Villkorad `PUT DocumentReference?identifier=<part>|<id>`, eller `transaction`-Bundle för flera | Systemkontext | Update |
| Avregistrera post | Registrerande part | Villkorad `PUT` med `status` = `superseded` eller `entered-in-error` och `deregistrationReason` | Systemkontext | Update med deleteFlag |
| Prenumerera på ändringar | Konsument | R5 `Subscription` på `SubscriptionTopic` `indexpost-andrad`; se [Prenumeration](subscriptions.html) | Systemkontext | ProcessNotification |
| Inkrementell avstämning | Konsument | `GET DocumentReference?_lastUpdated=gt…&status=current,superseded,entered-in-error` | Systemkontext | Saknas |
| Massuttag | Systemkonsument | Bulk Data `$export` med `_type=DocumentReference` och `_since` | Systemkontext | Saknas |
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

Patienten är en logisk referens, eftersom indexet inte har några Patient-resurser. Sökningen görs därför med modifieraren `:identifier` och inte som kedjad sökning (`patient.identifier=`), som skulle kräva att referensen löses upp till en Patient i FHIR-EI. Profilen kräver `subject.type = Patient`, så att servern kan avgöra att referensen gäller en patient. Vårdgivaren söks på samma sätt, med `custodian:identifier=`.

Exempel, registrerade poster för en patient inom en tjänst vars innehåll ändrats efter 1 oktober 2026:

```
GET [base]/DocumentReference?patient:identifier=http://electronichealth.se/identifier/personnummer|191212121212
    &type=https://fhir.inera.se/ig/engagementindex/CodeSystem/IneraServiceDomainCodeSystem|riv:clinicalprocess:healthcond:description
    &content-last-updated=gt2026-10-01
```

Svaret visas i exemplet [Sökresultat för en patient](Bundle-SokresultatForPatient.html).

---

### Läs- och skriv-API

Läs-, prenumerations- och export-API:et är detsamma för alla [försörjningssätt](population.html). Skriv-API:et används vid producentregistrering, av indexeringsagenten och av övergångsadaptern. Lokaliseringstjänsten skriver också via skriv-API:et, aldrig direkt i indexkärnan, så att reglerna för indexposten och livscykeln gäller på samma sätt; se [Roller och ansvar](roles-and-responsibilities.html).

När FHIR-EI vet att ett svar kan vara ofullständigt, till exempel när en källa inte svarade på lokaliseringstjänstens riktade fråga inom tidsgränsen, innehåller sökresultatet en `OperationOutcome` i `Bundle.issues`; se [Förväntade svar](expected-responses.html).

### Endpoint

Varje post har exakt en endpoint, som refereras i tjänstekatalogen med extension [sourceEndpoint](StructureDefinition-SourceEndpoint.html). Katalogen är auktoritativ för endpointens egenskaper. Adressen finns också i `content.attachment.url`, så att konsumenten kan anropa källan utan ett extra uppslag.

När endpointen adresseras med logisk adress, som tjänsteplattformen för RIV-TA, bär posten också [logicalAddress](StructureDefinition-LogicalAddress.html). Konsumenten anger den i anropet.

---

### Villkorad uppdatering

En registrerande part registrerar, uppdaterar och avregistrerar poster med villkorad `PUT` på `identifier`:

```
PUT [base]/DocumentReference?identifier=https://tjanstekatalog.example.org/fhir/Endpoint/journal-a|7f3c2a10-5b1e-4c8e-9f7a-2d6b8e4a1c33
```

Villkoret utvärderas bara mot den anropande partens egna poster. En part kan alltså aldrig träffa en annan parts post, och svaret avslöjar inte om en identifierare finns hos någon annan.

| Träffar bland partens egna poster | Resultat |
|---|---|
| 0 | Posten skapas |
| 1 | Posten uppdateras |
| Fler än 1 | Avvisas med `412 Precondition Failed`; ingen post ändras |
{:.grid}

Posten i kroppen har inget `id`. Flera poster registreras i en `transaction`-Bundle, som i exemplet [Registrering och avregistrering i en transaction](Bundle-RegistreringTransaction.html).

Samtidiga uppdateringar av samma post hanteras med versionsvillkor (`If-Match` på `ETag`) eller med regeln om `contentLastUpdated` under [Händelsemodell och övergång](event-model.html). En registrerande part får inte ändra `identifier` eller `registeringProducer` på en befintlig post.

Interaktionen `delete` stöds inte. Gravstenar rensas av FHIR-EI efter lagringstiden.

### Identitet och skrivbehörighet

En registrerande parts identitet är dess Endpoint i tjänstekatalogen. FHIR-EI binder den autentiserade klienten till en sådan endpoint, via en betrodd koppling mellan klientidentitet (certifikat eller token) och endpoint. Vid varje skrivning kontrollerar FHIR-EI:

| Kontroll | Regel |
|---|---|
| Registrerande part | `registeringProducer` är en absolut referens till den endpoint klienten är bunden till |
| Namnrymd | `identifier.system` är samma URL som `registeringProducer`. Profilens invariant `inera-ei-producer-namespace` kontrollerar det, och inget register över namnrymder behövs |
| Endpoint | För en producent eller indexeringsagent är `sourceEndpoint` samma endpoint som `registeringProducer` |
| Vårdgivare | `custodian` är en vårdgivare i tjänstekatalogen, inte ett källsystem eller en vårdenhet. Vårdgivaren, eller en underliggande enhet via `partOf`, listar `sourceEndpoint` i `Organization.endpoint` i tjänstekatalogen |
{:.grid}

Övergångsadaptern och lokaliseringstjänsten har ombudsroll. De är registrerade i tjänstekatalogen med egna endpoints och får registrera poster vars `sourceEndpoint` är en annan endpoint, men bara inom sitt underlag: adaptern för kombinationer av logisk adress och tjänstedomän i sitt adressregister, lokaliseringstjänsten för vårdgivare som eHM:s patientindex anger för patienten. Se [Försörjning av indexet](population.html).

En registrerande part får inte ändra `identifier` eller `registeringProducer` på en befintlig post. `meta.source` används aldrig ensamt för behörighetskontroll.
