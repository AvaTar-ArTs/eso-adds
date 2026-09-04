ESOProfileBridge = ESOProfileBridge or {}
local EPB = ESOProfileBridge

EPB.AdapterRegistry = {
    adapters = {},
}

function EPB.AdapterRegistry:Register(id, adapter)
    assert(type(id) == "string", "adapter id must be a string")
    assert(type(adapter) == "table", "adapter must be a table")
    self.adapters[id] = adapter
end

function EPB.AdapterRegistry:Initialize()
    for _, adapter in pairs(self.adapters) do
        if adapter.Initialize then
            adapter:Initialize()
        end
    end
end

function EPB.AdapterRegistry:CaptureAll()
    local out = {}
    for id, adapter in pairs(self.adapters) do
        if not adapter.IsAvailable or adapter:IsAvailable() then
            if adapter.Capture then
                out[id] = adapter:Capture()
            end
        end
    end
    return out
end

function EPB.AdapterRegistry:ApplyAll(payloads)
    for id, payload in pairs(payloads or {}) do
        local adapter = self.adapters[id]
        if adapter and (not adapter.IsAvailable or adapter:IsAvailable()) then
            if adapter.Apply then
                adapter:Apply(payload)
            end
        end
    end
end
