webhook = "discord webhool url"
discordID = "discord ID"


--script for webhook
local http = require("socket.http")
local ltn12 = require("ltn12")  
local json = require("json")

function webhookMessage(message, info) --sends discord message to the user
    local payload = {
        content = message,
        embeds = {
            {
                title = "G-A-G NOTIFICATION",
                description = message,
                color = 16711680, -- Red color
                footer = {
                    text = info
                }
            }
        }
    }

    local response_body = {}
    local res, code, response_headers, status = http.request{
        url = webhook,
        method = "POST",
        headers = {
            ["Content-Type"] = "application/json",
            ["Content-Length"] = tostring(#json.encode(payload))
        },
        source = ltn12.source.string(json.encode(payload)),
        sink = ltn12.sink.table(response_body)
    }

    if code == 200 then
        print("Message sent successfully!")
    else
        print("Failed to send message. Status code: " .. tostring(code))
    end
end

/* used to get all the workspace objects 
for _, obj in ipairs(workspace:GetChildren()) do
    print(obj.Name, obj.ClassName)
end
*/ 


