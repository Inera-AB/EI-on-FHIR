IG:n har två användningsfall. Båda läser befintlig information i EI; ingen av dem ändrar vad som registreras eller hur.

### 1. Stödtjänster hittar var information finns

En av Ineras interna stödtjänster i samverkansinfrastrukturen behöver veta var det finns information om en patient. Ett exempel är EHDS-bryggan, som kontrollerar att en vårdgivares system har information om patienten innan den gör ett RIV-TA-anrop. Det sparar anrop till källsystem som inte har något.

1. Stödtjänsten söker patientens engagemangsposter, avgränsat till en tjänstedomän och vid behov en logisk adress:
   ```
   GET [base]/DocumentReference?subject:identifier=http://electronichealth.se/identifier/personnummer|191212121212
       &type=https://fhir.inera.se/ig/engagementindex/CodeSystem/IneraServiceDomainCodeSystem|riv:clinicalprocess:healthcond:description
       &logical-address=urn:oid:1.2.752.29.4.19|SE0000000000-VG01
   ```
2. API:et kontrollerar att klienten är en behörig stödtjänst, läser posterna i EI, mappar dem till [Engagemangspost](StructureDefinition-IneraEngagement.html) och loggar anropet.
3. Svaret är en `searchset`-Bundle med postens status `current`. En tom Bundle betyder att EI saknar poster för urvalet.
4. Stödtjänsten anropar ett tjänstekontrakt i postens tjänstedomän via tjänsteplattformen, med postens logiska adress.

Användningsfallet motsvarar FindContent. Informationen används på samma sätt som i dag: för att hitta vart ett anrop ska gå.

### 2. Synk till eHM:s patientindex

En synktjänst fyller eHM:s patientindex för vårdgivarnas räkning, utifrån befintlig data i EI. Vårdgivarna behöver då inte rapportera samma vårdrelationer en gång till.

1. **Grundladdning.** Synktjänsten gör ett massuttag av alla engagemangsposter med Bulk Data `$export`.
2. **Löpande synk.** Med jämna mellanrum söker synktjänsten poster som ändrats sedan förra körningen, med `_lastUpdated`. Borttagna poster kommer med status `superseded`.
3. **Aggregering.** Synktjänsten slår ihop posterna per patient, vårdgivare och journalsystem och lägger till eller tar bort motsvarande uppgifter i eHM:s patientindex.
4. **Avstämning.** Med längre intervall jämför synktjänsten ett fullständigt uttag med patientindexet och rättar avvikelser.

Hur synken använder API:et beskrivs under [Synk till eHM:s patientindex](ehm-sync.html).

### Aktörer

| Aktör | Ansvar |
|---|---|
| EI-on-FHIR | Exponerar EI:s poster som FHIR, skrivskyddat. Kontrollerar klientens behörighet och loggar varje anrop |
| Engagemangsindex | Källan för posterna. Tar emot registreringar från källsystemen som i dag |
| Stödtjänst | Söker poster för en patient, inom sitt ändamål. Ansvarar för spärr och loggning när den hämtar och lämnar ut journalinformation |
| Synktjänst | Läser alla poster och ändringar och fyller eHM:s patientindex för vårdgivarnas räkning |
{:.grid}
