// Service domains and categories as coded in today's engagement index. The code systems are
// fragments: they hold the examples in this IG, while the full lists are maintained in Inera's
// register of service domains.
CodeSystem: IneraServiceDomainCodeSystem
Id: IneraServiceDomainCodeSystem
Title: "Kodsystem för tjänstedomäner"
Description: "Tjänstedomäner, som de anges i serviceDomain i engagemangsindex. Utdrag; den fullständiga förteckningen förvaltas i Ineras förteckning över tjänstedomäner."
* insert IneraMetadata(IneraServiceDomainCodeSystem)
* ^caseSensitive = true
* ^content = #fragment
* #riv:clinicalprocess:healthcond:description "riv:clinicalprocess:healthcond:description" "Tjänstedomänen riv:clinicalprocess:healthcond:description."
* #riv:clinicalprocess:activityprescription:actoutcome "riv:clinicalprocess:activityprescription:actoutcome" "Tjänstedomänen riv:clinicalprocess:activityprescription:actoutcome."

ValueSet: IneraServiceDomainValueSet
Id: IneraServiceDomainValueSet
Title: "Tjänstedomäner"
Description: "Alla tjänstedomäner i kodsystemet för tjänstedomäner."
* insert IneraMetadata(IneraServiceDomainValueSet)
* include codes from system IneraServiceDomainCodeSystem

CodeSystem: IneraEngagementCategoryCodeSystem
Id: IneraEngagementCategoryCodeSystem
Title: "Kodsystem för kategorier inom tjänstedomän"
Description: "Kategorier inom en tjänstedomän, som de anges i categorization i engagemangsindex. Utdrag; den fullständiga förteckningen förvaltas tillsammans med tjänstedomänerna."
* insert IneraMetadata(IneraEngagementCategoryCodeSystem)
* ^caseSensitive = true
* ^content = #fragment
* #voo "voo" "Kategorin voo inom tjänstedomänen riv:clinicalprocess:healthcond:description."

ValueSet: IneraEngagementCategoryValueSet
Id: IneraEngagementCategoryValueSet
Title: "Kategorier inom tjänstedomän"
Description: "Alla kategorier i kodsystemet för kategorier inom tjänstedomän."
* insert IneraMetadata(IneraEngagementCategoryValueSet)
* include codes from system IneraEngagementCategoryCodeSystem

ValueSet: IneraEngagementStatusValueSet
Id: IneraEngagementStatusValueSet
Title: "Status för engagemangsposter"
Description: "current för en post som finns i EI, superseded för en post som har tagits bort ur EI och visas under borttagsloggens lagringstid."
* insert IneraMetadata(IneraEngagementStatusValueSet)
* $docref-status#current
* $docref-status#superseded
