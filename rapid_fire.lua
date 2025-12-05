-- should work on all execs
local Players = game:GetService("Players")
local player = Players.LocalPlayer
pcall(function()
    local Gun = require(player.PlayerScripts.Modules.ItemTypes.Gun)
    if Gun and Gun.Update then
        local oldUpdate = Gun.Update
        Gun.Update = function(self, dt, ...)
            if self._shoot_cooldown then
                self._shoot_cooldown = 0
            end
            return oldUpdate(self, dt, ...)
        end
    end
end)
