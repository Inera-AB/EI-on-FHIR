Fel rapporteras med HTTP-statuskod och en `OperationOutcome` i svarskroppen. `OperationOutcome` bär aldrig uppgifter om andra patienter eller om poster som anroparen inte har rätt att se.

| Statuskod | `issue.code` | När |
|---|---|---|
| `400 Bad Request` | `invalid` | Ogiltig sökning, till exempel utan `patient:identifier`, eller okänd sökparameter |
| `401 Unauthorized` | `login` | Åtkomsttoken saknas eller är ogiltig |
| `403 Forbidden` | `forbidden` | Åtkomstkontexten räcker inte för anropet, eller en producent försöker skriva en post där den inte är registrerande system |
| `404 Not Found` | `not-found` | Posten finns inte, eller anroparen har inte rätt att se den |
| `410 Gone` | `deleted` | Posten är borttagen |
| `412 Precondition Failed` | `multiple-matches` | En villkorad `PUT` eller `DELETE` matchar flera poster |
| `422 Unprocessable Entity` | `processing` | Posten uppfyller inte [Indexpost](StructureDefinition-IneraEngagementIndexEntry.html), eller refererar till en okänd Endpoint |
| `429 Too Many Requests` | `throttled` | Anroparen har överskridit sin kvot. `Retry-After` anger när den kan försöka igen |
| `5xx` | `exception` | Tillfälligt fel i FHIR-EI eller i spärr-, logg- eller säkerhetstjänsten |
{:.grid}

### Fel i en transaction

En `transaction` registreras helt eller inte alls. Vid fel i någon entry svarar FHIR-EI med felets statuskod och en `OperationOutcome` som anger vilken entry som orsakade felet. Ingen entry i Bundlen har då skrivits.

### Omförsök

En producent SHALL försöka igen vid `429` och `5xx`, med ökande intervall. Vid `400`, `403` och `422` hjälper inte ett omförsök; händelsen läggs i kön för manuell hantering. Se [Händelsemodell och övergång](event-model.html).

Om spärrtjänsten inte svarar lämnar FHIR-EI inte ut några poster. Svaret är då `503 Service Unavailable`, inte ett tomt sökresultat.
