# ESO Official Forum Index

Research snapshot: 2026-09-04

This document turns the official Elder Scrolls Online forum into a structured research source for the PS5 / console add-on project. The forum is not a single add-on board; useful evidence is spread across product discussion, bug reports, PlayStation support, PTS feedback, patch notes, player help, and the dedicated Add-Ons & UI Mods category.

## Why index the whole forum

The dedicated Add-Ons & UI Mods board tells us what authors build and what users explicitly request. The rest of the forum tells us what players struggle with before they ever formulate an add-on request. For product discovery, both matter.

A recurring pattern is:

```text
player pain in General / PS Support / Game Systems
        -> repeated workaround discussions
        -> explicit request in Add-Ons & UI Mods
        -> developer implementation / Bethesda publication
```

This repo should therefore treat the forum as a demand-and-constraint corpus rather than just a list of addon threads.

## Primary forum surfaces

| Surface | URL | Why it matters to this repo |
|---|---|---|
| Forum home / category index | https://forums.elderscrollsonline.com/en/categories | Master taxonomy and entry point |
| Add-Ons & UI Mods | https://forums.elderscrollsonline.com/en/categories/add-ons-and-ui-mods | Addon releases, requests, API requests, console-port issues, developer discussion |
| PlayStation Technical Support | https://forums.elderscrollsonline.com/en/categories/playstation-technical-support | PS5-specific save, sync, install, crash, UI and platform problems |
| Bug Reports | https://forums.elderscrollsonline.com/en/categories/bug-reports | Base-game and UI regressions that may affect addon feasibility or create opportunities |
| Public Test Server | https://forums.elderscrollsonline.com/en/categories/pts | Upcoming API/UI behavior, feature changes and breakage before live release |
| General ESO Discussion | https://forums.elderscrollsonline.com/en/categories/general-discussion | Broad pain points, high-engagement requests, platform complaints and user priorities |
| Game Systems | https://forums.elderscrollsonline.com/en/categories/gamesystems | Crafting, housing and system-level friction that can become addon opportunities |
| Quests and Exploration | https://forums.elderscrollsonline.com/en/categories/quests-and-exploration | Quest, map, collectible and completion pain points |
| Combat & Character Mechanics | https://forums.elderscrollsonline.com/en/categories/combat-mechanics | Buffs, bars, rotations, skills, combat feedback and HUD needs |
| PvE Group Content | https://forums.elderscrollsonline.com/en/categories/pve-group-content | Trial/dungeon mechanic alerts, group tools and encounter UX |
| PvP Activities | https://forums.elderscrollsonline.com/en/categories/pvp-activities | PvP-specific HUD, alerts, map and combat information requirements |
| Players Helping Players | https://forums.elderscrollsonline.com/en/categories/players-helping-players | Repeated user questions often reveal missing discoverability or automation |
| Patch Notes & Hotfixes | https://forums.elderscrollsonline.com/en/categories/patch-notes | Version history, platform fixes, console regressions and release timing |
| Dev Tracker | https://forums.elderscrollsonline.com/en/tracker | Staff statements and engineering responses that carry higher evidentiary weight |
| Recent discussions | https://forums.elderscrollsonline.com/en/discussions | Fresh cross-category signal feed |
| Unanswered discussions | https://forums.elderscrollsonline.com/en/discussions/unanswered | Potentially underserved pain points and niche opportunities |

## Forum restructure context

ZOS restructured the forum in late 2024 to reduce category fragmentation. The current `Game Systems` area replaced / consolidated older Crafting, Housing and Tales of Tribute discussion areas while retaining archives. That means historical research must search both the current consolidated category and older archived category URLs when looking for long-running requests.

Reference: https://forums.elderscrollsonline.com/en/discussion/668568/game-systems-category-explainer

## High-value console/addon threads already identified

### Official console addon launch and developer pipeline

**ESO Console Add-ons – Developer Uploader Tool**  
https://forums.elderscrollsonline.com/en/discussion/676627/eso-console-add-ons-developer-uploader-tool

Why it matters:
- Official ZOS launch thread for next-gen console addons.
- Confirms PS5 / Xbox Series X|S support and UI-addon scope.
- Contains launch-era player/developer behavior, publication friction and console-specific bug reports.
- Useful source for what the console browser actually does after install and reload.

### Console memory pressure and addon profiles

**Please increase available memory for addons on console**  
https://forums.elderscrollsonline.com/en/discussion/693224/please-increase-available-memory-for-addons-on-console

Why it matters:
- Direct console demand for addon profiles such as Trials, Overland and Crafting.
- Links to the existing Bethesda `Addon Loadouts` addon, so profile management is a benchmark rather than an empty market.
- Developer discussion distinguishes memory leaks / poor allocation behavior from simply raising limits.
- ZOS Lead UI Engineer Dan Batson states that Update 52 changes the console warning threshold from 70% to 85% and force-reload threshold from 90% to 100%, while the 100 MB runtime limit itself remains under consideration.

Product implication:
- Addon Doctor should focus on stability and diagnostics, not only "use less memory" messaging.
- ESO Profile Bridge should complement addon loadout selection by preserving / restoring configuration state.

### Console save-file fragility and activity-specific setups

**Console Add-On Setups (Tested - No Save Errors)**  
https://forums.elderscrollsonline.com/en/discussion/680820/console-add-on-setups-tested-no-save-errors

Why it matters:
- Long-running PS5 empirical testing of addon combinations.
- Documents SAVE ERROR behavior, activity-specific addon sets, dependency combinations and add-on interactions.
- Includes an attempted experiment to pre-save individual addon configurations into a baseline PS cloud save; the author reports this did not solve the cumulative save-file problem.
- Gives concrete examples of Crafting / Trading, Dungeons / Trials, Lite Craft & Explore and heavier do-it-all sets.

Product implication:
- Strong evidence for profile, rollback, diagnostics and configuration portability tools.
- Valuable dataset for future compatibility-matrix testing.

### Direct demand for configuration backup / export

**Tech/Dev question: Would it possible to create a way to backup configs on console?**  
https://forums.elderscrollsonline.com/en/discussion/689040/tech-dev-question-would-it-possible-to-create-a-way-to-backup-configs-on-console

Why it matters:
- This is almost exactly the problem ESO Profile Bridge is trying to solve.
- The original poster cites Wizard's Wardrobe configuration loss and asks for general console addon configuration export.
- Baertram explains that addons can only persist through SavedVariables and cannot simply write arbitrary backup files on console.
- The thread discusses QR-code / fixed-URL export, manual text entry and chat-based import.
- A developer statement in the thread notes the ESO chat message limit as 350 characters, making chunked transport a concrete design consideration.

Product implication:
- EPB is grounded in demonstrated player demand, not a hypothetical convenience.
- The likely transport layer is bounded text / chunking plus manual import, not unrestricted file access.
- QR may help export, but import still requires an actual console input path.

### Addon presets before character load

**Addon Presets At Character Load Screen**  
https://forums.elderscrollsonline.com/en/discussion/690713/addon-presets-at-character-load-screen

**Addon Presets at Character Load Screen**  
https://forums.elderscrollsonline.com/en/discussion/691509/addon-presets-at-character-load-screen

Why it matters:
- Repeated demand for choosing addon packs before loading a character to avoid an extra `/reloadui` cycle.
- Reveals a limitation of runtime profile managers: they operate after character load.

Product implication:
- We should not promise pre-character-select integration unless ZOS exposes it.
- EPB can still improve profile state inside the loaded-character context.

### Bethesda library / install synchronization

**Bethesda.net add-on settings overwriting Console Add-ons**  
https://forums.elderscrollsonline.com/en/discussion/682726/bethesda-net-add-on-settings-overwriting-console-add-ons

**[Console] Add-Ons Install themselves every time I log on since U47**  
https://forums.elderscrollsonline.com/en/discussion/683052/console-add-ons-install-themselves-every-time-i-log-on-since-u47

**Is this new with console add-ons: it automatically installs your own released add-ons?**  
https://forums.elderscrollsonline.com/en/discussion/682846/is-this-new-with-console-add-ons-it-automatically-installs-your-own-released-add-ons

Why they matter:
- Show that `mods.bethesda.net` Library state can affect what the console installs.
- Reveal synchronization behavior between Bethesda account state, console-installed addons and multiple local accounts.
- Distinguish package-library synchronization from SavedVariables / settings persistence.

Product implication:
- EPB must never conflate "which packages Bethesda installs" with "which settings an addon restores."
- A future manager UI should explicitly display these as separate layers.

### Account switching and addon list replacement

**Switching accounts is deleting addons**  
https://forums.elderscrollsonline.com/en/discussion/680367/switching-accounts-is-deleting-addons

Why it matters:
- Multiple PSN / ESO accounts on one console can create surprising addon synchronization behavior.
- This is directly relevant to EPB account/server/character scoping.

### PS5 SavedVariables / autosave problems

**Auto-Save function not working properly on console?**  
https://forums.elderscrollsonline.com/en/discussion/679588/auto-save-function-not-working-properly-on-console

**PS5 Addons - Has Autosave really been fixed?**  
https://forums.elderscrollsonline.com/en/discussion/682782/ps5-addons-has-autosave-really-been-fixed

**PS5 - saving problems again?**  
https://forums.elderscrollsonline.com/en/discussion/685125/ps5-saving-problems-again

**[CONSOLE-PS5] Save problems with some addons**  
https://forums.elderscrollsonline.com/en/discussion/688439/console-ps5-save-problems-with-some-addons

Why they matter:
- SavedVariables persistence on console has had real-world failure modes.
- Players report deleting local/cloud save data as a recovery step, which also destroys or resets configuration.
- Reinforces the value of deterministic export, rollback and explicit scope metadata.

### Missing libraries / dependency distribution

**PS5 LibAddonMenu-2.0 Missing**  
https://forums.elderscrollsonline.com/en/discussion/693134/ps5-libaddonmenu-2-0-missing

Why it matters:
- Console dependency problems can disable multiple otherwise-working addons.
- Addon Doctor should model "missing dependency / unavailable package" separately from "addon bug."

### Real console port behavior: Fancy Action Bar+

**Console Fancy Action Bar+ Issues Thread**  
https://forums.elderscrollsonline.com/en/discussion/679516/console-fancy-action-bar-issues-thread

Why it matters:
- Excellent reference for gamepad settings behavior, base-game UI conflicts and console-flow testing.
- Shows that addons cannot automatically configure every base-game option on console.
- Provides examples of console-specific behavior introduced through settings-library translation.

### Addon browser outages

**Add-ons are busted and not working on PS5**  
https://forums.elderscrollsonline.com/en/discussion/698585/add-ons-are-busted-and-not-working-on-ps5

Why it matters:
- Package-browser availability itself is an external dependency.
- EPB local profiles should remain useful even when the Bethesda browsing/distribution layer is temporarily unavailable.

## Indexing taxonomy for future forum records

Every relevant thread should be normalized into these fields:

```text
thread_id
url
title
category
created_date
last_activity_date
author
platform
server
thread_type
signal_type
feature_cluster
addon_names
replies
views
staff_comments
staff_participants
developer_participants
problem_summary
requested_capability
workaround
known_fix
technical_constraint
bethesda_mod_id
source_quality
product_relevance
epb_relevance
addon_doctor_relevance
questlens_relevance
notes
```

### `signal_type`

Use one or more of:

- `request`
- `bug`
- `support`
- `developer_explanation`
- `staff_statement`
- `release`
- `workaround`
- `performance`
- `compatibility`
- `platform_constraint`
- `market_signal`

### `feature_cluster`

Normalize demand into recurring systems instead of counting titles literally:

- addon profiles / loadouts
- settings backup / portability
- SavedVariables persistence
- dependency management
- addon diagnostics
- quest / exploration intelligence
- inventory / account intelligence
- crafting / research
- trading / pricing
- completion tracking
- HUD / accessibility
- combat / alerts
- map / navigation
- social / chat
- housing
- immersion
- developer tooling

## Evidence hierarchy

Forum evidence should be scored by speaker and content type:

1. **ZOS staff / developer statement** — strong evidence for current behavior when discussing their own system.
2. **Addon author explaining their own implementation** — strong implementation evidence.
3. **Multiple independent console reports** — strong real-world signal, weaker for internal causation.
4. **Single player report** — useful lead, not proof.
5. **Inference from thread behavior** — product hypothesis only.

Views and replies are demand signals, not truth metrics.

## Exploration strategy

A complete crawl should proceed in layers rather than treating `Add-Ons & UI Mods` as the whole corpus:

1. Current year pages in Add-Ons & UI Mods.
2. PlayStation Technical Support since console addons launched in June 2025.
3. Bug Reports matching `addon`, `add-on`, `SavedVariables`, `save error`, `PS5`, `gamepad`, `UI`, `Bethesda`.
4. General Discussion threads with unusually high engagement around pain points that could be solved through UI addons.
5. Game Systems / Quests / Combat / PvE / PvP for domain-specific requests.
6. PTS and Patch Notes for API / UI changes that can break or enable addons.
7. Dev Tracker for staff confirmations and engineering constraints.
8. Historical pre-console threads for mature PC solutions that can be reinterpreted for PS5.

## Immediate research conclusions from the wider forum

The broader forum strengthens four directions already present in this repository:

1. **ESO Profile Bridge has direct demand evidence.** Users are explicitly asking for ways to back up console addon configurations, and Wizard's Wardrobe is cited as a painful example.
2. **Addon Doctor is justified by real failure modes.** Save-file errors, dependency disappearances, memory thresholds, library conflicts and package-sync confusion are recurring classes of problems.
3. **Profiles are already a known need and partially solved.** `Addon Loadouts` exists, so our differentiation should be settings/configuration state rather than simply toggling installed addons.
4. **Package management and configuration management are separate systems on console.** Bethesda controls package subscription/install state; addons control their own runtime/SavedVariables state. EPB belongs in the second layer.

This index should remain a living document. New high-value threads should be added to `data/forum-signals.csv` and linked back to the relevant product research files.