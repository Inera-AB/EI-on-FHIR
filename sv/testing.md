# Testning och validering - FHIR-baserat engagemangsindex (FHIR-EI) v0.1.0

## Testning och validering

Implementatörer kan validera indexposter och prenumerationer mot profilerna med [HL7 FHIR Validator](https://confluence.hl7.org/display/FHIR/Using+the+FHIR+Validator) och IG-paketet (se [Nedladdningar](downloads.md)):

```
java -jar validator_cli.jar indexpost.json -version 5.0.0 -ig inera.ei.engagementindex#current \
  -profile https://fhir.inera.se/ig/engagementindex/StructureDefinition/IneraIndexEntry

```

En tjänsts tillämpning valideras på samma sätt, med tjänstens IG och tillämpningens profil.

Exemplen i IG:n visar giltiga instanser:

| | |
| :--- | :--- |
| [Registrerad indexpost från en FHIR-producent](DocumentReference-IndexpostFhirProducent.md) | Indexpost |
| [Indexpost som inte visas för patient eller närstående](DocumentReference-IndexpostEjForPatient.md) | Indexpost |
| [Indexpost speglad av övergångsadaptern](DocumentReference-IndexpostFranAdapter.md) | Indexpost |
| [Indragen indexpost](DocumentReference-IndexpostIndragen.md) | Indexpost |
| [Prenumeration på en patients indexposter](Subscription-PrenumerationForPatient.md) | Prenumeration på indexposter |
| [Registrering och avregistrering i en transaction](Bundle-RegistreringTransaction.md) | Bundle |
| [Sökresultat för en patient](Bundle-SokresultatForPatient.md) | Bundle |

Exemplen använder testpersonnumret 191212121212, påhittade HSA-id:n och påhittade adresser i tjänstekatalogen. Någon testmiljö för FHIR-EI finns inte än.

Kodsystemen för tjänstedomäner och kategorier är utdrag. Validatorn varnar därför för koder som inte finns i utdraget; det är väntat.

