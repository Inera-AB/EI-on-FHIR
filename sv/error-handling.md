# Felhantering - EI-on-FHIR: FHIR-API för engagemangsindex v0.1.0

## Felhantering

Fel rapporteras med HTTP-statuskod och en `OperationOutcome` i svarskroppen. En `OperationOutcome` innehåller aldrig uppgifter om patienter.

| | | |
| :--- | :--- | :--- |
| `400 Bad Request` | `invalid` | Sökningen saknar`subject:identifier`och klienten har inte behörighet för synk, eller en parameter är ogiltig |
| `401 Unauthorized` | `login` | Token saknas eller är ogiltig |
| `403 Forbidden` | `forbidden` | Klienten saknar behörighet för interaktionen, till exempel massuttag utan behörighet för synk |
| `403 Forbidden` | `forbidden` | En producent försöker skriva en post med ett annat källsystem än sitt eget, eller ta bort en post från EI |
| `404 Not Found` | `not-found` | Posten finns inte, eller borttagsloggens lagringstid har gått ut |
| `412 Precondition Failed` | `multiple-matches` | Producentens villkorade update träffar fler än en av dess poster |
| `422 Unprocessable Entity` | `business-rule`eller`invalid` | Posten följer inte profilen,`custodian`är inte en vårdgivare, eller endpointen finns inte i tjänstekatalogen för vårdgivaren |
| `429 Too Many Requests` | `throttled` | Klienten har överskridit sin gräns för anrop |
| `503 Service Unavailable` | `transient` | EI är inte tillgängligt. Klienten försöker igen senare |

