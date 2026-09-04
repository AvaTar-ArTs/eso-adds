ESOProfileBridge = ESOProfileBridge or {}
local EPB = ESOProfileBridge

function EPB:InitializeSavedVariables()
    local defaults = {
        schemaVersion = EPB.PROFILE_SCHEMA_VERSION,
        profiles = {},
        activeProfile = nil,
        settings = {
            debug = false,
        },
    }

    -- Server name is incorporated into the profile namespace to avoid NA/EU collisions.
    local server = GetWorldName and GetWorldName() or "unknown"
    local namespace = "EPB-" .. tostring(server)

    EPB.sv = ZO_SavedVars:NewAccountWide(
        "ESOProfileBridgeSavedVariables",
        EPB.SV_VERSION,
        namespace,
        defaults
    )
end

function EPB:SaveProfile(profileName)
    local payload = {
        schemaVersion = EPB.PROFILE_SCHEMA_VERSION,
        createdAt = GetTimeStamp(),
        world = GetWorldName and GetWorldName() or "unknown",
        addons = EPB.AdapterRegistry:CaptureAll(),
    }

    EPB.sv.profiles[profileName] = payload
    EPB.sv.activeProfile = profileName
    return payload
end

function EPB:ApplyProfile(profileName)
    local profile = EPB.sv.profiles[profileName]
    if not profile then
        return false, "Profile not found"
    end

    EPB.AdapterRegistry:ApplyAll(profile.addons or {})
    EPB.sv.activeProfile = profileName
    return true
end

function EPB:ExportProfile(profileName)
    local profile = EPB.sv.profiles[profileName]
    if not profile then
        return nil, "Profile not found"
    end

    return EPB.Serializer:Encode(profile)
end
