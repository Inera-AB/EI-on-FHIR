FHIR-EI och eHM:s patientindex samexisterar. Inera tar inte ansvar för vårdgivarnas registrering i eHM:s index i första iterationen. FHIR-EI ska ändå klara de tre fall som en senare synk på vårdgivarnas vägnar förutsätter, med borttag som det viktigaste.

| Fall | Krav på FHIR-EI | FHIR-mekanism |
|---|---|---|
| Borttag | Varje borttag är en avregistrering som går att följa, med orsak: felregistrering, avslutat engagemang, gallring. Gravstenen behålls under gravstenarnas lagringstid | Status `superseded` / `entered-in-error` + [deregistrationReason](StructureDefinition-DeregistrationReason.html); notis som uppdatering; syns i `_lastUpdated`-sökning och `_since`-export |
| Grundladdning | FHIR-EI laddas initialt från dagens engagemangsindex. Senare ska ett tunt index kunna laddas från FHIR-EI | Engångsuttag via adaptern; Bulk Data `$export` med `_type=DocumentReference` |
| Återsynk | Avvikelser efter avbrott hittas och rättas utan full omladdning, även för borttag som missats | Inkrementell avstämning med `_lastUpdated` eller `$export` med `_since`, inklusive gravstenar; kontrollsummor eller antal per vårdgivare och dag |
{:.grid}

Eftersom borttag är avregistreringar och inte raderingar, finns de med som vanliga poster i ett `_since`-uttag. Hur kontrollsummor och antal per vårdgivare och dag exponeras är inte specificerat än.

Nästa steg är att torrsimma de tre fallen mot eHM:s API-specifikationer för patientindexet: nyckel, granularitet, API och semantik för borttag.

### Härledning av det tunna indexet

Att härleda det tunna indexet blir en aggregering: alla aktiva poster för samma patient och vårdgivare (eller vårdenhet) blir en post i eHM:s index. En avregistrering i FHIR-EI ska bara leda till borttag i det tunna indexet när den sista aktiva posten för den kombinationen avregistrerats. Exakt nyckel och granularitet beror på eHM:s krav; se [Öppna frågor](open-issues.html).
