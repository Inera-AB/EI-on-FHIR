# Förväntade svar - FHIR-baserat engagemangsindex (FHIR-EI) v0.1.0

## Förväntade svar

Svaren följer FHIR R5:s RESTful API. Tabellen visar de svar som är specifika för FHIR-EI. Fel beskrivs under [Felhantering](error-handling.md).

| | | |
| :--- | :--- | :--- |
| Sökning | `200 OK`med en`searchset`-Bundle | Utan`status`bara poster med status`current`. Poster som filtrerats bort av spärr eller behörighet räknas inte i`total` |
| Läsning av en post | `200 OK`med posten | Även för avregistrerade poster under gravstenarnas lagringstid.`404 Not Found`för en post som inte finns eller som konsumenten inte har rätt att se |
| Villkorad`PUT`, ingen träff | `201 Created` | `Location`och`ETag`anger den nya versionen |
| Villkorad`PUT`, en träff | `200 OK` | Ny version, eller den lagrade versionen oförändrad om den inkommande har äldre`contentLastUpdated` |
| `transaction` | `200 OK`med en`transaction-response`-Bundle | Ett svar per entry, i samma ordning |
| Skapa`Subscription` | `201 Created` | `status = requested`tills handskakningen lyckats, därefter`active` |
| `$status`,`$events` | `200 OK`med en`subscription-notification`-Bundle | Enligt R5 |
| `$export` | `202 Accepted`med`Content-Location` | Enligt Bulk Data Access |

### Paginering

En sökning kan ge flera sidor. Klienten följer länken `next` i Bundlen.

### Filtrerade poster

Om konsumenten får veta att poster filtrerats bort, till exempel "information finns men kräver samtycke", beror på lagstiftningen för syftet. Det styrs av `purposeOfUse` i frågan och av spärrtjänstens svar, som FHIR-EI för vidare i sitt svar. Se [Spärr, loggning och behörighet](security.md).

### Exempel

* [Sökresultat för en patient](Bundle-SokresultatForPatient.md)
* [Registrering och avregistrering i en transaction](Bundle-RegistreringTransaction.md)

