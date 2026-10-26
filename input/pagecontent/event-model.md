Leveransgarantin är minst den samma som idag: en ändring i källsystemet ska nå indexet utan förlust, i rätt ordning per post, och kunna återhämtas efter avbrott. Det gäller både dagens RIV-TA-producenter och framtida FHIR-producenter.

### Registrering, från producent till FHIR-EI

| Krav | Innebörd | Hur det uppfylls |
|---|---|---|
| Idempotens | Samma händelse två gånger ger samma resultat | Uppdatering och avregistrering sker villkorat på producentbunden `identifier` |
| Ordning per post | Sena eller omkastade händelser skriver inte över nyare | En uppdatering med äldre `contentLastUpdated` än den lagrade ignoreras. En avregistrering kan bara upphävas av en ny registrering med senare `contentLastUpdated` |
| Minst en leverans | Ingen händelse går förlorad | Producent eller adapter försöker igen tills FHIR-EI kvitterat. Ej levererbara händelser hamnar i en kö för manuell hantering |
| Atomicitet | En samling ändringar registreras helt eller inte alls | `transaction`-Bundle |
{:.grid}

En ignorerad uppdatering besvaras med `200 OK` och den lagrade versionen, med oförändrad `ETag`. Producenten ser att inget skrevs och försöker inte igen. Samtidiga uppdateringar av samma post hanteras med versionsvillkor (`If-Match` på `ETag`) eller med regeln om `contentLastUpdated`.

### Notiser, från FHIR-EI till prenumerant

Principen är att prenumerationen ger snabbhet och avstämningen ger korrekthet. En konsument ska kunna återställa en korrekt bild även om den missat notiser.

| Fråga | Regel |
|---|---|
| Kan notiser komma flera gånger? | Ja. Varje notis bär ett löpande händelsenummer i `SubscriptionStatus`. Konsumenten deduplicerar på händelsenummer och postens `meta.versionId` |
| Garanteras ordning? | Bara per post, via `meta.versionId`. Konsumenten ignorerar en notis om en äldre version än den den redan har. Ingen ordning garanteras mellan poster |
| Hur upptäcks missade notiser? | Luckor i händelsenumren, uteblivna heartbeat-notiser eller fel vid anrop av `$status` på prenumerationen |
| Hur återhämtar sig konsumenten? | Kortare avbrott: `$events` för att hämta missade händelser ur händelseloggen. Längre avbrott: inkrementell avstämning med `_lastUpdated` inklusive avregistrerade poster. Avbrott längre än gravstenarnas lagringstid, eller ny konsument: `$export` och full omladdning |
| Hur syns borttag? | Som uppdatering till status `superseded` eller `entered-in-error`. Gravstenen finns kvar under lagringstiden, så borttaget syns även vid avstämning |
{:.grid}

### Lagringstider

Två lagringstider ska fastställas. Båda härleds från samma fråga: hur långt avbrott ska en konsument klara utan full omladdning?

| Lagringstid | Vad den styr | Dimensioneras efter |
|---|---|---|
| Händelselogg | Hur långt bakåt en konsument kan hämta missade notiser med `$events` | Normala driftavbrott hos konsumenter; kort, eftersom avstämning tar vid efteråt |
| Gravstenar | Hur länge en avregistrerad post syns vid inkrementell avstämning och `_since`-export | Det längsta tillåtna avbrottet för alla synkande konsumenter, inklusive en framtida synk mot eHM |
{:.grid}

Värdena är en [öppen fråga](open-issues.html).

---

### Övergången i tre steg

1. **Spegling.** Dagens engagemangsindex är fortsatt master. En adapter prenumererar på det via ProcessNotification och skriver motsvarande indexposter i FHIR-EI. Grundladdning sker med ett engångsuttag. Inga producenter behöver ändras.
2. **Blandad drift.** Källsystem som kan FHIR registrerar direkt i FHIR-EI. Adaptern fortsätter för övriga. Adaptern måste skriva tillbaka FHIR-registrerade poster till dagens engagemangsindex så länge konsumenter läser därifrån.
3. **Byte av master.** När NPÖ och 1177 läser från FHIR-EI blir det master. Dagens engagemangsindex kan då speglas från FHIR-EI eller avvecklas.

<figure>
  <img src="overgang-blandad-drift.svg" alt="Steg 2, blandad drift: RIV-TA-källsystem skickar Update till dagens engagemangsindex, som via ProcessNotification och adaptern når FHIR-EI. FHIR-källsystem skriver direkt till FHIR-EI med villkorad PUT. NPÖ och 1177 söker och får notiser från FHIR-EI. En streckad pil visar en senare aggregering till eHM:s patientindex." style="max-width:100%;height:auto"/>
  <figcaption>Steg 2, blandad drift. Synken till eHM är streckad eftersom den inte ingår i första iterationen.</figcaption>
</figure>

RIV-TA-producenter når FHIR-EI via dagens index och adaptern; FHIR-producenter skriver direkt.

### Ansvar under övergången

Adaptern speglar dagens engagemangsindex utan egen affärslogik. Ansvaret för att indexposterna är korrekta ligger därför kvar hos producenterna, genom deras registrering i dagens engagemangsindex.

### Mappning av Update

Engagemangsposter för samma patient, logiska adress och tjänstedomän slås ihop till en indexpost, med dagens kategorier som informationsmängder. Varje indexpost blir en villkorad `PUT` i en `transaction`, med fältmappningen under [Mappning till profiler](mappings.html).

| Fält | Regel |
|---|---|
| `identifier` | System `https://fhir.inera.se/ig/engagementindex/sid/riv-ta-engagement` ([NamingSystem](NamingSystem-RivTaEngagementNamingSystem.html)). Värdet bildas deterministiskt ur patient, logisk adress och tjänstedomän, så att samma kombination alltid ger samma post |
| `contentLastUpdated` | Den senaste mostRecentContent bland de ingående engagemangsposterna |
| `content.profile[category]` | En Coding per kategori bland de ingående engagemangsposterna |
| Avregistrering | deleteFlag på den sista ingående engagemangsposten ger status `superseded`, `registrationStatus` `withdrawn` och `deregistrationReason` `transition-adapter`, eftersom dagens kontrakt inte bär någon orsak |
| `registeringProducer` | Adapterns egen producentidentitet |
{:.grid}

Se exemplet [Indexpost speglad av övergångsadaptern](DocumentReference-IndexpostFranAdapter.html).
