# Öppna frågor - EI-on-FHIR: FHIR-API för engagemangsindex v0.1.0

## Öppna frågor

Följande frågor är inte avgjorda. Svaren kan ändra profilen, API:et eller arkitekturen.

### Engagemangsindex

* **Åtkomst till EI:s data.** SAD:en föreslår att API:et läser EI:s databas, eller en läsreplika, som ett nytt gränssnitt i det nationella EI. Kan EI:s förvaltning ta det åtagandet, och vilken last tål databasen?
* **Borttagslogg.** Behåller EI borttagna poster i dag? Om inte behövs en borttagslogg i EI. Hur länge ska den sparas? Lagringstiden avgör hur långt avbrott synken klarar utan fullständig avstämning.
* **Fältlistan.** Mappningen ska stämmas av mot tjänstekontraktsbeskrivningen för `riv:itintegration:engagementindex`, så att alla fält i en engagemangspost kommer med.
* **Tidszon.** Bekräfta att EI:s tidsstämplar är svensk tid.
* **Stabilt id.** Vilken nyckel i EI identifierar en post, så att resursens id kan härledas ur den och inte ändras?

### Register för FHIR-producenter

* **Fasta kontakter.** Vilken tjänstedomän (`type`) har Fasta kontakter, och ska FHIR-poster också kunna ange tjänstens IG?
* **Koppling mellan klient och källsystem.** Hur binds en producents klient till dess källsystem (HSA-id)?
* **FHIR-endpoints i tjänstekatalogen.** Hur registrerar en vårdgivare sin FHIR-endpoint för en tjänst i tjänstekatalogen, så att API:et kan kontrollera den?
* **Avstämning för producenter.** Behöver producenterna kunna söka sina egna poster för att stämma av mot sitt källsystem?

### Synk till eHM:s patientindex

* **Uppdrag.** Hur ger vårdgivarna Inera i uppdrag att rapportera till patientindexet för deras räkning, och räcker det för att använda EI:s information för det ändamålet?
* **eHM:s API.** Hur rapporteras och tas uppgifter bort i patientindexet, och hur identifieras ett journalsystem?
* **Vårdgivaren.** Hur stor andel av posterna har källsystemets HSA-id i dataController, och hur många källsystem betjänar flera vårdgivare?

### Säkerhet

* **Behörighet för synk.** Hur uttrycks behörigheten för sökning utan patient och massuttag i token: som en egen scope eller som en klientroll i auktoriseringstjänsten?
* **Auktoriseringstjänst.** Vilken av Ineras auktoriseringstjänster utfärdar token till stödtjänsterna i samverkansinfrastrukturen?

### IG:n

* **Paket-id och canonical.** IG:n har tagit över paket-id och canonical från den arkiverade FHIR-EI-specen (branchen `arkiv/fhir-ei-vision`), som aldrig publicerades. Ska en framtida bredare IG få egna?

