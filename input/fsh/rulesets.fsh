// Metadata shared by the IG's StructureDefinitions, CodeSystems and ValueSets.
// The metadata identifier is kept the same as the name/id, per Inera's profiling guidance.
// The version is left out so that it follows the IG version in sushi-config.yaml.
RuleSet: IneraMetadata(id)
* ^status = #draft
* ^identifier.value = "{id}"
// Update on every material change to the artifact.
* ^date = "2026-10-26"
* ^publisher = "Inera AB"
* ^contact.name = "Inera AB"
* ^contact.telecom.system = #url
* ^contact.telecom.value = "https://www.inera.se"
* ^jurisdiction = urn:iso:std:iso:3166#SE "Sweden"

// The same metadata for definitional instances (SearchParameter, CapabilityStatement),
// which have no identifier element in R4.
RuleSet: IneraInstanceMetadata
* status = #draft
* date = "2026-10-26"
* publisher = "Inera AB"
* contact.name = "Inera AB"
* contact.telecom.system = #url
* contact.telecom.value = "https://www.inera.se"
* jurisdiction = urn:iso:std:iso:3166#SE "Sweden"

// CapabilityStatement helpers, inserted under a rest or resource path.
RuleSet: Interaction(code, level)
* interaction[+].code = #{code}
* interaction[=].extension[0].url = $expectation
* interaction[=].extension[0].valueCode = #{level}

RuleSet: SearchParam(name, definition, type, level)
* searchParam[+].name = "{name}"
* searchParam[=].definition = "{definition}"
* searchParam[=].type = #{type}
* searchParam[=].extension[0].url = $expectation
* searchParam[=].extension[0].valueCode = #{level}
