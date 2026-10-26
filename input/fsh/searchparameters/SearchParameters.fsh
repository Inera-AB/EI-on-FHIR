Instance: EpisodeOfCare-most-recent-content
InstanceOf: SearchParameter
Usage: #definition
Title: "Sök på senaste innehåll"
* insert IneraInstanceMetadata
* url = "https://fhir.inera.se/ig/engagementindex/SearchParameter/EpisodeOfCare-most-recent-content"
* name = "MostRecentContent"
* description = "Filtrerar indexposter på när innehållet i källsystemet senast ändrades (extension mostRecentContent). Ersätter tidsfiltret i FindContent."
* code = #most-recent-content
* base = #EpisodeOfCare
* type = #date
* expression = "EpisodeOfCare.extension('https://fhir.inera.se/ig/engagementindex/StructureDefinition/MostRecentContent').value"
* xpathUsage = #normal
* comparator[0] = #eq
* comparator[+] = #gt
* comparator[+] = #ge
* comparator[+] = #lt
* comparator[+] = #le

Instance: EpisodeOfCare-source-endpoint
InstanceOf: SearchParameter
Usage: #definition
Title: "Sök på källsystemets endpoint"
* insert IneraInstanceMetadata
* url = "https://fhir.inera.se/ig/engagementindex/SearchParameter/EpisodeOfCare-source-endpoint"
* name = "SourceEndpoint"
* description = "Källsystemets endpoint (extension sourceEndpoint). Används främst med _include=EpisodeOfCare:source-endpoint, så att en sökning returnerar både indexposterna och var informationen kan hämtas."
* code = #source-endpoint
* base = #EpisodeOfCare
* type = #reference
* target = #Endpoint
* expression = "EpisodeOfCare.extension('https://fhir.inera.se/ig/engagementindex/StructureDefinition/SourceEndpoint').value"
* xpathUsage = #normal

Instance: EpisodeOfCare-care-unit
InstanceOf: SearchParameter
Usage: #definition
Title: "Sök på vårdenhet"
* insert IneraInstanceMetadata
* url = "https://fhir.inera.se/ig/engagementindex/SearchParameter/EpisodeOfCare-care-unit"
* name = "CareUnit"
* description = "Vårdenhetens HSA-id (extension careUnit)."
* code = #care-unit
* base = #EpisodeOfCare
* type = #token
* expression = "EpisodeOfCare.extension('https://fhir.inera.se/ig/engagementindex/StructureDefinition/CareUnit').value"
* xpathUsage = #normal

Instance: EpisodeOfCare-content-profile
InstanceOf: SearchParameter
Usage: #definition
Title: "Sök på innehållsprofil"
* insert IneraInstanceMetadata
* url = "https://fhir.inera.se/ig/engagementindex/SearchParameter/EpisodeOfCare-content-profile"
* name = "ContentProfile"
* description = "Profil eller resurstyp som källsystemet exponerar informationen med (extension contentProfile). Lövnivån i kodverket för informationsmängder."
* code = #content-profile
* base = #EpisodeOfCare
* type = #uri
* expression = "EpisodeOfCare.extension('https://fhir.inera.se/ig/engagementindex/StructureDefinition/ContentProfile').value"
* xpathUsage = #normal
