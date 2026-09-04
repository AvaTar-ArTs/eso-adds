ESOProfileBridge = ESOProfileBridge or {}
local EPB = ESOProfileBridge

EPB.Util = {}

function EPB.Util:DeepCopy(value, seen)
    if type(value) ~= "table" then return value end
    seen = seen or {}
    if seen[value] then return seen[value] end

    local out = {}
    seen[value] = out

    for k, v in pairs(value) do
        out[self:DeepCopy(k, seen)] = self:DeepCopy(v, seen)
    end

    return out
end

function EPB.Util:SortedKeys(tbl)
    local keys = {}
    for k in pairs(tbl or {}) do
        keys[#keys + 1] = k
    end
    table.sort(keys, function(a, b) return tostring(a) < tostring(b) end)
    return keys
end
