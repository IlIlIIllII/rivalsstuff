-- wont work on xeno and solara
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
pcall(function()
    local GameplayUtility = require(ReplicatedStorage.Modules.GameplayUtility)
    GameplayUtility.GetSpread = function()
        return CFrame.identity
    end
end)
local FighterController = require(player.PlayerScripts.Controllers.FighterController)
local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    if method == "FireServer" and self.Name == "UseItem" then
        local args = {...}
        if typeof(args[3]) == "table" then
            args[3]["\2"] = true
        end
    end
    return oldNamecall(self, ...)
end)
