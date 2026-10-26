# Kodverk för tjänster och informationsmängder - FHIR-baserat engagemangsindex (FHIR-EI) v0.1.0

## Kodverk för tjänster och informationsmängder

Tjänst och informationsmängd är två nivåer i samma hierarki: en tjänst är en IG, och en informationsmängd är en profil eller resurs inom den. Indexet börjar med dagens tjänstedomäner och kategorier och går över till IG-canonicals och profil-canonicals. Under övergången får en post bära både gammal och ny kodning, så att konsumenter som bara förstår tjänstedomän fungerar hela vägen.

| | | | |
| :--- | :--- | :--- | :--- |
| Tjänst | Tjänstedomän, t.ex.`riv:clinicalprocess:healthcond:description`([kodsystem](CodeSystem-IneraServiceDomainCodeSystem.md)) | IG:ns canonical | `type.coding`, en kodning per generation:`type.coding[serviceDomain]`och`type.coding[implementationGuide]` |
| Informationsmängd | Kategori inom domänen, t.ex.`voo`([kodsystem](CodeSystem-IneraEngagementCategoryCodeSystem.md)) | Profilens canonical, eller resurstyp | `content.profile`som Coding (`content.profile[category]`) eller canonical (`content.profile[contentProfile]`) |

Tjänsten anges alltid, med tjänstedomän, IG-canonical eller båda. Informationsmängder är valfria i den gemensamma profilen; varje tjänsts [tillämpning](information-model.md) bestämmer om de är obligatoriska.

Konsumenter filtrerar på informationsmängd med standardparametrarna `format-code` (Coding) och `format-canonical` (canonical).

### Regel för uppdelning

En informationsmängd som behöver en egen tidpunkt för senaste ändring bryts ut till en egen tjänst. Tjänstegränsen följer alltså behovet av aktualitetsinformation, inte bara den kliniska domänen.

### Mappning mellan generationerna

En mappningstabell mellan tjänstedomän/kategori och IG/profil publiceras tillsammans med den gemensamma indexprofilen, som en `ConceptMap`. Övergångsadaptern använder den för att fylla i de nya kodningarna på poster som bara kommer med tjänstedomän. Tabellen kan skrivas när de första tjänsternas IG:er är publicerade.

### Utdrag

Kodsystemen för tjänstedomäner och kategorier i denna IG är utdrag (`content = fragment`) med exemplen ovan. Den fullständiga förteckningen förvaltas av Inera och ska läsas in innan IG:n används skarpt.

