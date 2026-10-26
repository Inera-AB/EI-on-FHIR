FHIR-EI stöder sex användningsfall. De tre första har motsvarigheter i dagens tjänstekontrakt; massuttag saknar motsvarighet idag.

### Sök var information finns om en patient

En konsument, till exempel NPÖ, ska visa en översikt över en patients information. Konsumenten söker patientens indexposter, eventuellt begränsat till vissa informationsmängder eller till poster som ändrats efter en viss tidpunkt. FHIR-EI kontrollerar spärrar, filtrerar bort poster som konsumenten inte har rätt att se, loggar åtkomsten och returnerar posterna med källsystemens endpoints. Konsumenten hämtar sedan informationen direkt från källsystemen. Motsvarar FindContent.

### Registrera eller uppdatera indexposter

Ett källsystem har fått ny eller ändrad information om en patient. Källsystemet, eller adaptern för källsystem som fortfarande använder RIV-TA, registrerar eller uppdaterar motsvarande indexposter. Uppdateringen är idempotent och en äldre ändring skriver aldrig över en nyare. Motsvarar Update.

### Ta bort indexposter

Ett källsystem håller inte längre informationen: den var felregistrerad, engagemanget är avslutat eller informationen har gallrats. Producenten tar bort indexposten och anger orsaken. Borttaget går att följa i postens historik och ger en notis till prenumeranter. Motsvarar Update med deleteFlag.

### Prenumerera på ändringar

En konsument vill veta när en patients indexposter ändras, utan att söka om. Konsumenten registrerar en prenumeration, filtrerad på patient, informationsmängd eller vårdgivare. Vid varje ändring som konsumenten har rätt att se får den en notis med postens id. Motsvarar ProcessNotification.

### Massuttag och återsynk

En systemkonsument, till exempel en framtida synk till eHM:s patientindex, behöver hela indexet eller allt som ändrats sedan en viss tidpunkt. Systemkonsumenten gör ett massuttag av indexposter. Används för grundladdning och för att hitta och rätta avvikelser efter avbrott. Saknar motsvarighet idag.

### Övergång från dagens engagemangsindex

Källsystem ska kunna gå över till FHIR i egen takt. Under övergången speglar en adapter dagens engagemangsindex till FHIR-EI och skriver tillbaka FHIR-registrerade poster till dagens index så länge konsumenter läser därifrån. Se [Händelsemodell och övergång](event-model.html).

---

Rollerna i användningsfallen beskrivs under [Roller och ansvar](roles-and-responsibilities.html).
