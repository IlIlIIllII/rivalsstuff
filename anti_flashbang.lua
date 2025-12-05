-- should work on all execs
local Players = game:GetService("Players")
local player = Players.LocalPlayer
pcall(function()
    local Flashed = require(player.PlayerScripts.Modules.ClientReplicatedClasses.ClientFighter.FighterInterface.Flashed)
    if Flashed and Flashed.Flash then
        Flashed.Flash = function()
            return
        end
    end
end)
