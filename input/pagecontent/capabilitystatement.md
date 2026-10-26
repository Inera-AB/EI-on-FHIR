IG:n definierar ett CapabilityStatement med `kind = requirements`:

| CapabilityStatement | Roll | Innehåll |
|---|---|---|
| [FHIR-EI server](CapabilityStatement-IneraEngagementIndexServer.html) | Server | Sökning, villkorad registrering och borttag, `transaction`, historik, prenumeration enligt Subscriptions Backport och `$export` |
{:.grid}

Kraven anges per interaktion och sökparameter med extension `capabilitystatement-expectation` (SHALL, SHOULD). CapabilityStatementet instantierar backport-IG:ns [krav på R4-servrar](https://hl7.org/fhir/uv/subscriptions-backport/STU1.1/CapabilityStatement-backport-subscription-server-r4.html) och annonserar topic `indexpost-andrad`.

Producenter och konsumenter har inga egna CapabilityStatements. Deras förväntningar beskrivs under [Roller och ansvar](roles-and-responsibilities.html).
