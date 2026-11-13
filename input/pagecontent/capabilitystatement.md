IG:n definierar ett CapabilityStatement med `kind = requirements`:

| CapabilityStatement | Roll | Innehåll |
|---|---|---|
| [EI-on-FHIR server](CapabilityStatement-IneraEngagementIndexServer.html) | Server | Läsning och sökning av engagemangsposter, och massuttag med Bulk Data `$export` |
{:.grid}

Kraven anges per interaktion och sökparameter med extension `capabilitystatement-expectation` (SHALL, SHOULD). Klienterna har inga egna CapabilityStatements; deras behörigheter beskrivs under [Säkerhet och loggning](security.html).
