ESOProfileBridge = ESOProfileBridge or {}
local EPB = ESOProfileBridge

EPB.ProfileUI = {}

function EPB.ProfileUI:Initialize()
    SLASH_COMMANDS["/epb"] = function(text)
        text = text or ""
        local command, rest = text:match("^(%S*)%s*(.-)$")

        if command == "save" and rest ~= "" then
            EPB:SaveProfile(rest)
            d("Saved profile: " .. rest)

        elseif command == "apply" and rest ~= "" then
            local ok, err = EPB:ApplyProfile(rest)
            d(ok and ("Applied profile: " .. rest) or ("EPB error: " .. tostring(err)))

        elseif command == "export" and rest ~= "" then
            local encoded, err = EPB:ExportProfile(rest)
            if not encoded then
                d("EPB error: " .. tostring(err))
                return
            end

            local chunks = EPB.Serializer:Chunk(encoded)
            d(string.format("Export contains %d chunk(s).", #chunks))
            for i, chunk in ipairs(chunks) do
                d(string.format("EPB[%d/%d] %s", i, #chunks, chunk))
            end

        else
            d("/epb save <name> | /epb apply <name> | /epb export <name>")
        end
    end
end
