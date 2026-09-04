# PC ESO Add-on Managers as Reference Architecture

This repository is PS5-first, but the PC ecosystem provides useful architectural precedents for package management, profiles, dependency handling and addon organization.

## Minion

Role: external desktop package manager traditionally used with ESOUI.

Useful ideas to preserve conceptually:

- addon discovery
- install/update/remove lifecycle
- dependency awareness
- backup/restore
- mapping installed folders to catalog metadata

What does **not** transfer directly to PS5:

- filesystem access
- desktop background updater
- direct manipulation of the ESO addon directory
- external SavedVariables management

For PS5, Bethesda's in-game browser owns the install/uninstall channel.

## ESO Addon Manager (open-source PC project)

Reference project discussed during research:
- https://github.com/arviceblot/eso-addons

Interesting architectural ideas:

- cross-platform manager implementation
- ESOUI search/install integration
- existing-addon detection
- dependency suggestions
- Minion import/migration
- special update flows for data-heavy addons

Use this as a package-management design reference, not as a PS5 deployment mechanism.

## Addon Selector

PC reference:
- https://www.esoui.com/downloads/info1161-AddonSelectorSaveLoadAddOnprofilespacks.html

Key idea: named **addon packs/profiles** for activities such as crafting, PvP, trials, housing or low-memory play.

This is especially relevant to PS5 because the console has a 100 MB total addon cap. However, a true PS5 equivalent depends on whether ESO's console API allows one addon to inspect or change enable state for other addons.

Therefore our PS5 concept should be called a **hypothesis** until tested:

```text
CRAFTING PROFILE
TRIALS PROFILE
PVP PROFILE
HOUSING PROFILE
EXPLORATION PROFILE
LOW-MEMORY PROFILE
```

If programmatic switching is impossible, the product can still become a recommendation/planning UI that tells the player what to enable/disable manually.

## Votan-style dependency intelligence

The PC ecosystem demonstrates the value of dependency-aware addon lists: turning on a pack should also surface its required libraries, and disabling a feature should reveal libraries that are no longer needed.

For PS5, that suggests an `Addon Doctor` dependency graph:

```text
Addon A ─┐
Addon B ─┼─> Shared Library X
Addon C ─┘

Addon D ───> Shared Library Y
```

Potential uses:

- missing dependency warning
- orphaned library warning
- duplicate functionality warning
- profile planning
- compatibility notes

## Category/grouping systems

PC addons such as AddonCategory demonstrate another useful idea: organize a huge addon list by functional taxonomy rather than alphabetical order.

Useful PS5 categories:

- Crafting
- Trading
- Combat
- PvE
- PvP
- Maps
- Exploration
- Completion
- Inventory
- Housing
- UI / HUD
- Accessibility
- Immersion
- Developer Tools
- Libraries

## PS5 translation

The correct mental model is:

```text
PC
ESOUI -> Minion -> filesystem -> Addon Selector -> dependencies -> ESO

PS5
Bethesda/ESO in-game browser -> installed addons -> our diagnostics/profile intelligence -> ESO UI
```

The console opportunity is therefore **not to replace Bethesda's installer**. It is to build the intelligence layer that the installer currently lacks, if the API exposes enough metadata.

## Research tasks

- verify all runtime addon-list APIs available under console flow
- inspect whether enable state is readable
- inspect whether dependency metadata is readable
- inspect whether enable state is writable
- confirm whether a UI reload can be requested from addon code on console
- map what information the Bethesda browser exposes to players but not Lua

These answers determine whether `LoadoutOS` becomes a true profile switcher or an intelligent assistant for manual profile management.