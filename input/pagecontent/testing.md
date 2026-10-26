Implementatörer kan validera indexposter och prenumerationer mot profilerna med [HL7 FHIR Validator](https://confluence.hl7.org/display/FHIR/Using+the+FHIR+Validator) och IG-paketet (se [Nedladdningar](downloads.html)):

```
java -jar validator_cli.jar indexpost.json -version 5.0.0 -ig inera.ei.engagementindex#current \
  -profile https://fhir.inera.se/ig/engagementindex/StructureDefinition/IneraIndexEntry
```

En tjänsts tillämpning valideras på samma sätt, med tjänstens IG och tillämpningens profil.

Exemplen i IG:n visar giltiga instanser:

| Exempel | Profil |
|---|---|
| [Registrerad indexpost från en FHIR-producent](DocumentReference-IndexpostFhirProducent.html) | Indexpost |
| [Indexpost speglad av övergångsadaptern](DocumentReference-IndexpostFranAdapter.html) | Indexpost |
| [Indragen indexpost](DocumentReference-IndexpostIndragen.html) | Indexpost |
| [Prenumeration på en patients indexposter](Subscription-PrenumerationForPatient.html) | Prenumeration på indexposter |
| [Registrering och avregistrering i en transaction](Bundle-RegistreringTransaction.html) | Bundle |
| [Sökresultat för en patient](Bundle-SokresultatForPatient.html) | Bundle |
{:.grid}

Exemplen använder testpersonnumret 191212121212, påhittade HSA-id:n och påhittade adresser i tjänstekatalogen. Någon testmiljö för FHIR-EI finns inte än.

Kodsystemen för tjänstedomäner och kategorier är utdrag. Validatorn varnar därför för koder som inte finns i utdraget; det är väntat.
