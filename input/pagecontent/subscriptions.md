En konsument prenumererar på ändrade indexposter med `Subscription` enligt [R4 Subscriptions Backport](https://hl7.org/fhir/uv/subscriptions-backport/STU1.1/) 1.1.0. Prenumerationen ersätter ProcessNotification.

Kraven på prenumerationer finns i text på denna sida, inte som en profil. Backport-IG:ns R4-paket bygger på FHIR 4.0.0, och IG Publisher 3 läser inga resurser från det, så en profil som ärver från backport-IG:ns Subscription går inte att bygga. Se [Öppna frågor](open-issues.html).

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

En prenumeration för en patient inom en tjänstedomän:

```json
{
  "resourceType": "Subscription",
  "meta": {
    "profile": ["http://hl7.org/fhir/uv/subscriptions-backport/StructureDefinition/backport-subscription"]
  },
  "status": "requested",
  "reason": "Visa aktuell översikt över patientens information",
  "criteria": "https://fhir.inera.se/ig/engagementindex/SubscriptionTopic/indexpost-andrad",
  "_criteria": {
    "extension": [{
      "url": "http://hl7.org/fhir/uv/subscriptions-backport/StructureDefinition/backport-filter-criteria",
      "valueString": "EpisodeOfCare?patient:identifier=http://electronichealth.se/identifier/personnummer|191212121212&type=https://fhir.inera.se/ig/engagementindex/CodeSystem/IneraServiceDomainCodeSystem|riv:clinicalprocess:healthcond:description"
    }]
  },
  "channel": {
    "extension": [{
      "url": "http://hl7.org/fhir/uv/subscriptions-backport/StructureDefinition/backport-heartbeat-period",
      "valueUnsignedInt": 3600
    }],
    "type": "rest-hook",
    "endpoint": "https://konsument.example.org/fhir/notifieringar",
    "payload": "application/fhir+json",
    "_payload": {
      "extension": [{
        "url": "http://hl7.org/fhir/uv/subscriptions-backport/StructureDefinition/backport-payload-content",
        "valueCode": "id-only"
      }]
    }
  }
}
```

### Krav på prenumerationen

| Element | Krav |
|---|---|
| `meta.profile` | Backport-IG:ns `backport-subscription` |
| `criteria` | `https://fhir.inera.se/ig/engagementindex/SubscriptionTopic/indexpost-andrad` |
| `_criteria` extension `backport-filter-criteria` | Filter enligt ovan. En konsument SHALL filtrera på patient |
| `channel.payload` extension `backport-payload-content` | Alltid `id-only`. FHIR-EI avvisar andra värden |
| `channel.extension` `backport-heartbeat-period` | SHOULD anges |
{:.grid}

### Notiser

Notisen är en `history`-Bundle enligt backport-IG:n, med postens id men utan posten. Konsumenten läser posten med `GET EpisodeOfCare/[id]`, och läsningen går genom samma spärr, loggning och filtrering som en sökning. Vid delete ger läsningen `410 Gone`.

En konsument får bara notis om poster som den skulle ha fått i en sökning. Det, och `id-only`-innehåll, hindrar att notiser läcker förekomst av spärrad information.

### Leverans

Konsumenten bör sätta `heartbeatPeriod`, så att ett avbrott upptäcks. Efter ett avbrott hämtar konsumenten missade notiser med `$status` och `$events` enligt backport-IG:n, eller söker om med `_lastUpdated`.
