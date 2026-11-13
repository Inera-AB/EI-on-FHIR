# EI-on-FHIR: FHIR API for the engagement index

[![Build and publish IG](https://github.com/Inera-AB/EI-on-FHIR/actions/workflows/publish.yml/badge.svg)](https://github.com/Inera-AB/EI-on-FHIR/actions/workflows/publish.yml)
[![Validate FSH](https://github.com/Inera-AB/EI-on-FHIR/actions/workflows/validate.yml/badge.svg)](https://github.com/Inera-AB/EI-on-FHIR/actions/workflows/validate.yml)
[![FHIR R5](https://img.shields.io/badge/FHIR-R5-blue)](https://hl7.org/fhir/R5/)
[![License: CC0-1.0](https://img.shields.io/badge/License-CC0_1.0-lightgrey.svg)](https://creativecommons.org/publicdomain/zero/1.0/)

**EI-on-FHIR covers what EHDS-bryggan, the sync to eHM's patient index and FHIR producers such as Fasta kontakter need.** It defines a FHIR R5 API on top of today's national engagement index (EI), modelled on NHS England's National Record Locator, with its own register for sources that implement a service's FHIR IG instead of the RIV-TA contract. The earlier, broader vision for a FHIR-based index (FHIR R5, several population methods, per-user access control and legal analysis) is kept on the branch [`arkiv/fhir-ei-vision`](https://github.com/Inera-AB/EI-on-FHIR/tree/arkiv/fhir-ei-vision) and is not part of this IG. The architecture document and the IG are written in Swedish.

| | |
|---|---|
| Package id | `inera.ei.engagementindex` |
| Canonical | `https://fhir.inera.se/ig/engagementindex` |
| FHIR version | 5.0.0 |
| Status | Draft, version 0.1.0 (unpublished) |

### Use cases

1. **Support services find where information is.** Inera's internal support services in the new interoperability infrastructure, such as EHDS-bryggan, search a patient's engagement entries before calling a source system. This corresponds to FindContent.
2. **Sync to eHM's patient index.** A sync service reads all entries and all changes through the API and populates eHM's patient index on behalf of care providers, from the data already in EI.
3. **FHIR producers register engagements.** A source that implements a service's FHIR IG instead of the RIV-TA contract, for example Fasta kontakter, registers its entries in EI-on-FHIR's own register, so that they appear alongside the entries from EI.

### What is in this repository

| Part | Where | What it is |
|---|---|---|
| Architecture document (SAD) | [`sad/ei-on-fhir-sad.md`](sad/ei-on-fhir-sad.md) | Scope, requirements, context, building blocks, runtime flows, decisions with alternatives, risks |
| Implementation Guide | `input/`, `sushi-config.yaml` | The formal specification in FSH and narrative pages, built with SUSHI and IG Publisher |
| Publishing instructions | [`docs/`](docs/) | Swedish instructions for versioning and releases, from the Inera IG template |

### Design in brief

- **A read interface in the national EI, not a new service with its own copy.** The API reads EI's database or a read replica, so there is no copy of EI to keep in sync.
- **Its own register for FHIR producers**, written with conditional update and delete as in NRL's producer API. Searches and exports return entries from EI and the register together.
- **Each entry says how to fetch the information:** `content.profile` (as a Coding) is `riv-ta` (logical address via the service platform) or `fhir` (endpoint URL). A source with both interfaces has two entries, matched on patient, service domain and logical address; a FHIR-capable consumer picks the FHIR one.
- **One `DocumentReference` per EI entry**, profiled as `IneraEngagement`, with no merging. Fields without a DocumentReference element are extensions: logical address, source system, owner and most recent content.
- **Search like NRL:** `subject:identifier` and `type`, plus `logical-address` to narrow to one care provider. A search without a patient is allowed only for the sync client.
- **Sync with standard FHIR:** Bulk Data `$export` for the initial load and reconciliation, `_lastUpdated` for incremental changes. Deleted entries appear with status `superseded` for a retention period.
- **System clients only**, with SMART Backend Services and three client roles: support service, sync service and producer. The API does not check blocking (spärr), as today's EI does not; the support service checks it when it releases clinical information.

### Related repositories

| Repository | Relation |
|---|---|
| [Inera-AB/ehds-brygga](https://github.com/Inera-AB/ehds-brygga) | Checks the engagement index before calling a care provider's system; the first consumer of use case 1 |
| [Inera-AB/tjanstekatalog](https://github.com/Inera-AB/tjanstekatalog) | Its organisations' HSA-ids are the logical addresses; the sync service looks up care providers there |

### IG artifacts

| Artifact | FSH file |
|---|---|
| Engagement entry profile on R5 `DocumentReference` (`IneraEngagement`) | `input/fsh/profiles/IneraEngagement.fsh` |
| Extensions: logical address, source system, most recent content, owner | `input/fsh/extensions/Extensions.fsh` |
| Code systems and value sets | `input/fsh/terminology/Terminology.fsh` |
| Search parameters `logical-address` and `source-system` | `input/fsh/searchparameters/SearchParameters.fsh` |
| Server CapabilityStatement | `input/fsh/capabilitystatements/IneraEngagementIndexServer.fsh` |
| Examples | `input/fsh/examples/Examples.fsh` |

Bulk Data `$export` is required in narrative only: Bulk Data Access is published for R4, so its OperationDefinition cannot be referenced from an R5 IG.

An R5 IG validates against the R5 terminology server, so `publish.yml`, `release.yml` and `pr-qa.yml` pass `tx-server: https://tx.fhir.org/r5` to the shared workflows.

Open questions are listed in the SAD and on the IG page *Öppna frågor* (`input/pagecontent/open-issues.md`).

The repository was created from [IneraFHIRTemplate](https://github.com/Inera-AB/IneraFHIRTemplate) 2.3.0. The sections below describe how the template's structure, publishing and CI work.

---

## Design choices

Three deliberate choices shape how this template's narrative pages are organised:

- **Menu structure inspired by European specifications.** The top menu (Home / Funktionellt / Implementering / Om / Artefakter — Home / Functional / Implementation / About / Artifacts) mirrors the pattern used by specifications such as FHIR ePS, rather than the ad-hoc Background/Artifacts grouping used in earlier versions of this template. Funktionellt and Implementering are expandable dropdowns grouping several narrower topic pages; this gives implementers a familiar entry point across Inera and other European FHIR IGs, and separates business requirements (Funktionellt), and what implementers actually build against (Implementering) into distinct top-level sections.
- **Artifacts is a single, auto-generated page, not hand-maintained catalog pages.** Profiles, terminology (code systems/value sets) and examples are not given their own narrative pages — IG Publisher already lists them automatically on the generated `artifacts.html` page, so the "Artefakter" menu entry links straight there. Maintaining separate `profiles.md`/`terminology.md`/`examples.md` pages would just duplicate that listing and require manual upkeep as profiles change.
- **The information model is published externally, separate from the IG.** Concept models, information models and detailed business workflows are not restated in this template — they live in an authoritative, independently published information specification that the IG references (see `information-basis.md`'s "Informationsunderlag" page, under Funktionellt, and `mappings.md`). This avoids duplicate documentation that can drift out of sync between the information specification and the IG over time. For EI-on-FHIR the information basis is today's engagement index and its contracts, which the IG's *Informationsunderlag* page points to.

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

The IG identity, `ig.ini`, `publication-request.json` (`"first": true`), `release.yml` and the package link are already set for this IG. The remaining one-time steps are repository settings: GitHub Pages on `gh-pages`, Actions write access, the `FHIR_PORTAL_TOKEN` secret and a `develop` branch. See [Förbereda en IG för publicering](docs/forbereda-och-releasa-ig.md#förberedelser-inför-första-publiceringen).

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

Write each entry as `## [X.Y.Z] — YYYY-MM-DD` with `###` sections. From IG Publisher 3.0.2 the publisher moves page headings one level down itself, so they render as `<h3>`/`<h4>` below the `<h2>` page title. The template's first line, `{::options header_offset="1" /}`, did the same for older publishers; with 3.0.2 it moves them two levels and the publisher reports skipped heading levels as errors, so this IG has removed it.

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
sad/                       The architecture document (SAD)
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
    capabilitystatements/  CapabilityStatement definitions
    examples/              Example instances (.fsh)
  pagecontent/             Narrative IG pages (.md); no leading "# Title", the template renders the page title
  images/                  Images, CSS and diagrams
  includes/                Fragment overrides (CSS, header) and menu.xml (only the <ul>; the IG template supplies the surrounding navbar markup)
```

---

## Governance

This IG is maintained by Inera AB. See the [Inera FHIR Landing Page](https://www.inera.se/fhir) for conformance requirements that apply to all Inera FHIR IGs.
