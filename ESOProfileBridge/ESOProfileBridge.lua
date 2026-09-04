ESOProfileBridge = ESOProfileBridge or {}
local EPB = ESOProfileBridge

EPB.name = "ESOProfileBridge"
EPB.version = "0.1.0"

local function OnAddonLoaded(_, addonName)
    if addonName ~= EPB.name then return end

    EVENT_MANAGER:UnregisterForEvent(EPB.name, EVENT_ADD_ON_LOADED)

    EPB:InitializeSavedVariables()
    EPB.AdapterRegistry:Initialize()
    EPB.ProfileUI:Initialize()

    d(string.format("|c66ccff%s|r %s loaded.", EPB.name, EPB.version))
end

EVENT_MANAGER:RegisterForEvent(EPB.name, EVENT_ADD_ON_LOADED, OnAddonLoaded)
