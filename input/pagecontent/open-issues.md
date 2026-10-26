Följande frågor är inte avgjorda. Svaren kan ändra profilen eller API:et.

### Från specen

- **Federation.** Dagens engagemangsindex kan vara hierarkiskt, där regionala index vidarebefordrar till det nationella via ProcessNotification. Ska FHIR-EI stödja en sådan topologi, eller bara ett nationellt index?
- **Latens.** Vilket krav gäller från ändring i källsystemet till synlig indexpost? Vad klarar dagens engagemangsindex i praktiken?
- **Lagringstider.** Hur långt avbrott ska en konsument klara utan full omladdning? Svaret sätter både händelseloggens och gravstenarnas lagringstid.
- **eHM:s tunna index.** Torrsimma borttag, grundladdning och återsynk mot eHM:s API-specifikationer.
- **R5-beroende.** Tidplanen för svenska basprofiler i R5, och om konsumenter och producenter är redo för R5. Denna version bygger direkt på FHIR:s basresurser.

### Uppkomna när IG:n skrevs

- **Bulk Data i R5.** Bulk Data Access finns bara publicerad för R4, så `$export` kan inte refereras formellt från denna R5-IG. Kravet står i text. Följs upp när Bulk Data publiceras för R5.
- **Endpoints för RIV-TA-källor.** Har tjänstekatalogen en Endpoint per logisk adress, så att övergångsadaptern kan referera till den? Annars behöver adaptern ett annat sätt att ange `sourceEndpoint`.
- **Kodverk.** Var förvaltas tjänstedomäner och kategorier som FHIR-kodsystem, och med vilken canonical? Denna IG har utdrag under sin egen canonical.
- **Kontrollsummor.** Hur exponeras antal och kontrollsummor per vårdgivare och dag för återsynk?
- **Producentidentitet.** `registeringProducer` är producentens HSA-id. Är det rätt identitet, och hur ser den betrodda kopplingen mellan klientidentitet och producentidentitet ut?
- **Namnrymd i `identifier.system`.** Hur kontrollerar FHIR-EI att namnrymden tillhör producenten? Det kräver ett register över producenternas namnrymder.
