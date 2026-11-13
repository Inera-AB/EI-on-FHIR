// Fields of an EI engagement post that DocumentReference has no element for.

Extension: LogicalAddress
Id: LogicalAddress
Title: "Logisk adress"
Description: "Den logiska adress som konsumenten anger när den anropar ett tjänstekontrakt i postens tjänstedomän via tjänsteplattformen (logicalAddress i EI). Ett HSA-id, oftast vårdgivarens eller vårdenhetens."
* insert IneraMetadata(LogicalAddress)
* ^context.type = #element
* ^context.expression = "DocumentReference"
* value[x] only Identifier
* valueIdentifier 1..1
* valueIdentifier.system 1..1
* valueIdentifier.system = $hsaid
* valueIdentifier.value 1..1

Extension: SourceSystem
Id: SourceSystem
Title: "Källsystem"
Description: "Det system som har informationen och har registrerat posten i EI (sourceSystem). Ett HSA-id."
* insert IneraMetadata(SourceSystem)
* ^context.type = #element
* ^context.expression = "DocumentReference"
* value[x] only Identifier
* valueIdentifier 1..1
* valueIdentifier.system 1..1
* valueIdentifier.system = $hsaid
* valueIdentifier.value 1..1

Extension: MostRecentContent
Id: MostRecentContent
Title: "Senaste innehåll"
Description: "När informationen hos källsystemet senast ändrades, enligt källsystemet (mostRecentContent i EI). Skiljer sig från meta.lastUpdated, som anger när posten senast ändrades i EI."
* insert IneraMetadata(MostRecentContent)
* ^context.type = #element
* ^context.expression = "DocumentReference"
* value[x] only dateTime
* valueDateTime 1..1

Extension: Owner
Id: Owner
Title: "Ägare"
Description: "Den EI-instans som äger posten (owner i EI). Ett HSA-id."
* insert IneraMetadata(Owner)
* ^context.type = #element
* ^context.expression = "DocumentReference"
* value[x] only Identifier
* valueIdentifier 1..1
* valueIdentifier.system 1..1
* valueIdentifier.system = $hsaid
* valueIdentifier.value 1..1
