API:et följer FHIR R5:s RESTful API. Det stöder läsning och sökning av engagemangsposter från EI och från EI-on-FHIR:s register, registrering i registret för FHIR-producenter, och massuttag med [Bulk Data Access](https://hl7.org/fhir/uv/bulkdata/). Poster från EI går inte att ändra via API:et. De formella kraven finns i [CapabilityStatement för EI-on-FHIR](CapabilityStatement-IneraEngagementIndexServer.html).

| Operation | Interaktion | Användningsfall | Motsvarighet i EI |
|---|---|---|---|
| Sök en patients poster | `GET DocumentReference?subject:identifier=…` | 1 | FindContent |
| Läs en post | `GET DocumentReference/[id]` | 1, 2 | – |
| Sök ändrade poster | `GET DocumentReference?_lastUpdated=gt…&status=current,superseded&_sort=_lastUpdated` | 2 | – |
| Massuttag | `GET [base]/$export?_type=DocumentReference` | 2 | – |
| Registrera eller uppdatera en post | `PUT DocumentReference?identifier=…` | 3 | Update |
| Ta bort en post | `DELETE DocumentReference/[id]` | 3 | Update med deleteFlag |
{:.grid}

---

### Sökparametrar

| Parameter | Typ | Element | Krav | Kommentar |
|---|---|---|---|---|
| `subject` | reference | `subject` | SHALL | Med `:identifier`. Obligatorisk, utom för klienter med behörighet för synk |
| `type` | token | `type` | SHALL | Tjänstedomän |
| [`logical-address`](SearchParameter-DocumentReference-logical-address.html) | token | extension logicalAddress | SHALL | HSA-id |
| `status` | token | `status` | SHALL | Standardvärde `current` |
| `_lastUpdated` | date | `meta.lastUpdated` | SHALL | Löpande synk |
| `category` | token | `category` | SHOULD | Kategori inom tjänstedomän |
| `custodian` | reference | `custodian` | SHOULD | Med `:identifier` |
| [`source-system`](SearchParameter-DocumentReference-source-system.html) | token | extension sourceSystem | SHOULD | HSA-id |
| `format-code` | token | `content.profile` som Coding | SHOULD | Hämtningsprotokoll, `riv-ta` eller `fhir` |
| `identifier` | token | `identifier` | SHALL | Producentens villkorade update |
| `_id` | token | `id` | SHOULD | |
{:.grid}

Patienten söks med `subject:identifier`, som i NRL. Indexet har inga Patient-resurser, så patienten är en logisk referens. En sökning utan `status` returnerar bara poster med status `current`. Sökresultatet innehåller poster från både EI och registret; `format-code=…|fhir` begränsar det till FHIR-poster.

Sökresultatet är en `searchset`-Bundle. Ett stort resultat delas upp i sidor; klienten följer länken `next`. API:et stöder `_count` och, för löpande synk, `_sort=_lastUpdated`. Se exemplet [Sökresultat för en patient](Bundle-SokresultatForPatient.html).

### Borttagna poster

EI tar bort en post när källsystemet registrerar den med deleteFlag, och registret tar bort en post när producenten anropar `DELETE`. För att synken ska se borttaget sparas posten i en borttagslogg under en lagringstid, och visas med status `superseded`. Den kommer med i en sökning som anger `status=superseded`, i ett massuttag med `_since` och vid läsning med id. Efter lagringstiden svarar API:et `404 Not Found`. Hur länge loggen sparas är en [öppen fråga](open-issues.html).

### Massuttag

Massuttaget följer Bulk Data Access på systemnivå. Bulk Data Access finns bara publicerad för R4, så kravet står här i text och inte i CapabilityStatementet:

1. Klienten startar uttaget med `GET [base]/$export?_type=DocumentReference`, och `_since=` för ändringar sedan en tidpunkt. Svaret är `202 Accepted` med `Content-Location`.
2. Klienten frågar statusadressen tills uttaget är klart. Svaret listar NDJSON-filer med en engagemangspost per rad.
3. Klienten hämtar filerna och tar sedan bort uttaget med `DELETE` på statusadressen.

Massuttag är bara tillåtet för klienter med behörighet för synk; se [Säkerhet och loggning](security.html).

### Registrering för FHIR-producenter

En källa som implementerar en tjänsts FHIR-IG registrerar sina poster i EI-on-FHIR:s register, som i NRL:s producent-API. Bara klienter med behörighet som producent får skriva, och bara poster med sitt eget källsystem.

```
PUT [base]/DocumentReference?identifier=c2d8e6f1-3a47-4b0e-9e21-5f8a7d3b6c04
Content-Type: application/fhir+json

{ "resourceType": "DocumentReference", "status": "current", … }
```

Villkoret utvärderas bara mot producentens egna poster i registret:

| Träffar bland producentens poster | Resultat |
|---|---|
| 0 | Posten skapas: `201 Created` med `Location` |
| 1 | Posten uppdateras: `200 OK` |
| Fler än 1 | Avvisas med `412 Precondition Failed` |
{:.grid}

Posten ska följa profilen [Engagemangspost](StructureDefinition-IneraEngagement.html) med `content.profile` = `fhir`. Producenten utelämnar `id`, `owner`, `date` och `meta.lastUpdated`, som API:et sätter. API:et kontrollerar dessutom:

| Kontroll | Regel |
|---|---|
| Källsystem | Extension `sourceSystem` är det källsystem som klienten är registrerad för |
| Vårdgivare | `custodian` är en vårdgivare i HSA |
| Endpoint | `content.attachment.url` är en FHIR-endpoint som vårdgivaren har i tjänstekatalogen |
| Logisk adress | Om den anges ska den vara en organisation hos samma vårdgivare |
{:.grid}

Ett anrop som bryter mot en kontroll avvisas med `422 Unprocessable Entity`; se [Felhantering](error-handling.html). `DELETE DocumentReference/[id]` tar bort en av producentens egna poster. Poster från EI kan inte tas bort via API:et.

### Läsning

`GET DocumentReference/[id]` returnerar posten. En post som inte finns, eller vars lagringstid i borttagsloggen har gått ut, ger `404 Not Found`.
