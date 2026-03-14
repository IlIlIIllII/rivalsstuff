local script_code = [[
local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RS = game:GetService("RunService")
local lp = Players.LocalPlayer

if not game:IsLoaded() then game.Loaded:Wait() end

local EnumLibrary = require(game.ReplicatedStorage.Modules:WaitForChild("EnumLibrary"))
EnumLibrary:WaitForEnumBuilder()

local ctrl = lp.PlayerScripts:WaitForChild("Controllers")
local cc = require(ctrl:WaitForChild("CameraController"))

local on = false
local gui = Instance.new("ScreenGui", lp.PlayerGui)
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
local btn = Instance.new("ImageButton", gui)
btn.Size = UDim2.fromOffset(70, 70)
btn.Position = UDim2.fromOffset(workspace.CurrentCamera.ViewportSize.X - 90, workspace.CurrentCamera.ViewportSize.Y - 160)
btn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
btn.BackgroundTransparency = 0.5
btn.AutoButtonColor = false
Instance.new("UICorner", btn).CornerRadius = UDim.new(1, 0)

local dragging, moved, last, ox, oy = false, false, Vector2.zero, 0, 0

btn.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        dragging, moved = true, false
        last = Vector2.new(i.Position.X, i.Position.Y)
        ox, oy = btn.Position.X.Offset, btn.Position.Y.Offset
    end
end)

UIS.InputChanged:Connect(function(i)
    if not dragging then return end
    if i.UserInputType ~= Enum.UserInputType.MouseMovement and i.UserInputType ~= Enum.UserInputType.Touch then return end
    local d = Vector2.new(i.Position.X, i.Position.Y) - last
    if d.Magnitude > 5 then moved = true end
    if moved then
        local vp = workspace.CurrentCamera.ViewportSize
        btn.Position = UDim2.fromOffset(math.clamp(ox + d.X, 0, vp.X - 70), math.clamp(oy + d.Y, 0, vp.Y - 70))
    end
end)

UIS.InputEnded:Connect(function(i)
    if i.UserInputType ~= Enum.UserInputType.MouseButton1 and i.UserInputType ~= Enum.UserInputType.Touch then return end
    if dragging and not moved then on = not on; btn.BackgroundTransparency = on and 0 or 0.5 end
    dragging = false
end)

UIS.InputBegan:Connect(function(i, g)
    if not g and i.KeyCode == Enum.KeyCode.Q then on = not on; btn.BackgroundTransparency = on and 0 or 0.5 end
end)

local function closest()
    if not cc._current_subject then return nil end
    local myEnv = lp:GetAttribute("EnvironmentID")
    local myTeam = lp:GetAttribute("TeamID")
    local cam = workspace.CurrentCamera
    local camPos = cam.CFrame.Position
    local cx, cy = cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2
    local best, bd = nil, math.huge
    for _, p in ipairs(Players:GetPlayers()) do
        if p == lp then continue end
        if p:GetAttribute("EnvironmentID") ~= myEnv then continue end
        if myTeam ~= nil and p:GetAttribute("TeamID") == myTeam then continue end
        local char = p.Character
        if not char then continue end
        local head = char:FindFirstChild("Head")
        local hum = char:FindFirstChild("Humanoid")
        if not head or not hum or hum.Health <= 0 then continue end
        local aimPos = head.Position
        local sp, vis = cam:WorldToViewportPoint(aimPos)
        if not vis then continue end
        local d = ((sp.X - cx)^2 + (sp.Y - cy)^2)^0.5
        if d < bd then bd = d; best = {pos = aimPos, camPos = camPos} end
    end
    return best
end

RS.Heartbeat:Connect(function()
    if not on then return end
    local t = closest()
    if not t then return end
    cc:MimicRotation(CFrame.lookAt(t.camPos, t.pos).Rotation)
end)
]]

loadstring(script_code)()
queue_on_teleport(script_code)
-- WAS MADE BY zzz (1181596987620077675)
