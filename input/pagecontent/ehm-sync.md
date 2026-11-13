En synktjänst kan använda API:et för att fylla eHM:s patientindex för vårdgivarnas räkning, utifrån befintlig data i EI. Sidan beskriver hur synktjänsten använder API:et. eHM:s API för patientindexet är inte specificerat än och beskrivs inte här.

Synken förutsätter att vårdgivarna har gett Inera i uppdrag att rapportera till patientindexet för deras räkning; se [Öppna frågor](open-issues.html).

### Vad patientindexet innehåller

Enligt promemorian S2026/01360 innehåller patientindexet patientens identitet, vårdgivarens organisationsnummer, vilket journalsystem som har uppgifter om patienten och vårdgivarens elektroniska kontaktuppgifter. Det anger inte vårdenhet, tjänst eller informationsmängd. Flera engagemangsposter motsvarar därför en uppgift i patientindexet.

| Uppgift i patientindexet | Källa |
|---|---|
| Patientens identitet | `subject.identifier` |
| Vårdgivarens organisationsnummer | Vårdgivaren bestäms enligt nedan, och dess organisationsnummer hämtas i HSA eller tjänstekatalogen |
| Journalsystem | Extension `sourceSystem` (HSA-id). Hur eHM vill identifiera journalsystem är inte bestämt |
| Elektroniska kontaktuppgifter | Tjänstekatalogen, inte EI |
{:.grid}

### Vårdgivaren

`custodian` är ofta vårdgivarens HSA-id, men kan vara källsystemets; se [Engagemangsposten](engagement.html). Synktjänsten bestämmer vårdgivaren i tur och ordning:

1. `custodian`, om det är en vårdgivare i HSA.
2. Organisationen för postens logiska adress, eller den vårdgivare den hör till.
3. Ett register över källsystem som bara betjänar en vårdgivare.

Går vårdgivaren inte att bestämma rapporterar synktjänsten inte posten. Den läggs i en kö för manuell hantering, och synktjänsten följer upp hur stor andelen sådana poster är.

### Flöde

| Steg | Anrop | Regel |
|---|---|---|
| Grundladdning | `$export?_type=DocumentReference` | Alla poster med status `current` |
| Löpande synk | `DocumentReference?_lastUpdated=gt[senast]&status=current,superseded&_sort=_lastUpdated` | Gränsen sätts till det senaste `meta.lastUpdated` som synktjänsten har behandlat, minus en säkerhetsmarginal. Samma post kan då komma flera gånger, så behandlingen ska vara idempotent |
| Återsynk efter avbrott | `$export?_type=DocumentReference&_since=[senast]` | När avbrottet är kortare än borttagsloggens lagringstid |
| Avstämning | `$export?_type=DocumentReference` | Ett fullständigt uttag jämförs med patientindexet med jämna mellanrum, och efter avbrott som är längre än lagringstiden |
{:.grid}

### Aggregering och borttag

Synktjänsten slår ihop poster per patient, vårdgivare och journalsystem:

- Den första posten med status `current` för en kombination ger en ny uppgift i patientindexet.
- När den sista posten för en kombination får status `superseded` tas uppgiften bort ur patientindexet.
- Övriga ändringar påverkar inte patientindexet.

Synktjänsten behöver därför hålla reda på vilka poster som ingår i varje kombination. Den sparar bara det som krävs för det: postens id, kombinationen och status.
