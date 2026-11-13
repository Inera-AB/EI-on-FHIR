IG:n har tre användningsfall. De två första läser engagemang. Det tredje gör att engagemang från källor som har valt FHIR i stället för tjänstekontraktet syns på samma sätt som de i EI.

### 1. Stödtjänster hittar var information finns

En av Ineras interna stödtjänster i samverkansinfrastrukturen behöver veta var det finns information om en patient. Ett exempel är EHDS-bryggan, som kontrollerar att en vårdgivares system har information om patienten innan den gör ett RIV-TA-anrop. Det sparar anrop till källsystem som inte har något.

1. Stödtjänsten söker patientens engagemangsposter, avgränsat till en tjänstedomän och vid behov en logisk adress:
   ```
   GET [base]/DocumentReference?subject:identifier=http://electronichealth.se/identifier/personnummer|191212121212
       &type=https://fhir.inera.se/ig/engagementindex/CodeSystem/IneraServiceDomainCodeSystem|riv:clinicalprocess:healthcond:description
       &logical-address=urn:oid:1.2.752.29.4.19|SE0000000000-VG01
   ```
2. API:et kontrollerar att klienten är en behörig stödtjänst, läser posterna i EI, mappar dem till [Engagemangspost](StructureDefinition-IneraEngagement.html) och loggar anropet.
3. Svaret är en `searchset`-Bundle med poster från både EI och EI-on-FHIR:s register, med status `current`. En tom Bundle betyder att det saknas poster för urvalet.
4. Stödtjänsten hämtar informationen på det sätt posten anger: med ett tjänstekontrakt via tjänsteplattformen och postens logiska adress, eller med FHIR från postens endpoint.

Användningsfallet motsvarar FindContent. Informationen används på samma sätt som i dag: för att hitta vart ett anrop ska gå. Hur en stödtjänst väljer när samma källa har både en RIV-TA-post och en FHIR-post beskrivs under [Engagemangsposten](engagement.html).

### 2. Synk till eHM:s patientindex

En synktjänst fyller eHM:s patientindex för vårdgivarnas räkning, utifrån befintlig data i EI. Vårdgivarna behöver då inte rapportera samma vårdrelationer en gång till.

1. **Grundladdning.** Synktjänsten gör ett massuttag av alla engagemangsposter med Bulk Data `$export`.
2. **Löpande synk.** Med jämna mellanrum söker synktjänsten poster som ändrats sedan förra körningen, med `_lastUpdated`. Borttagna poster kommer med status `superseded`.
3. **Aggregering.** Synktjänsten slår ihop posterna per patient, vårdgivare och journalsystem och lägger till eller tar bort motsvarande uppgifter i eHM:s patientindex.
4. **Avstämning.** Med längre intervall jämför synktjänsten ett fullständigt uttag med patientindexet och rättar avvikelser.

Hur synken använder API:et beskrivs under [Synk till eHM:s patientindex](ehm-sync.html).

### 3. FHIR-producenter registrerar engagemang

En vårdgivare kan välja att implementera en tjänsts FHIR-IG, till exempel Fasta kontakter, i stället för tjänstekontraktet. Dess engagemang behöver då synas för stödtjänsterna och synken, trots att källan inte registrerar i EI med Update.

1. Källan, eller en komponent för dess räkning, registrerar en post när den får information om en patient inom tjänsten:
   ```
   PUT [base]/DocumentReference?identifier=c2d8e6f1-3a47-4b0e-9e21-5f8a7d3b6c04
   ```
   Posten anger `content.profile` = `fhir` och källans FHIR-endpoint i `content.attachment.url`. Se exemplet [Engagemangspost från en FHIR-producent](DocumentReference-EngagemangspostFhir.html).
2. API:et kontrollerar att klienten är en producent som får skriva för postens källsystem, att `custodian` är en vårdgivare och att endpointen finns i tjänstekatalogen för den vårdgivaren. Posten sparas i EI-on-FHIR:s register.
3. Källan uppdaterar posten med samma anrop när informationen ändras, och tar bort den med `DELETE` när den inte längre har information om patienten inom tjänsten.
4. Posten kommer med i sökningar och massuttag, tillsammans med posterna från EI.

Användningsfallet motsvarar Update, för källor som har valt FHIR.

### Aktörer

| Aktör | Ansvar |
|---|---|
| EI-on-FHIR | Exponerar EI:s poster och de egna registrets poster som FHIR. Tar emot registreringar från FHIR-producenter. Kontrollerar klientens behörighet och loggar varje anrop |
| Engagemangsindex | Källan för poster från källor som implementerar tjänstekontrakten. Tar emot registreringar som i dag |
| FHIR-producent | Källa som implementerar en tjänsts FHIR-IG. Registrerar, uppdaterar och tar bort sina poster i EI-on-FHIR:s register |
| Stödtjänst | Söker poster för en patient, inom sitt ändamål. Ansvarar för spärr och loggning när den hämtar och lämnar ut journalinformation |
| Synktjänst | Läser alla poster och ändringar och fyller eHM:s patientindex för vårdgivarnas räkning |
{:.grid}
