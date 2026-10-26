# FHIR-baserat engagemangsindex (FHIR-EI)

[![Build and publish IG](https://github.com/Inera-AB/EI-on-FHIR/actions/workflows/publish.yml/badge.svg)](https://github.com/Inera-AB/EI-on-FHIR/actions/workflows/publish.yml)
[![Validate FSH](https://github.com/Inera-AB/EI-on-FHIR/actions/workflows/validate.yml/badge.svg)](https://github.com/Inera-AB/EI-on-FHIR/actions/workflows/validate.yml)
[![FHIR R5](https://img.shields.io/badge/FHIR-R5-blue)](https://hl7.org/fhir/R5/)
[![License: CC0-1.0](https://img.shields.io/badge/License-CC0_1.0-lightgrey.svg)](https://creativecommons.org/publicdomain/zero/1.0/)

The specification and FHIR Implementation Guide for FHIR-EI, Inera's FHIR-based engagement index. FHIR-EI answers three questions about a patient: which systems hold information about them, which information sets are there, and when they were last updated. It replaces today's engagement index (RIV-TA `itintegration:engagementindex`) when NPÖ and 1177 move to FHIR, following the same pattern as NHS England's National Record Locator and IHE MHD. Both the specification and the IG are written in Swedish.

| | |
|---|---|
| Package id | `inera.ei.engagementindex` |
| Canonical | `https://fhir.inera.se/ig/engagementindex` |
| FHIR version | 5.0.0 |
| Branch builds | `https://inera-ab.github.io/EI-on-FHIR/` |
| Status | Draft, version 0.1.0 (unpublished) |

### What is in this repository

| Part | Where | What it is |
|---|---|---|
| Specification | [`spec/fhir-ei-spec.md`](spec/fhir-ei-spec.md) | The design and its rationale: information model, code systems, API, event model and transition, access control, coexistence with eHM's patient index, open questions. Design changes are made here first |
| Implementation Guide | `input/`, `sushi-config.yaml` | The formal realisation in FSH and narrative pages, built with SUSHI and IG Publisher. Where the IG makes a choice the specification leaves open, the IG page *Mappning till profiler* says so |
| Publishing instructions | [`docs/`](docs/) | Swedish instructions for versioning and releases, from the Inera IG template |

### Design in brief

- **One index entry per patient × endpoint × service**, as a profiled R5 `DocumentReference` (`IneraIndexEntry`). A service is an IG (today a RIV-TA service domain); information sets are profiles within it (today categories). Each service publishes an application profile of the common entry in its own IG.
- **Pointers, not content.** The entry says where and when, never what; elements that would carry clinical content are prohibited.
- **Lifecycle by deregistration, not deletion.** The base `status` plus the extensions `registrationStatus` and `deregistrationReason`. Deregistered entries remain as tombstones for a retention period, so consumers that missed notifications can reconcile.
- **Producers are identified by their endpoint in [tjänstekatalogen](https://github.com/Inera-AB/tjanstekatalog).** The same URL is the producer's namespace in `identifier.system`, checked by an invariant, and a producer may only register for care providers that list its endpoint there.
- **Logical address is carried separately.** In tjänstekatalogen a logical address is an organisation's HSA-id, not an endpoint, so RIV-TA sources carry `logicalAddress` next to the endpoint.
- **Transition without changes to producers.** An adapter mirrors today's engagement index into FHIR-EI. It has an agent role and an address register built from TAK and tjänstekatalogen, the same idea as in [EHDS-bryggan](https://github.com/Inera-AB/ehds-brygga).
- **Native R5 subscriptions** on the topic `indexpost-andrad`, with `id-only` notifications, `$status` and `$events`; reconciliation with `_lastUpdated`; bulk export with `$export`.
- **FHIR-EI is its own access control point:** blocking (spärr), logging and filtering apply to every read, subscription and export.

### Related repositories

| Repository | Relation |
|---|---|
| [Inera-AB/tjanstekatalog](https://github.com/Inera-AB/tjanstekatalog) | Holds the endpoints that index entries point to and that identify producers. Its organisations' HSA-ids are the logical addresses |
| [Inera-AB/ehds-brygga](https://github.com/Inera-AB/ehds-brygga) | Uses the engagement index before calling producers, and is one of the address register's possible targets for RIV-TA sources |

### IG artifacts

| Artifact | FSH file |
|---|---|
| Index entry profile on R5 `DocumentReference` (`IneraIndexEntry`) | `input/fsh/profiles/IneraIndexEntry.fsh` |
| Extensions: source endpoint, care unit, registering producer, logical address, source system, content last updated, registration status, deregistration reason | `input/fsh/extensions/Extensions.fsh` |
| Code systems and value sets | `input/fsh/terminology/Terminology.fsh` |
| SubscriptionTopic `indexpost-andrad` and a Subscription profile (`IneraIndexSubscription`) | `input/fsh/subscriptions/Subscriptions.fsh` |
| National search parameters | `input/fsh/searchparameters/SearchParameters.fsh` |
| Server CapabilityStatement | `input/fsh/capabilitystatements/IneraIndexServer.fsh` |
| Examples | `input/fsh/examples/Examples.fsh` |

Bulk Data `$export` is required in narrative only: Bulk Data Access is published for R4, so its OperationDefinition cannot be referenced from an R5 IG.

An R5 IG validates against the R5 terminology server, so `publish.yml` and `release.yml` pass `tx-server: https://tx.fhir.org/r5` to the shared workflows, whose default is the R4 server. The shared `pr-qa.yml` always builds without a terminology server (`-tx n/a`) and has no input for one; its QA comment therefore reports three false errors on `SearchParameter.base` and `SearchParameter.target`, which a build against the R5 server does not.

Open questions are listed at the end of the specification and on the IG page *Öppna frågor* (`input/pagecontent/open-issues.md`).

The repository was created from [IneraFHIRTemplate](https://github.com/Inera-AB/IneraFHIRTemplate) 2.3.0. The sections below describe how the template's structure, publishing and CI work.

---

## Design choices

Three deliberate choices shape how this template's narrative pages are organised:

- **Menu structure inspired by European specifications.** The top menu (Home / Inledning / Funktionellt / Implementering / Om / Artefakter — Home / Introduction / Functional / Implementation / About / Artifacts) mirrors the pattern used by specifications such as FHIR ePS, rather than the ad-hoc Background/Artifacts grouping used in earlier versions of this template. Funktionellt and Implementering are expandable dropdowns grouping several narrower topic pages; this gives implementers a familiar entry point across Inera and other European FHIR IGs, and separates background material (Inledning), business requirements (Funktionellt), and what implementers actually build against (Implementering) into distinct top-level sections.
- **Artifacts is a single, auto-generated page, not hand-maintained catalog pages.** Profiles, terminology (code systems/value sets) and examples are not given their own narrative pages — IG Publisher already lists them automatically on the generated `artifacts.html` page, so the "Artefakter" menu entry links straight there. Maintaining separate `profiles.md`/`terminology.md`/`examples.md` pages would just duplicate that listing and require manual upkeep as profiles change.
- **The information model is published externally, separate from the IG.** Concept models, information models and detailed business workflows are not restated in this template — they live in an authoritative, independently published information specification that the IG references (see `information-basis.md`'s "Informationsunderlag" page, under Funktionellt, and `mappings.md`). This avoids duplicate documentation that can drift out of sync between the information specification and the IG over time. For FHIR-EI there is no separate information specification; the design lives in [`spec/fhir-ei-spec.md`](spec/fhir-ei-spec.md) in this repository, and the IG's *Informationsunderlag* page points to today's engagement index contracts.

---

## Inera branding

The template uses Inera's visual identity by default. All branding is isolated to four files:

| File | What it does |
|------|-------------|
| `input/includes/fragment-css.html` | Loads Inera CSS and favicon |
| `input/includes/fragment-header.html` | Inera logo in the header |
| `input/images/inera.css` | All Inera colours, fonts and layout |
| `input/images/inera-*.svg / inera-*.png` | Logos and favicon |

Remove these four files (and the `input/images/inera-*` assets) to revert to standard HL7 FHIR styling.

---

## How publishing works

Every Inera IG has three kinds of build:

| Build | Trigger | Published to |
|---|---|---|
| Branch build | Push to `main`, `develop`, `feature/**`, `support/**` (`publish.yml`) | The IG repo's own GitHub Pages: `https://inera-ab.github.io/<repo>/` (`main`), `…/branches/<branch>/` (other branches) |
| Release | Push of a release tag such as `1.2.0` (`release.yml`) | `https://fhir.inera.se/ig/<name>/<version>/`, with the latest milestone also at `https://fhir.inera.se/ig/<name>/` |
| Test publication | Manual run of `release.yml` on a branch | The test web root [inera-ab/fhir-portal-test](https://github.com/Inera-AB/fhir-portal-test), never fhir.inera.se |

Releases use IG Publisher's publication mode (`-go-publish`). The publisher publishes into a web root shared by all Inera IGs, the `ig/` folder of the `gh-pages` branch of [inera-ab/fhir-portal](https://github.com/Inera-AB/fhir-portal), and takes care of:

- the version folder and the copy of the latest milestone at the IG root
- the release banner on every page, including earlier versions ("The current version which supersedes this version is …")
- the version history: `package-list.json` and `history.html` at `https://fhir.inera.se/ig/<name>/history.html`
- the package and publication feeds (`package-feed.xml`, `publication-feed.xml`), through which packages reach packages.fhir.org once Inera's package feed is registered in FHIR/ig-registry (not yet done; it will be when the first real IG is published)
- the IG's entry in the FHIR IG registry (`fhir-ig-list.json`), saved as a workflow artifact for a PR to [FHIR/ig-registry](https://github.com/FHIR/ig-registry)

`<name>` is the third part of the package id: `inera.core.template` publishes to `https://fhir.inera.se/ig/template`. The layout rule in the web root's `publish-setup.json` only matches package ids with exactly three parts, and `<name>` must be unique among Inera IGs.

The Swedish instructions in [`docs/`](docs/) describe the process in full:

- [Versionshantering, brancher och releaser](docs/versionshantering-och-release.md)
- [Förbereda en IG för publicering och göra en release](docs/forbereda-och-releasa-ig.md)
- [Flytta en befintlig IG till publiceringsläget](docs/flytta-befintlig-ig.md)

---

## Before the first release

The IG identity, `ig.ini`, `publication-request.json` (`"first": true`), `release.yml` and the package link are already set for FHIR-EI. The remaining one-time steps are repository settings: GitHub Pages on `gh-pages`, Actions write access, the `FHIR_PORTAL_TOKEN` secret and a `develop` branch. See [Förbereda en IG för publicering](docs/forbereda-och-releasa-ig.md#förberedelser-inför-första-publiceringen).

---

## Daily workflow

1. Create a feature branch from `develop`, e.g. `feature/lab-observation`.
2. Push. `validate.yml` runs SUSHI and `publish.yml` builds the branch to `https://inera-ab.github.io/<repo>/branches/feature-lab-observation/`.
3. Open a pull request against `develop`. `pr-qa.yml` posts a QA report as a comment with the number of errors, warnings, hints and broken links, so there is no need to open the logs.
4. Merge when QA is green. `develop` is built to `https://inera-ab.github.io/<repo>/branches/develop/`, and the feature branch's build is removed when the branch is deleted.

Nothing is published to fhir.inera.se on ordinary merges. `develop` is merged to `main` before a release (see [Publish a release](#publish-a-release)).

Replace the template's placeholder content: profiles in `input/fsh/profiles/`, examples in `input/fsh/examples/` and narrative pages in `input/pagecontent/`.

### Editing in the browser

Any file can be edited on GitHub without cloning: open the file, click the pencil (*Edit this file*), make the change and choose *Create a new branch and start a pull request*, with `develop` as the target. `pr-qa.yml` runs automatically. Pressing `.` in a repository opens it in the web-based VS Code.

### Commit messages and choosing a version

The version is bumped by hand before a release, and the version history entry is written by hand. Nothing creates versions or tags automatically. Commit messages following [Conventional Commits](https://www.conventionalcommits.org/) make it easy to see what changed since the last release and which version the next one should get:

| Prefix | Meaning | Usually gives |
|---|---|---|
| `feat: ...` | New profile, element or page | Minor (0.1.0 → 0.2.0) |
| `fix: ...` | Bug fix in a profile or text | Patch (0.1.0 → 0.1.1) |
| `profile: ...` | Profile change | Patch |
| `valueset: ...` | Terminology change | Patch |
| `docs: ...` | Documentation only | Patch |
| `chore: ...` | Maintenance, CI | No new version |
| `feat!: ...` or `BREAKING CHANGE:` in the message | Backwards-incompatible change | Major (0.1.0 → 1.0.0) |

`git log --oneline <previous version>..HEAD` lists the changes since the last release, which are the basis for the entry in `input/pagecontent/version-history.md`.

---

## Publish a release

### Before tagging

On the branch that is released (`main`, or `support/<major>.x` for a patch to an older major version), via a pull request:

1. **Version:** set `version` in `sushi-config.yaml` and add an entry to `input/pagecontent/version-history.md` describing the changes.
2. **Publication request:** update `publication-request.json`:
   - `desc`: one line describing this release. It must differ from every earlier release.
   - `mode`: `milestone` for a release that becomes the current version at the IG root; `working` for a publication that does not replace the root, such as a release candidate or a patch to an older major version. (`technical-correction` also needs a `tech-correction.template.html` in the web root's templates, which is not set up yet.)
   - `status` and `sequence`: for example `release` / `Releases`.
   - `first`: `true` only for the IG's very first publication.

   `package-id`, `version` and `path` are filled in by the workflow from `sushi-config.yaml`.
3. **Dependencies:** pin them to published versions; the publisher refuses `current` dependencies.
4. **Test publication (optional):** Actions → *Publish release* → *Run workflow* on the branch publishes to the test web root.

### Tag

Release tags have no `v` prefix and must equal `version` in `sushi-config.yaml`:

```bash
git fetch origin
git tag -a 1.2.0 -m "1.2.0" origin/main
git push origin 1.2.0
```

`release.yml` then:

1. Checks that the tag, `sushi-config.yaml` and `publication-request.json` agree, and that the version and its description are new.
2. Builds the IG.
3. Checks out the web root (only this IG's folder and the shared files).
4. Runs `-go-publish`, which rebuilds the IG for publication and updates the web root.
5. Pushes the web root and updates the IG catalog on fhir.inera.se.
6. Saves the FHIR IG registry change (`fhir-ig-list.diff`) and the publication log as an artifact.

### After the release

- Check `https://fhir.inera.se/ig/<name>/<version>/`, `https://fhir.inera.se/ig/<name>/history.html` and the IG catalog at `https://fhir.inera.se/ig/`.
- Open a pull request to [FHIR/ig-registry](https://github.com/FHIR/ig-registry) with the change in `fhir-ig-list.diff`.

### Rules

- **Never publish the same version twice.** Package caches and packages.fhir.org may already hold it, and the feeds get duplicates. Publish a new patch version instead. The workflow refuses a version that is already in the web root.
- A failed run that never reached *Push web root* has changed nothing and can be re-run.

---

## Version history

`input/pagecontent/version-history.md` is the IG's change log. The publisher's `history.html` lists the published versions; the change log describes what changed in each.

Write each entry as `## [X.Y.Z] — YYYY-MM-DD` with `###` sections. The first line of `version-history.md`, `{::options header_offset="1" /}`, makes kramdown render them one level down (`<h3>`/`<h4>`), below the `<h2>` page title the template adds. Keep that line; without it IG Publisher reports a second `<h2>` on the page as an error.

---

## CI workflows

The workflows in `.github/workflows/` only set the triggers and permissions. They call the shared workflows in [Inera-AB/fhir-ig-workflows](https://github.com/Inera-AB/fhir-ig-workflows) at `@v1`, so fixes to the build and release flow reach every IG made from this template without copying files.

| Workflow | Trigger | What it does |
|----------|---------|--------------|
| `validate.yml` | Push to non-main branches; pull requests | Runs SUSHI |
| `pr-qa.yml` | Pull request (opened, synchronised) | Full IG Publisher build (no tx server), posts QA report as PR comment |
| `publish.yml` | Push to `main`, `develop`, `feature/**`, `support/**`; manual trigger | Branch build, deployed to `gh-pages` of this repo under the branch's directory; updates the IG catalog entry |
| `release.yml` | Push of a release tag (`1.2.0`, `1.2.0-rc1`); manual trigger | Publishes the release with `-go-publish`: a tag to fhir.inera.se, a manual run on a branch to the test web root |
| `cleanup.yml` | Branch deleted | Removes the branch's build directory from `gh-pages` |

Settings such as the web roots, the terminology server (an R5 IG uses `https://tx.fhir.org/r5`) and the IG Publisher version are inputs of the shared workflows, set with `with:` in the caller. See the [fhir-ig-workflows README](https://github.com/Inera-AB/fhir-ig-workflows#using-them-from-an-ig-repo).

---

## Local development

Prerequisites:

- Git
- VS Code
- Node.js 20 or later, for SUSHI
- Java 17 or later, for IG Publisher
- Ruby and Jekyll, which IG Publisher uses to render the pages

The commands below are for Git Bash (included in Git for Windows) or a terminal on macOS and Linux.

Once:

```bash
git clone https://github.com/inera-ab/<repo>.git
cd <repo>

# SUSHI and Jekyll
npm install -g fsh-sushi
gem install jekyll

# IG Publisher
mkdir -p input-cache
curl -sL https://github.com/HL7/fhir-ig-publisher/releases/latest/download/publisher.jar -o input-cache/publisher.jar
```

Day to day:

```bash
# New feature branch from develop
git checkout develop
git pull
git checkout -b feature/lab-observation

# Check the FSH
sushi .

# Build the whole IG (a few minutes)
java -jar input-cache/publisher.jar -ig ig.ini

# Open the result
start output/index.html       # Windows
open output/index.html        # macOS
xdg-open output/index.html    # Linux

# Commit and push
git add .
git commit -m "feat: add LaboratoryObservation profile"
git push -u origin feature/lab-observation
```

Then open a pull request against `develop` on GitHub.

Recommended VS Code extensions:

| Extension | Description |
|---|---|
| FHIR Shorthand (vscode-fsh) | Syntax highlighting and snippets for FSH |
| YAML | Validation of `sushi-config.yaml` |
| GitHub Pull Requests | Handle pull requests in VS Code |
| GitLens | Better git history and blame |

---

## Tips and common pitfalls

**FSH and SUSHI**

- Run `sushi .` locally before pushing. It is faster than waiting for CI.
- Aliases in `input/fsh/aliases.fsh` save repeating long URLs in every profile.
- Do not add `hl7.fhir.r4.core` as a dependency in `sushi-config.yaml`. SUSHI adds the core package itself.
- Pin other dependencies to published versions before a release, never `current`.

**IG Publisher and cache**

- The first build downloads several hundred MB of FHIR packages. Later builds are faster thanks to the cache in `~/.fhir/packages/`.
- `output/`, `temp/`, `template/`, `input-cache/` and `fsh-generated/` are git-ignored and must never be committed.
- The repository must never have a `package-list.json`. The version history lives on fhir.inera.se, and the publisher refuses to publish from a repository that has the file.

**GitHub Pages**

- Every push to a branch rebuilds the branch's page. The build takes a few minutes.
- If the page does not update: go to Actions, open the latest run of *Build and publish IG* and read the log.

**QA report on pull requests**

- `pr-qa.yml` posts a comment with the number of errors, warnings, hints and broken links, and the first issues in a table.
- The comment is updated on every push to the PR branch instead of a new one being added.
- Warnings listed in `input/ignoreWarnings.txt` are not counted in the report.

---

## Repository structure

```
.github/workflows/         Callers of the shared workflows in Inera-AB/fhir-ig-workflows
  validate.yml             Validate FSH on push / PR
  pr-qa.yml                IG Publisher QA on pull requests
  publish.yml              Branch builds to this repo's GitHub Pages
  release.yml              Releases with -go-publish to the web root
  cleanup.yml              Remove build dir for deleted branches
docs/                      Swedish instructions for versioning and publishing
spec/                      The FHIR-EI specification (design and rationale)
publication-request.json   What the next release is (desc, mode, status, sequence)
sushi-config.yaml          IG metadata, dependencies, pages and menu
ig.ini                     IG Publisher configuration
input/
  fsh/
    aliases.fsh            Shared FSH aliases
    rulesets.fsh           Shared metadata and CapabilityStatement rule sets
    profiles/              FHIR profile definitions (.fsh)
    extensions/            Extension definitions
    terminology/           Code systems and value sets
    searchparameters/      SearchParameter definitions
    subscriptions/         SubscriptionTopic and Subscription profile
    capabilitystatements/  CapabilityStatement definitions
    examples/              Example instances (.fsh)
  pagecontent/             Narrative IG pages (.md); no leading "# Title", the template renders the page title
  images/                  Images, CSS and diagrams
  includes/                Fragment overrides (CSS, header) and menu.xml (only the <ul>; the IG template supplies the surrounding navbar markup)
```

---

## Governance

This IG is maintained by Inera AB. See the [Inera FHIR Landing Page](https://www.inera.se/fhir) for conformance requirements that apply to all Inera FHIR IGs.
