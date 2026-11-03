// Swedish identifiers
Alias: $personnummer = http://electronichealth.se/identifier/personnummer
Alias: $samordningsnummer = http://electronichealth.se/identifier/samordningsnummer
// HSA-id, as in HL7 Sweden's base profiles and tjänstekatalogen. RIV-TA uses the OID
// 1.2.752.129.2.1.4.1 for the same identifier space; FHIR-EI accepts both, see mappings.html.
Alias: $hsaid = urn:oid:1.2.752.29.4.19
// Swedish organisation number, as in eHM's patient index and tjänstekatalogen
Alias: $orgnr = urn:oid:2.5.4.97

// This IG's code systems, referred to by URL where a slice fixes the system
Alias: $service-domain = https://fhir.inera.se/ig/engagementindex/CodeSystem/IneraServiceDomainCodeSystem
Alias: $engagement-category = https://fhir.inera.se/ig/engagementindex/CodeSystem/IneraEngagementCategoryCodeSystem
Alias: $population-method = https://fhir.inera.se/ig/engagementindex/CodeSystem/IneraIndexPopulationMethodCodeSystem

// FHIR core extensions
Alias: $expectation = http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation
