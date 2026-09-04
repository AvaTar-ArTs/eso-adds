# eso-adds

Research and engineering notebook for **The Elder Scrolls Online add-ons on PlayStation 5**, with a focus on:

- what console add-ons already exist,
- what PS5 players repeatedly request,
- which PC capabilities are still missing or reduced on console,
- console-specific technical constraints,
- legitimate porting / clean-room reimplementation opportunities,
- and a roadmap for original console-first add-ons.

> Research snapshot: **2026-09-04**. Console add-ons are a fast-moving ecosystem, so claims are tagged by evidence quality and should be rechecked before implementation.

## Current build track: ESO Profile Bridge

The repository now includes the first working scaffold for **ESO Profile Bridge (EPB)**, an experimental configuration-profile framework designed around ESO's real addon constraints.

EPB's purpose is to capture, store, validate, restore, and eventually transport configuration profiles for compatible addons without pretending console addons have unrestricted filesystem or network access.

Architecture:

```text
ESO runtime
  -> EPB lifecycle
  -> Profile Store
  -> Adapter Registry
  -> Addon Adapters
  -> Serializer / Transfer Layer
  -> Gamepad / Console UI
```

Prototype location: [`ESOProfileBridge/`](ESOProfileBridge/)

Comprehensive continuation brief: [`docs/AGENT_HANDOFF.md`](docs/AGENT_HANDOFF.md)

Current prototype commands:

```text
/epb save <name>
/epb apply <name>
/epb export <name>
```

The current implementation is a scaffold, not a production console release. The decoder, validation/migration system, real third-party adapter, controller-native UI, rollback behavior, and external transport experiments remain development work.

## Core platform facts

ESO added add-on support for **PlayStation 5 and Xbox Series X|S in June 2025**. Console add-ons are UI-only. Players install them from ESO's in-game Add-Ons browser. The current documented console installation cap is **100 MB total**, language add-ons are unsupported, and Bethesda/ZeniMax does not QA or guarantee community add-ons.

PlayStation also has a notable developer gotcha: manifest paths are **case-sensitive**.

Primary sources:

- ESO Support: Console add-on developer uploader: https://help.elderscrollsonline.com/app/answers/detail/a_id/69621/
- ESO Support: Enable/manage console add-ons: https://help.elderscrollsonline.com/app/answers/detail/a_id/70903/
- ESO Support: ESO UI API: https://help.elderscrollsonline.com/app/answers/detail/a_id/1081/
- ESO Support: What add-ons are: https://help.elderscrollsonline.com/app/answers/detail/a_id/9127/

## Repository map

| File | Purpose |
|---|---|
| [`ESOProfileBridge/`](ESOProfileBridge/) | First Lua prototype for portable addon configuration profiles |
| [`docs/AGENT_HANDOFF.md`](docs/AGENT_HANDOFF.md) | Detailed project state, architecture, guardrails, unknowns and agent continuation prompt |
| [`docs/console-platform.md`](docs/console-platform.md) | PS5 platform rules, developer constraints, memory/runtime notes |
| [`docs/ps5-addon-landscape.md`](docs/ps5-addon-landscape.md) | Add-ons currently reported/recommended by PS5/console players |
| [`docs/requested-and-missing.md`](docs/requested-and-missing.md) | Deep dive into repeatedly requested / wished-for capabilities |
| [`docs/opportunity-map.md`](docs/opportunity-map.md) | Ranked original-addon opportunities and proposed product family |
| [`docs/sources.md`](docs/sources.md) | Source ledger with evidence type and notes |
| [`data/ps5-addons.csv`](data/ps5-addons.csv) | Seed inventory of console/PS5 add-ons mentioned in current research |
| [`data/opportunities.csv`](data/opportunities.csv) | Working opportunity scoring model |

## Current conclusions

The most promising opportunities are not simple PC clones. Console has different limits and different failure modes. The strongest pattern is to extract the **player value** of a PC add-on and rebuild it as a smaller, controller-first, console-native system.

Current top opportunities:

1. **QuestLens** — side-quest starters, incomplete quests, completion filters and zone progress.
2. **Addon Doctor** — console add-on health, dependency/error diagnostics, total memory monitoring and compatibility guidance.
3. **InventoryLens** — account-wide item / knowledge intelligence adapted to console limits.
4. **CraftBrain** — trait research, recipe/plan knowledge, writ intelligence and crafting completion.
5. **CompletionLens** — modular collectible/achievement/plan tracking.
6. **HUD Studio** — configurable HUD positioning, visibility and presentation where ESO APIs permit it.
7. **TradeLens PS** — lightweight PlayStation-native market intelligence without pretending PC TTC infrastructure exists on console.
8. **ESO Profile Bridge** — normalized profile capture/restore across compatible addons, with transport treated as a separately validated console problem.

A recurring architecture idea is a shared **AvaTar ESO ConsoleKit** providing controller UI, SavedVariables wrappers, event routing, map pins, settings, diagnostics, localization and lightweight data utilities once for the whole family. EPB is a natural candidate for one of the first consumers of that shared layer.

## Important legal / ethical rule

Do **not** copy another author's source and republish it as ours. Before porting an existing add-on, inspect its license and author permissions. Where reuse is not licensed, study the user-facing problem and API behavior and build an original implementation.

For EPB specifically, compatibility adapters should prefer documented/public addon APIs. Direct manipulation of another addon's SavedVariables must be narrowly scoped, version-aware, validated, and never treated as permission to redistribute that addon's code.

## Evidence policy

We distinguish between:

- **Official** — ESO / Bethesda / ZeniMax documentation.
- **Developer** — addon author, ESOUI project page, maintainer discussion.
- **Community signal** — Reddit/forum player reports, useful for demand and real-world usage but not authoritative for API facts.
- **Hypothesis** — our engineering/product inference, to be tested.

That distinction matters. For example, ESO exposes `GetTotalUserAddOnMemoryPoolUsageMB()` for console-flow testing, but available evidence indicates there is **no reliable API for attributing memory to each individual add-on**. `Addon Doctor` therefore must not promise impossible per-addon memory accounting.

The same rule applies to EPB: PS5 filesystem access, arbitrary network access, clipboard access, QR import, and cross-device synchronization must never be claimed unless specifically verified.

## Next research/build phases

- Audit `ESOProfileBridge/` line by line against the current official ESO UI API and console documentation.
- Complete a bounded non-executing serializer decoder with validation, payload limits, schema versions and malformed-input tests.
- Build one real addon adapter and prove capture → mutate → restore → reload.
- Add pre-restore snapshots and rollback behavior.
- Build a controller-native profile management surface.
- Experiment with console-safe profile transport only after input/output capabilities are verified.
- Expand the console catalog into a full census with author, category, version, dependencies, size, platform, source repo, license and maintenance status.
- Map the major PC ESOUI catalog to PS5 equivalents and gaps.
- Inspect open-source console-compatible add-ons for legitimate architectural patterns.
- Prototype a shared console-first SDK / test addon using ESO's console-flow tooling.
- Validate exactly what metadata and enable/disable controls the ESO API exposes to one add-on about other installed add-ons.

This repository is intended to become both a **research archive** and the design ground for original PS5 ESO add-ons.
