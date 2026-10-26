Detta är beskrivningen av FHIR-baserat engagemangsindex (FHIR-EI). IG:n är en kravspecifikation för parter som registrerar indexposter i, söker i eller prenumererar på FHIR-EI. Parterna ska följa både de maskintolkbara reglerna i profilerna och de regler som uttrycks i text i denna IG.

---

### Begrepp

FHIR-EI är ett rikt index av pekare. Det ska klara minst det dagens engagemangsindex klarar, och vara byggt så att ett tunt index hos eHM kan härledas ur det senare.

| Begrepp | Betydelse |
|---|---|
| Indexpost | En pekare: patient × vårdgivare/vårdenhet × källsystem × informationsmängd, med tidpunkt för senaste innehåll. Profil: [Indexpost](StructureDefinition-IneraEngagementIndexEntry.html) |
| Informationsmängd | Vad posten pekar på: tjänstedomän idag, IG och profil eller resurstyp framåt. Se [Kodverk för informationsmängder](information-sets.html) |
| Källsystem | Systemet som håller journalinformationen och exponerar den. Profil: [Källsystemets endpoint](StructureDefinition-IneraEngagementIndexEndpoint.html) |
| Producent | System som registrerar, uppdaterar och tar bort indexposter: källsystemet eller en adapter |
| Konsument | Tjänst som söker i eller prenumererar på indexet, till exempel NPÖ och 1177 |
| Adapter | Komponent som under övergången speglar dagens engagemangsindex till FHIR-EI och tillbaka |
| Tunt index | eHM:s patientindex kopplat till NDI |
{:.grid}

---

### Arkitekturprinciper

1. **Pekare, inte innehåll.** Indexet svarar på var och när, aldrig vad. Profilen förbjuder de element i EpisodeOfCare som skulle kunna bära journalinnehåll.
2. **Minst lika god förmåga som idag.** Det gäller aktualitet, leveransgarantier, borttag och återhämtning.
3. **Registrera en gång.** Indexposten bär det som behövs för att härleda ett tunt index, även om Inera inte tar det ansvaret i första iterationen.
4. **Övergång utan krav på producenterna.** Befintliga uppdateringar till engagemangsindex mappas in, så att källsystem kan gå över till FHIR i egen takt.
5. **Indexet är självt skyddsvärd information.** Att en patient har en post hos en viss vårdenhet är en uppgift om patienten. Komponenten tillämpar därför spärr, loggning och filtrering.
6. **Profilering enligt Ineras tre-lagersmodell.** I denna version bygger profilerna direkt på FHIR:s basresurser; se [Öppna frågor](open-issues.html).

---

### Varför EpisodeOfCare

En indexpost är en profilerad `EpisodeOfCare`. EpisodeOfCare uttrycker att en organisation har ett pågående engagemang för en patient över tid, vilket är just vad engagemangsindex registrerar. Resursen pekar på strukturerad information, inte på dokument. Det är skälet att välja den framför `DocumentReference`, som NHS Englands National Record Locator använder.
