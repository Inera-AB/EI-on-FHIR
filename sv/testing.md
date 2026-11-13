# Testning och validering - EI-on-FHIR: FHIR-API för engagemangsindex v0.1.0

## Testning och validering

Implementatörer, till exempel FHIR-producenter som vill kontrollera sina registreringar, kan validera engagemangsposter mot profilen med [HL7 FHIR Validator](https://confluence.hl7.org/display/FHIR/Using+the+FHIR+Validator) och IG-paketet (se [Nedladdningar](downloads.md)):

```
java -jar validator_cli.jar engagemangspost.json -version 5.0.0 -ig inera.ei.engagementindex#current \
  -profile https://fhir.inera.se/ig/engagementindex/StructureDefinition/IneraEngagement

```

Exemplen i IG:n visar giltiga instanser:

| | |
| :--- | :--- |
| [Aktuell engagemangspost](DocumentReference-EngagemangspostAktuell.md) | Engagemangspost |
| [Engagemangspost från en FHIR-producent](DocumentReference-EngagemangspostFhir.md) | Engagemangspost |
| [Engagemangspost med källsystemet som personuppgiftsansvarig](DocumentReference-EngagemangspostKallsystemSomPuA.md) | Engagemangspost |
| [Borttagen engagemangspost](DocumentReference-EngagemangspostBorttagen.md) | Engagemangspost |
| [Sökresultat för en patient](Bundle-SokresultatForPatient.md) | Bundle |

Exemplen använder testpersonnumret 191212121212 och påhittade HSA-id:n. Någon testmiljö för EI-on-FHIR finns inte än.

Kodsystemen för tjänstedomäner och kategorier är utdrag. Validatorn varnar därför för koder som inte finns i utdraget; det är väntat.

