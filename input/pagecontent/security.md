API:et är bara till för Ineras interna stödtjänster och synktjänsten. Alla klienter är system. Ingen klient anropar för en enskild användares räkning, och API:et lämnar inte ut poster till användare.

### Autentisering

Klienter autentiserar sig enligt [SMART Backend Services](https://hl7.org/fhir/smart-app-launch/backend-services.html): de får en åtkomsttoken med systembehörigheter från Ineras auktoriseringstjänst, med en signerad JWT som klientidentitet. API:et tar bara emot klienter som är registrerade hos auktoriseringstjänsten.

### Behörigheter

| Klientroll | Exempel | Tillåtet |
|---|---|---|
| Stödtjänst | EHDS-bryggan | Läsning, och sökning som anger `subject:identifier` |
| Synktjänst | Synk till eHM:s patientindex | Som stödtjänst, och dessutom sökning utan patient och massuttag med `$export` |
{:.grid}

Behörigheten uttrycks med systembehörigheten `system/DocumentReference.rs` och en behörighet för synk. Hur den senare uttrycks i token är en [öppen fråga](open-issues.html).

### Spärr och ändamål

API:et prövar inte spärr eller samtycke. Det gör inte heller dagens engagemangsindex. Den stödtjänst som hämtar journalinformation med hjälp av en post ansvarar för spärrprövning och loggning när den lämnar ut informationen. EHDS-bryggan gör det redan, efter att svaret från källsystemet har mappats.

Informationen i EI får användas för att hitta vart ett anrop ska gå, och användningsfall 1 håller sig till det ändamålet. Användningsfall 2 använder informationen för ett nytt ändamål och förutsätter vårdgivarnas uppdrag; se [Öppna frågor](open-issues.html).

### Loggning

API:et loggar varje anrop med klientens identitet, tidpunkt, interaktion och sökparametrar, inklusive patientens identitet när den anges, och antalet returnerade poster. Ett massuttag loggas per uttag. Loggarna följs upp av EI:s förvaltning.

### Transport

API:et nås bara med TLS. Ineras generella säkerhetskrav för FHIR-gränssnitt på [FHIR på Inera](https://fhir.inera.se/) gäller.
