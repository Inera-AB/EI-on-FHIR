Fel rapporteras med HTTP-statuskod och en `OperationOutcome` i svarskroppen. En `OperationOutcome` innehåller aldrig uppgifter om patienter.

| Statuskod | `issue.code` | När |
|---|---|---|
| `400 Bad Request` | `invalid` | Sökningen saknar `subject:identifier` och klienten har inte behörighet för synk, eller en parameter är ogiltig |
| `401 Unauthorized` | `login` | Token saknas eller är ogiltig |
| `403 Forbidden` | `forbidden` | Klienten saknar behörighet för interaktionen, till exempel massuttag utan behörighet för synk |
| `404 Not Found` | `not-found` | Posten finns inte, eller borttagsloggens lagringstid har gått ut |
| `429 Too Many Requests` | `throttled` | Klienten har överskridit sin gräns för anrop |
| `503 Service Unavailable` | `transient` | EI är inte tillgängligt. Klienten försöker igen senare |
{:.grid}
