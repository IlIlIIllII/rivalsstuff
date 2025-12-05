-- should work on all execs
local device = "VR" --"Touch", "Gamepad", "MouseKeyboard", "VR"
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
pcall(function()
    local remote = ReplicatedStorage.Remotes.Replication.Fighter.SetControls
    local controllers = player.PlayerScripts.Controllers
    local fighterController = require(controllers:WaitForChild("FighterController", 10))
    if fighterController and fighterController._ReplicateControls then
        fighterController._ReplicateControls = function(self)
            remote:FireServer(device)
            if not self._last_controls_replicated_time then
                self._last_controls_replicated_time = 0
            end
            self._last_controls_replicated_time = tick()
        end
        remote:FireServer(device)
    end
end)
