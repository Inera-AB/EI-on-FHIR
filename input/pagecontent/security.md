FHIR-EI är sin egen åtkomstkontrollpunkt. Komponenten anropar spärrtjänsten, loggar i loggtjänsten och filtrerar svaren innan de lämnas ut, på samma sätt som EHDS-bryggan. Konsumenterna får alltså bara se poster de har rätt att se. Det är en första hypotes som behöver bekräftas.

Skälet är att indexet självt är skyddsvärd information: att en patient har en post hos en viss vårdenhet är en uppgift om patienten.

| Funktion | Vad FHIR-EI gör | Beroende |
|---|---|---|
| Åtkomstkontext | Kräver i varje anrop vem som frågar (HSA-id eller invånare), för vilken vårdgivare och vårdenhet, i vilket uppdrag, med vilket syfte (`purposeOfUse`), samt samtycke eller nödåtkomst där det krävs | Säkerhetstjänst, token med kontextanspråk |
| Spärrkontroll | Frågar spärrtjänsten med åtkomstkontexten och tar bort poster som omfattas av spärr | Spärrtjänsten, på sikt en FHIR-baserad spärrtjänst |
| Filtrering | Tar bort poster utanför frågande aktörs behörighet. Om konsumenten får veta att poster filtrerats (till exempel "information finns men kräver samtycke") beror på lagstiftningen för syftet. Det styrs av `purposeOfUse` i frågan och av spärrtjänstens svar, som FHIR-EI för vidare i sitt svar | Spärrtjänsten, policy per konsument (NPÖ, 1177) |
| Ombud | För 1177: tillämpar fullmakt när någon söker för en annan person | Fullmaktsarkitekturen |
| Loggning | Loggar både varje sökning och varje utlämnad post som åtkomst till patientuppgift | Loggtjänsten |
{:.grid}

### Alla operationer

Kontrollen gäller alla operationer: sökning, läsning, skrivning, prenumeration, inkrementell avstämning och export. Filtreringen sker i FHIR-EI innan svaret lämnas ut, aldrig bara i den komponent som presenterar svaret. Export kräver egen behörighet för systemkonsumenten och loggas per uttag.

### Ett index, prövning per syfte

NPÖ och 1177 använder samma indexposter. Det som skiljer är prövningen vid varje läsning, som FHIR-EI väljer utifrån åtkomstkontexten och `purposeOfUse`.

| Prövning | NPÖ (sammanhållen journalföring) | 1177 (patientens direktåtkomst) |
|---|---|---|
| Vem frågar | Vårdpersonal med uppdrag | Patienten, eller ombud med fullmakt |
| Spärr | Gäller | Gäller inte mot patienten själv |
| Samtycke och nödåtkomst | Krävs | Ersätts av inloggning och identitet |
| Särskilda begränsningar | – | Till exempel vårdgivarens fördröjda visning och sekretess mot vårdnadshavare för unga |
{:.grid}

Att indexet får användas för både sammanhållen journalföring och patientens direktåtkomst är en juridisk fråga: vårdgivarens ändamål som personuppgiftsansvarig, och att Ineras personuppgiftsbiträdesavtal täcker båda tjänsterna. Det är prövningen per syfte som gör delningen försvarbar, inte att informationen är densamma. Se [Öppna frågor](open-issues.html).

### Säkerhetsetiketter

En post kan i sig avslöja uppgifter, till exempel för en vårdnadshavare att en ungdom har besökt en viss mottagning. Producenten kan därför märka en post med säkerhetsetiketter i `meta.security`, till exempel `NOPAT` ur HL7:s kodsystem `v3-ActCode`: inte till patient, närstående eller vårdnadshavare utan behandlarens medgivande. FHIR-EI tillämpar etiketterna per syfte. Vilka etiketter som används, och hur de tillämpas, beslutas tillsammans med reglerna för 1177. Se exemplet [Indexpost som inte visas för patient eller närstående](DocumentReference-IndexpostEjForPatient.html).

### Prenumerationer

Prenumerationer filtreras på samma sätt. En konsument får bara notis om poster den skulle ha fått i en sökning. Det, och `id-only`-innehåll, hindrar att notiser läcker förekomst av spärrad information. Se [Prenumeration](subscriptions.html).

### Producenter

Producenternas skrivningar filtreras inte men auktoriseras. Producentens identitet är dess endpoint i tjänstekatalogen, och en producent får bara registrera för vårdgivare som listar endpointen där. Se [REST-interaktioner och sökparametrar](rest-interactions.html). `meta.source` används aldrig ensamt för behörighetskontroll.

### Granularitet

Spärrar gäller idag på vårdgivar- och vårdenhetsnivå. Med indexposter per tjänst går det längre fram att spärra eller filtrera per tjänst utan ändrad modell.

### Allmänna krav

Ineras generella säkerhetskrav för FHIR-gränssnitt på [FHIR på Inera](https://fhir.inera.se/) gäller. Exakt tokenformat och vilka anspråk åtkomstkontexten bär specificeras inte i denna version.
