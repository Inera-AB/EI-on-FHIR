Indexposten är en pekare: den anger att en producent, via en endpoint, har information om en patient inom en tjänst. Posten representeras med profilen [Indexpost](StructureDefinition-IneraIndexEntry.html) på R5 `DocumentReference`. Hur varje element motsvarar dagens engagemangsindex beskrivs under [Mappning till profiler](mappings.html).

### Granularitet

Det finns en post per patient × endpoint × tjänst. En tjänst är en IG och motsvarar tjänstedomän i dagens modell. En post kan bära flera informationsmängder. Tidpunkten för senaste ändring gäller hela posten. En informationsmängd som behöver en egen tidpunkt bryts ut till en egen tjänst.

### Producent, endpoint och logisk adress

Producentens identitet är dess endpoint i tjänstekatalogen. FHIR-EI binder den autentiserade klienten till en Endpoint där, och postens [registeringProducer](StructureDefinition-RegisteringProducer.html) är en absolut referens till den endpointen. Samma URL är producentens namnrymd i `identifier.system`, så att FHIR-EI kan kontrollera namnrymden utan ett eget register.

| Producent | registeringProducer | sourceEndpoint | logicalAddress |
|---|---|---|---|
| Direktansluten FHIR-producent | Producentens endpoint | Samma endpoint | Utelämnas |
| Övergångsadaptern | Adapterns egen endpoint | Endpoint enligt adapterns adressregister, t.ex. tjänsteplattformens endpoint för tjänstekontraktet | Logisk adress från dagens engagemangsindex |
{:.grid}

En endpoint i tjänstekatalogen kan delas av många logiska adresser, till exempel tjänsteplattformens adress för ett tjänstekontrakt. Posten bär därför den [logiska adressen](StructureDefinition-LogicalAddress.html) separat när endpointen adresseras med logisk adress. I tjänstekatalogen är den logiska adressen en organisations HSA-id, så konsumenten kan slå upp den där.

Poster från adaptern bär också [källsystemet](StructureDefinition-SourceSystem.html) från dagens engagemangsindex, eftersom registrerande producent då är adaptern.

### Tillämpning per tjänst

Vad indexet svarar på bestäms per tjänst: bara var det finns information, eller också vilka informationsmängder som finns och hur aktuella de är. Varje tjänst publicerar sin tillämpning som en profil av den gemensamma indexprofilen, i tjänstens IG. Därmed hålls semantiken ihop även när tjänsterna använder indexet olika.

| Element | Gemensam modell | Tillämpningen per tjänst bestämmer |
|---|---|---|
| Patient, tjänst, endpoint, producent, vårdgivare | Obligatoriska | Inget |
| Informationsmängder | 0..\* | Om de anges, och vilka värden som är tillåtna |
| Innehållets senaste ändring | 0..1 | Om den är obligatorisk, och vad som räknas som ändring |
| Status och livscykel | Obligatoriska | Inget |
{:.grid}

En tillämpning i en tjänsts IG kan se ut så här. Tjänstens IG har denna IG som beroende.

```
Profile: LakemedelIndexEntry
Parent: https://fhir.inera.se/ig/engagementindex/StructureDefinition/IneraIndexEntry
* type.coding[implementationGuide].code = "<läkemedels-IG:ns canonical>"
* content.profile 1..*
* extension[contentLastUpdated] 1..1
```

En konsument känner igen indexposter på `meta.profile`.

### Tidpunkter

| Tidpunkt | Betydelse | Element |
|---|---|---|
| Innehållets senaste ändring | När det kliniska innehållet i källsystemet senast ändrades, enligt producenten | Extension [contentLastUpdated](StructureDefinition-ContentLastUpdated.html) |
| Postens senaste ändring | När indexposten senast ändrades i FHIR-EI. Sätts av servern | `meta.lastUpdated`, `_history` |
| Mottagningstid | När FHIR-EI senast tog emot en rapport om posten | Loggas för drift och avstämning, inte sökbar |
{:.grid}

En uppdatering av posten ändrar inte `contentLastUpdated` om innehållet är oförändrat.

### Livscykel

| Logiskt tillstånd | R5 `status` (basvärde) | Extension [registrationStatus](StructureDefinition-RegistrationStatus.html) | Synlig i standardsökning |
|---|---|---|---|
| Registrerad: informationen finns tillgänglig | `current` | `active` | Ja |
| Indragen: producenten har dragit tillbaka posten (avslutat engagemang, gallring) | `superseded` | `withdrawn` | Nej; syns vid explicit statusfilter, ändringssökning och export |
| Felregistrerad: posten skulle aldrig ha funnits | `entered-in-error` | `entered-in-error` | Som indragen |
{:.grid}

`DocumentReference.status` har en obligatorisk bindning till `current | superseded | entered-in-error` och kan inte utökas med egna koder. Den exakta semantiken bärs därför av extensionen `registrationStatus`. En generisk FHIR-konsument som inte förstår extensionen ser ändå på basvärdet att posten inte längre är aktuell. Profilens invarianter håller basvärdet och extensionen i takt.

`withdrawn` är valt framför `unavailable`, eftersom det uttrycker en avsiktlig och bestående handling av producenten. `unavailable` kan läsas som ett tillfälligt driftavbrott, och det ska indexet inte uttrycka.

Orsaken anges i [deregistrationReason](StructureDefinition-DeregistrationReason.html), som finns om och endast om posten inte är registrerad. En indragen post ligger kvar som gravsten under gravstenarnas lagringstid och rensas sedan fysiskt. Se [Händelsemodell och övergång](event-model.html).

### Exempel

- [Registrerad indexpost från en FHIR-producent](DocumentReference-IndexpostFhirProducent.html)
- [Indexpost speglad av övergångsadaptern](DocumentReference-IndexpostFranAdapter.html)
- [Indragen indexpost](DocumentReference-IndexpostIndragen.html)
