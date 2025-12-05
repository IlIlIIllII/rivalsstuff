-- should work on all execs
local Players = game:GetService("Players")
local player = Players.LocalPlayer
pcall(function()
    local ClientItem = require(player.PlayerScripts.Modules.ClientReplicatedClasses.ClientFighter.ClientItem)
    if ClientItem and ClientItem._Recoil then
        ClientItem._Recoil = function()
            return
        end
    end
end)
