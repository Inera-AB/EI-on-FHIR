Profile: IneraEngagementIndexSubscription
Parent: $backport-subscription
Id: IneraEngagementIndexSubscription
Title: "Prenumeration på indexposter (FHIR-EI)"
Description: """
En konsuments prenumeration på ändrade indexposter, enligt R4 Subscriptions Backport. Prenumerationen
gäller topic `indexpost-andrad` och kan filtreras på patient, informationsmängd och vårdgivare. Notiser
bär bara id för ändrade poster, så att de inte bär mer patientinformation än nödvändigt.
"""
* insert IneraMetadata(IneraEngagementIndexSubscription)

* criteria = "https://fhir.inera.se/ig/engagementindex/SubscriptionTopic/indexpost-andrad"
* criteria ^short = "Topic indexpost-andrad"
* criteria.extension[filterCriteria] ^short = "Filter på patient, type och organization, t.ex. EpisodeOfCare?patient:identifier=…"

* channel.type MS
* channel.endpoint MS
// id-only: a notification only says that an entry changed; the consumer reads it through the
// same access control as a search, which keeps notifications from leaking blocked information.
* channel.payload.extension[content].valueCode = #id-only
