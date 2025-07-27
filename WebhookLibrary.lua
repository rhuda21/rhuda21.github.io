local http = game:GetService("HttpService")
function SendMessageEMBED(url, embed, mention)
    local payload = {
        content = mention and ("<@" .. mention .. ">") or "",
        embeds = {{
            title = embed.title,
            description = embed.description,
            color = embed.color,
            fields = embed.fields,
            footer = embed.footer and {
                text = embed.footer.text, 
                icon_url = embed.footer.icon_url
            } or nil,
            thumbnail = embed.thumbnail and {
                url = embed.thumbnail.url
            } or nil,
            image = embed.image and {
                url = embed.image.url
            } or nil,
            author = embed.author and {
                name = embed.author.name, 
                icon_url = embed.author.icon_url
            } or nil,
            timestamp = embed.timestamp
        }}
    }
    local function cleanTable(t)
        local cleaned = {}
        for k, v in pairs(t) do
            if type(v) == "table" then
                local cleanedTable = cleanTable(v)
                if next(cleanedTable) ~= nil then
                    cleaned[k] = cleanedTable
                end
            elseif v ~= nil then
                cleaned[k] = v
            end
        end
        return cleaned
    end
    payload.embeds[1] = cleanTable(payload.embeds[1])
    if next(payload.embeds[1]) == nil then
        warn("No valid embed data provided")
        return
    end
    local success, response = pcall(function()
        return request({
            Url = url,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json",
            },
            Body = http:JSONEncode(payload)
        })
    end)
    if not success then
        warn("Failed to send webhook:", response)
    end
end
