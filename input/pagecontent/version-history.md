Den här sidan beskriver vad som har ändrats i varje version. Listan över alla publicerade versioner nås via länken i bannern överst på varje sida.

---

## [0.1.0] — opublicerad

### Features

- Första utkastet av EI-on-FHIR: ett skrivskyddat FHIR R4-API ovanpå dagens engagemangsindex, med NHS Englands National Record Locator som förebild
- Två användningsfall: stödtjänster som hittar var information finns, och synk till eHM:s patientindex
- Profilen Engagemangspost på `DocumentReference`, med en resurs per post i EI
- Extensions för logisk adress, källsystem, ägare och senaste innehåll
- Sökparametrarna `logical-address` och `source-system`
- Borttagna poster med status `superseded` under borttagsloggens lagringstid
- Massuttag med Bulk Data `$export`
- CapabilityStatement för EI-on-FHIR som server
