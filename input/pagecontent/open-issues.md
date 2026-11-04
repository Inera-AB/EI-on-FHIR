Följande frågor är inte avgjorda. Svaren kan ändra profilen eller API:et.

### Från specen

- **Federation.** Dagens engagemangsindex kan vara hierarkiskt, där regionala index vidarebefordrar till det nationella via ProcessNotification. Ska FHIR-EI stödja en sådan topologi, eller bara ett nationellt index?
- **Latens.** Vilket krav gäller från ändring i källsystemet till synlig indexpost? Vad klarar dagens engagemangsindex i praktiken?
- **Lagringstider.** Hur långt avbrott ska en konsument klara utan full omladdning? Svaret sätter både händelseloggens och gravstenarnas lagringstid.
- **eHM:s tunna index.** Torrsimma båda riktningarna, och borttag, grundladdning och återsynk, mot eHM:s API-specifikationer när de finns. Granulariteten är besvarad: vårdgivare (organisationsnummer) och journalsystem, inte vårdenhet; se [Samexistens med eHM:s patientindex](ehm-coexistence.html).
- **R5-beroende.** Tidplanen för svenska basprofiler i R5, och om konsumenter och producenter är redo för R5. Denna version bygger direkt på FHIR:s basresurser.

### Uppkomna när IG:n skrevs

- **Bulk Data i R5.** Bulk Data Access finns bara publicerad för R4, så `$export` kan inte refereras formellt från denna R5-IG. Kravet står i text. Följs upp när Bulk Data publiceras för R5.
- **Kodverk.** Var förvaltas tjänstedomäner och kategorier som FHIR-kodsystem, och med vilken canonical? Denna IG har utdrag under sin egen canonical.
- **Kontrollsummor.** Hur exponeras antal och kontrollsummor per vårdgivare och dag för återsynk?
- **Koppling mellan klient och endpoint.** Den registrerande partens identitet är dess endpoint i tjänstekatalogen. Hur binds ett klientcertifikat eller en token till en endpoint? Tjänstekatalogens Endpoint har i dag ingen identifierare för det producerande systemet, så kopplingen kräver antingen en sådan i tjänstekatalogen eller ett register i FHIR-EI.
- **Adressregistrets innehåll.** Vilken variant ska adaptern peka på för RIV-TA-källor: tjänsteplattformens endpoint per tjänstekontrakt, eller EHDS-bryggans FHIR-yta per vårdgivare? Bryggan använder vårdgivarens HSA-id som logisk adress; dagens engagemangsposter kan ha vårdenhetens eller källsystemets.
- **Överlämning från adaptern.** När ett källsystem går över till FHIR blir det en avregistrering och en ny registrering per post. Räcker det, eller behövs en operation som flyttar ägarskapet?
- **Behörighet per vårdgivare.** Regeln att en producent bara får registrera för vårdgivare som listar dess endpoint i tjänstekatalogen förutsätter att vårdgivarna håller sina listningar aktuella. Hur säkerställs det?
- **Aggregerande tjänster.** Stämmer det att de är dagens huvudsakliga konsumenter av engagemangsindex, per tjänstedomän? [Övergången per tjänst](event-model.html) bygger på det.
- **Spärr och samtycke i dagens kedja.** Var filtreras de i dag, i den aggregerande tjänsten eller hos konsumenten? Om FHIR-EI också filtrerar kan läge 2 ge dubbel filtrering eller ändrat beteende.
- **Juridik.** Täcker vårdgivarnas ändamål och Ineras personuppgiftsbiträdesavtal att samma index används för sammanhållen journalföring och för patientens direktåtkomst?
- **Säkerhetsetiketter.** Vilka etiketter används, och hur tillämpas de per syfte?
- **Vårdgivarens prövning vid sökning.** Ska FHIR-EI, som det nederländska lokaliseringsindexet, fråga vårdgivaren om åtkomst vid varje sökning i stället för att filtrera centralt? Ansvaret för samtycke och spärr blir då tydligt, men det kostar svarstid och kräver en beslutstjänst hos varje vårdgivare.
- **Avregistrering via indexeringsagenten.** Hur vet agenten att informationen inte längre finns hos producenten?
- **R4-tjänster.** Publiceras deras tillämpning i ett separat R5-paket, eller går tjänsterna över till R5?
- **Första tjänst.** Vilken tjänst går först genom övergången?
- **Försörjningssätt per tjänst.** Vem beslutar, och var anges det, så att lokaliseringstjänsten och adaptern vet vilka endpoints de ska fylla?
- **Riktad fråga.** Egen operation (till exempel `$inventory`) eller `batch` med `_summary=count`? Definieras den i denna IG eller i tjänsternas IG:er? Och svarar den med vårdenhet?
- **Lokaliseringstjänstens behörighet.** När en sökning utlöser den riktade frågan ställs den med användarens kontext. Under vilket ändamål och med vilken identitet ställs den vid färskhållning, och hur loggas den hos källan och i FHIR-EI?
- **Tidsgränser.** Hur länge är en cachepost färsk när källan saknar prenumeration, och hur länge väntar FHIR-EI på en källa innan svaret redovisas som ofullständigt?
- **Post utan vårdenhet.** Räcker fail-closed vid inre spärr, eller behöver den riktade frågan alltid ange vårdenhet?
- **Rättslig grund för systemkontext.** Med vilken grund får en systemkonsument ta emot indexposter och notiser om patienter utan att en användare har frågat, och hur regleras dess ansvar för prövning och loggning per användare?
- **Lokala kopior av innehåll.** Vilka tjänster behöver ett synkat läsmönster, till exempel läkemedelsordinationer och uppmärksamhetsinformation? Vem är personuppgiftsansvarig och åtkomstkontrollpunkt för en sådan kopia?
- **Gemensam beslutstjänst.** Ska åtkomstlagret använda samma beslutstjänst för spärr, samtycke och syfte som EHDS-bryggan och framtida åtkomst till innehåll?
- **Användarens kontext.** Hur får konsumenten en token med användarens anspråk till FHIR-EI, och hur skickar lokaliseringstjänsten den vidare till källorna, till exempel med token exchange?
- **Spärr i systemkontext.** Ska ett system som agerar för en bestämd vårdgivare få notiser filtrerade på yttre spärr redan i FHIR-EI, och hur anges vårdgivaren?
