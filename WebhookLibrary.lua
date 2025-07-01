local http = game:GetService("HttpService")
local function SendMessageEMBED(url, embed, mention)
    local response = request({
        Url = url,
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json",
        },
        Body = http:JSONEncode({
            content = mention and ("<@" .. mention .. ">") or nil,
            embeds = {{
                title = embed.title,
                description = embed.description,
                color = embed.color,
                fields = embed.fields,
                footer = {
                    text = embed.footer.text,
                    icon_url = embed.footer.icon_url
                },
                thumbnail = {
                    url = embed.thumbnail.url
                },
                author = {
                    name = embed.author.name,
                    icon_url = embed.author.icon_url 
                }
            }}
        })
    })
end

return SendMessageEMBED
