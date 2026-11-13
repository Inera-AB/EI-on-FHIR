// Examples use the test personnummer 191212121212 and made-up HSA-ids.

Instance: EngagemangspostAktuell
InstanceOf: IneraEngagement
Title: "Aktuell engagemangspost"
Description: "En engagemangspost i tjänstedomänen riv:clinicalprocess:healthcond:description, där vårdgivarens HSA-id är både logisk adress och personuppgiftsansvarig."
Usage: #example
* meta.lastUpdated = "2026-11-02T14:32:10+01:00"
* extension[logicalAddress].valueIdentifier.value = "SE0000000000-VG01"
* extension[sourceSystem].valueIdentifier.value = "SE0000000000-SYS1"
* extension[mostRecentContent].valueDateTime = "2026-11-02T14:30:00+01:00"
* extension[owner].valueIdentifier.value = "SE0000000000-EI00"
* identifier.value = "7f3c2a10-5b1e-4c8e-9f7a-2d6b8e4a1c33"
* status = #current
* type = $service-domain#riv:clinicalprocess:healthcond:description
* category = $engagement-category#voo
* subject.identifier.system = $personnummer
* subject.identifier.value = "191212121212"
* date = "2025-03-11T09:15:00+01:00"
* custodian.identifier.value = "SE0000000000-VG01"
* content.attachment.contentType = #application/xml

Instance: EngagemangspostKallsystemSomPuA
InstanceOf: IneraEngagement
Title: "Engagemangspost med källsystemet som personuppgiftsansvarig"
Description: "En engagemangspost där dataController är källsystemets HSA-id, som EI har godtagit sedan migreringen från NPÖ:s index. Vårdgivaren går inte att läsa ut ur custodian."
Usage: #example
* meta.lastUpdated = "2026-10-28T08:01:44+01:00"
* extension[logicalAddress].valueIdentifier.value = "SE0000000000-VE02"
* extension[sourceSystem].valueIdentifier.value = "SE0000000000-SYS2"
* extension[owner].valueIdentifier.value = "SE0000000000-EI00"
* identifier.value = "BOI-2024-000118"
* status = #current
* type = $service-domain#riv:clinicalprocess:activityprescription:actoutcome
* subject.identifier.system = $personnummer
* subject.identifier.value = "191212121212"
* date = "2024-06-03T10:20:00+02:00"
* custodian.identifier.value = "SE0000000000-SYS2"
* content.attachment.contentType = #application/xml

Instance: EngagemangspostBorttagen
InstanceOf: IneraEngagement
Title: "Borttagen engagemangspost"
Description: "En post som har tagits bort ur EI. Den visas med status superseded under borttagsloggens lagringstid, så att synken till eHM:s patientindex ser borttaget."
Usage: #example
* meta.lastUpdated = "2026-11-05T16:45:02+01:00"
* extension[logicalAddress].valueIdentifier.value = "SE0000000000-VG03"
* extension[sourceSystem].valueIdentifier.value = "SE0000000000-SYS3"
* extension[owner].valueIdentifier.value = "SE0000000000-EI00"
* identifier.value = "a91d4e77-0c2f-4b19-8d55-3e6f0b7c2a90"
* status = #superseded
* type = $service-domain#riv:clinicalprocess:healthcond:description
* category = $engagement-category#voo
* subject.identifier.system = $personnummer
* subject.identifier.value = "191212121212"
* date = "2023-09-19T13:05:00+02:00"
* custodian.identifier.value = "SE0000000000-VG03"
* content.attachment.contentType = #application/xml

Instance: SokresultatForPatient
InstanceOf: Bundle
Title: "Sökresultat för en patient"
Description: "Svar på GET [base]/DocumentReference?subject:identifier=http://electronichealth.se/identifier/personnummer|191212121212. Den borttagna posten kommer inte med, eftersom sökningen inte anger status."
Usage: #example
* type = #searchset
* total = 2
* link[0].relation = "self"
* link[0].url = "https://ei.example.org/fhir/DocumentReference?subject:identifier=http://electronichealth.se/identifier/personnummer|191212121212"
* entry[0].fullUrl = "https://ei.example.org/fhir/DocumentReference/EngagemangspostAktuell"
* entry[0].resource = EngagemangspostAktuell
* entry[0].search.mode = #match
* entry[1].fullUrl = "https://ei.example.org/fhir/DocumentReference/EngagemangspostKallsystemSomPuA"
* entry[1].resource = EngagemangspostKallsystemSomPuA
* entry[1].search.mode = #match
