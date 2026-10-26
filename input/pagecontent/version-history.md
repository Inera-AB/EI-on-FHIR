{::options header_offset="1" /}

Den här sidan beskriver vad som har ändrats i varje version. Listan över alla publicerade versioner nås via länken i bannern överst på varje sida.

---

## [0.1.0] — opublicerad

### Features

- Första utkastet av FHIR-EI, byggt från specen *FHIR-baserad engagemangsindexkomponent*
- FHIR R5. Indexposten är en profilerad `DocumentReference` med en post per patient × endpoint × tjänst
- Livscykel med registrering och avregistrering i stället för radering: basstatus plus extensions för registreringsstatus och orsak till avregistrering
- Extensions för producentens endpoint i tjänstekatalogen, vårdenhet, registrerande producent, logisk adress, källsystem och innehållets senaste ändring
- Kodsystem och värdemängder för tjänstedomäner, kategorier, registreringsstatus och orsaker till avregistrering
- SubscriptionTopic `indexpost-andrad` och en profil för prenumeration med `id-only`
- Nationella sökparametrar `content-last-updated` och `source-endpoint`
- CapabilityStatement för FHIR-EI som server
- Producentens identitet är dess endpoint i tjänstekatalogen, och dess namnrymd i `identifier.system` är samma URL
- Extensions för logisk adress och källsystem
- Adressregister i övergångsadaptern och regler för överlämning
- HSA-id med basprofilernas system `urn:oid:1.2.752.29.4.19`
- Övergång per tjänst i fem lägen, med regeln att konsumenten byter först och utan återskrivning till dagens engagemangsindex
- Uppdateringsregler per tjänst: en `SubscriptionTopic` per informationsmängd och `obligation` i tillämpningsprofilen
- Ett index för både NPÖ och 1177, med prövning per syfte och säkerhetsetiketter i `meta.security`
- Sidan Stöd för producenter: direkt registrering, indexeringsagent som bygger på FHIR Subscriptions, och övergångsadaptern
- Sidor om indexposten, händelsemodell och övergång, samexistens med eHM:s patientindex, prenumeration, spärr och loggning samt öppna frågor
