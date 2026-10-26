// Services and information sets as coded today: service domains and their categories.
// The code systems are fragments: they hold the examples in this IG, while the full lists are
// maintained in Inera's register of service domains.
CodeSystem: IneraServiceDomainCodeSystem
Id: IneraServiceDomainCodeSystem
Title: "Kodsystem för tjänstedomäner"
Description: "Tjänstedomäner, som anger tjänst i FHIR-EI under övergången till IG-canonicals. Utdrag; den fullständiga förteckningen förvaltas i Ineras förteckning över tjänstedomäner."
* insert IneraMetadata(IneraServiceDomainCodeSystem)
* ^caseSensitive = true
* ^content = #fragment
* #riv:clinicalprocess:healthcond:description "riv:clinicalprocess:healthcond:description" "Tjänstedomänen riv:clinicalprocess:healthcond:description."

ValueSet: IneraServiceDomainValueSet
Id: IneraServiceDomainValueSet
Title: "Tjänstedomäner"
Description: "Alla tjänstedomäner i Ineras kodverk för tjänstedomäner."
* insert IneraMetadata(IneraServiceDomainValueSet)
* include codes from system IneraServiceDomainCodeSystem

CodeSystem: IneraEngagementCategoryCodeSystem
Id: IneraEngagementCategoryCodeSystem
Title: "Kodsystem för kategorier inom tjänstedomän"
Description: "Kategorier inom en tjänstedomän, som anger informationsmängd i FHIR-EI under övergången till profil-canonicals. Motsvarar categorization i dagens engagemangsindex. Utdrag; den fullständiga förteckningen förvaltas tillsammans med tjänstedomänerna."
* insert IneraMetadata(IneraEngagementCategoryCodeSystem)
* ^caseSensitive = true
* ^content = #fragment
* #voo "voo" "Kategorin voo inom tjänstedomänen riv:clinicalprocess:healthcond:description."

ValueSet: IneraEngagementCategoryValueSet
Id: IneraEngagementCategoryValueSet
Title: "Kategorier inom tjänstedomän"
Description: "Alla kategorier i kodverket för kategorier inom tjänstedomän."
* insert IneraMetadata(IneraEngagementCategoryValueSet)
* include codes from system IneraEngagementCategoryCodeSystem

CodeSystem: IneraIndexRegistrationStatusCodeSystem
Id: IneraIndexRegistrationStatusCodeSystem
Title: "Kodsystem för registreringsstatus"
Description: "En indexposts livscykeltillstånd. Varje kod motsvarar ett värde i DocumentReference.status."
* insert IneraMetadata(IneraIndexRegistrationStatusCodeSystem)
* ^caseSensitive = true
* ^content = #complete
* #active "Registrerad" "Informationen finns tillgänglig hos producenten. Basstatus current."
* #withdrawn "Indragen" "Producenten har avsiktligt och varaktigt dragit tillbaka posten. Basstatus superseded."
* #entered-in-error "Felregistrerad" "Posten skulle aldrig ha funnits. Basstatus entered-in-error."

ValueSet: IneraIndexRegistrationStatusValueSet
Id: IneraIndexRegistrationStatusValueSet
Title: "Registreringsstatus för indexposter"
Description: "Alla livscykeltillstånd för en indexpost."
* insert IneraMetadata(IneraIndexRegistrationStatusValueSet)
* include codes from system IneraIndexRegistrationStatusCodeSystem

CodeSystem: IneraDeregistrationReasonCodeSystem
Id: IneraDeregistrationReasonCodeSystem
Title: "Kodsystem för orsaker till avregistrering"
Description: "Varför en indexpost avregistreras. Orsaken avgör hur mottagare, till exempel ett tunt index, ska hantera avregistreringen."
* insert IneraMetadata(IneraDeregistrationReasonCodeSystem)
* ^caseSensitive = true
* ^content = #complete
* #entered-in-error "Felregistrering" "Posten skulle aldrig ha registrerats. Används med registreringsstatus entered-in-error."
* #ended "Avslutat engagemang" "Producenten håller inte längre information om patienten inom tjänsten. Används med registreringsstatus withdrawn."
* #purged "Gallring" "Informationen har gallrats hos producenten. Används med registreringsstatus withdrawn."
* #transition-adapter "Avregistrering via övergångsadapter" "Posten avregistrerades i dagens engagemangsindex, vars kontrakt inte bär någon orsak. Används med registreringsstatus withdrawn."

ValueSet: IneraDeregistrationReasonValueSet
Id: IneraDeregistrationReasonValueSet
Title: "Orsaker till avregistrering"
Description: "Alla orsaker till avregistrering av en indexpost."
* insert IneraMetadata(IneraDeregistrationReasonValueSet)
* include codes from system IneraDeregistrationReasonCodeSystem
