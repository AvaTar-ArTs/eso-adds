# ESO Add-on Repository Catalog

Research snapshot: 2026-09-04

This catalog is the repository-level companion to the existing PS5 / console add-on research. Its goal is to identify **every ESO add-on project we can trace to source**, distinguish original repositories from forks, mirrors, tooling and libraries, and record what each project does in a form that can later support ESO Vault compatibility work.

## Current universe

The public `the-jolly-green-bryant/eso-addon-mirror` index currently exposes **3,800 mirrored ESO add-ons**: **599 Bethesda / Console** records and **3,201 ESOUI PC / Mac** records. The mirror provides unpacked source and stable source IDs, which makes it a useful census layer. It is not automatically the original development repository for each add-on.

This catalog therefore separates three different concepts:

1. **Add-on record** — one published ESO add-on, identified by Bethesda UUID or ESOUI ID when available.
2. **Development repository** — the author's or maintainer's GitHub repository when one can be verified.
3. **Mirror / fork / archive** — a secondary copy that may preserve source but should not be confused with the canonical project.

One repository may contain several add-ons. One add-on may have several forks. Those relationships must remain explicit rather than flattening everything into one ambiguous list.

## Catalog goals

For every ESO add-on / repository pair, capture:

- add-on name and canonical source ID
- repository owner/name and URL
- author / maintainer
- repository relationship: original, maintainer fork, historical fork, mirror, archive, multi-addon collection, library, manager/tool
- platform: PC / Mac, Console, PS5-specific, Xbox-specific, cross-platform, unknown
- console publication evidence
- primary use / player problem solved
- major features
- category and subcategory
- SavedVariables table names where source inspection confirms them
- SavedVariables scope: account, character, world/server, mixed, unknown
- settings framework: LibAddonMenu, LibHarvensAddonSettings, custom, none, unknown
- dependencies / libraries
- manifest names and API versions when inspected
- license
- activity / archival state
- Bethesda ID and ESOUI ID where available
- source / evidence confidence
- ESO Vault relevance and adapter complexity

## Repository classification

Use these values for `repo_type`:

- `original` — verified primary development repository
- `maintainer_fork` — active continuation/fork maintained by another developer
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

## Vault compatibility dimensions

The repository catalog doubles as an evidence base for ESO Vault. Each inspected project should receive:

- `savedvars_present`: yes / no / unknown
- `savedvars_scope`: account / character / world / mixed / unknown
- `settings_framework`: LAM / Harvens / custom / none / unknown
- `vault_capture_mode`: settings-api / explicit-adapter / raw-archive / none / unknown
- `vault_complexity`: low / medium / high / extreme / unknown
- `vault_priority`: critical / high / medium / low / none

### Suggested compatibility interpretation

**Low** — small configuration table, simple scalar values, clear stable schema.

**Medium** — several settings groups or mixed scopes but straightforward data.

**High** — large user-authored profiles, character/account mixtures, migrations, or substantial nested state.

**Extreme** — large databases, history/cache data, external data pipelines, or schemas where indiscriminate restore could be dangerous.

## Evidence rules

Do not infer features solely from repository names when a README, manifest, source, ESOUI page or Bethesda record can be inspected. When a row has not yet received that inspection, mark `evidence_level` as `discovery-only` and leave uncertain fields blank rather than manufacturing details.

Recommended evidence levels:

- `source-inspected`
- `readme-inspected`
- `official-listing`
- `repository-metadata`
- `discovery-only`

## Initial high-value repositories already confirmed

| Repository | Type | Role / use | Vault relevance |
|---|---|---|---|
| `nicokimmel/wizardswardrobe` | original | Build / setup and loadout management; source shows account-wide settings plus character-scoped `setups` and `pages` | **Critical** high-complexity adapter benchmark |
| `Dolgubon/DolgubonsLazyWritCreator` | original | Crafting writ automation | High because crafting preferences/state are important console configuration |
| `B7TxSpeed/FancyActionBar` | original/needs lineage check | Action-bar / effect presentation | High; console users have extensive configuration and a known console support thread |
| `Ayantir/LoreBooks` | original/historical lineage to verify | Lorebook location and map assistance | Medium; settings are likely more portable than map datasets |
| `simenon/LostTreasure` | original | Treasure map / survey assistance | Medium; map-data versus settings distinction matters |
| `Baertram/pChat` | original | Chat UI / chat behavior customization | Medium-high for configuration preservation |
| `klingo/ESO-PersonalAssistant` | original | Multi-module personal automation / inventory-oriented assistance | High; likely mixed feature/state surface |
| `silvereyes333/LibSavedVars` | library | SavedVariables lifecycle / compatibility library | **Critical research dependency** for Vault architecture |
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

The proper census joins:

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
        ↓
canonical add-on ↔ repository graph
```

For each of the 3,800 mirror records, determine whether an original repository exists. Then de-duplicate forks and collections using repository identity plus Bethesda/ESOUI IDs. Console records should additionally receive PS5/Xbox evidence status rather than assuming every Bethesda Console entry has identical behavior on both platforms.

## Legal / provenance rule

Cataloging or studying source does not grant redistribution rights. Each add-on keeps its own author attribution and license. A mirror or fork must never be treated as permission to copy an author's implementation into AvaTar projects. ESO Vault adapters should prefer documented APIs and narrowly scoped compatibility code.

## Related files

- `data/eso-addon-repositories.csv` — machine-readable repository catalog
- `data/ps5-addons.csv` — PS5-focused seed inventory
- `data/forum-signals.csv` — player demand / bug / constraint corpus
- `docs/forum-index.md` — official ESO forum research index
- `docs/ps5-addon-landscape.md` — console landscape notes
