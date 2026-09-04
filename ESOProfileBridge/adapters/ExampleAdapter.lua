ESOProfileBridge = ESOProfileBridge or {}
local EPB = ESOProfileBridge

local ExampleAdapter = {}

function ExampleAdapter:IsAvailable()
    return true
end

function ExampleAdapter:Capture()
    -- Replace this with a supported addon's public settings API
    -- or a carefully scoped SavedVariables adapter.
    return {
        exampleSetting = true,
    }
end

function ExampleAdapter:Apply(payload)
    if type(payload) ~= "table" then return end
    -- Apply validated values here.
end

EPB.AdapterRegistry:Register("example", ExampleAdapter)
