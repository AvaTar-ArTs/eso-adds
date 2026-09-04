# Source Ledger

Research snapshot: 2026-09-04.

This file keeps primary platform facts separate from community demand signals.

## Official ESO / Bethesda / ZeniMax sources

### Console developer uploader
https://help.elderscrollsonline.com/app/answers/detail/a_id/69621/

Supports:
- console add-on support added June 2025,
- PS5 / Xbox Series X|S in-game downloads,
- UI-only scope,
- PlayStation manifest paths are case-sensitive,
- developer uploader workflow exists,
- developers are responsible for addon maintenance.

Evidence grade: **Official / primary**

### Enable and manage console add-ons
https://help.elderscrollsonline.com/app/answers/detail/a_id/70903/

Supports:
- Browse Add-Ons workflow,
- search/filter/install/uninstall/reinstall/ignore updates,
- enable/disable installed addons,
- disk-usage display,
- PS5 / Xbox Series X|S only,
- 100 MB installed-addons cap,
- UI-only addons,
- language addons unsupported.

Evidence grade: **Official / primary**

### ESO add-on/UI API
https://help.elderscrollsonline.com/app/answers/detail/a_id/1081/

Supports:
- ESO exposes a UI API for addon authors,
- ESOUI Wiki / tutorials are official recommended learning resources,
- console uploader docs are linked from official support.

Evidence grade: **Official / primary**

### What add-ons are
https://help.elderscrollsonline.com/app/answers/detail/a_id/9127/

Supports:
- addons customize the UI,
- community-made / unsupported by ESO customer support,
- addons must be free under ESO terms.

Evidence grade: **Official / primary**

---

## Developer / ESOUI sources

### MemoryUsage
https://esoui.com/downloads/info4181-MemoryUsage.html

Supports:
- `GetTotalUserAddOnMemoryPoolUsageMB()` exists for console flow mode,
- tool is intended for total addon-memory monitoring during console development,
- console memory optimization matters.

Evidence grade: **Developer utility / strong technical evidence**

### Per-addon memory discussion
https://www.esoui.com/forums/archive/index.php/t-4669.html/t-10386.html

Supports:
- no known reliable ESO Lua/API mechanism for measuring exact memory consumption separately per addon,
- shared UI objects / libraries complicate attribution.

Evidence grade: **Developer discussion / strong constraint signal**

---

## Current community usage and recommendations

### PS5 question, June 2026
https://www.reddit.com/r/elderscrollsonline/comments/1tvwl1a/ps5_question/

Signals:
- Code's Combat Alerts
- CrutchAlerts
- Lazy Writ Crafter
- HarvestMap
- Skyshards / Lorebooks
- TSC pricing
- 702 tracker
- Battle Scrolls
- Can Craft Master Writ

Evidence grade: **Community usage signal**

### Addons for PS5, June 2026
https://www.reddit.com/r/elderscrollsonline/comments/1u8bgm1/addons_for_ps5/

Signals:
- BeamMeUp
- Chat Log Preserver
- Circular Votan's Minimap
- Votan's Minimap
- Got To Open 'Em All
- Map Pins
- Stay Mounted
- Wizard's Wardrobe
- Code's Combat Alerts
- CrutchAlerts
- Can Craft Master Writ
- 702
- Volcano's Stat Colors
- Points of Color
- Rainbow Reticle

Evidence grade: **Community usage signal**

### Most impactful PS5 addons, July 2026
https://www.reddit.com/r/elderscrollsonline/comments/1v4ar1j/most_impactful_ps5_addons/

Signals:
- Wizard's Wardrobe
- Murf's Treasures
- Lazy Writ Crafter
- AutoLoot+
- Murf's map addons
- Tamriel Savings Co.

Evidence grade: **Community usage signal**

### Best addons for console, May 2026
https://www.reddit.com/r/elderscrollsonline/comments/1tcwp9s/best_addons_for_console/

Signals:
- Antiquarians Codex
- AutoBind Uncollected Set Items
- QAutoConfirm
- Auto Extract
- Auto Recharge and Repair
- Abah's Appraiser
- Code's Combat Alerts
- CrutchAlerts

Evidence grade: **Community usage signal**

### New-player console addons, August 2026
https://www.reddit.com/r/elderscrollsonline/comments/1w3a813/downloading_game_right_now_and_saw_addons_are_a/

Signals:
- minimap
- skyshards / lorebooks / treasure-map tools
- auto repair/recharge
- Auto Bind
- Lazy Writ Crafter

Evidence grade: **Community usage signal**

### Older PS5 recommendation thread, October 2025
https://www.reddit.com/r/elderscrollsonline/comments/1obe4gh/

Signals:
- minimap
- Lazy Writ Crafter
- treasure/survey mapping
- house hotkey
- Wizard's Wardrobe
- TSC market helper
- Code's Combat Alerts
- CrutchAlerts
- AutoBind
- 702 Craft Completionist

Evidence grade: **Community usage signal**

---

## Missing / requested capability sources

### Quest starter markers, July 2026
https://www.reddit.com/r/elderscrollsonline/comments/1upfb9u/console_addon_question/

Signal:
- PS5 player explicitly wants the PC-style quest-starter/exclamation-mark map experience,
- multiple replies say they also want it,
- discussion raises console memory concerns.

Evidence grade: **Direct demand signal**

### Side-quest finder, August 2026
https://www.reddit.com/r/elderscrollsonline/comments/1vp6k09/ps5_addon_for_trackingfinding_sidequests/

Signal:
- current PS5 player asks for side-quest-giver map markers and remaining side-quest visibility.

Evidence grade: **Direct demand signal**

### Side Quests console beta, March 2026
https://www.reddit.com/r/elderscrollsonline/comments/1rhmnnq/creating_a_new_addon/

Signals:
- developer is building a console Quest Map-like addon,
- beta exists,
- current implementation has completed-quest filtering and database quality limitations,
- author proposes collaborative data cleanup.

Evidence grade: **Developer + community signal**

---

## Supporting ecosystem sources from earlier research

These were referenced in the conversation and should be individually revalidated before we build claims on them:

- ESOUI main addons/forums: https://www.esoui.com/
- ESO Add-Ons & UI Mods forum: https://forums.elderscrollsonline.com/en/categories/add-ons-and-ui-mods
- Addon Selector (PC reference architecture): https://www.esoui.com/downloads/info1161-AddonSelectorSaveLoadAddOnprofilespacks.html
- ESO Addon Manager open-source project discussed as a modern PC manager reference: https://github.com/arviceblot/eso-addons

Evidence grade: **Reference architecture / requires targeted follow-up**

## Research rule

When a future document says something is "available on PS5," prefer one of these proof levels:

1. official Bethesda/ESO catalog or documentation,
2. addon author explicitly confirms PlayStation/console support,
3. multiple recent PS5 users report using it,
4. single community report only.

Store the proof level in the eventual census instead of flattening all evidence into a yes/no column.