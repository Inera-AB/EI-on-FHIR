// Search parameters on the extensions that DocumentReference has no element for.

Instance: DocumentReference-logical-address
InstanceOf: SearchParameter
Usage: #definition
Title: "Sökparameter logical-address"
* insert IneraInstanceMetadata
* url = "https://fhir.inera.se/ig/engagementindex/SearchParameter/DocumentReference-logical-address"
* name = "LogicalAddress"
* description = "Söker engagemangsposter på logisk adress (extension logicalAddress), till exempel en vårdgivares HSA-id."
* code = #logical-address
* base = #DocumentReference
* type = #token
* expression = "DocumentReference.extension('https://fhir.inera.se/ig/engagementindex/StructureDefinition/LogicalAddress').value.ofType(Identifier)"
* xpathUsage = #normal

Instance: DocumentReference-source-system
InstanceOf: SearchParameter
Usage: #definition
Title: "Sökparameter source-system"
* insert IneraInstanceMetadata
* url = "https://fhir.inera.se/ig/engagementindex/SearchParameter/DocumentReference-source-system"
* name = "SourceSystem"
* description = "Söker engagemangsposter på källsystem (extension sourceSystem)."
* code = #source-system
* base = #DocumentReference
* type = #token
* expression = "DocumentReference.extension('https://fhir.inera.se/ig/engagementindex/StructureDefinition/SourceSystem').value.ofType(Identifier)"
* xpathUsage = #normal
