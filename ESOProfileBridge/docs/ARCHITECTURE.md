# Architecture

ESOProfileBridge
├── Core lifecycle
├── SavedVariables-backed ProfileStore
├── AdapterRegistry
├── Deterministic Serializer
├── Gamepad/console UI
└── Addon adapters

Each adapter owns knowledge about one target addon. The core never assumes another addon's internal SavedVariables layout.

A profile is conceptually:

```lua
{
  schemaVersion = 1,
  createdAt = <timestamp>,
  world = <server>,
  addons = {
    addonA = {...},
    addonB = {...}
  }
}
```

This makes migrations and partial restores possible.
