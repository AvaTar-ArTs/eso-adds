ESOProfileBridge = ESOProfileBridge or {}
local EPB = ESOProfileBridge

EPB.Serializer = {}

local function encodeScalar(v)
    local t = type(v)
    if t == "nil" then return "n:" end
    if t == "boolean" then return v and "b:1" or "b:0" end
    if t == "number" then return "d:" .. tostring(v) end
    if t == "string" then
        return "s:" .. tostring(#v) .. ":" .. v
    end
    error("Unsupported scalar type: " .. t)
end

local function encodeValue(v)
    if type(v) ~= "table" then
        return encodeScalar(v)
    end

    local pieces = {"t:{"}
    for _, k in ipairs(EPB.Util:SortedKeys(v)) do
        pieces[#pieces + 1] = encodeValue(k)
        pieces[#pieces + 1] = encodeValue(v[k])
    end
    pieces[#pieces + 1] = "}"
    return table.concat(pieces)
end

function EPB.Serializer:Encode(tbl)
    return "EPB1|" .. encodeValue(tbl)
end

function EPB.Serializer:Chunk(encoded)
    local chunks = {}
    local maxLen = EPB.MAX_EXPORT_CHUNK or 320
    local i = 1
    while i <= #encoded do
        chunks[#chunks + 1] = string.sub(encoded, i, i + maxLen - 1)
        i = i + maxLen
    end
    return chunks
end

-- Decoder intentionally left as a hardened second step.
-- Never feed arbitrary Lua code to loadstring().
function EPB.Serializer:Decode(_)
    return nil, "Decoder not implemented yet"
end
