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
* description = "Övergångsadapterns id för indexposter som den speglar från dagens engagemangsindex. Värdet bildas deterministiskt ur patient, logisk adress och tjänstedomän, som är de fält adaptern slår ihop engagemangsposter på."
* uniqueId.type = #uri
* uniqueId.value = "https://fhir.inera.se/ig/engagementindex/sid/riv-ta-engagement"
* uniqueId.preferred = true
