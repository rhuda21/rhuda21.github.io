local http = game:GetService("HttpService")
local function SendMessageEMBED(url, embed, mention)
    local payload = {
        content = mention and ("<@" .. mention .. ">") or "",
        embeds = {{
            title = embed.title,
            description = embed.description,
            color = embed.color,
            fields = embed.fields,
            footer = embed.footer and {text = embed.footer.text, icon_url = embed.footer.icon_url} or nil,
            thumbnail = embed.thumbnail and {url = embed.thumbnail.url} or nil,
            author = embed.author and {name = embed.author.name, icon_url = embed.author.icon_url} or nil,
            timestamp = embed.timestamp
        }}
    }
    local success, response = pcall(function()
        return request({
            Url = url,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json",
            },
            Body = game:GetService("HttpService"):JSONEncode(payload)
        })
    end)
    if not success then
        warn("Failed to send webhook:", response)
    end
end
return SendMessageEMBED
