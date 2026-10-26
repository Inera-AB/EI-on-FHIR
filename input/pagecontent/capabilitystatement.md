IG:n definierar ett CapabilityStatement med `kind = requirements`:

| CapabilityStatement | Roll | Innehåll |
|---|---|---|
| [FHIR-EI server](CapabilityStatement-IneraIndexServer.html) | Server | Sökning, villkorad registrering och avregistrering, `transaction`, historik, topic-baserad prenumeration med `$status` och `$events`, och SubscriptionTopic |
{:.grid}

Kraven anges per interaktion och sökparameter med extension `capabilitystatement-expectation` (SHALL, SHOULD). CapabilityStatementet annonserar de nationella sökparametrarna och, via SubscriptionTopic-resursen, vilka prenumerationsfilter som stöds.

Massuttag med Bulk Data `$export` står inte i CapabilityStatementet. Bulk Data Access finns bara publicerad för R4, så dess OperationDefinition kan inte refereras från en R5-IG. Kravet står i text under [REST-interaktioner och sökparametrar](rest-interactions.html): FHIR-EI SHALL stödja `$export` på systemnivå med `_type=DocumentReference` och `_since`, och ett `_since`-uttag SHALL innehålla avregistrerade poster inom gravstenarnas lagringstid.

Producenter och konsumenter har inga egna CapabilityStatements. Deras förväntningar beskrivs under [Roller och ansvar](roles-and-responsibilities.html).
