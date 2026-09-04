# ESO Add-on Repository Catalog

Research snapshot: 2026-09-04

This catalog is the repository-level companion to the existing PS5 / console add-on research. Its goal is to identify **every ESO add-on project we can trace to source**, distinguish original repositories from forks, mirrors, tooling and libraries, and record what each project does in a form that can later support ESO Profile Bridge and other console-first research.

## Current universe and an important census caveat

The public `the-jolly-green-bryant/eso-addon-mirror` index currently exposes **3,800 mirrored ESO add-on records**: **599 Bethesda / Console** records and **3,201 ESOUI PC / Mac** records. The mirror provides unpacked source and stable source IDs, which makes it a useful bounded census layer.

That count is **not equivalent to every ESO add-on or every ESO GitHub repository that has ever existed**. It may omit unpublished repositories, abandoned projects never mirrored, private sources, historical versions, non-GitHub development locations, and repositories whose add-on identity is difficult to infer. It can also contain records that represent forks, ports, continuations, renames or otherwise related projects.

Accordingly, 3,800 is a measurable research universe, not a claim of universal completeness.

This catalog separates four concepts:

1. **Published add-on record** — one Bethesda or ESOUI listing, identified by Bethesda UUID or ESOUI ID when available.
2. **Logical add-on/project identity** — the human concept that may span renames, ports and continuations.
3. **Development repository** — the author's or maintainer's source repository when one can be verified.
4. **Mirror / fork / archive / collection** — a secondary source relationship that must not be confused with canonical authorship.

One repository may contain several add-ons. One logical add-on may have several published records and several repositories. Those relationships must remain explicit rather than flattening everything into one ambiguous list.

## Catalog goals

For every ESO add-on / repository pair, capture:

- add-on name and canonical source ID
- logical project identity / lineage family
- repository owner/name and URL
- author / maintainer
- repository relationship: original, maintainer fork, historical fork, mirror, archive, multi-addon collection, library, manager/tool
- platform: PC / Mac, Console, PS5-specific, Xbox-specific, cross-platform, unknown
- console publication evidence and **console-tested evidence** as separate fields
- primary use / player problem solved
- major features
- category and subcategory
- SavedVariables table names where source inspection confirms them
- SavedVariables scope: account, character, world/server, mixed, unknown
- SavedVariables **state class**: settings, profiles, player-authored data, progress, history, cache, generated database, mixed, unknown
- settings framework: LibAddonMenu, LibHarvensAddonSettings, custom, none, unknown
- dependencies / libraries and minimum declared versions
- manifest names, manifest type (`.txt` / `.addon`) and API versions when inspected
- major runtime events/hooks when technically relevant
- gamepad/controller support evidence
- license and redistribution status
- activity / archival state
- Bethesda ID and ESOUI ID where available
- source / evidence confidence
- Profile Bridge relevance and adapter complexity

## Repository classification

Use these values for `repo_type`:

- `original` — verified primary development repository
- `maintainer_fork` — active continuation/fork maintained by another developer
- `console_port` — console-oriented derivative where lineage can be established
- `historical_fork` — fork or old copy that should not be treated as current
- `mirror` — preservation / distribution mirror
- `archive` — historical source snapshot
- `collection` — repository containing multiple ESO add-ons
- `library` — reusable ESO library rather than a player-facing add-on
- `manager` — external add-on manager / updater / maintenance utility
- `developer_tool` — developer tooling for ESO add-on creation or publishing
- `unknown` — relationship has not yet been verified

## Feature categories

Normalize `category` to one of these broad families while preserving more specific features in `feature_summary`:

- addon-management
- combat
- crafting
- inventory
- trading
- map-exploration
- quests
- completion
- UI-HUD
- chat-social
- guild-group
- housing
- mail
- travel
- collectibles-antiquities
- accessibility
- automation-QoL
- library-framework
- developer-tooling
- external-manager
- other

## Profile-state model

The most important new distinction is that an add-on's SavedVariables table is not automatically synonymous with "settings."

A table can contain several kinds of state:

- **settings** — booleans, positions, colors, filters, preferences
- **profiles/loadouts** — named user-created configurations
- **player-authored data** — notes, custom lists, rules, labels
- **progress/knowledge** — learned recipes, completion state, research observations
- **history** — mail, trading, loot or combat history
- **cache** — reconstructed data that should usually not be restored across versions/devices
- **generated/static database state** — potentially huge or version-sensitive structures

Profile Bridge should normally prioritize settings, profiles and user-authored state. History, caches and generated databases require stricter analysis and may be excluded from portable capture even when they reside in the same SavedVariables table.

## Profile Bridge compatibility dimensions

Each inspected project should receive:

- `savedvars_present`: yes / no / unknown
- `savedvars_scope`: account / character / world / mixed / unknown
- `savedvars_state_class`: settings / profiles / authored / progress / history / cache / database / mixed / unknown
- `settings_framework`: LAM / Harvens / custom / none / unknown
- `bridge_capture_mode`: public-api / explicit-adapter / raw-archive / none / unknown
- `bridge_complexity`: low / medium / high / extreme / unknown
- `bridge_priority`: critical / high / medium / low / none
- `requires_reload`: yes / no / conditional / unknown
- `migration_risk`: low / medium / high / unknown

### Suggested compatibility interpretation

**Low** — small configuration table, simple scalar values, clear stable schema.

**Medium** — several settings groups or mixed scopes but straightforward data.

**High** — large user-authored profiles, character/account mixtures, migrations, or substantial nested state.

**Extreme** — large databases, history/cache data, external data pipelines, schemas with unstable IDs, or state where indiscriminate restore could be dangerous.

## Evidence rules

Do not infer features solely from repository names when a README, manifest, source, ESOUI page or Bethesda record can be inspected. When a row has not yet received that inspection, mark `evidence_level` as `discovery-only` and leave uncertain fields blank rather than manufacturing details.

Recommended evidence levels:

- `source-inspected`
- `readme-inspected`
- `official-listing`
- `developer-stated`
- `console-tested-report`
- `repository-metadata`
- `discovery-only`

A Bethesda Console listing proves distribution availability, not feature parity, PS5 stability or successful real-console testing. Those must remain separate claims.

## Current platform facts that affect repository analysis

Current official support confirms that console add-ons are UI-only, install through the in-game browser on PS5 / Xbox Series consoles, and have a documented **100 MB total installation cap**. PlayStation manifest paths are case-sensitive.

Do not confuse that installation cap with historical developer discussions about runtime memory or SavedVariables limits. Those are separate resources and their final current values need independent verification.

For console-capable source:

- `.addon` is the console manifest convention described by ZOS/ESOUI developer material.
- `.txt` remains the normal PC manifest form.
- Code inside `PC` or `Keyboard` folders is not available in console flow and can expose hidden porting dependencies.
- `ForceConsoleFlow` on PC is useful for compatibility testing but is not equivalent to real PS5 QA.
- path casing must be audited before PlayStation packaging.

## SavedVariables research rules

SavedVariables are created/loaded through ESO's add-on lifecycle and are written at UI reload/loading transitions rather than behaving like arbitrary filesystem writes. Account-wide, character-aware and world/server-aware layouts are all possible.

Repository inspection must therefore record not merely `SavedVariables = yes`, but:

1. manifest-declared global table name(s)
2. initialization path and wrapper (`ZO_SavedVars`, `LibSavedVars`, custom)
3. schema/version number
4. account/character/world namespace behavior
5. defaults and migration logic
6. which fields are portable user configuration versus cache/history/database state
7. whether mutation takes effect immediately or requires UI reload/relog/scene reconstruction

`LibSavedVars` is actively maintained as of 2026, but current console compatibility cannot be assumed from maintenance status alone. Treat it as a research target until ForceConsoleFlow and real-console behavior are verified.

## Initial high-value repositories already confirmed

| Repository | Type | Role / use | Bridge relevance |
|---|---|---|---|
| `nicokimmel/wizardswardrobe` | original | Build / setup and loadout management; source shows account-wide settings plus character-scoped `setups` and `pages` | **Critical** high-complexity adapter benchmark |
| `Dolgubon/DolgubonsLazyWritCreator` | original | Crafting writ automation | High because crafting preferences/state are important console configuration |
| `B7TxSpeed/FancyActionBar` | original/needs lineage check | Action-bar / effect presentation | High; console users have extensive configuration and a known console support thread |
| `Ayantir/LoreBooks` | original/historical lineage to verify | Lorebook location and map assistance | Medium; settings are likely more portable than map datasets |
| `simenon/LostTreasure` | original | Treasure map / survey assistance | Medium; map-data versus settings distinction matters |
| `Baertram/pChat` | original | Chat UI / chat behavior customization | Medium-high for configuration preservation |
| `klingo/ESO-PersonalAssistant` | original | Multi-module personal automation / inventory-oriented assistance | High; likely mixed feature/state surface |
| `silvereyes333/LibSavedVars` | library | SavedVariables lifecycle / compatibility library | **Critical research dependency** for bridge architecture |
| `kyoma/ESO-RaidNotifier` | original | Raid / trial mechanic notifications | Medium-high; configuration can be encounter-specific |
| `inimicus/CruxCounter` | original | Arcanist Crux tracking | Low-medium, useful as a smaller adapter specimen |
| `j-blandford/BetterUI` | original/lineage check | UI / gamepad-oriented interface improvements | High console-design reference |
| `iFedix/Dustman` | original | Loot / junk automation | Medium; configuration-focused |
| `uladz/PriceTracker` | original | Trading price tracking | High/extreme if historical price data is mixed with settings |
| `michaelwestbrook/Provinatus` | original | HUD / map overlay system | High due broad UI settings and large feature surface |
| `Baertram/FCOItemSaver` | original | Item protection / inventory marking rules | High because player-defined rules are valuable state |
| `silvereyes333/Postmaster` | original | Mail automation / mail quality-of-life | Medium |
| `ralfepoisson/CombatStatus-Console` | original | Console-specific combat status display | Low; useful small-console architecture specimen |
| `MikoBratcie/ESO-RaidNotifierConsole` | console fork/port, lineage to verify | Console-targeted RaidNotifier variant | High PS5/console comparison target |
| `gamersa22/Pet-Health-Console` | original/console | Console pet-health UI | Low-medium, compact console specimen |
| `Bazooper-blip/MailHistoryConsole` | original/console | Console mail-history functionality | Medium-high because history and settings should be separated |
| `Fluazinam/LibConsoleMenu` | library | Console menu / UI library | High ConsoleKit reference |
| `the-jolly-green-bryant/eso-addon-mirror` | mirror | 3,800-record Bethesda + ESOUI source census and preservation mirror | Critical discovery/index source, not assumed canonical author repo |
| `FAR747/ESO_SavedVariables_Auto_Backup` | external/tooling, inspect | SavedVariables backup utility for ESO environments | Critical comparative research for backup semantics |
| `arviceblot/eso-addons` | external manager | PC ESO add-on manager / ecosystem reference | High architectural comparison, not directly portable to PS5 |

Rows above are the **verified discovery seed**, not the finished exhaustive catalog. The machine-readable table is `data/eso-addon-repositories.csv` and should be expanded until every traceable GitHub-backed ESO project and every Bethesda Console record with source is represented.

## Exhaustive expansion strategy

The target is not “whatever GitHub search happens to return.” GitHub search misses repositories whose names/descriptions do not mention ESO and returns unrelated utilities.

The research graph should join:

```text
Bethesda console catalog
        +
ESOUI catalog
        +
3,800-record public mirror census
        +
GitHub repository discovery
        +
source/manifests/README inspection
        +
forum/developer lineage evidence
        ↓
logical addon identity ↔ publication record ↔ repository graph
```

For each mirror record, determine whether an original repository exists. Then de-duplicate forks, ports, renamed projects and collections using repository identity plus Bethesda/ESOUI IDs and source lineage. Console records should additionally receive PS5/Xbox evidence status rather than assuming every Bethesda Console entry has identical behavior on both platforms.

## Deep-inspection pass

For high-value repositories, inspect at least:

1. README / project description
2. manifest(s)
3. declared SavedVariables
4. startup/lifecycle code
5. settings initialization
6. dependency declarations
7. data/model modules
8. migration/version code
9. public API or callbacks
10. gamepad / console branches
11. packaging or console-specific files
12. license
13. release/maintenance history

The resulting analysis should answer both **what the add-on does for a player** and **how it is architected**, without treating source availability as permission to reuse implementation.

## Legal / provenance rule

Cataloging or studying source does not grant redistribution rights. Each add-on keeps its own author attribution and license. A mirror or fork must never be treated as permission to copy an author's implementation into AvaTar projects. Profile Bridge adapters should prefer documented APIs and narrowly scoped compatibility code.

## Related files

- `data/eso-addon-repositories.csv` — machine-readable repository catalog
- `data/ps5-addons.csv` — PS5-focused seed inventory
- `data/forum-signals.csv` — player demand / bug / constraint corpus
- `docs/forum-index.md` — official ESO forum research index
- `docs/ps5-addon-landscape.md` — console landscape notes
- `docs/AGENT_HANDOFF.md` — Profile Bridge architecture, unresolved transport questions and guardrails
