-- should work on all execs
local Players = game:GetService("Players")
local player = Players.LocalPlayer
pcall(function()
	local Gun = require(player.PlayerScripts.Modules.ItemTypes.Gun)
	if Gun and Gun.Unequip then
		local oldUnequip = Gun.Unequip
		Gun.Unequip = function(self, ...)
			self._shoot_cooldown = 0
			return oldUnequip(self, ...)
		end
	end
end)
