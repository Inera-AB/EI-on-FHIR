// Identifier systems owned by this IG. Personnummer, samordningsnummer and HSA-id are
// defined elsewhere and are not repeated here.
Instance: RivTaEngagementNamingSystem
InstanceOf: NamingSystem
Usage: #definition
Title: "Identifierare för speglade engagemangsposter"
* name = "RivTaEngagementNamingSystem"
* status = #draft
* kind = #identifier
* date = "2026-10-26"
* publisher = "Inera AB"
* contact.name = "Inera AB"
* contact.telecom.system = #url
* contact.telecom.value = "https://www.inera.se"
* jurisdiction = urn:iso:std:iso:3166#SE "Sweden"
* description = "Producentens id för indexposter som adaptern speglar från dagens engagemangsindex. Värdet bildas deterministiskt ur engagemangspostens nyckelfält."
* uniqueId.type = #uri
* uniqueId.value = "https://fhir.inera.se/ig/engagementindex/sid/riv-ta-engagement"
* uniqueId.preferred = true

Instance: ClinicalProcessInterestIdNamingSystem
InstanceOf: NamingSystem
Usage: #definition
Title: "clinicalProcessInterestId"
* name = "ClinicalProcessInterestIdNamingSystem"
* status = #draft
* kind = #identifier
* date = "2026-10-26"
* publisher = "Inera AB"
* contact.name = "Inera AB"
* contact.telecom.system = #url
* contact.telecom.value = "https://www.inera.se"
* jurisdiction = urn:iso:std:iso:3166#SE "Sweden"
* description = "clinicalProcessInterestId från dagens engagemangsindex, som behålls på indexposten för spårbarhet under övergången."
* uniqueId.type = #uri
* uniqueId.value = "https://fhir.inera.se/ig/engagementindex/sid/clinical-process-interest-id"
* uniqueId.preferred = true
