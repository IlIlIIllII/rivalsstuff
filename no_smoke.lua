-- should work on all execs
local Players = game:GetService("Players")
local player = Players.LocalPlayer
pcall(function()
    local SmokeScreen = require(player.PlayerScripts.Modules.ClientReplicatedClasses.ClientFighter.FighterInterface.SmokeScreen)
    if SmokeScreen and SmokeScreen.Update then
        SmokeScreen.Update = function(self)
            self._smoke_cloud_spring.Target = 0
            self._smoke_cloud_cover.Transparency = 1
            if self._smoke_cloud_dof then
                self._smoke_cloud_dof.Parent = nil
            end
            return
        end
    end
end)
pcall(function()
    local SmokeCloud = require(player.PlayerScripts.Modules.SmokeCloud)
    if SmokeCloud and SmokeCloud.Update then
        SmokeCloud.Update = function(self)
            if self.Model then
                self.Model:Destroy()
            end
            return true
        end
    end
end)
