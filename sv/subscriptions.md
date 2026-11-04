# Prenumeration - FHIR-baserat engagemangsindex (FHIR-EI) v0.1.0

## Prenumeration

En konsument prenumererar på ändrade indexposter med R5:s inbyggda topic-baserade prenumerationer, profilerade som [Prenumeration på indexposter](StructureDefinition-IneraIndexSubscription.md). Prenumerationen ersätter ProcessNotification. Den sker i systemkontext, eftersom den lever längre än en användares session; se [Spärr, loggning och behörighet](security.md).

### Topic indexpost-andrad

| | |
| :--- | :--- |
| Resurs | [SubscriptionTopic indexpost-andrad](SubscriptionTopic-indexpost-andrad.md) |
| Canonical | `https://fhir.inera.se/ig/engagementindex/SubscriptionTopic/indexpost-andrad` |
| Triggar på | Skapande och uppdatering av`DocumentReference`, vilket omfattar avregistrering |
| Filter | `patient`(med`:identifier`),`type`och`custodian`(med`:identifier`) |
| Notisinnehåll | `id-only` |

Avregistrering syns som en uppdatering till status `superseded` eller `entered-in-error`, inte som en radering.

### Prenumerationen

Se exemplet [Prenumeration på en patients indexposter](Subscription-PrenumerationForPatient.md). Prenumerationen anger:

| | |
| :--- | :--- |
| `topic` | `https://fhir.inera.se/ig/engagementindex/SubscriptionTopic/indexpost-andrad` |
| `filterBy` | Filter enligt topic |
| `content` | Alltid`id-only`. FHIR-EI avvisar andra värden |
| `heartbeatPeriod` | Bör anges, så att ett avbrott upptäcks |

### Notiser

Notisen är en `subscription-notification`-Bundle med en `SubscriptionStatus` och postens id, men utan posten. Konsumenten läser posten med `GET DocumentReference/[id]`: i systemkontext för egen bearbetning, eller i användarkontext när posten ska visas för en användare. Läsningen i användarkontext går genom samma spärr, loggning och filtrering som en sökning.

FHIR-EI filtrerar notiserna på prenumerantens behörighet, och på yttre spärr när prenumeranten agerar för en bestämd vårdgivare. Samtycke och nödåtkomst kan inte prövas utan en användare, så prenumeranten ansvarar för prövningen per användare när informationen visas. `id-only` gör att notisen inte för med sig mer om patienten än nödvändigt.

### Leverans och återhämtning

Varje notis bär ett löpande händelsenummer. Konsumenten deduplicerar, upptäcker luckor med `$status` och hämtar missade händelser med `$events`. Reglerna för ordning, dubbletter och återhämtning finns under [Händelsemodell och övergång](event-model.md).

