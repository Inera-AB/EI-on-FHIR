FHIR-EI är sin egen åtkomstkontrollpunkt. Komponenten anropar spärrtjänsten, loggar i loggtjänsten och filtrerar svaren innan de lämnas ut, på samma sätt som EHDS-bryggan. Konsumenterna får alltså bara se poster de har rätt att se. Det är en första hypotes som behöver bekräftas.

Skälet är att indexet självt är skyddsvärd information: att en patient har en post hos en viss vårdenhet är en uppgift om patienten.

| Funktion | Vad FHIR-EI gör | Beroende |
|---|---|---|
| Åtkomstkontext | Kräver i varje anrop vem som frågar (HSA-id eller invånare), för vilken vårdgivare och vårdenhet, i vilket uppdrag och syfte, samt samtycke eller nödåtkomst där det krävs | Säkerhetstjänst, token med kontextanspråk |
| Spärrkontroll | Tar bort poster som omfattas av spärr för frågande aktör | Spärrtjänsten, på sikt en FHIR-baserad spärrtjänst |
| Filtrering | Tar bort poster utanför frågande aktörs behörighet, till exempel andra vårdgivares poster utan samtycke vid sammanhållen journalföring | Policy per konsument (NPÖ, 1177) |
| Ombud | För 1177: tillämpar fullmakt när någon söker för en annan person | Fullmaktsarkitekturen |
| Loggning | Loggar varje sökning och varje utlämnad post som åtkomst till patientuppgift | Loggtjänsten |
{:.grid}

### Prenumerationer

Prenumerationer filtreras på samma sätt. En konsument får bara notis om poster den skulle ha fått i en sökning. Det, och `id-only`-innehåll, hindrar att notiser läcker förekomst av spärrad information. Se [Prenumeration](subscriptions.html).

### Producenter

Producenternas skrivningar filtreras inte men auktoriseras: bara registrerande system får ändra sina poster. FHIR-EI sätter `meta.source` från klientens identitet och jämför vid varje uppdatering och borttag.

### Granularitet

Spärrar gäller idag på vårdgivar- och vårdenhetsnivå. Indexposter per informationsmängd gör det möjligt att längre fram spärra eller filtrera per informationsmängd utan ändrad modell.

### Allmänna krav

Ineras generella säkerhetskrav för FHIR-gränssnitt på [FHIR på Inera](https://fhir.inera.se/) gäller. Exakt tokenformat och vilka anspråk åtkomstkontexten bär specificeras inte i denna version.
