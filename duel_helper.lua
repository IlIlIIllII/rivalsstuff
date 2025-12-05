-- duel helper
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local duel = {}
function duel.isInDuel()
    local DuelController = require(player.PlayerScripts.Controllers.DuelController)
    if not DuelController then return false end
    local success, result = pcall(function()
        local duel = DuelController:GetDuel(player)
        return duel ~= nil
    end)
    return success and result
end
function duel.getDuelPlayers()
    if not duel.isInDuel() then return {} end
    local DuelController = require(player.PlayerScripts.Controllers.DuelController)
    if not DuelController then return {} end
    local players = {}
    local success, currentDuel = pcall(function()
        return DuelController:GetDuel(player)
    end)
    if not success or not currentDuel then return {} end
    for _, dueler in pairs(currentDuel.Duelers) do
        if dueler.Player and dueler.Player ~= player then
            local character = dueler.Player.Character
            if character then
                local humanoid = character:FindFirstChild("Humanoid")
                if humanoid and humanoid.Health > 0 then
                    table.insert(players, {
                        Player = dueler.Player,
                        Character = character,
                        Humanoid = humanoid,
                        Name = dueler.Player.Name
                    })
                end
            end
        end
    end
    return players
end
return duel

-- example usage:
-- local duel = loadstring(game:HttpGet("https://github.com/IlIlIIllII/rivalsstuff/raw/refs/heads/main/duel_helper.lua"))()
-- local teamcheck = loadstring(game:HttpGet("https://github.com/IlIlIIllII/rivalsstuff/raw/refs/heads/main/teamcheck.lua"))()
-- if duel.isInDuel() then
--     local allPlayers = duel.getDuelPlayers()
--     for _, p in pairs(allPlayers) do
--         if teamcheck.isSameTeam(p.Player) then
--             print(p.Name .. " is your teammate")
--         else
--             print(p.Name .. " is your enemy")
--         end
--     end
-- end
