# Resource FHIR-baserat engagemangsindex (FHIR-EI)



## Resource Content

```json
{
  "resourceType" : "ImplementationGuide",
  "id" : "inera.ei.engagementindex",
  "language" : "sv",
  "url" : "https://fhir.inera.se/ig/engagementindex/ImplementationGuide/inera.ei.engagementindex",
  "version" : "0.1.0",
  "name" : "IneraEngagementIndex",
  "title" : "FHIR-baserat engagemangsindex (FHIR-EI)",
  "status" : "draft",
  "date" : "2026-10-26T22:11:12+00:00",
  "publisher" : "Inera AB",
  "contact" : [{
    "name" : "Inera AB",
    "telecom" : [{
      "system" : "url",
      "value" : "https://www.inera.se"
    }]
  }],
  "description" : "Indexprofil, API och händelsemodell för FHIR-EI, ett index över var det finns information om en patient, vilka informationsmängder som finns där och när de senast uppdaterades.",
  "jurisdiction" : [{
    "coding" : [{
      "system" : "urn:iso:std:iso:3166",
      "code" : "SE",
      "display" : "Sweden"
    }]
  }],
  "packageId" : "inera.ei.engagementindex",
  "fhirVersion" : ["5.0.0"],
  "dependsOn" : [{
    "id" : "hl7tx",
    "extension" : [{
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/implementationguide-dependency-comment",
      "valueMarkdown" : "Automatically added as a dependency - all IGs depend on HL7 Terminology"
    }],
    "uri" : "http://terminology.hl7.org/ImplementationGuide/hl7.terminology",
    "packageId" : "hl7.terminology.r5",
    "version" : "7.4.0"
  },
  {
    "id" : "hl7ext",
    "extension" : [{
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/implementationguide-dependency-comment",
      "valueMarkdown" : "Automatically added as a dependency - all IGs depend on the HL7 Extension Pack"
    }],
    "uri" : "http://hl7.org/fhir/extensions/ImplementationGuide/hl7.fhir.uv.extensions",
    "packageId" : "hl7.fhir.uv.extensions.r5",
    "version" : "5.3.0"
  }],
  "definition" : {
    "extension" : [{
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-internal-dependency",
      "valueCode" : "hl7.fhir.uv.tools.r5#1.3.0"
    }],
    "resource" : [{
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "CapabilityStatement"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "CapabilityStatement-IneraIndexServer.html"
      }],
      "reference" : {
        "reference" : "CapabilityStatement/IneraIndexServer"
      },
      "name" : "FHIR-EI server",
      "description" : "Krav på FHIR-EI som server: sökning, registrering och avregistrering, prenumeration, inkrementell avstämning och massuttag av indexposter.",
      "isExample" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "StructureDefinition:resource"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "StructureDefinition-IneraIndexEntry.html"
      }],
      "reference" : {
        "reference" : "StructureDefinition/IneraIndexEntry"
      },
      "name" : "Indexpost (FHIR-EI)",
      "description" : "Gemensam indexpost. Anger att en producent via en endpoint har information om en patient inom en tjänst.\nDet finns en post per patient × endpoint × tjänst. Posten kan bära flera informationsmängder, och tidpunkten\nför senaste ändring av innehållet gäller hela posten.\n\nPosten är en pekare, inte innehåll. Varje tjänst publicerar sin tillämpning som en profil av denna profil, i\ntjänstens IG, och bestämmer där om informationsmängder och tidpunkt för senaste ändring är obligatoriska.",
      "isExample" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "DocumentReference"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "DocumentReference-IndexpostEjForPatient.html"
      }],
      "reference" : {
        "reference" : "DocumentReference/IndexpostEjForPatient"
      },
      "name" : "Indexpost som inte visas för patient eller närstående",
      "description" : "Producenten har märkt posten med säkerhetsetiketten NOPAT. FHIR-EI lämnar inte ut den vid patientens direktåtkomst eller till ombud och vårdnadshavare, men vid sammanhållen journalföring prövas den som vanligt.",
      "isExample" : true,
      "profile" : ["https://fhir.inera.se/ig/engagementindex/StructureDefinition/IneraIndexEntry"]
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "DocumentReference"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "DocumentReference-IndexpostFranAdapter.html"
      }],
      "reference" : {
        "reference" : "DocumentReference/IndexpostFranAdapter"
      },
      "name" : "Indexpost speglad av övergångsadaptern",
      "description" : "Adaptern har slagit ihop dagens engagemangsposter för samma patient, logiska adress och tjänstedomän till en indexpost, med dagens kategori som informationsmängd. Endpointen är tjänsteplattformens endpoint för tjänstekontraktet, enligt adapterns adressregister, och den logiska adressen anges separat. Registrerande producent är adaptern, och källsystemet behålls.",
      "isExample" : true,
      "profile" : ["https://fhir.inera.se/ig/engagementindex/StructureDefinition/IneraIndexEntry"]
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "SubscriptionTopic"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "SubscriptionTopic-indexpost-andrad.html"
      }],
      "reference" : {
        "reference" : "SubscriptionTopic/indexpost-andrad"
      },
      "name" : "Indexpost ändrad",
      "description" : "Triggar när en indexpost skapas, uppdateras eller avregistreras. Avregistrering är en uppdatering till status superseded eller entered-in-error, inte en radering.",
      "isExample" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "DocumentReference"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "DocumentReference-IndexpostIndragen.html"
      }],
      "reference" : {
        "reference" : "DocumentReference/IndexpostIndragen"
      },
      "name" : "Indragen indexpost",
      "description" : "Producenten har dragit tillbaka posten eftersom engagemanget är avslutat. Posten ligger kvar som gravsten under gravstenarnas lagringstid och syns vid avstämning och export, men inte i en standardsökning.",
      "isExample" : true,
      "profile" : ["https://fhir.inera.se/ig/engagementindex/StructureDefinition/IneraIndexEntry"]
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "StructureDefinition:extension"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "StructureDefinition-ContentLastUpdated.html"
      }],
      "reference" : {
        "reference" : "StructureDefinition/ContentLastUpdated"
      },
      "name" : "Innehållets senaste ändring",
      "description" : "När det kliniska innehållet i källsystemet senast ändrades, enligt producenten. Gäller hela posten. Hålls isär från meta.lastUpdated, som anger när indexposten ändrades i FHIR-EI. Motsvarar mostRecentContent i dagens engagemangsindex.",
      "isExample" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "ValueSet"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "ValueSet-IneraEngagementCategoryValueSet.html"
      }],
      "reference" : {
        "reference" : "ValueSet/IneraEngagementCategoryValueSet"
      },
      "name" : "Kategorier inom tjänstedomän",
      "description" : "Alla kategorier i kodverket för kategorier inom tjänstedomän.",
      "isExample" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "CodeSystem"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "CodeSystem-IneraEngagementCategoryCodeSystem.html"
      }],
      "reference" : {
        "reference" : "CodeSystem/IneraEngagementCategoryCodeSystem"
      },
      "name" : "Kodsystem för kategorier inom tjänstedomän",
      "description" : "Kategorier inom en tjänstedomän, som anger informationsmängd i FHIR-EI under övergången till profil-canonicals. Motsvarar categorization i dagens engagemangsindex. Utdrag; den fullständiga förteckningen förvaltas tillsammans med tjänstedomänerna.",
      "isExample" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "CodeSystem"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "CodeSystem-IneraDeregistrationReasonCodeSystem.html"
      }],
      "reference" : {
        "reference" : "CodeSystem/IneraDeregistrationReasonCodeSystem"
      },
      "name" : "Kodsystem för orsaker till avregistrering",
      "description" : "Varför en indexpost avregistreras. Orsaken avgör hur mottagare, till exempel ett tunt index, ska hantera avregistreringen.",
      "isExample" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "CodeSystem"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "CodeSystem-IneraIndexRegistrationStatusCodeSystem.html"
      }],
      "reference" : {
        "reference" : "CodeSystem/IneraIndexRegistrationStatusCodeSystem"
      },
      "name" : "Kodsystem för registreringsstatus",
      "description" : "En indexposts livscykeltillstånd. Varje kod motsvarar ett värde i DocumentReference.status.",
      "isExample" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "CodeSystem"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "CodeSystem-IneraServiceDomainCodeSystem.html"
      }],
      "reference" : {
        "reference" : "CodeSystem/IneraServiceDomainCodeSystem"
      },
      "name" : "Kodsystem för tjänstedomäner",
      "description" : "Tjänstedomäner, som anger tjänst i FHIR-EI under övergången till IG-canonicals. Utdrag; den fullständiga förteckningen förvaltas i Ineras förteckning över tjänstedomäner.",
      "isExample" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "StructureDefinition:extension"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "StructureDefinition-SourceSystem.html"
      }],
      "reference" : {
        "reference" : "StructureDefinition/SourceSystem"
      },
      "name" : "Källsystem",
      "description" : "Källsystemet enligt dagens engagemangsindex, som HSA-id. Sätts av övergångsadaptern, eftersom registrerande producent då är adaptern och inte källsystemet. En post kan ha flera källsystem när adaptern slår ihop engagemangsposter. Motsvarar sourceSystem i dagens engagemangsindex.",
      "isExample" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "StructureDefinition:extension"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "StructureDefinition-LogicalAddress.html"
      }],
      "reference" : {
        "reference" : "StructureDefinition/LogicalAddress"
      },
      "name" : "Logisk adress",
      "description" : "Den logiska adress som konsumenten anger när den hämtar informationen via tjänsteplattformen, som HSA-id. Krävs när endpointen adresseras med logisk adress, som för RIV-TA-källor; annars utelämnas den. I tjänstekatalogen är den logiska adressen en organisations HSA-id. Motsvarar logicalAddress i dagens engagemangsindex.",
      "isExample" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "StructureDefinition:extension"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "StructureDefinition-DeregistrationReason.html"
      }],
      "reference" : {
        "reference" : "StructureDefinition/DeregistrationReason"
      },
      "name" : "Orsak till avregistrering",
      "description" : "Varför posten avregistrerades: felregistrering, avslutat engagemang, gallring eller avregistrering via övergångsadaptern. Finns om och endast om posten inte är registrerad.",
      "isExample" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "ValueSet"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "ValueSet-IneraDeregistrationReasonValueSet.html"
      }],
      "reference" : {
        "reference" : "ValueSet/IneraDeregistrationReasonValueSet"
      },
      "name" : "Orsaker till avregistrering",
      "description" : "Alla orsaker till avregistrering av en indexpost.",
      "isExample" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "Subscription"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "Subscription-PrenumerationForPatient.html"
      }],
      "reference" : {
        "reference" : "Subscription/PrenumerationForPatient"
      },
      "name" : "Prenumeration på en patients indexposter",
      "description" : "En konsument prenumererar på ändrade indexposter för en patient inom en tjänst.",
      "isExample" : true,
      "profile" : ["https://fhir.inera.se/ig/engagementindex/StructureDefinition/IneraIndexSubscription"]
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "StructureDefinition:resource"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "StructureDefinition-IneraIndexSubscription.html"
      }],
      "reference" : {
        "reference" : "StructureDefinition/IneraIndexSubscription"
      },
      "name" : "Prenumeration på indexposter (FHIR-EI)",
      "description" : "En konsuments prenumeration på ändrade indexposter, på topic `indexpost-andrad`. Prenumerationen kan\nfiltreras på patient, tjänst och vårdgivare. Notiser bär bara id för ändrade poster, så att de inte bär\nmer patientinformation än nödvändigt.",
      "isExample" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "StructureDefinition:extension"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "StructureDefinition-SourceEndpoint.html"
      }],
      "reference" : {
        "reference" : "StructureDefinition/SourceEndpoint"
      },
      "name" : "Producentens endpoint",
      "description" : "Producentens åtkomstpunkt, som Endpoint-resurs i tjänstekatalogen. Katalogen är auktoritativ för endpointens egenskaper. Exakt en per indexpost. Motsvarar logicalAddress i dagens engagemangsindex.",
      "isExample" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "DocumentReference"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "DocumentReference-IndexpostFhirProducent.html"
      }],
      "reference" : {
        "reference" : "DocumentReference/IndexpostFhirProducent"
      },
      "name" : "Registrerad indexpost från en FHIR-producent",
      "description" : "Journalsystem A har vård- och omsorgsdokumentation om patienten. Tjänsten anges med både tjänstedomän och IG-canonical, och informationsmängden med både kategori och profil-canonical.",
      "isExample" : true,
      "profile" : ["https://fhir.inera.se/ig/engagementindex/StructureDefinition/IneraIndexEntry"]
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "StructureDefinition:extension"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "StructureDefinition-RegisteringProducer.html"
      }],
      "reference" : {
        "reference" : "StructureDefinition/RegisteringProducer"
      },
      "name" : "Registrerande producent",
      "description" : "Producentens identitet: den Endpoint i tjänstekatalogen som den autentiserade klienten är bunden till, som absolut referens. För en direktansluten producent är det samma endpoint som i sourceEndpoint. Referensen är också producentens namnrymd i identifier.system. FHIR-EI kontrollerar värdet mot den autentiserade klienten. Får inte ändras på en befintlig post. Motsvarar owner i dagens engagemangsindex.",
      "isExample" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "Bundle"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "Bundle-RegistreringTransaction.html"
      }],
      "reference" : {
        "reference" : "Bundle/RegistreringTransaction"
      },
      "name" : "Registrering och avregistrering i en transaction",
      "description" : "En producent registrerar en post och avregistrerar en felregistrerad post i samma transaction. Bundlen registreras helt eller inte alls.",
      "isExample" : true
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "StructureDefinition:extension"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "StructureDefinition-RegistrationStatus.html"
      }],
      "reference" : {
        "reference" : "StructureDefinition/RegistrationStatus"
      },
      "name" : "Registreringsstatus",
      "description" : "Postens exakta livscykeltillstånd: registrerad, indragen eller felregistrerad. Bär den semantik som DocumentReference.status inte kan uttrycka, eftersom basbindningen inte kan utökas.",
      "isExample" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "ValueSet"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "ValueSet-IneraIndexRegistrationStatusValueSet.html"
      }],
      "reference" : {
        "reference" : "ValueSet/IneraIndexRegistrationStatusValueSet"
      },
      "name" : "Registreringsstatus för indexposter",
      "description" : "Alla livscykeltillstånd för en indexpost.",
      "isExample" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "SearchParameter"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "SearchParameter-DocumentReference-content-last-updated.html"
      }],
      "reference" : {
        "reference" : "SearchParameter/DocumentReference-content-last-updated"
      },
      "name" : "Sök på innehållets senaste ändring",
      "description" : "Filtrerar indexposter på när det kliniska innehållet i källsystemet senast ändrades (extension contentLastUpdated). Ersätter tidsfiltret i FindContent.",
      "isExample" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "SearchParameter"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "SearchParameter-DocumentReference-source-endpoint.html"
      }],
      "reference" : {
        "reference" : "SearchParameter/DocumentReference-source-endpoint"
      },
      "name" : "Sök på producentens endpoint",
      "description" : "Producentens endpoint i tjänstekatalogen (extension sourceEndpoint).",
      "isExample" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "Bundle"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "Bundle-SokresultatForPatient.html"
      }],
      "reference" : {
        "reference" : "Bundle/SokresultatForPatient"
      },
      "name" : "Sökresultat för en patient",
      "description" : "Svar på en konsuments sökning efter en patients indexposter. Utan status-parameter returneras bara registrerade poster, så den indragna posten finns inte med.",
      "isExample" : true
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "ValueSet"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "ValueSet-IneraServiceDomainValueSet.html"
      }],
      "reference" : {
        "reference" : "ValueSet/IneraServiceDomainValueSet"
      },
      "name" : "Tjänstedomäner",
      "description" : "Alla tjänstedomäner i Ineras kodverk för tjänstedomäner.",
      "isExample" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "StructureDefinition:extension"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "StructureDefinition-CareUnit.html"
      }],
      "reference" : {
        "reference" : "StructureDefinition/CareUnit"
      },
      "name" : "Vårdenhet",
      "description" : "Vårdenheten där informationen finns, som HSA-id. Motsvarar careUnitId i dagens engagemangsindex.",
      "isExample" : false
    }],
    "page" : {
      "sourceUrl" : "toc.html",
      "name" : "toc.html",
      "title" : "Table of Contents",
      "generation" : "html",
      "page" : [{
        "sourceUrl" : "index.html",
        "name" : "index.html",
        "title" : "Hem",
        "generation" : "markdown"
      },
      {
        "sourceUrl" : "introduction.html",
        "name" : "introduction.html",
        "title" : "Inledning",
        "generation" : "markdown"
      },
      {
        "sourceUrl" : "information-basis.html",
        "name" : "information-basis.html",
        "title" : "Informationsunderlag",
        "generation" : "markdown"
      },
      {
        "sourceUrl" : "use-cases.html",
        "name" : "use-cases.html",
        "title" : "Användningsfall",
        "generation" : "markdown"
      },
      {
        "sourceUrl" : "roles-and-responsibilities.html",
        "name" : "roles-and-responsibilities.html",
        "title" : "Roller och ansvar",
        "generation" : "markdown"
      },
      {
        "sourceUrl" : "information-model.html",
        "name" : "information-model.html",
        "title" : "Indexposten",
        "generation" : "markdown"
      },
      {
        "sourceUrl" : "information-sets.html",
        "name" : "information-sets.html",
        "title" : "Kodverk för tjänster och informationsmängder",
        "generation" : "markdown"
      },
      {
        "sourceUrl" : "event-model.html",
        "name" : "event-model.html",
        "title" : "Händelsemodell och övergång",
        "generation" : "markdown"
      },
      {
        "sourceUrl" : "ehm-coexistence.html",
        "name" : "ehm-coexistence.html",
        "title" : "Samexistens med eHM:s patientindex",
        "generation" : "markdown"
      },
      {
        "sourceUrl" : "mappings.html",
        "name" : "mappings.html",
        "title" : "Mappning till profiler",
        "generation" : "markdown"
      },
      {
        "sourceUrl" : "rest-interactions.html",
        "name" : "rest-interactions.html",
        "title" : "REST-interaktioner och sökparametrar",
        "generation" : "markdown"
      },
      {
        "sourceUrl" : "subscriptions.html",
        "name" : "subscriptions.html",
        "title" : "Prenumeration",
        "generation" : "markdown"
      },
      {
        "sourceUrl" : "producer-support.html",
        "name" : "producer-support.html",
        "title" : "Stöd för producenter",
        "generation" : "markdown"
      },
      {
        "sourceUrl" : "expected-responses.html",
        "name" : "expected-responses.html",
        "title" : "Förväntade svar",
        "generation" : "markdown"
      },
      {
        "sourceUrl" : "capabilitystatement.html",
        "name" : "capabilitystatement.html",
        "title" : "CapabilityStatement",
        "generation" : "markdown"
      },
      {
        "sourceUrl" : "error-handling.html",
        "name" : "error-handling.html",
        "title" : "Felhantering",
        "generation" : "markdown"
      },
      {
        "sourceUrl" : "security.html",
        "name" : "security.html",
        "title" : "Spärr, loggning och behörighet",
        "generation" : "markdown"
      },
      {
        "sourceUrl" : "testing.html",
        "name" : "testing.html",
        "title" : "Testning och validering",
        "generation" : "markdown"
      },
      {
        "sourceUrl" : "about.html",
        "name" : "about.html",
        "title" : "Om",
        "generation" : "markdown"
      },
      {
        "sourceUrl" : "open-issues.html",
        "name" : "open-issues.html",
        "title" : "Öppna frågor",
        "generation" : "markdown"
      },
      {
        "sourceUrl" : "downloads.html",
        "name" : "downloads.html",
        "title" : "Nedladdningar",
        "generation" : "markdown"
      },
      {
        "sourceUrl" : "version-history.html",
        "name" : "version-history.html",
        "title" : "Versionshistorik",
        "generation" : "markdown"
      }]
    },
    "parameter" : [{
      "code" : {
        "system" : "http://hl7.org/fhir/tools/CodeSystem/ig-parameters",
        "code" : "copyrightyear"
      },
      "value" : "2026+"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/tools/CodeSystem/ig-parameters",
        "code" : "releaselabel"
      },
      "value" : "ci-build"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/tools/CodeSystem/ig-parameters",
        "code" : "show-inherited-invariants"
      },
      "value" : "false"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/tools/CodeSystem/ig-parameters",
        "code" : "usage-stats-opt-out"
      },
      "value" : "true"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/tools/CodeSystem/ig-parameters",
        "code" : "i18n-default-lang"
      },
      "value" : "sv"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/tools/CodeSystem/ig-parameters",
        "code" : "autoload-resources"
      },
      "value" : "true"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/guide-parameter-code",
        "code" : "path-resource"
      },
      "value" : "input/capabilities"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/guide-parameter-code",
        "code" : "path-resource"
      },
      "value" : "input/examples"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/guide-parameter-code",
        "code" : "path-resource"
      },
      "value" : "input/extensions"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/guide-parameter-code",
        "code" : "path-resource"
      },
      "value" : "input/models"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/guide-parameter-code",
        "code" : "path-resource"
      },
      "value" : "input/operations"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/guide-parameter-code",
        "code" : "path-resource"
      },
      "value" : "input/profiles"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/guide-parameter-code",
        "code" : "path-resource"
      },
      "value" : "input/resources"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/guide-parameter-code",
        "code" : "path-resource"
      },
      "value" : "input/vocabulary"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/guide-parameter-code",
        "code" : "path-resource"
      },
      "value" : "input/maps"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/guide-parameter-code",
        "code" : "path-resource"
      },
      "value" : "input/testing"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/guide-parameter-code",
        "code" : "path-resource"
      },
      "value" : "input/history"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/guide-parameter-code",
        "code" : "path-resource"
      },
      "value" : "fsh-generated/resources"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/guide-parameter-code",
        "code" : "path-pages"
      },
      "value" : "template/config"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/guide-parameter-code",
        "code" : "path-pages"
      },
      "value" : "input/assets"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/guide-parameter-code",
        "code" : "path-pages"
      },
      "value" : "input/images"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/tools/CodeSystem/ig-parameters",
        "code" : "path-liquid-template"
      },
      "value" : "template/liquid"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/tools/CodeSystem/ig-parameters",
        "code" : "path-liquid-template"
      },
      "value" : "input/liquid"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/tools/CodeSystem/ig-parameters",
        "code" : "path-qa"
      },
      "value" : "temp/qa"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/tools/CodeSystem/ig-parameters",
        "code" : "path-temp"
      },
      "value" : "temp/pages"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/tools/CodeSystem/ig-parameters",
        "code" : "path-output"
      },
      "value" : "output"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/guide-parameter-code",
        "code" : "path-tx-cache"
      },
      "value" : "input-cache/txcache"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/tools/CodeSystem/ig-parameters",
        "code" : "path-suppressed-warnings"
      },
      "value" : "input/ignoreWarnings.txt"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/tools/CodeSystem/ig-parameters",
        "code" : "path-history"
      },
      "value" : "https://fhir.inera.se/ig/engagementindex/history.html"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/tools/CodeSystem/ig-parameters",
        "code" : "template-html"
      },
      "value" : "template-page.html"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/tools/CodeSystem/ig-parameters",
        "code" : "template-md"
      },
      "value" : "template-page-md.html"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/tools/CodeSystem/ig-parameters",
        "code" : "apply-contact"
      },
      "value" : "true"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/tools/CodeSystem/ig-parameters",
        "code" : "apply-context"
      },
      "value" : "true"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/tools/CodeSystem/ig-parameters",
        "code" : "apply-copyright"
      },
      "value" : "true"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/tools/CodeSystem/ig-parameters",
        "code" : "apply-jurisdiction"
      },
      "value" : "true"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/tools/CodeSystem/ig-parameters",
        "code" : "apply-license"
      },
      "value" : "true"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/tools/CodeSystem/ig-parameters",
        "code" : "apply-publisher"
      },
      "value" : "true"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/tools/CodeSystem/ig-parameters",
        "code" : "apply-version"
      },
      "value" : "true"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/tools/CodeSystem/ig-parameters",
        "code" : "apply-wg"
      },
      "value" : "true"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/tools/CodeSystem/ig-parameters",
        "code" : "active-tables"
      },
      "value" : "true"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/tools/CodeSystem/ig-parameters",
        "code" : "fmm-definition"
      },
      "value" : "http://hl7.org/fhir/versions.html#maturity"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/tools/CodeSystem/ig-parameters",
        "code" : "propagate-status"
      },
      "value" : "true"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/tools/CodeSystem/ig-parameters",
        "code" : "excludelogbinaryformat"
      },
      "value" : "true"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/tools/CodeSystem/ig-parameters",
        "code" : "tabbed-snapshots"
      },
      "value" : "true"
    }]
  }
}

```
