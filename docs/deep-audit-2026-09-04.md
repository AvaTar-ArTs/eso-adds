# ESO Add-on Ecosystem Deep Audit

Research date: 2026-09-04

This audit re-evaluates the current `eso-adds` research, the ESO Profile Bridge handoff, the repository-catalog model, official console documentation, current ESOUI developer guidance, and the remaining unknowns that must be resolved before implementation claims become product promises.

## Executive conclusion

The project direction is sound, but several concepts previously sat too close together and needed separation:

1. the **100 MB console installation cap** is an official current player-facing limit;
2. runtime memory limits and SavedVariables limits were discussed separately during console development and must not be assumed to equal that installation cap without current evidence;
3. a Bethesda Console listing proves distribution availability, not PS5 stability, parity or real-console testing;
4. a SavedVariables table is not equivalent to portable settings;
5. a mirrored source record is not necessarily a canonical repository;
6. a GitHub repository is not necessarily one logical add-on;
7. `ForceConsoleFlow` is a compatibility tool, not a substitute for PS5 QA;
8. profile portability is an adapter/schema problem first and a transport problem second.

The research should therefore evolve into a relationship graph rather than a flat addon list.

## Current platform baseline

Official ESO support currently confirms:

- console add-ons launched in June 2025;
- supported platforms are PlayStation 5 and Xbox Series X|S;
- add-ons are UI-only;
- players install them through the in-game Add-Ons browser;
- installed add-ons can be enabled/disabled through the base game UI;
- the current documented total installation cap is 100 MB;
- language add-ons are not supported;
- PlayStation manifest paths are case-sensitive;
- Bethesda/ZeniMax does not QA or guarantee community add-ons.

This means an original Addon Doctor/Profile Bridge should add diagnostics, configuration intelligence and compatibility orchestration rather than simply recreate the base game's addon browser.

## Current API-version state

Update 51 / Season One is in PTS during this audit with API version `101051`. ESOUI's Update 51 schedule shows live release planned for 2026-09-28. Current 12.0-era releases use API version `101050`.

Therefore the project should keep both concepts explicitly:

- `liveApiVersion` = verified immediately before testing/release;
- `ptsApiVersion` = separately tracked when testing future compatibility.

No manifest should freeze an API number into architecture doctrine.

## Manifest and console-loading model

ZOS developer guidance for console support established that console add-ons use the `.addon` manifest form, while normal PC-only projects should stay with `.txt`. ESOUI developers continue to warn in 2026 that using `.addon` makes a project participate in console/ForceConsoleFlow behavior even when it has not actually been made console-safe.

Port inspection should therefore include:

- manifest extension;
- exact file/path casing;
- `## APIVersion`;
- `## AddOnVersion`;
- `## SavedVariables`;
- `## DependsOn` / `## OptionalDependsOn`;
- minimum dependency version checks;
- files underneath `PC` or `Keyboard` folders;
- console/gamepad code branches;
- libraries that themselves may not support console.

A repository with a `.addon` manifest should not automatically be labeled "PS5 tested."

## SavedVariables model, corrected

ESO SavedVariables are a lifecycle-managed persistence mechanism. They are declared in the manifest and become available during the add-on load lifecycle. They are written during UI reload/loading transitions rather than functioning as arbitrary realtime filesystem writes.

The repository census must inspect four distinct questions:

1. **Where is state stored?**
   - manifest table name(s)
   - `ZO_SavedVars`
   - `LibSavedVars`
   - custom wrappers

2. **What is its scope?**
   - account-wide
   - character
   - world/server
   - mixed

3. **What kind of state is it?**
   - settings
   - profiles/loadouts
   - user-authored data
   - progress/knowledge
   - history
   - cache
   - generated/static database

4. **Can it be safely migrated?**
   - schema version
   - stable identifiers
   - migration functions
   - addon version coupling
   - reload requirements
   - cross-server or cross-character assumptions

This is the critical foundation for ESO Profile Bridge.

## LibSavedVars finding

`LibSavedVars` is not a dead library. Its ESOUI listing was updated in August 2026 and reports version 6.1. However, recent maintainer/community discussion still raised whether console mode is actually supported/tested.

This creates an important distinction:

**actively maintained != console validated**

The project should inspect and test LibSavedVars rather than making it a console dependency by assumption.

## Profile Bridge architecture validation

The existing handoff correctly treats SavedVariables as the in-game persistence layer, uses per-addon adapters, and separates storage from transport. That remains the strongest architectural decision.

The adapter contract should ultimately classify:

- availability;
- exact addon/version compatibility;
- capture scope;
- data-field allowlist;
- validation rules;
- apply semantics;
- migration semantics;
- account/character/world scope;
- reload requirement;
- rollback capability;
- failure reporting.

Profile Bridge should not indiscriminately dump another addon's entire global SavedVariables table and call that compatibility.

## Transport remains unresolved

No evidence reviewed establishes arbitrary filesystem, network or clipboard access for a PS5 ESO addon.

Therefore these remain experiments, not features:

- QR export;
- QR import;
- companion web transfer;
- text chunk transfer;
- cross-device synchronization;
- clipboard-assisted transfer.

The safe sequence remains:

`capture -> validate -> restore -> migrate -> rollback -> deterministic serialization -> transport experiments`

## Console runtime constraints

Historical ZOS development notes for Update 45 described:

- ForceConsoleFlow simulation;
- a preliminary 100 MB runtime-memory limit;
- a separately planned SavedVariables limit;
- a 1-second-per-frame addon execution limit;
- disabled key rebinding on console;
- some user settings blocked from addon modification.

Those development notes are extremely valuable architectural evidence, but they are not the same as current final player-facing limits. Their present values/behavior should be revalidated before documentation presents them as current hard limits.

The project should therefore track three resource budgets independently:

1. installed package size;
2. runtime addon memory;
3. SavedVariables persistence size.

## Repository-census correction

The 3,800-record mirror is a strong bounded corpus, not proof that exactly 3,800 ESO addons/repositories exist.

The real graph has at least these entity types:

```text
Logical Project
  -> Publication Record(s)
       -> Bethesda UUID
       -> ESOUI ID
  -> Repository/Repositories
       -> canonical
       -> maintainer continuation
       -> console port
       -> historical fork
       -> mirror/archive
  -> Releases/Versions
  -> Dependencies/Libraries
```

This avoids false duplicate counts and false canonicality.

## New fields required for serious repository analysis

Each deep-inspected repository should capture:

- canonicality confidence;
- logical addon family;
- publication IDs;
- current maintainer;
- last meaningful update;
- manifest type;
- current API versions;
- platform declaration;
- console publication evidence;
- real PS5 test evidence;
- Xbox test evidence;
- SavedVariables table names;
- SavedVariables wrapper;
- SavedVariables schema version;
- scope;
- state class;
- migration logic;
- settings framework;
- dependencies and required versions;
- event registrations / polling patterns;
- gamepad compatibility;
- data-table footprint;
- license;
- public API/callback surface;
- Profile Bridge capture strategy;
- portability risk;
- reload requirements;
- evidence quality.

## Addon-management finding

The base console client already provides browse/search/install/uninstall/reinstall/ignore-update/enable/disable functionality.

This changes the opportunity for Addon Doctor and Profile Bridge. Their strongest value is not being another package manager. It is:

- dependency/compatibility understanding;
- configuration snapshots;
- safe restore;
- addon-specific migration;
- diagnostics;
- profile composition;
- conflict awareness;
- user-readable state diffs.

Programmatic enable/disable of other addons remains an API experiment and must not be assumed.

## High-priority technical specimens

The next deep source inspections should deliberately span different complexity classes:

### Small console specimen

Use a compact console addon with a tiny settings surface to validate manifest, lifecycle, SavedVariables and gamepad patterns.

### Settings-heavy specimen

Use a configurable UI addon such as FancyActionBar / similar to study nested preferences and reload behavior.

### Profile-heavy specimen

Wizard's Wardrobe is a high-value benchmark because player-authored loadouts are semantically richer than plain settings.

### Mixed-state specimen

Inventory/trading/mail addons can contain settings plus history/cache, forcing the bridge to distinguish portable data from disposable data.

### Library specimen

Inspect LibSavedVars and console menu/settings libraries separately because library compatibility can become a transitive console failure.

## Important product insight

The repository census and Profile Bridge are converging on a broader primitive:

**normalized addon state intelligence**

Once state is classified and adapters exist, the same evidence can support:

- backup/restore;
- profile composition;
- configuration diffing;
- schema migration;
- compatibility reports;
- conflict diagnostics;
- portable presets;
- addon-health analysis;
- account/character-aware views.

This is more defensible than a generic backup utility.

## What is still not fully understood

The following questions remain genuinely unresolved and should stay labeled as such:

1. What exact final runtime-memory limit is enforced on real PS5 in the current live build?
2. What exact final aggregate/per-addon SavedVariables size rules are enforced on console today?
3. Which installed-addon metadata/functions are exposed to one addon at runtime?
4. Can another addon's enabled state be changed programmatically on console, and under what restrictions?
5. Which settings/user-setting API calls are blocked specifically under console flow today?
6. What is the exact console behavior for add-ons/libraries packaged with `.addon` versus `.txt` across PC, ForceConsoleFlow and Bethesda distribution?
7. What input paths are available for reconstructing serialized profile data on PS5?
8. Whether QR rendering is practical is unknown; QR input is even less established.
9. Which console addons expose stable public APIs rather than requiring direct SavedVariables adapters?
10. How Bethesda package updates interact with incompatible SavedVariables schemas across addon versions.
11. How NA/EU/world and character identifiers should be normalized for genuinely portable profiles.
12. Which state changes are safe immediately versus requiring reload UI, relog or scene reconstruction.
13. How large libraries/static datasets influence real console load time, CPU budget and runtime memory.
14. Whether every mirrored console record has source lineage that can be verified to an author repository.
15. How many GitHub ESO projects exist outside the mirror/ESOUI/Bethesda publication graph.
16. License status for many old or mirrored projects.
17. How the current Bethesda review/security pipeline treats addons whose purpose includes encoded import/export.

## Research doctrine going forward

For every claim, use this ladder:

`official current documentation > ZOS developer/API statement > source code > maintainer statement > real-console test report > community report > engineering inference`

Do not collapse the levels.

For every addon, answer these in order:

`What player problem does it solve?`

`What state/data does it own?`

`How does it persist that state?`

`What does it depend on?`

`What does it do at runtime?`

`What is actually portable?`

`What is console-safe?`

`What is legally reusable?`

## Immediate next research pass

1. Expand all 599 mirrored Bethesda Console records into normalized addon identities.
2. Join them to verified GitHub repositories where possible.
3. Inspect console manifests and dependency graphs.
4. Extract SavedVariables declarations automatically, then manually classify state semantics.
5. Separate `published on console` from `tested on PS5`.
6. Build lineage families for ports/forks/continuations.
7. Deep-inspect 10 representative repositories across the complexity classes above.
8. Run targeted API research for installed-addon enumeration/state manipulation.
9. Verify current real-console runtime and SavedVariables limits.
10. Convert the resulting findings into an adapter-feasibility matrix for Profile Bridge.

This audit should be treated as a correction and expansion checkpoint, not as the final state of knowledge.