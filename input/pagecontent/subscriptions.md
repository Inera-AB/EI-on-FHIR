En konsument prenumererar på ändrade indexposter med `Subscription` enligt [R4 Subscriptions Backport](https://hl7.org/fhir/uv/subscriptions-backport/STU1.1/), profilerad som [Prenumeration på indexposter](StructureDefinition-IneraEngagementIndexSubscription.html). Prenumerationen ersätter ProcessNotification.

### Topic `indexpost-andrad`

| | |
|---|---|
| Canonical | `https://fhir.inera.se/ig/engagementindex/SubscriptionTopic/indexpost-andrad` |
| Resurs | `EpisodeOfCare` |
| Triggar på | create, update och delete |
| Filter | `patient` (med `:identifier`), `type` och `organization` (med `:identifier`) |
| Notisinnehåll | `id-only` |
{:.grid}

FHIR R4 har ingen SubscriptionTopic-resurs. FHIR-EI annonserar topic i sitt CapabilityStatement med extension `capabilitystatement-subscriptiontopic-canonical`, som backport-IG:n anger för R4.

### Filter

Filtret anges i `Subscription.criteria` med extension `backport-filter-criteria`, i samma syntax som en sökning:

```
EpisodeOfCare?patient:identifier=http://electronichealth.se/identifier/personnummer|191212121212
  &type=https://fhir.inera.se/ig/engagementindex/CodeSystem/IneraServiceDomainCodeSystem|riv:clinicalprocess:healthcond:description
```

Se exemplet [Prenumeration på en patients indexposter](Subscription-PrenumerationForPatient.html).

### Notiser

Notisen är en `history`-Bundle enligt backport-IG:n, med postens id men utan posten. Konsumenten läser posten med `GET EpisodeOfCare/[id]`, och läsningen går genom samma spärr, loggning och filtrering som en sökning. Vid delete ger läsningen `410 Gone`.

En konsument får bara notis om poster som den skulle ha fått i en sökning. Det, och `id-only`-innehåll, hindrar att notiser läcker förekomst av spärrad information.

### Leverans

Konsumenten bör sätta `heartbeatPeriod`, så att ett avbrott upptäcks. Efter ett avbrott hämtar konsumenten missade notiser med `$status` och `$events` enligt backport-IG:n, eller söker om med `_lastUpdated`.
