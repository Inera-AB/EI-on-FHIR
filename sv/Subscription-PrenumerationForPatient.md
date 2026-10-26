# Prenumeration på en patients indexposter - FHIR-baserat engagemangsindex (FHIR-EI) v0.1.0

## Exempel Subscription: Prenumeration på en patients indexposter

Profil: [Prenumeration på indexposter (FHIR-EI)](StructureDefinition-IneraIndexSubscription.md)

**status**: Requested

**topic**: [Indexpost ändrad](SubscriptionTopic-indexpost-andrad.md)

**reason**: Visa aktuell översikt över patientens information

> **filterBy****resourceType**: [http://hl7.org/fhir/StructureDefinition/DocumentReference](http://hl7.org/fhir/R5/documentreference.html)**filterParameter**: patient**modifier**: Identifier**value**: http://electronichealth.se/identifier/personnummer|191212121212

> **filterBy****resourceType**: [http://hl7.org/fhir/StructureDefinition/DocumentReference](http://hl7.org/fhir/R5/documentreference.html)**filterParameter**: type**value**: https://fhir.inera.se/ig/engagementindex/CodeSystem/IneraServiceDomainCodeSystem|riv:clinicalprocess:healthcond:description

**channelType**: [SubscriptionChannel Type Codes: rest-hook](http://terminology.hl7.org/7.4.0/CodeSystem-subscription-channel-type.html#subscription-channel-type-rest-hook) (Rest Hook)

**endpoint**: [https://konsument.example.org/fhir/notifieringar](https://konsument.example.org/fhir/notifieringar)

**heartbeatPeriod**: 3600

**contentType**: application/fhir+json



## Resource Content

```json
{
  "resourceType" : "Subscription",
  "id" : "PrenumerationForPatient",
  "meta" : {
    "profile" : ["https://fhir.inera.se/ig/engagementindex/StructureDefinition/IneraIndexSubscription"]
  },
  "status" : "requested",
  "topic" : "https://fhir.inera.se/ig/engagementindex/SubscriptionTopic/indexpost-andrad",
  "reason" : "Visa aktuell översikt över patientens information",
  "filterBy" : [{
    "resourceType" : "http://hl7.org/fhir/StructureDefinition/DocumentReference",
    "filterParameter" : "patient",
    "modifier" : "identifier",
    "value" : "http://electronichealth.se/identifier/personnummer|191212121212"
  },
  {
    "resourceType" : "http://hl7.org/fhir/StructureDefinition/DocumentReference",
    "filterParameter" : "type",
    "value" : "https://fhir.inera.se/ig/engagementindex/CodeSystem/IneraServiceDomainCodeSystem|riv:clinicalprocess:healthcond:description"
  }],
  "channelType" : {
    "system" : "http://terminology.hl7.org/CodeSystem/subscription-channel-type",
    "code" : "rest-hook"
  },
  "endpoint" : "https://konsument.example.org/fhir/notifieringar",
  "heartbeatPeriod" : 3600,
  "contentType" : "application/fhir+json"
}

```
