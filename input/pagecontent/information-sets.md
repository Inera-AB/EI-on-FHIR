Indexet börjar med dagens tjänstedomäner och växer mot IG-nivå, med profil eller resurstyp som lövnivå. Nivåerna läggs till, de ersätter inte varandra. En post kan därför bära flera nivåer samtidigt, och konsumenter som bara förstår tjänstedomän fungerar under hela övergången.

| Nivå | Exempel (illustrativa) | Representation i indexposten | Införs |
|---|---|---|---|
| Tjänstedomän + kategori | `riv:clinicalprocess:healthcond:description`, kategori `voo` | `type[serviceDomain]` och `type[category]`, med [Tjänstedomäner](CodeSystem-IneraServiceDomainCodeSystem.html) och [Kategorier](CodeSystem-IneraEngagementCategoryCodeSystem.html) | Iteration 1 |
| IG | Canonical för en Inera-IG | `type[implementationGuide]`, system `urn:ietf:rfc:3986`, code = IG:ns canonical | Iteration 2 |
| Profil/resurs (lövnivå) | Canonical för en profil, eller en resurstyp som `http://hl7.org/fhir/StructureDefinition/Observation` | Extension [contentProfile](StructureDefinition-ContentProfile.html) (canonical, 0..\*) | Iteration 3 |
{:.grid}

Tjänstedomän är obligatorisk på varje post. IG och lövnivå är valfria och fylls i när producenten, eller adaptern, kan ange dem.

Kodsystemen för tjänstedomäner och kategorier i denna IG är utdrag (`content = fragment`) med exemplen ovan. Den fullständiga förteckningen förvaltas av Inera och ska läsas in innan IG:n används skarpt.

### Mappning mellan nivåerna

En mappningstabell mellan tjänstedomän/kategori och IG ska publiceras i denna IG, som en `ConceptMap`. Den låter adaptern fylla i IG-nivån för poster som bara kommer med tjänstedomän. Tabellen kan skrivas när de första IG:erna för NPÖ:s informationsmängder är publicerade, inför iteration 2.

### Avvägning för lövnivån

Lövnivån ger finare filtrering och bättre hämtningsbeslut, men fler poster per patient. Avvägningen bör följas upp med volymdata innan iteration 3.
