Implementatörer kan validera indexposter och endpoints mot profilerna med [HL7 FHIR Validator](https://confluence.hl7.org/display/FHIR/Using+the+FHIR+Validator) och IG-paketet (se [Nedladdningar](downloads.html)):

```
java -jar validator_cli.jar indexpost.json -version 4.0.1 -ig inera.ei.engagementindex#current \
  -profile https://fhir.inera.se/ig/engagementindex/StructureDefinition/IneraEngagementIndexEntry
```

Exemplen i IG:n visar giltiga instanser:

| Exempel | Profil |
|---|---|
| [Indexpost från ett FHIR-källsystem](EpisodeOfCare-IndexpostFhirProducent.html) | Indexpost |
| [Indexpost speglad från dagens engagemangsindex](EpisodeOfCare-IndexpostFranAdapter.html) | Indexpost |
| [Indexpost med orsak till borttag](EpisodeOfCare-IndexpostMedBorttagsorsak.html) | Indexpost |
| [Endpoint för ett FHIR-källsystem](Endpoint-EndpointJournalsystemFhir.html) | Källsystemets endpoint |
| [Endpoint för ett RIV-TA-källsystem](Endpoint-EndpointRivTaKallsystem.html) | Källsystemets endpoint |
| [Registrering av indexposter i en transaction](Bundle-RegistreringTransaction.html) | Bundle |
| [Sökresultat för en patient](Bundle-SokresultatForPatient.html) | Bundle |
{:.grid}

Exemplen använder testpersonnumret 191212121212 och påhittade HSA-id:n. Någon testmiljö för FHIR-EI finns inte än.

Kodsystemen för tjänstedomäner och kategorier är utdrag. Validatorn varnar därför för koder som inte finns i utdraget; det är väntat.
