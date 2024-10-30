local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local aimbot = loadstring("https://pastebin.com/VPm173iv")
local Player = game:GetService("Players").LocalPlayer
local Window = OrionLib:MakeWindow({Name = "Regal", HidePremium = false, SaveConfig = true, IntroEnabled = false})

OrionLib:MakeNotification({
    Name = "Logged in!",
    Content = "You are logged in as "..Player.Name..".",
    Image = "rbxassetid://4483345875",
    Time = 5
})

_G.Key = "test"
_G.KeyInput = "string"
_G.Validated = false
_G.Notifications = true

function MakeNotification(Name, Content, Time)
    if _G.Notifications then
        OrionLib:MakeNotification({
            Name = Name,
            Content = Content,
            Time = Time
        })
    end
end



function MakeScriptHub()
    print(("\n"):rep(20))
    local game_name = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
    game_name = string.lower(game_name)

    local universal = Window:MakeTab({
        Name = "Universal Settings",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })
    universal:AddToggle({
        Name = "Notifications",
        Default = true,            
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false,
        Callback = function(Value)
            OrionLib:MakeNotification({
                Name = "Notifications",
                Content = "Notifications are now "..(Value and "enabled" or "disabled"),
                Time = 5
            })

            _G.Notifications = Value
        end
    })

    if string.find(game_name, "rivals") then
        local rivals = Window:MakeTab({
            Name = "Rivals",
            Icon = "rbxassetid://4483345998",
            PremiumOnly = false
        })

        local combat = rivals:AddSection({
            Name = "Combat"
        })
        combat:AddToggle({
            Name = "Aimbot",
            Default = false,
            Callback = function(Value)
                aimbot.ToggleAimbot(Value)
            end
        })
    end
end

local Tab = Window:MakeTab({
    Name = "Key",
    Icon = "rbxassetid://4483345875",
    PremiumOnly = false
})

Tab:AddTextbox({
    Name = "Enter Key",
    Default = "Enter Key",
    TextDisappear = true,
    Callback = function(Value)
        _G.KeyInput = Value
    end
})

Tab:AddButton({
    Name = "Check key",
    Callback = function()
        if _G.KeyInput == _G.Key then
            _G.Validated = true
            MakeScriptHub()
        else
            MakeNotification("Invalid Key", "The key you entered is incorrect.", 5)
        end
    end
})