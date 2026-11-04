# Användningsfall - FHIR-baserat engagemangsindex (FHIR-EI) v0.1.0

## Användningsfall

API:et skiljer på tre sätt att läsa indexet: sökning vid behov, löpande uppdatering via prenumeration och avstämning eller massuttag för korrekthet. Till det kommer producenternas registrering och övergången från dagens engagemangsindex.

### Sök var information finns om en patient

En konsument, till exempel NPÖ, ska visa en översikt över en patients information. Konsumenten söker patientens indexposter, eventuellt begränsat till vissa tjänster, informationsmängder eller poster vars innehåll ändrats efter en viss tidpunkt. Sökningen sker i användarkontext. FHIR-EI kontrollerar användarens behörighet och spärrar, filtrerar bort poster som användaren inte har rätt att se, loggar åtkomsten och returnerar de registrerade posterna. Konsumenten hämtar sedan informationen direkt från producenternas endpoints. Motsvarar FindContent.

### Fylla indexet

En källa har fått ny eller ändrad information om en patient inom en tjänst, och indexet ska spegla det. Hur det sker beror på tjänstens [försörjningssätt](population.md): producenten registrerar själv eller via en indexeringsagent, Ineras lokaliseringstjänst frågar källan när posten behövs och håller den färsk med prenumeration, eller övergångsadaptern speglar dagens engagemangsindex för källor som fortfarande använder RIV-TA. Oavsett sätt är uppdateringen idempotent och en äldre ändring skriver aldrig över en nyare. Motsvarar Update.

### Avregistrera indexposter

En källa håller inte längre informationen: den var felregistrerad, engagemanget är avslutat eller informationen har gallrats. Den registrerande parten avregistrerar posten och anger orsaken. Posten ligger kvar som gravsten under en lagringstid, så att avregistreringen syns för prenumeranter och vid avstämning. Motsvarar Update med deleteFlag.

### Prenumerera på ändringar

En konsument vill veta när en patients indexposter ändras, utan att söka om. Konsumenten registrerar en prenumeration i systemkontext, filtrerad på patient, tjänst eller vårdgivare. Vid varje ändring inom konsumentens behörighet får den en notis med postens id. Motsvarar ProcessNotification.

### Hålla en lokal kopia aktuell

En systemkonsument håller en lokal kopia av innehåll inom en tjänst, till exempel läkemedelsordinationer eller uppmärksamhetsinformation, och behöver veta när den ska hämta på nytt. Den prenumererar i systemkontext och hämtar från källan när en notis kommer. Kopian ligger utanför FHIR-EI, och systemkonsumenten prövar och loggar per användare när innehållet visas. Tjänsten behöver producentregistrering eller spegling; se [Spärr, loggning och behörighet](security.md).

### Stäm av efter avbrott

En konsument har missat notiser. Vid kortare avbrott hämtar den missade händelser ur händelseloggen. Vid längre avbrott söker den poster som ändrats sedan en viss tidpunkt, inklusive avregistrerade. Saknar motsvarighet idag.

### Massuttag

En systemkonsument, till exempel en framtida synk till eHM:s patientindex, behöver hela indexet eller allt som ändrats sedan en viss tidpunkt. Systemkonsumenten gör ett massuttag. Används för grundladdning, för ny konsument och efter avbrott längre än gravstenarnas lagringstid. Saknar motsvarighet idag.

### Övergång från dagens engagemangsindex

Källsystem ska kunna gå över till FHIR i egen takt. Övergången görs per tjänst: en adapter speglar tjänstens poster från dagens engagemangsindex till FHIR-EI, tjänstens konsumenter byter till FHIR-EI, och först därefter registrerar producenterna direkt. Se [Händelsemodell och övergång](event-model.md).

-------

Rollerna i användningsfallen beskrivs under [Roller och ansvar](roles-and-responsibilities.md).

