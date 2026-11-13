### EI-on-FHIR

EI-on-FHIR är ett FHIR R5-API ovanpå dagens engagemangsindex (EI). API:et gör befintlig EI-information tillgänglig för Ineras interna stödtjänster i den nya samverkansinfrastrukturen, till exempel EHDS-bryggan. Det kan också vara källa för en synktjänst som fyller eHM:s patientindex för vårdgivarnas räkning. En källa som implementerar en tjänsts FHIR-IG i stället för tjänstekontraktet registrerar sina engagemang i EI-on-FHIR:s eget register, så att de syns på samma sätt.

Förebilden är NHS Englands [National Record Locator](https://digital.nhs.uk/services/national-record-locator) (NRL): en post i indexet är en pekare som exponeras som `DocumentReference`, och den söks på patientens identitet och informationens typ.

> **Status:** utkast. Specifikationen är under arbete och kan ändras utan föregående meddelande. Se [Öppna frågor](open-issues.html).

---

### Omfattning

IG:n omfattar tre [användningsfall](use-cases.html):

1. **Stödtjänster hittar var information finns.** En intern stödtjänst söker en patients engagemangsposter, till exempel för att se om en vårdgivares system har information innan den anropar det. Det motsvarar FindContent.
2. **Synk till eHM:s patientindex.** En synktjänst läser alla poster och alla ändringar och fyller eHM:s patientindex utifrån befintlig data i EI.
3. **FHIR-producenter registrerar engagemang.** En källa som implementerar en tjänsts FHIR-IG, till exempel Fasta kontakter, registrerar sina engagemang i EI-on-FHIR:s register i stället för med Update i EI.

För det definierar IG:n:

- profilen [Engagemangspost](StructureDefinition-IneraEngagement.html) och hur den motsvarar fälten i EI ([Engagemangsposten](engagement.html))
- [API:et](api.html): läsning, sökning, registrering för FHIR-producenter och massuttag med Bulk Data
- hur API:et används för [synk till eHM:s patientindex](ehm-sync.html)
- [säkerhet och loggning](security.html)

### Utanför omfattningen

- Ändringar i EI. Källor som implementerar tjänstekontrakten registrerar som i dag med Update, och EI behåller sina RIV-TA-kontrakt.
- Prenumerationer och notiser.
- Åtkomst för vårdpersonal och invånare, till exempel via NPÖ eller 1177, och andra framtida användningar av indexet.
- eHM:s eget API för patientindexet. Synktjänsten beskrivs bara som konsument av detta API.

### Arkitektur

Arkitekturen, med alternativ och beslut, beskrivs i [SAD för EI-on-FHIR](https://github.com/Inera-AB/EI-on-FHIR/blob/main/sad/ei-on-fhir-sad.md) i IG:ns repo.

---

### Målgrupp

- Utvecklare av Ineras interna stödtjänster, till exempel EHDS-bryggan
- Utvecklare av synktjänsten mot eHM:s patientindex
- Leverantörer av källsystem som implementerar en tjänsts FHIR-IG
- Förvaltare av engagemangsindex
