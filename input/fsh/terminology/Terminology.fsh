// Information sets, iteration 1: today's service domains and categories.
// The code systems are fragments: they hold the examples in this IG, while the full lists are
// maintained in Inera's register of service domains.
CodeSystem: IneraServiceDomainCodeSystem
Id: IneraServiceDomainCodeSystem
Title: "Kodsystem för tjänstedomäner"
Description: "Tjänstedomäner som informationsmängd i FHIR-EI. Utdrag; den fullständiga förteckningen förvaltas i Ineras förteckning över tjänstedomäner."
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
Description: "Underkategorier inom en tjänstedomän, motsvarande categorization i dagens engagemangsindex. Utdrag; den fullständiga förteckningen förvaltas tillsammans med tjänstedomänerna."
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

CodeSystem: IneraEngagementIndexIdentifierTypeCodeSystem
Id: IneraEngagementIndexIdentifierTypeCodeSystem
Title: "Kodsystem för typer av identifierare för indexposter"
Description: "Skiljer producentens id för indexposten från identifierare som behålls från dagens engagemangsindex."
* insert IneraMetadata(IneraEngagementIndexIdentifierTypeCodeSystem)
* ^caseSensitive = true
* ^content = #complete
* #source-entry-id "Producentens id" "Producentens id för indexposten. Nyckel för idempotent uppdatering och borttag."
* #clinical-process-interest-id "clinicalProcessInterestId" "Identifierare från dagens engagemangsindex, behålls för spårbarhet under övergången."

CodeSystem: IneraDeletionReasonCodeSystem
Id: IneraDeletionReasonCodeSystem
Title: "Kodsystem för orsaker till borttag av indexpost"
Description: "Varför en indexpost tas bort. Orsaken avgör hur mottagare, till exempel ett tunt index, ska hantera borttaget."
* insert IneraMetadata(IneraDeletionReasonCodeSystem)
* ^caseSensitive = true
* ^content = #complete
* #entered-in-error "Felregistrering" "Posten skulle aldrig ha registrerats."
* #ended "Avslutat engagemang" "Källsystemet håller inte längre information av informationsmängden om patienten hos vårdenheten."
* #purged "Gallring" "Informationen har gallrats i källsystemet."

ValueSet: IneraDeletionReasonValueSet
Id: IneraDeletionReasonValueSet
Title: "Orsaker till borttag av indexpost"
Description: "Alla orsaker till borttag av indexpost."
* insert IneraMetadata(IneraDeletionReasonValueSet)
* include codes from system IneraDeletionReasonCodeSystem

CodeSystem: IneraEndpointConnectionTypeCodeSystem
Id: IneraEndpointConnectionTypeCodeSystem
Title: "Kodsystem för Inera-specifika anslutningstyper"
Description: "Anslutningstyper som saknas i HL7:s kodverk för Endpoint.connectionType."
* insert IneraMetadata(IneraEndpointConnectionTypeCodeSystem)
* ^caseSensitive = true
* ^content = #complete
* #riv-ta "RIV-TA" "Informationen hämtas med RIV-TA-tjänstekontrakt via tjänsteplattformen, adresserad med logisk adress."

ValueSet: IneraEndpointConnectionTypeValueSet
Id: IneraEndpointConnectionTypeValueSet
Title: "Anslutningstyper för källsystem"
Description: "Hur ett källsystem exponerar informationen som en indexpost pekar på."
* insert IneraMetadata(IneraEndpointConnectionTypeValueSet)
* $endpoint-connection-type#hl7-fhir-rest "HL7 FHIR"
* IneraEndpointConnectionTypeCodeSystem#riv-ta "RIV-TA"
