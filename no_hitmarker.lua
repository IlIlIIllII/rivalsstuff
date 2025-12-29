local Players = game:GetService("Players")
local player = Players.LocalPlayer
pcall(function()
    local Hitmarker = require(player.PlayerScripts.Modules.ClientReplicatedClasses.ClientFighter.ClientItem.ItemInterface.Mouse.Hitmarker)
    if Hitmarker then
        Hitmarker.DamageEffect = function() end
    end
end)
