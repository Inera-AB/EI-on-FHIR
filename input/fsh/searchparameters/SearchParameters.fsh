Instance: DocumentReference-content-last-updated
InstanceOf: SearchParameter
Usage: #definition
Title: "Sök på innehållets senaste ändring"
* insert IneraInstanceMetadata
* url = "https://fhir.inera.se/ig/engagementindex/SearchParameter/DocumentReference-content-last-updated"
* name = "ContentLastUpdated"
* description = "Filtrerar indexposter på när det kliniska innehållet i källsystemet senast ändrades (extension contentLastUpdated). Ersätter tidsfiltret i FindContent."
* code = #content-last-updated
* base = #DocumentReference
* type = #date
* expression = "DocumentReference.extension('https://fhir.inera.se/ig/engagementindex/StructureDefinition/ContentLastUpdated').value"
* processingMode = #normal
* comparator[0] = #eq
* comparator[+] = #gt
* comparator[+] = #ge
* comparator[+] = #lt
* comparator[+] = #le

Instance: DocumentReference-source-endpoint
InstanceOf: SearchParameter
Usage: #definition
Title: "Sök på producentens endpoint"
* insert IneraInstanceMetadata
* url = "https://fhir.inera.se/ig/engagementindex/SearchParameter/DocumentReference-source-endpoint"
* name = "SourceEndpoint"
* description = "Producentens endpoint i tjänstekatalogen (extension sourceEndpoint)."
* code = #source-endpoint
* base = #DocumentReference
* type = #reference
* target = #Endpoint
* expression = "DocumentReference.extension('https://fhir.inera.se/ig/engagementindex/StructureDefinition/SourceEndpoint').value"
* processingMode = #normal
