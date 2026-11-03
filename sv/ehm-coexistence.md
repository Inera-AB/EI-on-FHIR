# Samexistens med eHM:s patientindex - FHIR-baserat engagemangsindex (FHIR-EI) v0.1.0

## Samexistens med eHM:s patientindex

FHIR-EI och eHM:s patientindex samexisterar. Enligt promemorian S2026/01360 (juni 2026) får patientindexet innehålla patientens identitetsbeteckning, vårdgivarens organisationsnummer, vilket journalsystem som har uppgifter om patienten och vårdgivarens elektroniska kontaktuppgifter. Förordningen lägger till anropsadresser till informationssystem och tekniska tjänster. Vårdenhet, tjänst, informationsmängd och senast uppdaterad ingår inte. Lagen föreslås träda i kraft 1 juli 2027, med detaljer i föreskrifter från eHM.

Det tunna indexet är alltså nycklat på organisationsnummer och journalsystem. Det kan inte ensamt bära spärr på vårdenhetsnivå eller svara på vilka informationsmängder som finns. Därför tillåter indexposten vårdgivare med organisationsnummer och saknad vårdenhet; se [Indexposten](information-model.md).

### Två riktningar

Förhållandet mellan indexen kan gå åt två håll, och IG:n tillåter båda. Vilken riktning som gäller avgörs av tjänstens [försörjningssätt](population.md).

| | | |
| :--- | :--- | :--- |
| Det tunna indexet är sanning för var | FHIR-EI fylls utifrån eHM:s patientindex och riktade frågor till källorna. Vårdgivarna registrerar bara hos eHM | Inera-försörjd cache |
| Det rika indexet härleder det tunna | FHIR-EI fylls av producenterna eller genom spegling, och det tunna indexet härleds ur det, eventuellt av Inera för vårdgivarnas räkning | Producentregistrering eller spegling |

Den andra riktningen förutsätter att Inera får rådighet över uppgifterna och tillåtelse att lämna dem till eHM. Promemorian lägger uppgiftsskyldigheten på vårdgivaren, så ett sådant upplägg behöver godkännas av vårdgivarna och accepteras av eHM. Inera tar inte det ansvaret i första iterationen.

### Om det tunna indexet härleds ur FHIR-EI

FHIR-EI ska klara de tre fall som en synk på vårdgivarnas vägnar förutsätter, med borttag som det viktigaste.

| | | |
| :--- | :--- | :--- |
| Borttag | Varje borttag är en avregistrering som går att följa, med orsak: felregistrering, avslutat engagemang, gallring. Gravstenen behålls under gravstenarnas lagringstid | Status`superseded`/`entered-in-error`+[deregistrationReason](StructureDefinition-DeregistrationReason.md); notis som uppdatering; syns i`_lastUpdated`-sökning och`_since`-export |
| Grundladdning | FHIR-EI laddas initialt från dagens engagemangsindex. Senare ska ett tunt index kunna laddas från FHIR-EI | Engångsuttag via adaptern; Bulk Data`$export`med`_type=DocumentReference` |
| Återsynk | Avvikelser efter avbrott hittas och rättas utan full omladdning, även för borttag som missats | Inkrementell avstämning med`_lastUpdated`eller`$export`med`_since`, inklusive gravstenar; kontrollsummor eller antal per vårdgivare och dag |

Eftersom borttag är avregistreringar och inte raderingar, finns de med som vanliga poster i ett `_since`-uttag. Hur kontrollsummor och antal per vårdgivare och dag exponeras är inte specificerat än.

Att härleda det tunna indexet blir en aggregering: alla aktiva poster för samma patient, vårdgivare och journalsystem blir en post i eHM:s index. En avregistrering i FHIR-EI ska bara leda till borttag i det tunna indexet när den sista aktiva posten för den kombinationen avregistrerats.

### Om FHIR-EI fylls utifrån det tunna indexet

Lokaliseringstjänsten läser eHM:s patientindex för att veta vilka vårdgivare och journalsystem patienten har, och frågar källorna om resten; se [Försörjning av indexet](population.md). Kvaliteten och täckningsgraden i eHM:s index blir då en beroendepunkt som Inera inte styr.

Nästa steg är att torrsimma båda riktningarna mot eHM:s API-specifikationer för patientindexet när de finns.

