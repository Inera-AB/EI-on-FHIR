# Spärr, loggning och behörighet - FHIR-baserat engagemangsindex (FHIR-EI) v0.1.0

## Spärr, loggning och behörighet

FHIR-EI är sin egen åtkomstkontrollpunkt. Komponenten anropar spärrtjänsten, loggar i loggtjänsten och filtrerar svaren innan de lämnas ut, på samma sätt som EHDS-bryggan. Konsumenterna får alltså bara se poster de har rätt att se. Det är en första hypotes som behöver bekräftas.

Skälet är att indexet självt är skyddsvärd information: att en patient har en post hos en viss vårdenhet är en uppgift om patienten.

| | | |
| :--- | :--- | :--- |
| Åtkomstkontext | Kräver i varje anrop vem som frågar (HSA-id eller invånare), för vilken vårdgivare och vårdenhet, i vilket uppdrag, med vilket syfte (`purposeOfUse`), samt samtycke eller nödåtkomst där det krävs | Säkerhetstjänst, token med kontextanspråk |
| Spärrkontroll | Frågar spärrtjänsten med åtkomstkontexten och tar bort poster som omfattas av spärr | Spärrtjänsten, på sikt en FHIR-baserad spärrtjänst |
| Filtrering | Tar bort poster utanför frågande aktörs behörighet. Om konsumenten får veta att poster filtrerats (till exempel "information finns men kräver samtycke") beror på lagstiftningen för syftet. Det styrs av`purposeOfUse`i frågan och av spärrtjänstens svar, som FHIR-EI för vidare i sitt svar | Spärrtjänsten, policy per konsument (NPÖ, 1177) |
| Ombud | För 1177: tillämpar fullmakt när någon söker för en annan person | Fullmaktsarkitekturen |
| Loggning | Loggar både varje sökning och varje utlämnad post som åtkomst till patientuppgift | Loggtjänsten |

### Alla operationer

Kontrollen gäller alla operationer: sökning, läsning, skrivning, prenumeration, inkrementell avstämning och export. Filtreringen sker i FHIR-EI innan svaret lämnas ut, aldrig bara i den komponent som presenterar svaret. Export kräver egen behörighet för systemkonsumenten och loggas per uttag.

### Prenumerationer

Prenumerationer filtreras på samma sätt. En konsument får bara notis om poster den skulle ha fått i en sökning. Det, och `id-only`-innehåll, hindrar att notiser läcker förekomst av spärrad information. Se [Prenumeration](subscriptions.md).

### Producenter

Producenternas skrivningar filtreras inte men auktoriseras. Producentens identitet är dess endpoint i tjänstekatalogen, och en producent får bara registrera för vårdgivare som listar endpointen där. Se [REST-interaktioner och sökparametrar](rest-interactions.md). `meta.source` används aldrig ensamt för behörighetskontroll.

### Granularitet

Spärrar gäller idag på vårdgivar- och vårdenhetsnivå. Med indexposter per tjänst går det längre fram att spärra eller filtrera per tjänst utan ändrad modell.

### Allmänna krav

Ineras generella säkerhetskrav för FHIR-gränssnitt på [FHIR på Inera](https://fhir.inera.se/) gäller. Exakt tokenformat och vilka anspråk åtkomstkontexten bär specificeras inte i denna version.

