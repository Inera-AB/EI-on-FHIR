# Händelsemodell och övergång - FHIR-baserat engagemangsindex (FHIR-EI) v0.1.0

## Händelsemodell och övergång

Leveransgarantin är minst den samma som idag: en ändring i källsystemet ska nå indexet utan förlust, i rätt ordning per post, och kunna återhämtas efter avbrott. Det gäller både dagens RIV-TA-producenter och framtida FHIR-producenter.

### Registrering, från producent till FHIR-EI

| | | |
| :--- | :--- | :--- |
| Idempotens | Samma händelse två gånger ger samma resultat | Uppdatering och avregistrering sker villkorat på producentbunden`identifier` |
| Ordning per post | Sena eller omkastade händelser skriver inte över nyare | En uppdatering med äldre`contentLastUpdated`än den lagrade ignoreras. En avregistrering kan bara upphävas av en ny registrering med senare`contentLastUpdated` |
| Minst en leverans | Ingen händelse går förlorad | Producent eller adapter försöker igen tills FHIR-EI kvitterat. Ej levererbara händelser hamnar i en kö för manuell hantering |
| Atomicitet | En samling ändringar registreras helt eller inte alls | `transaction`-Bundle |

En ignorerad uppdatering besvaras med `200 OK` och den lagrade versionen, med oförändrad `ETag`. Producenten ser att inget skrevs och försöker inte igen. Samtidiga uppdateringar av samma post hanteras med versionsvillkor (`If-Match` på `ETag`) eller med regeln om `contentLastUpdated`.

### Notiser, från FHIR-EI till prenumerant

Principen är att prenumerationen ger snabbhet och avstämningen ger korrekthet. En konsument ska kunna återställa en korrekt bild även om den missat notiser.

| | |
| :--- | :--- |
| Kan notiser komma flera gånger? | Ja. Varje notis bär ett löpande händelsenummer i`SubscriptionStatus`. Konsumenten deduplicerar på händelsenummer och postens`meta.versionId` |
| Garanteras ordning? | Bara per post, via`meta.versionId`. Konsumenten ignorerar en notis om en äldre version än den den redan har. Ingen ordning garanteras mellan poster |
| Hur upptäcks missade notiser? | Luckor i händelsenumren, uteblivna heartbeat-notiser eller fel vid anrop av`$status`på prenumerationen |
| Hur återhämtar sig konsumenten? | Kortare avbrott:`$events`för att hämta missade händelser ur händelseloggen. Längre avbrott: inkrementell avstämning med`_lastUpdated`inklusive avregistrerade poster. Avbrott längre än gravstenarnas lagringstid, eller ny konsument:`$export`och full omladdning |
| Hur syns borttag? | Som uppdatering till status`superseded`eller`entered-in-error`. Gravstenen finns kvar under lagringstiden, så borttaget syns även vid avstämning |

### Lagringstider

Två lagringstider ska fastställas. Båda härleds från samma fråga: hur långt avbrott ska en konsument klara utan full omladdning?

| | | |
| :--- | :--- | :--- |
| Händelselogg | Hur långt bakåt en konsument kan hämta missade notiser med`$events` | Normala driftavbrott hos konsumenter; kort, eftersom avstämning tar vid efteråt |
| Gravstenar | Hur länge en avregistrerad post syns vid inkrementell avstämning och`_since`-export | Det längsta tillåtna avbrottet för alla synkande konsumenter, inklusive en framtida synk mot eHM |

Värdena är en [öppen fråga](open-issues.md).

-------

### Övergång per tjänst

Övergången görs per tjänst. Dagens konsumenter läser engagemangsindex per tjänstedomän: de aggregerande tjänsterna på tjänsteplattformen frågar FindContent per tjänstedomän för att hitta vilka logiska adresser de ska anropa, och NPÖ och 1177 Journalen går via dem. Det ska bekräftas; se [Öppna frågor](open-issues.md). Varje tjänst kan därför gå över i egen takt, utan att andra tjänster påverkas och utan att NPÖ och 1177 behöver ändras först.

| | | | | |
| :--- | :--- | :--- | :--- | :--- |
| 0. Bara engagemangsindex | Dagens konsumenter, via engagemangsindex | RIV-producenter, till engagemangsindex | Tjänstens tillämpning är publicerad, och tjänstedomänens uppdelning i tjänster är beslutad | – |
| 1. Spegling | Engagemangsindex; FHIR-EI läses parallellt för jämförelse | Adaptern speglar tjänstens poster | Avstämningen visar samma antal per vårdgivare och dag under en överenskommen period | Stäng av speglingen för tjänsten |
| 2. Konsumenten byter | Tjänstedomänens aggregerande tjänst läser FHIR-EI | Som i läge 1 | Samma svar i drift; spärr, samtycke och loggning godkända för tjänstens syften | Peka konsumenten mot engagemangsindex igen |
| 3. FHIR-producenter | Konsumenter som kan FHIR hämtar direkt från producenterna | FHIR-producenter, direkt eller via[indexeringsagent](producer-support.md); adaptern för övriga | Inga RIV-producenter kvar för tjänstedomänen | – |
| 4. Avveckling | FHIR-EI | FHIR-producenter | – | – |

Läge 3 för en tjänst: FHIR-producenter skriver direkt, RIV-TA-producenter når FHIR-EI via dagens index och adaptern. Synken till eHM är streckad eftersom den inte ingår i första iterationen.
#### Konsumenten först

En producent får registrera en tjänst enbart i FHIR-EI först när tjänstens konsumenter läser FHIR-EI och kan hämta med FHIR. En producent som bara har en FHIR-endpoint kan ändå inte nås av en konsument som läser engagemangsindex och anropar med RIV-TA, och en producent som har kvar RIV-TA uppdaterar engagemangsindex själv. Adaptern skriver därför inte tillbaka FHIR-registrerade poster till dagens engagemangsindex.

Adapterns konfiguration per tjänstedomän anger om den ska spegla tjänsten och om dess poster ska dras in. Eftersom adaptern aldrig skriver till dagens engagemangsindex uppstår ingen rundgång via ProcessNotification. Om återskrivning ändå skulle behövas i ett undantagsfall måste adaptern känna igen och hoppa över sina egna poster.

#### Uppdelning, avstämning och första tjänst

| | |
| :--- | :--- |
| Uppdelning i tjänster | Beslutas före läge 1. Dagens engagemangsindex har en mostRecentContent per kategori, medan en indexpost har en tidpunkt för alla sina informationsmängder. En kategori vars konsumenter filtrerar på aktualitet bryts ut till en egen tjänst innan speglingen startar |
| Avstämning | Grundladdning och spegling görs per tjänstedomän. Antal och kontrollsummor per vårdgivare, dag och tjänstedomän i dagens engagemangsindex jämförs med FHIR-EI. Avstämningen är villkoret för att gå från läge 1 till läge 2 |
| Första tjänst | En tjänst med publicerad eller nära förestående IG, få producenter och en konsument via en aggregerande tjänst som Inera förvaltar, så att läge 1 och 2 kan genomföras helt inom Inera |

### Ansvar under övergången

Adaptern speglar dagens engagemangsindex utan egen affärslogik. Ansvaret för att indexposterna är korrekta ligger därför kvar hos producenterna, genom deras registrering i dagens engagemangsindex.

### Mappning av Update

Engagemangsposter för samma patient, logiska adress och tjänstedomän slås ihop till en indexpost, med dagens kategorier som informationsmängder. Varje indexpost blir en villkorad `PUT` i en `transaction`, med fältmappningen under [Mappning till profiler](mappings.md).

| | |
| :--- | :--- |
| `identifier` | System = adapterns endpoint-URL, som för alla producenter. Värdet bildas deterministiskt ur patient, logisk adress och tjänstedomän, så att samma kombination alltid ger samma post |
| `sourceEndpoint`,`content.attachment.url` | Endpoint och adress enligt adressregistret nedan |
| `logicalAddress` | logicalAddress från engagemangsposterna |
| `sourceSystem` | sourceSystem från de ingående engagemangsposterna |
| `contentLastUpdated` | Den senaste mostRecentContent bland de ingående engagemangsposterna |
| `content.profile[category]` | En Coding per kategori bland de ingående engagemangsposterna |
| Avregistrering | deleteFlag på den sista ingående engagemangsposten ger status`superseded`,`registrationStatus``withdrawn`och`deregistrationReason``transition-adapter`, eftersom dagens kontrakt inte bär någon orsak |
| `registeringProducer` | Adapterns egen endpoint i tjänstekatalogen |

### Adressregister i adaptern

Tjänstekatalogen har ingen endpoint per logisk adress. Där är den logiska adressen en organisations HSA-id, och organisationen listar sina endpoints i `Organization.endpoint`. Tjänstekatalogen har inte heller TAK:s uppgift om vilken logisk adress och vilket tjänstekontrakt som routas till vilken producent.

Adaptern håller därför ett eget adressregister, byggt genom att samköra TAK med tjänstekatalogen:

| | |
| :--- | :--- |
| Logisk adress och tjänstedomän (via tjänstekontrakt i TAK) | Endpoint i tjänstekatalogen som posten ska peka på |

Två varianter är möjliga för värdet:

1. **Tjänsteplattformens endpoint för tjänstekontraktet.**Konsumenten anropar tjänsteplattformen med RIV-TA och anger postens`logicalAddress`.
1. **EHDS-bryggans FHIR-yta för vårdgivaren**(`/fhir/{vg-hsa-id}/`). Konsumenten hämtar informationen med FHIR, och bryggan översätter till RIV-TA. Bryggan använder vårdgivarens HSA-id som logisk adress, medan dagens engagemangsposter kan ha vårdenhetens eller källsystemets. Det måste stämmas av mot TAK innan varianten används.

Samma tanke finns i EHDS-bryggan, som håller ett eget register från vårdgivare till endpoint.

### Överlämning från adaptern

När ett källsystem börjar registrera en tjänst direkt i FHIR-EI får dess poster en ny endpoint, och därmed nya poster, eftersom en post gäller patient × endpoint × tjänst. Adressregistret markerar då kombinationen av källsystem och tjänstedomän som överlämnad. Adaptern drar in sina poster för kombinationen med `deregistrationReason` `transition-adapter` och slutar spegla den. Annars skulle konsumenterna se två poster för samma information under övergången. Prenumeranter ser en avregistrering och en ny registrering. Om det behövs en operation som flyttar ägarskapet i stället är en [öppen fråga](open-issues.md).

Se exemplet [Indexpost speglad av övergångsadaptern](DocumentReference-IndexpostFranAdapter.md).

