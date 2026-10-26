### FHIR-baserat engagemangsindex (FHIR-EI)

FHIR-EI är en ny komponent som pekar ut var det finns information om en patient. Den svarar på tre frågor: i vilka system finns information om patienten, vilka informationsmängder finns där, och när uppdaterades de senast. Komponenten ersätter engagemangsindex när NPÖ och 1177 FHIR-ifieras, och följer samma mönster som NHS Englands [National Record Locator](https://digital.nhs.uk/services/national-record-locator).

> **Status:** utkast. Specifikationen är under arbete och kan ändras utan föregående meddelande. Se [Öppna frågor](open-issues.html).

---

### Omfattning

IG:n omfattar:

- informationsmodell för indexposten ([Indexpost](StructureDefinition-IneraEngagementIndexEntry.html))
- [kodverk för informationsmängder](information-sets.html)
- [API för sökning, registrering](rest-interactions.html) och [prenumeration](subscriptions.html)
- [händelsemodell och leveransgarantier](event-model.html), inklusive övergången från dagens engagemangsindex
- [spärr, loggning och filtrering](security.html) av svar
- [samexistens med eHM:s patientindex](ehm-coexistence.html): borttag, grundladdning och återsynk

Utanför IG:n ligger allt som rör hämtning av journalinformation: realtidshämtning, pre-warm, cachning och central lagring. Komponenten pekar ut var information finns. Den lagrar eller förmedlar inte journalinnehåll.

---

### Syfte

Dagens engagemangsindex bygger på RIV-TA-tjänstekontrakten FindContent, Update och ProcessNotification. När NPÖ och 1177 går över till FHIR behöver de ett index med FHIR-gränssnitt. FHIR-EI ska klara minst det dagens engagemangsindex klarar, i aktualitet, leveransgarantier, borttag och återhämtning, och vara byggt så att ett tunt index hos eHM kan härledas ur det senare.

---

### Målgrupp

- Leverantörer av källsystem som registrerar indexposter (producenter)
- Tjänster som söker i eller prenumererar på indexet, till att börja med NPÖ och 1177 (konsumenter)
- Arkitekter och förvaltare av engagemangsindex och FHIR-EI

Nya läsare börjar med [Inledning](introduction.html). Implementatörer går till [REST-interaktioner och sökparametrar](rest-interactions.html).

---

### Terminologi

Kodverken för informationsmängder i denna IG är utdrag. Den fullständiga förteckningen över tjänstedomäner förvaltas av Inera. På [Inera Terminologitjänst](https://www.inera.se/tjanster/alla-tjanster-a-o/terminologitjanst-for-nationell-e-halsa/) finns de kodsystem och värdemängder som Inera förvaltar.

---

### Beroenden

IG:n bygger på FHIR R4 (4.0.1) och använder:

| Paket | Version | Används för |
|---|---|---|
| [Subscriptions R5 Backport](https://hl7.org/fhir/uv/subscriptions-backport/STU1.1/) (`hl7.fhir.uv.subscriptions-backport.r4`) | 1.1.0 | Prenumeration på ändrade indexposter |
| [Bulk Data Access](https://hl7.org/fhir/uv/bulkdata/STU2/) (`hl7.fhir.uv.bulkdata`) | 2.0.0 | Massuttag för grundladdning och återsynk |
{:.grid}

Profilerna bygger direkt på FHIR:s basresurser. Om de ska bygga på svenska basprofiler är en öppen fråga.

---

### Dokumentation

Mer information om FHIR på Inera finns på [fhir.inera.se](https://fhir.inera.se/). FHIR på Inera är en del av RIVTA, referensarkitekturen för svensk hälso- och sjukvård.

Information om hur denna IG förvaltas finns under [Om](about.html).
