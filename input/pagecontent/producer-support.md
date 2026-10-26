En producent kan registrera indexposter på tre sätt. Alla tre ger poster enligt [Indexpost](StructureDefinition-IneraIndexEntry.html) och tjänstens tillämpning; det som skiljer är hur mycket producenten själv måste göra.

| Väg | För vem | Vad producenten behöver |
|---|---|---|
| Direkt registrering | Producenter som själva vill hantera indexet | Upptäcka ändringar enligt tjänstens topics, skicka villkorad `PUT` och sköta omförsök, ordning och avregistrering; se [REST-interaktioner och sökparametrar](rest-interactions.html) |
| Indexeringsagent | Producenter med en FHIR-server | Stöd för FHIR Subscriptions och tjänstens topics; inget annat |
| Övergångsadaptern | Producenter som har kvar RIV-TA | Inget nytt; registreringen i dagens engagemangsindex speglas; se [Händelsemodell och övergång](event-model.html) |
{:.grid}

### Indexeringsagenten

Agenten låter en producent bidra till indexet med enbart standard-FHIR. Indexlogiken implementeras en gång, i agenten, i stället för hos varje producent.

1. Producentens FHIR-server stöder tjänstens `SubscriptionTopic`, en per informationsmängd. Det är standard i R5 och finns för R4 via Subscriptions Backport. Vilka topics en tjänst har står i tjänstens IG; se [Indexposten](information-model.html).
2. Agenten prenumererar med `content = empty` eller `id-only`. Notisens `focus` och `additionalContext` (i `SubscriptionStatus.notificationEvent`) pekar på resursen och patienten, så agenten läser aldrig journalinnehållet.
3. Agenten översätter varje händelse till en indexpost, enligt tabellen nedan.
4. Agenten sköter det som är svårt att få rätt hos varje producent: omförsök tills FHIR-EI kvitterat, ordning per post, avregistrering, kön för ej levererbara händelser och avstämning per dag.

| Element i indexposten | Källa |
|---|---|
| `type`, `content.profile` | Vilket topic händelsen gäller |
| `subject` | Patienten i notisens `additionalContext` |
| `sourceEndpoint`, `registeringProducer`, `identifier.system` | Producentens endpoint i tjänstekatalogen, ur agentens konfiguration |
| `custodian`, `careUnit` | Agentens konfiguration per producent, eller resursens förvaltare och författare |
| `contentLastUpdated` | Händelsens `timestamp` |
{:.grid}

En agent kan tjäna flera producenter, till exempel en per region eller plattform, och kan placeras nära producenten, som EHDS-bryggans proxy mot tjänsteplattformen. Den autentiserar sig med en token bunden till producentens endpoint i tjänstekatalogen, till exempel enligt SMART Backend Services, så att FHIR-EI:s kontroller av producentidentitet och namnrymd gäller som för en direkt registrering.

Avregistrering kräver att agenten vet när informationen inte längre finns hos producenten. Det kräver antingen att tjänstens topics också uttrycker det, eller att agenten stämmer av mot producenten; se [Öppna frågor](open-issues.html).
