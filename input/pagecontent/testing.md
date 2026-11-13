Implementatörer kan validera engagemangsposter mot profilen med [HL7 FHIR Validator](https://confluence.hl7.org/display/FHIR/Using+the+FHIR+Validator) och IG-paketet (se [Nedladdningar](downloads.html)):

```
java -jar validator_cli.jar engagemangspost.json -version 4.0.1 -ig inera.ei.engagementindex#current \
  -profile https://fhir.inera.se/ig/engagementindex/StructureDefinition/IneraEngagement
```

Exemplen i IG:n visar giltiga instanser:

| Exempel | Profil |
|---|---|
| [Aktuell engagemangspost](DocumentReference-EngagemangspostAktuell.html) | Engagemangspost |
| [Engagemangspost med källsystemet som personuppgiftsansvarig](DocumentReference-EngagemangspostKallsystemSomPuA.html) | Engagemangspost |
| [Borttagen engagemangspost](DocumentReference-EngagemangspostBorttagen.html) | Engagemangspost |
| [Sökresultat för en patient](Bundle-SokresultatForPatient.html) | Bundle |
{:.grid}

Exemplen använder testpersonnumret 191212121212 och påhittade HSA-id:n. Någon testmiljö för EI-on-FHIR finns inte än.

Kodsystemen för tjänstedomäner och kategorier är utdrag. Validatorn varnar därför för koder som inte finns i utdraget; det är väntat.
