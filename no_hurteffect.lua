-- should work on all execs
local Players = game:GetService("Players")
local player = Players.LocalPlayer
pcall(function()
	local modules = player.PlayerScripts.Modules
	local clientEntity = require(modules:WaitForChild("ClientReplicatedClasses"):WaitForChild("ClientEntity"))
	if clientEntity and clientEntity._HurtEffect then
		clientEntity._HurtEffect = function() end
	end
end)
