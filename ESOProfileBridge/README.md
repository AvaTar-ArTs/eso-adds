# ESO Profile Bridge

A starter architecture for an Elder Scrolls Online addon that captures, stores, applies, and eventually imports/exports profiles of addon settings.

## Goals

- Work from one Lua core on PC, Xbox Series X|S, and PlayStation 5 where ESO's console addon API permits.
- Store profiles in ESO SavedVariables.
- Keep each third-party addon integration isolated in an adapter.
- Serialize settings into a deterministic, non-executable text format.
- Chunk export strings for console-friendly display/copy workflows.
- Avoid unsafe `loadstring()` based imports.

## Current commands

- `/epb save NAME`
- `/epb apply NAME`
- `/epb export NAME`

## Important console reality

ESO console addons are UI addons. They do not receive arbitrary filesystem or network access. Treat SavedVariables as the persistent in-game store. External export/import must therefore use a user-visible bridge such as text chunks or a future QR/web workflow, subject to the ESO API and console UI restrictions.

## Manifest strategy

- `.addon` is provided for the console-targeting package.
- `.txt` is included for convenient PC development/testing.
- API versions are currently set to `101050 101051`; verify with `/script d(GetAPIVersion())` before release.

## Next implementation steps

1. Harden and complete the decoder.
2. Add validation/schema migration.
3. Add real adapters for popular addons.
4. Add controller/gamepad-native UI.
5. Add QR export experiment if API/runtime constraints permit.
6. Build a console uploader release package.
