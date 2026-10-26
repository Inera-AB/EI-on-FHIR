IG:n definierar ett CapabilityStatement med `kind = requirements`:

| CapabilityStatement | Roll | Innehåll |
|---|---|---|
| [FHIR-EI server](CapabilityStatement-IneraEngagementIndexServer.html) | Server | Sökning, villkorad registrering och borttag, `transaction`, historik, prenumeration enligt Subscriptions Backport och `$export` |
{:.grid}

Kraven anges per interaktion och sökparameter med extension `capabilitystatement-expectation` (SHALL, SHOULD). FHIR-EI SHALL dessutom uppfylla backport-IG:ns [krav på R4-servrar](https://hl7.org/fhir/uv/subscriptions-backport/STU1.1/CapabilityStatement-backport-subscription-server-r4.html) och i sitt eget CapabilityStatement annonsera topic `indexpost-andrad` med extension `capabilitystatement-subscriptiontopic-canonical`. Det står i text, eftersom backport-IG:ns paket inte kan läsas av IG Publisher 3; se [Prenumeration](subscriptions.html).

Producenter och konsumenter har inga egna CapabilityStatements. Deras förväntningar beskrivs under [Roller och ansvar](roles-and-responsibilities.html).
