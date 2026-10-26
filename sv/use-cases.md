# Användningsfall - FHIR-baserat engagemangsindex (FHIR-EI) v0.1.0

## Användningsfall

API:et skiljer på tre sätt att läsa indexet: sökning vid behov, löpande uppdatering via prenumeration och avstämning eller massuttag för korrekthet. Till det kommer producenternas registrering och övergången från dagens engagemangsindex.

### Sök var information finns om en patient

En konsument, till exempel NPÖ, ska visa en översikt över en patients information. Konsumenten söker patientens indexposter, eventuellt begränsat till vissa tjänster, informationsmängder eller poster vars innehåll ändrats efter en viss tidpunkt. FHIR-EI kontrollerar behörighet och spärrar, filtrerar bort poster som konsumenten inte har rätt att se, loggar åtkomsten och returnerar de registrerade posterna. Konsumenten hämtar sedan informationen direkt från producenternas endpoints. Motsvarar FindContent.

### Registrera eller uppdatera indexposter

En producent har fått ny eller ändrad information om en patient inom en tjänst. Producenten, eller övergångsadaptern för källsystem som fortfarande använder RIV-TA, registrerar eller uppdaterar motsvarande indexpost. Uppdateringen är idempotent och en äldre ändring skriver aldrig över en nyare. Motsvarar Update.

### Avregistrera indexposter

En producent håller inte längre informationen: den var felregistrerad, engagemanget är avslutat eller informationen har gallrats. Producenten avregistrerar posten och anger orsaken. Posten ligger kvar som gravsten under en lagringstid, så att avregistreringen syns för prenumeranter och vid avstämning. Motsvarar Update med deleteFlag.

### Prenumerera på ändringar

En konsument vill veta när en patients indexposter ändras, utan att söka om. Konsumenten registrerar en prenumeration, filtrerad på patient, tjänst eller vårdgivare. Vid varje ändring som konsumenten har rätt att se får den en notis med postens id. Motsvarar ProcessNotification.

### Stäm av efter avbrott

En konsument har missat notiser. Vid kortare avbrott hämtar den missade händelser ur händelseloggen. Vid längre avbrott söker den poster som ändrats sedan en viss tidpunkt, inklusive avregistrerade. Saknar motsvarighet idag.

### Massuttag

En systemkonsument, till exempel en framtida synk till eHM:s patientindex, behöver hela indexet eller allt som ändrats sedan en viss tidpunkt. Systemkonsumenten gör ett massuttag. Används för grundladdning, för ny konsument och efter avbrott längre än gravstenarnas lagringstid. Saknar motsvarighet idag.

### Övergång från dagens engagemangsindex

Källsystem ska kunna gå över till FHIR i egen takt. Under övergången speglar en adapter dagens engagemangsindex till FHIR-EI och skriver tillbaka FHIR-registrerade poster till dagens index så länge konsumenter läser därifrån. Se [Händelsemodell och övergång](event-model.md).

-------

Rollerna i användningsfallen beskrivs under [Roller och ansvar](roles-and-responsibilities.md).

