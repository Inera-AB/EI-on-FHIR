En konsument prenumererar på ändrade indexposter med R5:s inbyggda topic-baserade prenumerationer, profilerade som [Prenumeration på indexposter](StructureDefinition-IneraIndexSubscription.html). Prenumerationen ersätter ProcessNotification.

### Topic `indexpost-andrad`

| | |
|---|---|
| Resurs | [SubscriptionTopic indexpost-andrad](SubscriptionTopic-indexpost-andrad.html) |
| Canonical | `https://fhir.inera.se/ig/engagementindex/SubscriptionTopic/indexpost-andrad` |
| Triggar på | Skapande och uppdatering av `DocumentReference`, vilket omfattar avregistrering |
| Filter | `patient` (med `:identifier`), `type` och `custodian` (med `:identifier`) |
| Notisinnehåll | `id-only` |
{:.grid}

Avregistrering syns som en uppdatering till status `superseded` eller `entered-in-error`, inte som en radering.

### Prenumerationen

Se exemplet [Prenumeration på en patients indexposter](Subscription-PrenumerationForPatient.html). Prenumerationen anger:

| Element | Krav |
|---|---|
| `topic` | `https://fhir.inera.se/ig/engagementindex/SubscriptionTopic/indexpost-andrad` |
| `filterBy` | Filter enligt topic |
| `content` | Alltid `id-only`. FHIR-EI avvisar andra värden |
| `heartbeatPeriod` | Bör anges, så att ett avbrott upptäcks |
{:.grid}

### Notiser

Notisen är en `subscription-notification`-Bundle med en `SubscriptionStatus` och postens id, men utan posten. Konsumenten läser posten med `GET DocumentReference/[id]`, och läsningen går genom samma spärr, loggning och filtrering som en sökning.

En konsument får bara notis om poster som den skulle ha fått i en sökning. Det, och `id-only`-innehåll, hindrar att notiser läcker förekomst av spärrad information.

### Leverans och återhämtning

Varje notis bär ett löpande händelsenummer. Konsumenten deduplicerar, upptäcker luckor med `$status` och hämtar missade händelser med `$events`. Reglerna för ordning, dubbletter och återhämtning finns under [Händelsemodell och övergång](event-model.html).
