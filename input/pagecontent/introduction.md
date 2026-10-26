Detta är beskrivningen av FHIR-baserat engagemangsindex (FHIR-EI). IG:n är en kravspecifikation för parter som registrerar indexposter i, söker i eller prenumererar på FHIR-EI, och för tjänster som tillämpar indexprofilen. Parterna ska följa både de maskintolkbara reglerna i profilerna och de regler som uttrycks i text i denna IG.

---

### Begrepp

FHIR-EI är ett rikt index av pekare. Det ska klara minst det dagens engagemangsindex klarar, och vara byggt så att ett tunt index hos eHM kan härledas ur det senare.

| Begrepp | Betydelse |
|---|---|
| Indexpost | En pekare: patient × endpoint × tjänst, med de informationsmängder som finns och tidpunkt för senaste innehåll. Profil: [Indexpost](StructureDefinition-IneraIndexEntry.html) |
| Tjänst | En IG; motsvarar tjänstedomän i dagens modell |
| Informationsmängd | En profil eller resurs inom en tjänst; motsvarar kategori i dagens modell |
| Tillämpning | En tjänsts profil av den gemensamma indexprofilen, som bestämmer vad indexet svarar på för just den tjänsten. Se [Indexposten](information-model.html) |
| Endpoint | Producentens åtkomstpunkt, registrerad i tjänstekatalogen |
| Logisk adress | Den adress en RIV-TA-konsument anger mot tjänsteplattformen. I tjänstekatalogen är den en organisations HSA-id |
| Producent | System som registrerar, uppdaterar och avregistrerar indexposter: källsystemet eller övergångsadaptern. Identifieras med sin endpoint i tjänstekatalogen |
| Konsument | Tjänst som söker i eller prenumererar på indexet, till exempel NPÖ och 1177 |
| Tunt index | eHM:s patientindex kopplat till NDI |
{:.grid}

---

### Arkitekturprinciper

1. **Pekare, inte innehåll.** Indexet svarar på var och när, aldrig vad. Profilen förbjuder de element i DocumentReference som skulle beskriva eller bära journalinnehåll.
2. **Minst lika god förmåga som idag.** Det gäller aktualitet, leveransgarantier, borttag och återhämtning.
3. **Registrera en gång.** Indexposten bär det som behövs för att härleda ett tunt index, även om Inera inte tar det ansvaret i första iterationen.
4. **Övergång utan krav på producenterna.** Befintliga uppdateringar till engagemangsindex mappas in, så att källsystem kan gå över till FHIR i egen takt.
5. **Indexet är självt skyddsvärd information.** Att en patient har en post hos en viss vårdenhet är en uppgift om patienten. Komponenten tillämpar därför spärr, loggning och filtrering.
6. **Profilering enligt Ineras tre-lagersmodell, ovanpå svenska basprofiler.** I denna version bygger profilen direkt på FHIR:s basresurser; se [Öppna frågor](open-issues.html).

---

### Varför DocumentReference

Indexposten definieras i en gemensam logisk modell och representeras i FHIR R5 som en profilerad `DocumentReference`. Det är samma mönster som NHS NRL och IHE MHD. I R5 har DocumentReference breddats till att referera innehåll av alla slag, inte bara dokument.

Tre begrepp hålls isär:

| Begrepp | Vad det är | I indexet |
|---|---|---|
| Vårdepisod | Klinisk information hos producenten | Ingår inte |
| Indexpost | Uppgiften att information finns tillgänglig hos en producent | Representeras med [indexprofilen](StructureDefinition-IneraIndexEntry.html) |
| Innehåll | Själva journalinformationen | Hämtas från producentens endpoint efter att indexet pekat ut den |
{:.grid}
