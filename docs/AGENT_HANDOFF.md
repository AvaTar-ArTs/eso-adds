# ESO Profile Bridge — Comprehensive Agent Handoff

## 1. Executive Brief

This project is developing an Elder Scrolls Online addon framework tentatively named **ESO Profile Bridge (EPB)**. The original problem emerged from researching ESO console addons and recurring player pain points. The project then narrowed toward a more infrastructural opportunity: give players a controlled way to capture, organize, restore, and where technically possible transfer addon configuration profiles.

This is **not** currently assumed to be a magical filesystem backup utility. ESO addons operate inside ZeniMax Online Studios' UI addon sandbox. The design therefore treats ESO SavedVariables as the in-game persistence layer and treats cross-device or external import/export as a constrained bridge that must be proven experimentally. Every future agent should preserve this distinction.

## 2. User Intent and Product Vision

Steven is exploring how to create his own ESO addons, especially addons that solve console/PS5 problems rather than merely cloning PC conveniences. The current flagship concept is a profile/settings portability layer. A player should eventually be able to create named configurations such as `Trials`, `Solo`, `Crafting`, `PvP`, or `Accessibility`, capture compatible addon settings into those profiles, restore them later, and selectively move or reproduce configurations when the platform permits.

Long-range product vision:

- One common profile model spanning multiple compatible addons.
- Per-addon adapters rather than brittle direct coupling inside the core.
- Account/server/character-aware scopes.
- Schema versions and migrations so old profiles survive addon evolution.
- Gamepad-native management UI suitable for console.
- Selective capture and selective restore instead of all-or-nothing state replacement.
- Human-readable or machine-readable export representation.
- Potential chunked text, QR, companion-web, or other transfer mechanisms only after API feasibility is demonstrated.
- A reusable framework that other addon authors could integrate with.

## 3. Research Conclusions So Far

ESO addons are Lua-based UI extensions driven by ZOS APIs, events, controls, manifests, and SavedVariables. Console addon support changes the distribution surface but does not turn addons into unrestricted applications. The console design must assume a sandboxed UI environment, strict packaging expectations, gamepad interaction, and no arbitrary filesystem/network bridge unless a documented API explicitly provides one.

Current research also indicated that console addon development/distribution has an official ZeniMax developer workflow and that manifests/API versions must be kept current. Do not freeze the prototype's `APIVersion` numbers into product doctrine. Verify live and PTS API versions immediately before testing or release.

## 4. Core Architectural Decision

The system is intentionally decomposed as:

```text
ESO runtime
  -> EPB lifecycle
  -> Profile Store
  -> Adapter Registry
  -> Addon Adapters
  -> Serializer / Transfer Layer
  -> Gamepad / Console UI
```

The **adapter boundary** is the most important decision. The core should not indiscriminately inspect or overwrite every addon's internal SavedVariables. Each integration should explicitly describe availability, capture behavior, validation, apply behavior, version compatibility, and migration rules. This keeps failures local and allows individual integrations to be disabled without destabilizing EPB.

## 5. Prototype Created

The starter project currently has this structure:

```text
ESOProfileBridge/
  ESOProfileBridge.addon
  ESOProfileBridge.txt
  ESOProfileBridge.lua
  README.md
  core/
    Constants.lua
    Util.lua
    Serializer.lua
    ProfileStore.lua
    AdapterRegistry.lua
  adapters/
    ExampleAdapter.lua
  ui/
    ProfileUI.lua
  docs/
    ARCHITECTURE.md
```

The current scaffold implements or sketches:

- `EVENT_ADD_ON_LOADED` lifecycle initialization.
- Account-wide SavedVariables initialization with a world/server namespace.
- Named profile storage.
- Adapter registration, capture-all, and apply-all flows.
- Deep-copy/sorted-key utilities.
- A deterministic serializer prototype.
- Chunking of exported text.
- Slash-command prototype: `/epb save <name>`, `/epb apply <name>`, `/epb export <name>`.
- An `ExampleAdapter` showing the intended integration contract.

## 6. What Is Prototype vs. Proven

Agents must distinguish implemented scaffolding from validated ESO behavior. The Lua project has not yet been presented as a production-tested console addon.

The serializer decoder is intentionally unfinished. The current export chunk size is a design placeholder. The example adapter does not yet integrate a real third-party addon. The UI is presently slash-command oriented, not a finished gamepad screen. Manifest/API values must be revalidated against the current ESO build.

## 7. SavedVariables Strategy

SavedVariables are the canonical in-game persistence mechanism. EPB currently creates account-wide state containing:

- `schemaVersion`
- `profiles`
- `activeProfile`
- EPB settings

Profiles contain metadata plus an `addons` map keyed by adapter ID. Server/world identity is included because ESO environments can have server-specific state and name collisions must be avoided.

Conceptual profile:

```lua
{
  schemaVersion = 1,
  createdAt = <timestamp>,
  world = <world/server>,
  addons = {
    addonA = { ...validated settings... },
    addonB = { ...validated settings... }
  }
}
```

## 8. Import / Export Philosophy

The transfer problem is deliberately separated from profile storage. First make profile capture/restore trustworthy inside ESO. Then solve transport.

Never assume that `export` means writing a normal file on PS5. A viable console export might instead render encoded data to UI, split it into chunks, encode it visually, or hand it to a supported platform mechanism. A viable import must likewise be based on an actually available input path.

Security rule: **do not deserialize user input by executing it as Lua**. In particular, do not use `loadstring()` as the import mechanism. Build a bounded parser for a narrow data grammar, validate types/ranges/keys, impose payload limits, verify schema versions, and reject unknown or malformed content.

## 9. Adapter Contract to Evolve

Each adapter should ultimately expose something close to:

```text
id / displayName / version
IsAvailable()
GetCompatibility()
Capture(context)
Validate(payload)
Apply(payload, context)
Migrate(payload, fromVersion, toVersion)
DescribeSettings()
GetScope()        -- account / character / server as appropriate
RequiresReload() -- whether UI reload is needed after restore
```

Prefer a target addon's documented/public API where available. Direct manipulation of another addon's SavedVariables should be treated as compatibility-sensitive and tested against exact versions. Never silently overwrite unknown fields.

## 10. Gamepad / Console UX Direction

The finished console experience should not depend on slash commands. Build a gamepad-native screen using ESO's established menu/control patterns.

Desired flow:

```text
Open Profile Bridge
  -> see profiles
  -> inspect included addons
  -> Save Current / Apply / Duplicate / Rename / Delete / Export
  -> confirmation
  -> validation/result report
```

Dangerous operations need previews and clear rollback expectations.

Requirements:

- Show which adapters are installed and compatible.
- Show what will change before applying a profile.
- Allow individual addons to be excluded.
- Mark profiles created under older schemas.
- Warn when a target addon is missing or incompatible.
- Surface whether reload/relog is required.
- Never destroy the current configuration without first offering a snapshot/rollback profile.

## 11. Recommended Development Process

### Phase A — Verify platform facts

Recheck official ESO addon documentation, current API version, manifest rules, console uploader requirements, SavedVariables behavior, permitted controls/input APIs, and console-specific restrictions. Separate official facts from forum/community experiments.

### Phase B — Establish PC test harness

Install the addon in a PC ESO development environment first because iteration/logging is easier. Verify loading, SavedVariables creation, server namespaces, profile save/apply, reload behavior, and error handling.

### Phase C — Complete serializer

Specify the EPB wire grammar, implement a non-executing decoder, add escaping, maximum depth/size, deterministic ordering, corruption detection/checksum, schema validation, and malformed-input tests.

### Phase D — Integrate one real addon

Choose one simple, actively maintained addon with understandable settings. Build a production adapter. Prove capture → mutate → restore → reload. Document exactly which fields are supported.

### Phase E — Profile safety

Add transactional apply behavior where practical: snapshot current state, validate the entire incoming payload, apply supported changes, record failures, and provide rollback.

### Phase F — Native UI

Replace slash-command dependence with keyboard and gamepad-friendly UI. Test at console-safe resolutions and controller navigation.

### Phase G — Transport experiments

Test text chunk export first. Then investigate whether QR rendering, clipboard-like platform facilities, companion-web encoding, or another approved bridge is genuinely possible. Record failed experiments as evidence.

### Phase H — Console packaging

Create the correct console manifest/package, audit case sensitivity and dependencies, validate size limits, test through the official uploader path, and perform real PS5/controller QA.

## 12. Research Questions Still Open

- What exact data entry/copy mechanisms are exposed to an ESO addon on PS5 today?
- Can an addon reliably render a scannable QR code using ESO UI texture/control primitives within acceptable performance limits?
- What are the practical limits for text edit controls, chat output, strings, SavedVariables payload size, and UI rendering?
- Which console addons expose stable/public APIs suitable for adapters?
- How do console addon updates affect SavedVariables compatibility and migration?
- What official review/security requirements apply to an addon whose purpose includes serialized import/export?
- Can profiles be meaningfully portable between NA/EU, accounts, characters, or devices without including identifiers that should remain local?
- Which settings require UI reload, zone change, relog, or cannot safely be changed at runtime?

## 13. Agent Guardrails

- Do not claim PS5 filesystem access, arbitrary network access, clipboard access, QR import, or cross-device transfer unless verified.
- Do not equate PC addon behavior with console behavior without testing/documentation.
- Do not execute imported strings as Lua.
- Do not bulk-copy arbitrary SavedVariables tables and call that compatibility.
- Do not overwrite user state without validation and a rollback strategy.
- Do not assume an addon is compatible merely because its settings table can be found.
- Do not publish stale `APIVersion` values. Verify immediately before release.
- Prefer official ZOS/Bethesda documentation for platform facts. Use ESOUI/forum material for implementation knowledge and clearly label it as community evidence.

## 14. Definition of a Successful MVP

MVP does **not** require magical cross-console synchronization.

MVP is successful when EPB can:

- load cleanly,
- create multiple named profiles,
- capture and restore its own state plus at least one real supported addon through an adapter,
- validate payloads,
- survive `/reloadui`,
- provide a usable controller-oriented interface,
- snapshot before destructive restores,
- produce a deterministic export representation that can be inspected and reconstructed in a test environment.

## 15. Definition of the Larger Product

Beyond MVP, EPB becomes a compatibility platform: a registry of addon adapters, a portable profile schema, migration machinery, controller-native management, diagnostics, backup/rollback, and a carefully researched transfer bridge.

The most interesting moat is not merely `backup settings`. It is **normalized configuration intelligence across otherwise unrelated ESO addons**. Once settings have schemas and adapters, EPB can support presets, diffing, profile composition, compatibility reports, migration, sharing, and potentially community-distributed configuration recipes.

## 16. Immediate Next-Agent Assignment

Start by auditing the generated `ESOProfileBridge` template line by line against the current official ESO API. Do not rewrite everything immediately.

Produce a compatibility matrix containing:

- current code assumption,
- authoritative API evidence,
- PC status,
- PS5 status,
- risk,
- required change.

Then implement the hardened serializer/decoder and one real addon adapter behind tests. Only after those foundations pass should substantial time be spent on visual UI or QR transfer.

## 17. Existing Artifact

The repository's `ESOProfileBridge/` directory contains the scaffold described above. Treat it as a starting checkpoint, not an immutable specification.

## 18. Compact Context Prompt for a New Agent

> You are continuing development of ESO Profile Bridge, a research-driven Elder Scrolls Online addon framework aimed especially at console/PS5 users. Its purpose is to capture, store, validate, restore, and eventually transport configuration profiles for compatible ESO addons. The architecture uses ESO SavedVariables for persistence and per-addon adapters for interoperability. External import/export is an unresolved transport problem and must never be assumed to have filesystem/network access. Audit all platform claims against current official ZOS documentation. Preserve safety: no loadstring deserialization, validate before apply, snapshot before destructive changes, isolate compatibility inside adapters, version schemas, and design for controller-native UI. The current scaffold has ProfileStore, AdapterRegistry, Serializer, ExampleAdapter, slash commands, and PC/console manifest placeholders. First validate the scaffold, complete secure serialization, integrate one real addon, and prove save/mutate/restore before pursuing QR or companion transfer.
