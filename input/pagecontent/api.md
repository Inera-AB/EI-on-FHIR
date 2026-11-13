API:et är skrivskyddat och följer FHIR R4:s RESTful API. Det stöder läsning och sökning av engagemangsposter och massuttag med [Bulk Data Access](https://hl7.org/fhir/uv/bulkdata/). De formella kraven finns i [CapabilityStatement för EI-on-FHIR](CapabilityStatement-IneraEngagementIndexServer.html).

| Operation | Interaktion | Användningsfall | Motsvarighet i EI |
|---|---|---|---|
| Sök en patients poster | `GET DocumentReference?subject:identifier=…` | 1 | FindContent |
| Läs en post | `GET DocumentReference/[id]` | 1, 2 | – |
| Sök ändrade poster | `GET DocumentReference?_lastUpdated=gt…&status=current,superseded&_sort=_lastUpdated` | 2 | – |
| Massuttag | `GET [base]/$export?_type=DocumentReference` | 2 | – |
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
| `_id` | token | `id` | SHOULD | |
{:.grid}

Patienten söks med `subject:identifier`, som i NRL. Indexet har inga Patient-resurser, så patienten är en logisk referens. En sökning utan `status` returnerar bara poster med status `current`.

Sökresultatet är en `searchset`-Bundle. Ett stort resultat delas upp i sidor; klienten följer länken `next`. API:et stöder `_count` och, för löpande synk, `_sort=_lastUpdated`. Se exemplet [Sökresultat för en patient](Bundle-SokresultatForPatient.html).

### Borttagna poster

EI tar bort en post när källsystemet registrerar den med deleteFlag. För att synken ska se borttaget behåller EI-on-FHIR posten i en borttagslogg under en lagringstid, och visar den med status `superseded`. Den kommer med i en sökning som anger `status=superseded`, i ett massuttag med `_since` och vid läsning med id. Efter lagringstiden svarar API:et `404 Not Found`. Hur länge loggen sparas är en [öppen fråga](open-issues.html).

### Massuttag

Massuttaget följer Bulk Data Access på systemnivå:

1. Klienten startar uttaget med `GET [base]/$export?_type=DocumentReference`, och `_since=` för ändringar sedan en tidpunkt. Svaret är `202 Accepted` med `Content-Location`.
2. Klienten frågar statusadressen tills uttaget är klart. Svaret listar NDJSON-filer med en engagemangspost per rad.
3. Klienten hämtar filerna och tar sedan bort uttaget med `DELETE` på statusadressen.

Massuttag är bara tillåtet för klienter med behörighet för synk; se [Säkerhet och loggning](security.html).

### Läsning

`GET DocumentReference/[id]` returnerar posten. En post som inte finns, eller vars lagringstid i borttagsloggen har gått ut, ger `404 Not Found`.
