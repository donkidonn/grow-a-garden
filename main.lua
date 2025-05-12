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

--teleport to specific location (currently hardcoded) 
local player = game.Players.LocalPlayer -- name of the user

local function teleportPlayer(player, position)
    local character = player.Character
    if character then
        local findChild = character:FindFirstChild("HumanoidRootPart") --find the humanoid root part if not then returns nil
        if findChild then
            findChild.CFrame = CFrame.new(position) 
        end
    end
end

teleportPlayer(player, Vector3.new(-3, 10, -79))

local player = game.Players.LocalPlayer  --get player object (name etc)
local npc = Workspace.NPCS.Steven  -- NPC object name

-- teleport to selling npc
local function teleportToSteven()
    local humanoidRootPart = npc:WaitForChild("HumanoidRootPart")

    if humanoidRootPart then
        local targetPosition = humanoidRootPart.Position  -- get the position of Steven
        local character = player.Character or player.CharacterAdded:Wait()

        -- Teleport the player by setting the player's HumanoidRootPart position
        local findChild = character:WaitForChild("HumanoidRootPart")
        hrp.CFrame = CFrame.new(targetPosition)  -- Teleport the player to Steven's position
    end
end

teleportToSteven()

