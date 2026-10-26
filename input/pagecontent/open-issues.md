Följande frågor är inte avgjorda. Svaren kan ändra profilerna eller API:et.

### Från specutkastet

- **FHIR-version.** Profilera EpisodeOfCare på R4 nu, eller vänta in svenska basprofiler i R5? Denna version använder R4 och FHIR:s basresurser.
- **Granularitet.** En post per informationsmängd (som föreslås här) eller en post per patient × vårdenhet med flera `type`? Det första behåller `mostRecentContent` per mängd men ger fler poster.
- **Aggregering.** Ska dagens aggregering i engagemangsindex behållas, och i så fall var?
- **Endpoint.** Egen `Endpoint`-resurs i FHIR-EI (som i denna version), eller referens till tjänstekatalogen eller eHM:s NTK?
- **Latens.** Vilket krav gäller från ändring i källsystemet till synlig indexpost? Vad klarar dagens engagemangsindex i praktiken?
- **Filtrerade poster.** Ska en konsument få veta att poster filtrerats bort, till exempel för att visa att information finns men kräver samtycke?
- **Loggning.** Loggas varje sökning, varje utlämnad post, eller båda? Denna version anger båda.
- **eHM:s krav på tunt index.** Nyckel, granularitet, API och semantik för borttag.
- **Ansvar.** Vem svarar för att indexposten är korrekt när den härrör från adaptern?

### Uppkomna när IG:n skrevs

- **Unik nyckel från adaptern.** Är businessObjectInstanceIdentifier unik per källsystem i dagens data? Om inte bildar adaptern `identifier[sourceEntryId]` ur hela engagemangsnyckeln, som [Händelsemodell och övergång](event-model.html) beskriver.
- **Format för `meta.source`.** Registrerande system ska anges som en URI. Hur ett HSA-id skrivs som URI är inte bestämt.
- **Orsak vid borttag.** En villkorad `DELETE` har ingen kropp, så orsaken kräver en `PUT` före borttaget. Räcker det, eller behövs en egen operation som tar bort och anger orsak atomärt?
- **Äldre uppdateringar.** IG:n ignorerar en uppdatering med äldre `mostRecentContent` och svarar `200 OK`. Specutkastet lämnade öppet om den i stället ska avvisas.
- **Kodverk.** Var förvaltas tjänstedomäner och kategorier som FHIR-kodsystem, och med vilken canonical? Denna IG har utdrag under sin egen canonical.
- **Kontrollsummor.** Hur exponeras antal och kontrollsummor per vårdgivare och dag för återsynk?
- **Endpoints för RIV-TA-källor.** En endpoint per kombination av källsystem och logisk adress kan bli många. Är det rätt nivå?
