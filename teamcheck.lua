-- teamcheck module
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local teamcheck = {}
function teamcheck.isSameTeam(targetPlayer)
    if not targetPlayer or targetPlayer == player then return false end
    local playerTeamID = targetPlayer:GetAttribute("TeamID")
    local localTeamID = player:GetAttribute("TeamID")
    if playerTeamID and localTeamID then
        return playerTeamID == localTeamID
    end
    return false
end
return teamcheck

-- example usage:
-- local teamcheck = loadstring(game:HttpGet("https://github.com/IlIlIIllII/rivalsstuff/raw/refs/heads/main/teamcheck.lua"))()
-- for _, player in pairs(game.Players:GetPlayers()) do
--     if teamcheck.isSameTeam(player) then
--         print(player.Name .. " is on your team")
--     else
--         print(player.Name .. " is an enemy")
--     end
-- end
