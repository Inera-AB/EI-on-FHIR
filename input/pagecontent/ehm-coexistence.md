FHIR-EI och eHM:s patientindex samexisterar. Inera tar inte ansvar för vårdgivarnas registrering i eHM:s index i första iterationen. FHIR-EI ska ändå klara de tre fall som en senare synk på vårdgivarnas vägnar förutsätter, med borttag som det viktigaste.

| Fall | Krav på FHIR-EI | FHIR-mekanism |
|---|---|---|
| Borttag | Varje borttag ger en händelse som går att följa. Orsaken skiljs åt: felregistrering, avslutat engagemang, gallring. En gravsten behålls tills alla mottagare kvitterat, minst en avstämningsperiod | `DELETE` + `_history`; subscription-notis på delete; orsakskod som extension [deletionReason](StructureDefinition-DeletionReason.html) på den sista versionen |
| Grundladdning | FHIR-EI laddas initialt från dagens engagemangsindex. Senare ska ett tunt index kunna laddas från FHIR-EI | Engångsuttag via adaptern; Bulk Data `$export` med `_type=EpisodeOfCare` |
| Återsynk | Avvikelser efter avbrott hittas och rättas utan full omladdning | `$export` med `_since`; kontrollsummor eller antal per vårdgivare och dag |
{:.grid}

Vid `$export` med `_since` SHALL FHIR-EI fylla i fältet `deleted` i svarsmanifestet med de poster som tagits bort efter tidpunkten. Bulk Data-specen gör det bara till SHOULD, men utan det kan en återsynk inte se borttag. Hur kontrollsummor och antal per vårdgivare och dag exponeras är inte specificerat än.

### Härledning av det tunna indexet

Att härleda det tunna indexet blir en aggregering: alla poster för samma patient och vårdgivare (eller vårdenhet) blir en post i eHM:s index. Ett borttag i FHIR-EI ska bara leda till borttag i det tunna indexet när den sista posten för den kombinationen försvunnit. Exakt nyckel och granularitet beror på eHM:s krav; se [Öppna frågor](open-issues.html).
