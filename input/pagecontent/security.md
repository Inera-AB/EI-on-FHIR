FHIR-EI används på två sätt som kräver olika säkerhetsmodell. När en användare öppnar en patient finns någon vars behörighet kan prövas. När ett system registrerar, prenumererar, stämmer av eller håller en lokal kopia aktuell finns ingen användare, och prövningen per användare kan inte göras i det ögonblicket. FHIR-EI skiljer därför på två åtkomstlägen och är uppdelat efter dem; se [Roller och ansvar](roles-and-responsibilities.html).

Vid läsning i användarkontext är FHIR-EI sin egen åtkomstkontrollpunkt. Åtkomstlagret anropar spärrtjänsten, loggar i loggtjänsten och filtrerar svaren innan de lämnas ut, på samma sätt som EHDS-bryggan. Användaren får alltså bara se poster den har rätt att se. Det är en första hypotes som behöver bekräftas.

Skälet är att indexet självt är skyddsvärd information: att en patient har en post hos en viss vårdenhet är en uppgift om patienten.

### Åtkomstlägen

| | Användarkontext | Systemkontext |
|---|---|---|
| När | Anropet görs för en namngiven användare: vårdpersonal, invånare eller ombud | Ingen användare: ett system anropar för egen räkning |
| Autentisering | Token med användarens kontextanspråk från säkerhetstjänsten, till exempel genom token exchange från konsumentens session | Klientcertifikat eller signerad token enligt SMART Backend Services |
| Vad FHIR-EI prövar | Spärr, samtycke, nödåtkomst, syfte, fullmakt och säkerhetsetiketter | Systemets behörighet: vilka tjänster och vilket syfte, och för registrerande parter vilket underlag |
| Loggning i FHIR-EI | Per användare: varje sökning och varje utlämnad post | Per anrop och uttag, med systemets identitet |
| Prövning per användare | I FHIR-EI, innan svaret lämnas ut | I det mottagande systemet, när informationen visas för en användare |
{:.grid}

| Operation | Åtkomstläge |
|---|---|
| Sökning och läsning för visning, till exempel i NPÖ och 1177 | Användarkontext |
| Registrering och avregistrering | Systemkontext |
| Prenumeration | Systemkontext |
| Inkrementell avstämning och massuttag | Systemkontext |
| Lokaliseringstjänstens riktade fråga, när en sökning träffar en saknad eller inaktuell cachepost | Användarkontext, som skickas vidare till källan |
| Lokaliseringstjänstens färskhållning | Systemkontext |
{:.grid}

Ett system som tar emot indexposter i systemkontext är en betrodd mellanhand. Dess behörighet begränsas per tjänst och syfte och regleras i avtal, och det ansvarar för prövning och loggning per användare när informationen visas. Ett mellanläge är ett system som agerar för en bestämd vårdgivare. FHIR-EI kan då pröva yttre spärr mot den vårdgivaren redan i systemkontext, men inte samtycke eller nödåtkomst, som kräver en användare.

### Läsmönster per tjänst

Hur en tjänsts konsumenter läser avgör i vilket åtkomstläge läsningen sker, och det begränsar vilka [försörjningssätt](population.html) som passar:

| Läsmönster | Exempel | Åtkomstläge | Försörjning |
|---|---|---|---|
| Vid behov: konsumenten söker när en användare öppnar patienten, och kan förhämta innehåll (pre-warm) | Översikten i NPÖ, journalen i 1177 | Användarkontext | Alla tre. Vid Inera-försörjd cache är det användarens sökning som utlöser den riktade frågan |
| Synkat: en systemkonsument håller en lokal kopia av innehåll och uppdaterar den löpande | Läkemedelsordinationer och uppmärksamhetsinformation | Systemkontext | Producentregistrering eller spegling. Inera-försörjd cache passar dåligt, eftersom posterna bara fylls när någon söker |
{:.grid}

Förhämtning i användarkontext loggas hos källan som användarens åtkomst, även för informationsmängder som användaren sedan inte öppnar. En lokal kopia av innehåll är central lagring. Den ligger utanför IG:n och kräver egen rättslig grund, och dess ägare blir åtkomstkontrollpunkt för innehållet. FHIR-EI:s del är att förse den med indexposter och notiser i systemkontext.

### Prövning i användarkontext

| Funktion | Vad FHIR-EI gör | Beroende |
|---|---|---|
| Åtkomstkontext | Kräver i varje anrop i användarkontext vem som frågar (HSA-id eller invånare), för vilken vårdgivare och vårdenhet, i vilket uppdrag, med vilket syfte (`purposeOfUse`), samt samtycke eller nödåtkomst där det krävs | Säkerhetstjänst, token med kontextanspråk |
| Spärrkontroll | Frågar spärrtjänsten med åtkomstkontexten och tar bort poster som omfattas av spärr | Spärrtjänsten, på sikt en FHIR-baserad spärrtjänst |
| Filtrering | Tar bort poster utanför frågande aktörs behörighet. Om konsumenten får veta att poster filtrerats (till exempel "information finns men kräver samtycke") beror på lagstiftningen för syftet. Det styrs av `purposeOfUse` i frågan och av spärrtjänstens svar, som FHIR-EI för vidare i sitt svar | Spärrtjänsten, policy per konsument (NPÖ, 1177) |
| Ombud | För 1177: tillämpar fullmakt när någon söker för en annan person | Fullmaktsarkitekturen |
| Loggning | Loggar både varje sökning och varje utlämnad post som åtkomst till patientuppgift | Loggtjänsten |
{:.grid}

### Alla operationer

Kontrollen gäller alla operationer, men vad som prövas beror på åtkomstläget. I användarkontext filtrerar FHIR-EI svaret innan det lämnas ut, aldrig bara i den komponent som presenterar svaret. I systemkontext prövar FHIR-EI systemets behörighet, och det mottagande systemet ansvarar för prövningen per användare när informationen visas. Massuttag kräver egen behörighet för systemkonsumenten och loggas per uttag.

### Ett index, prövning per syfte

NPÖ och 1177 använder samma indexposter. Det som skiljer är prövningen vid varje läsning, som FHIR-EI väljer utifrån åtkomstkontexten och `purposeOfUse`.

| Prövning | NPÖ (sammanhållen journalföring) | 1177 (patientens direktåtkomst) |
|---|---|---|
| Vem frågar | Vårdpersonal med uppdrag | Patienten, eller ombud med fullmakt |
| Spärr | Gäller | Gäller inte mot patienten själv |
| Samtycke och nödåtkomst | Krävs | Ersätts av inloggning och identitet |
| Särskilda begränsningar | – | Till exempel vårdgivarens fördröjda visning och sekretess mot vårdnadshavare för unga |
{:.grid}

Att indexet får användas för både sammanhållen journalföring och patientens direktåtkomst är en juridisk fråga: vårdgivarens ändamål som personuppgiftsansvarig, och att Ineras personuppgiftsbiträdesavtal täcker båda tjänsterna. Det är prövningen per syfte som gör delningen försvarbar, inte att informationen är densamma. Se [Rättslig grund och ändamål](legal-basis.html) och [Öppna frågor](open-issues.html).

### Säkerhetsetiketter

En post kan i sig avslöja uppgifter, till exempel för en vårdnadshavare att en ungdom har besökt en viss mottagning. Den registrerande parten kan därför märka en post med säkerhetsetiketter i `meta.security`, till exempel `NOPAT` ur HL7:s kodsystem `v3-ActCode`: inte till patient, närstående eller vårdnadshavare utan behandlarens medgivande. FHIR-EI tillämpar etiketterna per syfte. Vid Inera-försörjd cache måste den riktade frågan kunna returnera etiketterna; dagens engagemangsindex har ingen motsvarighet, så speglade poster saknar dem. Vilka etiketter som används, och hur de tillämpas, beslutas tillsammans med reglerna för 1177. Se exemplet [Indexpost som inte visas för patient eller närstående](DocumentReference-IndexpostEjForPatient.html).

### Prenumerationer

Prenumerationer sker i systemkontext, eftersom de lever längre än en användares session. FHIR-EI filtrerar notiserna på systemets behörighet, och på yttre spärr när systemet agerar för en bestämd vårdgivare. Notisen bär bara postens id (`id-only`), så att den inte för med sig mer om patienten än nödvändigt. Det mottagande systemet läser posten i systemkontext för egen bearbetning, eller via åtkomstlagret i användarkontext när den ska visas, och ansvarar för prövningen per användare. Se [Prenumeration](subscriptions.html).

### Producenter

Skrivningar från registrerande parter filtreras inte men auktoriseras. Partens identitet är dess endpoint i tjänstekatalogen. En producent får bara registrera för vårdgivare som listar endpointen där; övergångsadaptern och lokaliseringstjänsten bara inom sitt underlag. Se [REST-interaktioner och sökparametrar](rest-interactions.html). `meta.source` används aldrig ensamt för behörighetskontroll.

### Granularitet

Spärrar gäller idag på vårdgivar- och vårdenhetsnivå. Med indexposter per tjänst går det längre fram att spärra eller filtrera per tjänst utan ändrad modell.

### Vårdgivare och vårdenhet i spärrkontrollen

Yttre spärr prövas mot vårdgivaren. När posten anger vårdgivaren med organisationsnummer slår FHIR-EI upp vårdgivarens HSA-id i tjänstekatalogen, som har båda på den juridiska personen.

Inre spärr prövas mot vårdenheten i `careUnit`. En post utan `careUnit`, vilket kan förekomma vid [Inera-försörjd cache](population.html), lämnas inte ut om patienten har en inre spärr hos vårdgivaren (fail-closed). Det kan dölja information som patienten inte har spärrat, så regeln är en [öppen fråga](open-issues.html).

### Allmänna krav

Ineras generella säkerhetskrav för FHIR-gränssnitt på [FHIR på Inera](https://fhir.inera.se/) gäller. Exakt tokenformat och vilka anspråk åtkomstkontexten bär specificeras inte i denna version.
