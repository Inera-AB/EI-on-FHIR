# Versionshistorik - FHIR-baserat engagemangsindex (FHIR-EI) v0.1.0

## Versionshistorik

Den här sidan beskriver vad som har ändrats i varje version. Listan över alla publicerade versioner nås via länken i bannern överst på varje sida.

-------

### [0.1.0] — opublicerad

#### Features

* Första utkastet av FHIR-EI, byggt från specen **FHIR-baserad engagemangsindexkomponent**
* FHIR R5. Indexposten är en profilerad `DocumentReference` med en post per patient × endpoint × tjänst
* Livscykel med registrering och avregistrering i stället för radering: basstatus plus extensions för registreringsstatus och orsak till avregistrering
* Extensions för producentens endpoint i tjänstekatalogen, vårdenhet, registrerande producent, logisk adress, källsystem och innehållets senaste ändring
* Kodsystem och värdemängder för tjänstedomäner, kategorier, registreringsstatus och orsaker till avregistrering
* SubscriptionTopic `indexpost-andrad` och en profil för prenumeration med `id-only`
* Nationella sökparametrar `content-last-updated` och `source-endpoint`
* CapabilityStatement för FHIR-EI som server
* Producentens identitet är dess endpoint i tjänstekatalogen, och dess namnrymd i `identifier.system` är samma URL
* Extensions för logisk adress och källsystem
* Adressregister i övergångsadaptern och regler för överlämning
* HSA-id med basprofilernas system `urn:oid:1.2.752.29.4.19`
* Övergång per tjänst i fem lägen, med regeln att konsumenten byter först och utan återskrivning till dagens engagemangsindex
* Uppdateringsregler per tjänst: en `SubscriptionTopic` per informationsmängd och `obligation` i tillämpningsprofilen
* Ett index för både NPÖ och 1177, med prövning per syfte och säkerhetsetiketter i `meta.security`
* Neutral försörjning: konsumentkontraktet är detsamma oavsett om en tjänsts indexposter fylls genom producentregistrering, Inera-försörjd cache (lokaliseringstjänst utifrån eHM:s patientindex och riktade frågor) eller spegling av dagens engagemangsindex. Ny sida Försörjning av indexet, som ersätter Stöd för producenter
* Försörjningssätt i `meta.tag`, nytt kodsystem för försörjningssätt och ny avregistreringsorsak `not-at-source`
* Vårdgivaren får anges med organisationsnummer, och vårdenhet är valfri, eftersom eHM:s patientindex är nycklat på vårdgivare och journalsystem
* Ofullständiga sökresultat redovisas med en `OperationOutcome` i `Bundle.issues`
* Övergångens lägen beskriver konsumenternas byte, oberoende av försörjningssätt
* Samexistens med eHM:s patientindex i två riktningar
* Två åtkomstlägen: sökning och läsning för visning sker i användarkontext med prövning i FHIR-EI, medan registrering, prenumeration, avstämning och massuttag sker i systemkontext, där det mottagande systemet prövar per användare
* Läsmönster per tjänst: vid behov eller synkat mot en lokal kopia, och hur läsmönstret begränsar försörjningen
* FHIR-EI delas i indexkärna och åtkomstlager, med försörjningskomponenterna som registrerande parter som skriver via skriv-API:et
* Ny sida Rättslig grund och ändamål: dagens juridiska tolkning av engagemangsindex, det FHIR-EI går utöver, vägar framåt, ändamål per tjänst och vad en systemkonsument får spara
* Övergångsadaptern bestämmer vårdgivaren i speglade poster i stället för att mappa dataController rakt av, och FHIR-EI kontrollerar att `custodian` är en vårdgivare
* Sidor om indexposten, händelsemodell och övergång, samexistens med eHM:s patientindex, prenumeration, spärr och loggning samt öppna frågor

