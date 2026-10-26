Fel rapporteras med HTTP-statuskod och en `OperationOutcome` i svarskroppen. `OperationOutcome` bär aldrig uppgifter om andra patienter eller om poster som anroparen inte har rätt att se.

| Statuskod | `issue.code` | När |
|---|---|---|
| `400 Bad Request` | `invalid` | Ogiltig sökning, till exempel utan `patient:identifier`, eller okänd sökparameter |
| `401 Unauthorized` | `login` | Åtkomsttoken saknas eller är ogiltig |
| `403 Forbidden` | `forbidden` | Åtkomstkontexten räcker inte för anropet, eller en producent försöker skriva en post som inte tillhör dess identitet |
| `404 Not Found` | `not-found` | Posten finns inte, eller anroparen har inte rätt att se den |
| `405 Method Not Allowed` | `not-supported` | `DELETE` på en indexpost; avregistrering sker med villkorad `PUT` |
| `409 Conflict` | `conflict` | En producent försöker ändra `identifier` eller `registeringProducer` på en befintlig post |
| `412 Precondition Failed` | `multiple-matches` | En villkorad `PUT` matchar flera poster, eller `If-Match` stämmer inte med aktuell version |
| `422 Unprocessable Entity` | `processing` | Posten uppfyller inte [Indexpost](StructureDefinition-IneraIndexEntry.html) eller tjänstens tillämpning |
| `429 Too Many Requests` | `throttled` | Anroparen har överskridit sin kvot. `Retry-After` anger när den kan försöka igen |
| `5xx` | `exception` | Tillfälligt fel i FHIR-EI eller i spärr-, logg- eller säkerhetstjänsten |
{:.grid}

### Fel i en transaction

En `transaction` registreras helt eller inte alls. Vid fel i någon entry svarar FHIR-EI med felets statuskod och en `OperationOutcome` som anger vilken entry som orsakade felet. Ingen entry i Bundlen har då skrivits.

### Omförsök

En producent SHALL försöka igen vid `429` och `5xx`, med ökande intervall. Vid `400`, `403`, `409` och `422` hjälper inte ett omförsök; händelsen läggs i kön för manuell hantering. Se [Händelsemodell och övergång](event-model.html).

Om spärrtjänsten inte svarar lämnar FHIR-EI inte ut några poster. Svaret är då `503 Service Unavailable`, inte ett tomt sökresultat.
