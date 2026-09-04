# Most Requested / Wished-For PS5 Add-on Capabilities

Research snapshot: 2026-09-04.

This document focuses on repeated pain points and wishes rather than merely cataloging existing add-ons.

## 1. Quest-map intelligence

This is one of the clearest current PS5 gaps.

Players explicitly ask for PC-style quest starter markers, especially side-quest exclamation marks and a way to see what remains incomplete in each zone.

Recent PS5 threads:
- July 2026: https://www.reddit.com/r/elderscrollsonline/comments/1upfb9u/console_addon_question/
- August 2026: https://www.reddit.com/r/elderscrollsonline/comments/1vp6k09/ps5_addon_for_trackingfinding_sidequests/

A developer also created a console **Side Quests** beta inspired by Quest Map. Their post describes incomplete filtering, duplicate/out-of-bounds quest data and a community-maintained database effort. That is strong evidence that the demand is real and that the hard part is data quality / completion-state handling rather than drawing a pin.

Developer/community thread:
- https://www.reddit.com/r/elderscrollsonline/comments/1rhmnnq/creating_a_new_addon/

### Product inference

A stronger console-first implementation should target:

- quest starter pins,
- incomplete side-quest filters,
- zone progress summary,
- repeatable/completed filtering,
- nearest unfinished quest,
- compact segmented data rather than one giant database.

Working name: **QuestLens**.

---

## 2. Inventory / account-wide knowledge

Console players repeatedly value tools that answer questions the base UI makes tedious:

- Does my crafter know this plan?
- Which character has this item?
- Which traits remain to research?
- Is this recipe / motif already known?
- What master writs / surveys do I have?

The enthusiasm around 702's trackers and auto-bind / auto-extract utilities shows that account-wide knowledge is one of the highest-value console QoL areas.

Current community examples:
- https://www.reddit.com/r/elderscrollsonline/comments/1tvwl1a/ps5_question/
- https://www.reddit.com/r/elderscrollsonline/comments/1u8bgm1/addons_for_ps5/
- https://www.reddit.com/r/elderscrollsonline/comments/1obe4gh/

### Product inference

An original console-first **InventoryLens** could focus on high-value questions rather than cloning the entire PC Inventory Insight surface.

Possible modules:

- account item locator,
- known-plan / known-motif lookup,
- trait research matrix,
- duplicate collectible detection,
- survey/master-writ counts,
- compact set-collection intelligence.

---

## 3. Add-on health, diagnostics and dependency intelligence

Console players operate under a hard ecosystem budget, yet debugging is much less comfortable than on PC.

Official documentation caps installed console add-ons at 100 MB:
- https://help.elderscrollsonline.com/app/answers/detail/a_id/70903/

ESOUI's MemoryUsage utility proves that console-flow testing can read total add-on memory pool usage through `GetTotalUserAddOnMemoryPoolUsageMB()`:
- https://esoui.com/downloads/info4181-MemoryUsage.html

However, developer discussion indicates **accurate per-addon memory attribution is not available**, because Lua memory and libraries are shared:
- https://www.esoui.com/forums/archive/index.php/t-4669.html/t-10386.html

### Product inference

A useful **Addon Doctor** should therefore emphasize what is measurable and honest:

- total memory pool usage,
- installed/enabled dependency graph where exposed,
- missing dependencies,
- duplicate/unused libraries where detectable,
- Lua/UI errors,
- event/listener diagnostics,
- known-heavy combinations,
- profile recommendations,
- console-flow developer instrumentation.

Do not promise fake per-addon MB numbers.

---

## 4. Trading / price intelligence

Console players want the same basic answer PC players get from TTC / Master Merchant:

> What is this item worth here, on this platform, right now?

Current PS5 recommendations regularly mention TSC / Tamriel Savings Co. price helpers, showing strong demand for pricing context:
- https://www.reddit.com/r/elderscrollsonline/comments/1tvwl1a/ps5_question/
- https://www.reddit.com/r/elderscrollsonline/comments/1v4ar1j/most_impactful_ps5_addons/
- https://www.reddit.com/r/elderscrollsonline/comments/1obe4gh/

### Constraint

Console cannot simply reproduce the classic PC pattern of a desktop scanner/client writing external market data into SavedVariables on the same machine.

### Product inference

A console-native **TradeLens PS** should explore legal/technical data sources such as:

- observed listings the player actually sees,
- compact bundled snapshots,
- manually/community-curated price datasets,
- platform-specific medians and confidence bands,
- crafting-cost vs listing-value helpers.

It should never pretend PC prices equal PlayStation prices.

---

## 5. HUD customization and accessibility

Console players repeatedly use or request add-ons that alter:

- minimap presence,
- reticles,
- stat colors,
- buff/action information,
- UI layout,
- quest readability,
- immersion / HUD visibility.

Examples of currently recommended tools include Points of Color, Volcano's Stat Colors, Rainbow Reticle and Votan's Minimap:
- https://www.reddit.com/r/elderscrollsonline/comments/1u8bgm1/addons_for_ps5/
- https://www.reddit.com/r/elderscrollsonline/comments/1scnm7m/what_mods_should_i_use_on_a_first_playthrough_ps5/

### Product inference

Instead of many tiny single-purpose tweaks, test whether a modular **HUD Studio** can safely expose controller-friendly controls for ESO UI elements the API allows us to move, hide, scale or recolor.

---

## 6. Completion / collectible intelligence

The popularity of map pins, skyshards, lorebooks, treasure maps, furnishing-plan tracking and motif knowledge suggests a broader demand:

> Tell me what I have not finished yet.

Examples:
- https://www.reddit.com/r/elderscrollsonline/comments/1w3a813/downloading_game_right_now_and_saw_addons_are_a/
- https://www.reddit.com/r/elderscrollsonline/comments/1obe4gh/

### Product inference

**CompletionLens** could become a shared framework with optional data packs for:

- skyshards,
- lorebooks,
- furnishing plans,
- motifs,
- antiquities,
- achievement-linked collectibles,
- zone completion categories.

A data-pack architecture may be better for console than one giant always-loaded database.

---

## 7. Crafting / research intelligence

Lazy Writ Crafter is repeatedly described as essential. That proves crafting automation has one of the clearest console value propositions.

Examples:
- https://www.reddit.com/r/elderscrollsonline/comments/1tvwl1a/ps5_question/
- https://www.reddit.com/r/elderscrollsonline/comments/1w3a813/downloading_game_right_now_and_saw_addons_are_a/

### Product inference

A broader **CraftBrain** could layer on:

- trait-research tracking,
- account-wide recipe/plan knowledge,
- master-writ evaluation,
- material availability checks,
- crafting completion dashboards,
- price-before-craft integration where data is available.

---

## 8. Better add-on profile management

PC players can maintain huge addon installations and use profile/loadout managers. On console, the built-in browser supports enable/disable, but the 100 MB cap and controller workflow make activity-based curation more valuable.

Official capabilities:
- https://help.elderscrollsonline.com/app/answers/detail/a_id/70903/

### Product hypothesis to test

Could an add-on provide named profiles such as:

- Crafting
- Trials
- PvP
- Housing
- Exploration
- Low-memory

The feasibility depends on what ESO exposes about other installed add-ons and whether runtime enable/disable control is permitted. This must be experimentally verified before promising a true `Addon Selector` equivalent.

---

# Demand ranking

These scores are a product-research synthesis, not scientific polling.

| Rank | Capability | Demand signal | Competition | Technical risk | Opportunity |
|---:|---|---|---|---|---|
| 1 | QuestLens | Very high | Medium | Medium | Excellent |
| 2 | Addon Doctor | High | Low | Medium | Excellent |
| 3 | InventoryLens | Very high | Medium | High | Excellent |
| 4 | CraftBrain | High | Medium | Medium | Strong |
| 5 | CompletionLens | High | Fragmented | Medium | Strong |
| 6 | HUD Studio | High | Fragmented | Medium | Strong |
| 7 | TradeLens PS | Very high | Medium | Very high | High if data solved |
| 8 | Add-on profiles | High | Low | API-dependent | High if API permits |
| 9 | New combat intelligence | High | High | High | Lower-priority first build |

# Strategic takeaway

The strongest console opportunities are not brute-force PC ports. They are **console-native reductions and recombinations** of proven PC value:

`player pain → smallest useful capability → controller-first UI → compact data → lazy/event-driven runtime → honest console constraints`

That is the design principle this repository should preserve.