# PS5 / Console Add-on Platform

Research snapshot: 2026-09-04.

## What console add-ons are

ESO console add-ons are **UI add-ons**, not arbitrary game mods. They can alter presentation, surface information, automate permitted UI interactions, and react to ESO's exposed Lua/UI APIs, but they do not modify zones, models, weapons, quests or game content in the sense of a single-player mod.

Official ESO support states that console add-on support arrived in **June 2025**, is available on **PlayStation 5 and Xbox Series X|S**, and is not available on last-gen consoles.

Sources:
- https://help.elderscrollsonline.com/app/answers/detail/a_id/69621/
- https://help.elderscrollsonline.com/app/answers/detail/a_id/70903/
- https://help.elderscrollsonline.com/app/answers/detail/a_id/9127/

## Player-side management

ESO's in-game console browser supports:

- browse add-ons,
- filter by name / users / status / category,
- search,
- install,
- uninstall,
- reinstall,
- ignore updates,
- enable / disable installed add-ons,
- view disk usage.

The official documented installation limit is **100 MB total** across console add-ons.

Source:
- https://help.elderscrollsonline.com/app/answers/detail/a_id/70903/

## Developer-side publishing

Bethesda/ZeniMax provides a console add-on uploader tool. The official page explicitly points developers toward ESOUI and the ESO Add-Ons & UI Mods forums for authoring/API information.

Important PlayStation behavior documented by ESO support:

> PlayStation manifest paths are case-sensitive.

That means a package that works on Xbox can fail on PlayStation if manifest paths and actual file/folder casing do not exactly match.

Source:
- https://help.elderscrollsonline.com/app/answers/detail/a_id/69621/

## API and authoring

ESO exposes a UI API for add-on authors. Official support links to the ESOUI Wiki and add-on tutorial resources.

Source:
- https://help.elderscrollsonline.com/app/answers/detail/a_id/1081/

Useful community development hubs:

- https://www.esoui.com/forums/
- https://forums.elderscrollsonline.com/en/categories/add-ons-and-ui-mods

## Memory constraints

Console add-on memory is a first-class design constraint.

The ESOUI `MemoryUsage` utility documents the console-flow API function:

`GetTotalUserAddOnMemoryPoolUsageMB()`

It is specifically intended to show **total** add-on memory pool usage while testing in console flow mode.

Source:
- https://esoui.com/downloads/info4181-MemoryUsage.html

### Critical correction: total memory is not per-addon memory

A common idea is to build a tool that says exactly how many MB each add-on consumes. Available ESOUI developer discussion says there is no supported way to accurately attribute shared Lua memory to individual add-ons. Add-ons share libraries and objects, so naive attribution would be misleading.

Source:
- https://www.esoui.com/forums/archive/index.php/t-4669.html/t-10386.html

Therefore an `Addon Doctor` can reasonably expose:

- total console add-on memory,
- current errors,
- enabled dependencies,
- library relationships,
- event/listener activity where measurable,
- known-heavy combinations,
- user-facing warnings,
- test instrumentation,

but should **not claim precise per-addon memory accounting** unless ESO exposes a new API in the future.

## Console-first engineering principles

These are engineering inferences based on the platform constraints above:

1. Prefer event-driven behavior over constant polling.
2. Keep SavedVariables compact.
3. Avoid loading giant static datasets if data can be segmented or generated lazily.
4. Reuse shared libraries carefully, but remember shared libraries complicate resource attribution.
5. Design for controller/gamepad navigation first.
6. Test path casing explicitly for PlayStation packages.
7. Treat 100 MB as an ecosystem budget, not an invitation to consume 100 MB.
8. Build graceful degradation when optional data/features cannot load.

## Questions to prove experimentally

Before building a PS5 add-on manager/profile system, test the following directly against the API:

- Can an add-on enumerate all installed add-ons?
- What metadata is exposed for each add-on?
- Can an add-on detect enable/disable state of other add-ons?
- Can it programmatically enable/disable another add-on, or only inspect state?
- What dependency metadata is available at runtime?
- How does console flow differ from a real PS5 runtime?
- What SavedVariables size/runtime behavior changes on console?
- What is the practical CPU-time budget for loading large data tables?

Until proven, these should remain hypotheses rather than product promises.