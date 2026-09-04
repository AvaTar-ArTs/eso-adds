# PS5 ESO Add-on Opportunity Map

Research snapshot: 2026-09-04.

## Core thesis

The best PS5 add-on opportunities are not literal PC clones. They are **console-first implementations of proven player needs**.

The design loop:

```text
PC capability / player pain
        ↓
extract the core value
        ↓
remove desktop-only assumptions
        ↓
controller-first interaction
        ↓
compact / lazy data
        ↓
console-safe runtime
        ↓
original PS5-native addon
```

## Proposed product family

### AvaTar ESO ConsoleKit

Shared infrastructure for future add-ons:

- bootstrap / lifecycle
- event routing
- controller UI components
- settings wrappers
- SavedVariables wrappers
- map-pin utilities
- localization
- data segmentation / lazy loading helpers
- diagnostics
- compatibility/version checks
- packaging validation for PlayStation path casing

The goal is to avoid rebuilding the same machinery in every addon and to reduce duplicated overhead.

---

## 1. QuestLens

### Problem
PS5 players repeatedly ask for a Quest Map-like experience: unfinished side quests, quest starter pins and better zone completion awareness.

### MVP
- side-quest starter pins
- zone filter
- hide/show completed where API/state permits
- compact zone summary
- controller-native settings

### Advanced
- nearest unfinished quest
- achievement-linked quest chains
- repeatable filtering
- community-correctable quest data
- segmented zone data packs

### Risk
Large quest databases can become expensive on console. Data architecture matters as much as UI.

---

## 2. Addon Doctor

### Problem
Console users have a 100 MB installation budget and less debugging visibility than PC users.

### MVP
- total console add-on memory usage where API supports it
- current Lua/UI error summary
- loaded dependency/library inventory
- missing dependency warnings
- console flow diagnostics page

### Advanced
- known incompatibility rules
- heavy-combination warnings
- dependency graph visualization
- profile recommendations
- developer event instrumentation

### Hard rule
Do not fabricate per-addon memory figures. Current evidence supports total pool monitoring, not exact per-addon attribution.

---

## 3. InventoryLens

### Problem
Players want to know where items live and what their account already knows.

### MVP
- account-wide known recipe/plan lookup
- trait research state
- selected inventory/bank location index

### Advanced
- set item lookup
- survey/master-writ overview
- duplicate knowledge detection
- crafting-character designation

### Risk
SavedVariables growth. Store only what materially improves lookup.

---

## 4. CraftBrain

### Problem
Crafting is one of the strongest proven console addon categories, but knowledge is fragmented across writs, traits, plans and materials.

### MVP
- trait research dashboard
- known plans / recipes
- master writ checklist

### Advanced
- value-per-voucher estimates with optional pricing data
- material availability
- crafting completion goals
- integration hooks for Lazy Writ Crafter-compatible workflows where technically/legal appropriate

---

## 5. CompletionLens

### Problem
Console players already install separate systems for skyshards, lorebooks, treasures, furnishing plans and motifs.

### Architecture
Use a modular core + optional data packs.

```text
CompletionLens Core
├── Skyshards data
├── Lorebooks data
├── Furnishing plans
├── Motifs
├── Antiquities
└── Zone achievements
```

This keeps users from paying the memory/data cost for categories they do not care about.

---

## 6. HUD Studio

### Problem
Players want reticle, map, buff, action-bar and readability changes without juggling many tiny settings addons.

### MVP depends entirely on API feasibility
- move/scale supported controls
- visibility toggles
- text scale options
- color presets

### Constraint
Only expose changes that ESO's UI API safely allows. Some camera/game-setting wishes may remain impossible on console.

---

## 7. TradeLens PS

### Problem
PlayStation has a distinct economy and lacks the traditional PC desktop-client data pipeline.

### MVP possibilities
- player-observed listing history
- local rolling medians
- confidence based on sample count
- craft-cost notes
- platform-specific data import only if Bethesda's console model legally/technically permits a supported workflow

### Rule
Never silently substitute PC prices for PlayStation prices.

---

## 8. Add-on Profiles / LoadoutOS

### Vision
Named activity profiles such as Crafting, Trials, PvP, Housing and Exploration.

### First experiment
Before building UI, prove what the API allows:

1. enumerate installed add-ons
2. read enable state
3. read dependencies
4. change enable state, if permitted
5. determine whether reload is required/possible

If programmatic state changes are not exposed, pivot to a **recommendation/diagnostic profile planner** rather than pretending to be a true package manager.

---

# Suggested build order

```text
0. ConsoleKit probe addon
   ↓
1. Addon Doctor
   ↓
2. QuestLens
   ↓
3. CraftBrain / InventoryLens shared knowledge layer
   ↓
4. CompletionLens
   ↓
5. HUD Studio
   ↓
6. TradeLens PS research prototype
```

Why this order?

- The probe establishes platform truths.
- Addon Doctor gives us instrumentation.
- QuestLens is an immediately visible flagship.
- Inventory/Crafting share account-knowledge infrastructure.
- CompletionLens reuses map/data-pack machinery.
- TradeLens waits until the data question is solved.

## Scoring model

Opportunity score should eventually combine:

```text
Demand
+ Console fit
+ Differentiation
+ Reuse across future addons
+ Maintainability
- API uncertainty
- dataset cost
- runtime/memory risk
- strong existing competition
```

The current numbers in `data/opportunities.csv` are working hypotheses, intended to be replaced by measured evidence as the census grows.