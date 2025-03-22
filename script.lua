-- Load Orion UI Library
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()

-- Bikin UI Window
local Window = OrionLib:MakeWindow({Name = "PSX Script | Auto Farm + Teleport", HidePremium = false, SaveConfig = true, ConfigFolder = "PSX_Config"})

-- Variabel Player
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Auto Farm Function
function AutoFarm()
    while getgenv().Farm do
        task.wait(0.5)
        
        -- Loop semua coin/diamond di map
        for _,v in pairs(game.Workspace["__THINGS"].Orbs:GetChildren()) do
            if v:IsA("Model") and v:FindFirstChild("TouchInterest") then
                firetouchinterest(character.HumanoidRootPart, v.PrimaryPart, 0)
                firetouchinterest(character.HumanoidRootPart, v.PrimaryPart, 1)
            end
        end
    end
end

-- Tab Farming
local FarmingTab = Window:MakeTab({ Name = "Auto Farm", Icon = "rbxassetid://4483345998", PremiumOnly = false })

FarmingTab:AddToggle({
    Name = "Auto Farm Coins & Diamonds",
    Default = false,
    Callback = function(state)
        getgenv().Farm = state
        if state then
            AutoFarm()
        end
    end
})

-- Teleport Function
function TeleportWorld(worldName)
    local worlds = {
        ["Spawn"] = CFrame.new(0, 10, 0),
        ["Fantasy"] = CFrame.new(200, 10, 0),
        ["Tech"] = CFrame.new(400, 10, 0),
        ["Axolotl"] = CFrame.new(600, 10, 0),
        ["Pixel"] = CFrame.new(800, 10, 0),
        ["Doodle"] = CFrame.new(1000, 10, 0)
    }
    
    if worlds[worldName] then
        character.HumanoidRootPart.CFrame = worlds[worldName]
    end
end

-- Tab Teleport
local TeleportTab = Window:MakeTab({ Name = "Teleport", Icon = "rbxassetid://4483345998", PremiumOnly = false })

TeleportTab:AddDropdown({
    Name = "Pilih World",
    Options = {"Spawn", "Fantasy", "Tech", "Axolotl", "Pixel", "Doodle"},
    Callback = function(selected)
        TeleportWorld(selected)
    end
})

-- Bypass Anti-Cheat
function BypassAntiCheat()
    for _,v in pairs(getgc(true)) do
        if type(v) == "function" and islclosure(v) and not is_synapse_function(v) then
            local info = debug.getinfo(v)
            if info.name == "kick" or info.name == "ban" then
                hookfunction(v, function() return end)
            end
        end
    end
end

BypassAntiCheat()

-- Show UI
OrionLib:Init()
