-- should work on all execs
local Players = game:GetService("Players")
local player = Players.LocalPlayer

pcall(function()
	local viewModelModule = player.PlayerScripts.Modules.ClientReplicatedClasses.ClientFighter.ClientItem:FindFirstChild("ClientViewModel")
	if viewModelModule then
		local ClientViewModel = require(viewModelModule)
		if ClientViewModel and ClientViewModel.Update then
			local originalUpdate = ClientViewModel.Update
			ClientViewModel.Update = function(self, ...)
				local result = originalUpdate(self, ...)
				local weaponPlayer = self.ClientItem and self.ClientItem.ClientFighter and self.ClientItem.ClientFighter.Player
				if weaponPlayer == player and self.Model then
					for _, obj in pairs(self.Model:GetDescendants()) do
						if obj:IsA("BasePart") then
							obj.Transparency = 1
						elseif obj:IsA("Decal") or obj:IsA("Texture") then
							obj.Transparency = 1
						elseif obj:IsA("Highlight") then
							obj:Destroy()
						elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") then
							obj.Enabled = false
						end
					end
					if self._highlight then
						self._highlight:Destroy()
						self._highlight = nil
					end
				end
				return result
			end
		end
	end
end)
