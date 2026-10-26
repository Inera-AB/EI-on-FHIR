Svaren följer FHIR R4:s RESTful API. Tabellen visar de svar som är specifika för FHIR-EI. Fel beskrivs under [Felhantering](error-handling.html).

| Interaktion | Svar vid lyckat anrop | Kommentar |
|---|---|---|
| Sökning | `200 OK` med en `searchset`-Bundle | Träffar har `search.mode = match`, inkluderade Endpoints `search.mode = include`. Poster som filtrerats bort av spärr eller behörighet räknas inte i `total` |
| Läsning av en post | `200 OK` med posten | `410 Gone` för en borttagen post; `404 Not Found` för en post som inte finns eller som konsumenten inte har rätt att se |
| Villkorad `PUT`, ingen träff | `201 Created` | `Location` och `ETag` anger den nya versionen |
| Villkorad `PUT`, en träff | `200 OK` | Ny version, eller den lagrade versionen oförändrad om den inkommande har äldre `mostRecentContent` |
| Villkorad `DELETE` | `200 OK` eller `204 No Content` | Även när ingen post matchar, så att borttag är idempotent |
| `transaction` | `200 OK` med en `transaction-response`-Bundle | Ett svar per entry, i samma ordning |
| Skapa `Subscription` | `201 Created` | `status = requested` tills handskakningen lyckats, därefter `active` |
| `$export` | `202 Accepted` med `Content-Location` | Enligt Bulk Data Access |
{:.grid}

### Paginering

En sökning kan ge flera sidor. Klienten följer länken `next` i Bundlen. Inkluderade Endpoints finns på samma sida som de poster som refererar till dem.

### Filtrerade poster

En konsument får inte veta att poster filtrerats bort. Om det ska ändras, till exempel för att visa att information finns men kräver samtycke, är en [öppen fråga](open-issues.html).

### Exempel

- [Sökresultat för en patient](Bundle-SokresultatForPatient.html)
- [Registrering av indexposter i en transaction](Bundle-RegistreringTransaction.html)
