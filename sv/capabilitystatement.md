# CapabilityStatement - EI-on-FHIR: FHIR-API för engagemangsindex v0.1.0

## CapabilityStatement

IG:n definierar ett CapabilityStatement med `kind = requirements`:

| | | |
| :--- | :--- | :--- |
| [EI-on-FHIR server](CapabilityStatement-IneraEngagementIndexServer.md) | Server | Läsning och sökning av engagemangsposter, registrering och borttag för FHIR-producenter, och massuttag med Bulk Data`$export` |

Kraven anges per interaktion och sökparameter med extension `capabilitystatement-expectation` (SHALL, SHOULD). Massuttag med Bulk Data `$export` står inte i CapabilityStatementet, eftersom Bulk Data Access bara finns publicerad för R4. Kravet står i text under [API](api.md). Klienterna har inga egna CapabilityStatements; deras behörigheter beskrivs under [Säkerhet och loggning](security.md).

