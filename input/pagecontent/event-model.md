Leveransgarantin är minst den samma som idag: en ändring i källsystemet ska nå indexet utan förlust, i rätt ordning per post, och kunna återhämtas efter avbrott. Det gäller både dagens RIV-TA-producenter och framtida FHIR-producenter.

### Krav på händelsehanteringen

| Krav | Innebörd | Hur det uppfylls |
|---|---|---|
| Idempotens | Samma händelse två gånger ger samma resultat | Uppdatering och borttag sker villkorat på `identifier[sourceEntryId]` |
| Ordning per post | Sena eller omkastade händelser skriver inte över nyare | FHIR-EI skriver inte en uppdatering vars `mostRecentContent` är äldre än den lagrade; se nedan |
| Minst en leverans | Ingen händelse går förlorad | Producent eller adapter försöker igen tills FHIR-EI kvitterat. Ej levererbara händelser hamnar i en kö för manuell hantering |
| Atomicitet | En samling ändringar registreras helt eller inte alls | `transaction`-Bundle |
| Avstämning | Avvikelser efter avbrott hittas och rättas | Återsynk enligt [Samexistens med eHM:s patientindex](ehm-coexistence.html) |
{:.grid}

#### Äldre uppdateringar

När en villkorad `PUT` träffar en lagrad post vars `mostRecentContent` är senare än den inkommande, skriver FHIR-EI inte uppdateringen. Svaret är `200 OK` med den lagrade versionen och oförändrad `ETag`, så att producenten ser att inget skrevs och inte försöker igen. Samma `mostRecentContent` som den lagrade skrivs som vanligt, så att en producent kan rätta övriga fält.

Specen lämnade öppet om sådana uppdateringar ska avvisas eller ignoreras. IG:n väljer att ignorera dem, eftersom ett felsvar skulle få en producent med minst-en-leverans att försöka igen i onödan.

#### Orsak vid borttag

Ett borttag görs med villkorad `DELETE`, som inte har någon kropp. En producent som vill ange orsak gör först en villkorad `PUT` med extension [deletionReason](StructureDefinition-DeletionReason.html) och sedan `DELETE`. Versionen med orsaken blir då den sista i postens historik; se exemplet [Indexpost med orsak till borttag](EpisodeOfCare-IndexpostMedBorttagsorsak.html). Hur det ska göras atomärt är en [öppen fråga](open-issues.html).

---

### Övergången i tre steg

1. **Spegling.** Dagens engagemangsindex är fortsatt master. En adapter prenumererar på det via ProcessNotification och skriver motsvarande indexposter i FHIR-EI. Grundladdning sker med ett engångsuttag. Inga producenter behöver ändras.
2. **Blandad drift.** Källsystem som kan FHIR registrerar direkt i FHIR-EI. Adaptern fortsätter för övriga. Adaptern måste skriva tillbaka FHIR-registrerade poster till dagens engagemangsindex så länge konsumenter läser därifrån.
3. **Byte av master.** När NPÖ och 1177 läser från FHIR-EI blir det master. Dagens engagemangsindex kan då speglas från FHIR-EI eller avvecklas.

<figure>
  <img src="overgang-blandad-drift.svg" alt="Steg 2, blandad drift: RIV-TA-källsystem skickar Update till dagens engagemangsindex, som via ProcessNotification och adaptern når FHIR-EI. FHIR-källsystem skriver direkt till FHIR-EI med PUT och DELETE. NPÖ och 1177 söker och får notiser från FHIR-EI. En streckad pil visar en senare aggregering till eHM:s patientindex." style="max-width:100%;height:auto"/>
  <figcaption>Steg 2, blandad drift. Synken till eHM är streckad eftersom den inte ingår i första iterationen.</figcaption>
</figure>

RIV-TA-producenter når FHIR-EI via dagens index och adaptern; FHIR-producenter skriver direkt.

### Mappning av Update

Varje engagemangspost i ett Update blir en villkorad `PUT`, eller `DELETE` vid deleteFlag, i en `transaction`. Fälten mappas enligt [Mappning till profiler](mappings.html).

Adaptern sätter `identifier[sourceEntryId]` med systemet `https://fhir.inera.se/ig/engagementindex/sid/riv-ta-engagement`. Värdet bildas deterministiskt ur engagemangspostens nyckelfält, så att samma post alltid får samma värde och spegling och återsynk blir idempotenta. Om businessObjectInstanceIdentifier ensam räcker som nyckel är en [öppen fråga](open-issues.html).

Adaptern skapar en [Endpoint](StructureDefinition-IneraEngagementIndexEndpoint.html) med `connectionType = riv-ta` per kombination av källsystem och logisk adress, och refererar till den från posten.
