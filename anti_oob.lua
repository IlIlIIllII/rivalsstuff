-- should work on all execs
local ReplicatedStorage = game:GetService("ReplicatedStorage")
pcall(function()
    local GameplayUtility = require(ReplicatedStorage.Modules.GameplayUtility)
    if GameplayUtility and GameplayUtility.IsWithinOOBPart then
        GameplayUtility.IsWithinOOBPart = function()
            return nil
        end
    end
end)
