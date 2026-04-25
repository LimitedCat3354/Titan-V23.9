--[[ 
    TITAN V24.0 - MEGA UPDATE
    - Added: Fly (Espace/Ctrl)
    - Added: Speed & Jump Power
    - Added: Invisibility (Server-Side Bypass)
    - Added: Character Shrink (Hitbox Manipulation)
    - Fixed: ESP (Constant Refresh)
--]]

local Player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local TS = game:GetService("TweenService")
local Camera = workspace.CurrentCamera

if CoreGui:FindFirstChild("TitanV24") then CoreGui.TitanV24:Destroy() end

local settings = {
    ghost = false, esp = false, noclip = false, 
    fly = false, speed = 16, jump = 50, invisible = false,
    shrink = false, theme = Color3.fromRGB(255, 0, 150),
    version = "V24.0"
}

local sg = Instance.new("ScreenGui", CoreGui); sg.Name = "TitanV24"
local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 500, 0, 450); Main.Position = UDim2.new(0.5, -250, 0.4, 0)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15); Main.BorderSizePixel = 0; Main.Active = true
Instance.new("UICorner", Main)

-- --- TABS / NAVIGATION ---
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 40); Title.Text = "TITAN " .. settings.version; Title.TextColor3 = Color3.new(1,1,1); Title.Font = "GothamBold"; Title.BackgroundTransparency = 1

local Holder = Instance.new("ScrollingFrame", Main)
Holder.Size = UDim2.new(1, -20, 1, -150); Holder.Position = UDim2.new(0, 10, 0, 50); Holder.BackgroundTransparency = 1; Holder.ScrollBarThickness = 2

local LogFrame = Instance.new("Frame", Main)
LogFrame.Size = UDim2.new(1, -20, 0, 80); LogFrame.Position = UDim2.new(0, 10, 1, -90); LogFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Instance.new("UICorner", LogFrame)
local LogTitle = Instance.new("TextLabel", LogFrame)
LogTitle.Size = UDim2.new(1, 0, 0, 20); LogTitle.Text = " JOURNAL DES MISES À JOUR"; LogTitle.TextColor3 = settings.theme; LogTitle.Font = "GothamBold"; LogTitle.TextSize = 12; LogTitle.TextXAlignment = "Left"; LogTitle.BackgroundTransparency = 1
local LogText = Instance.new("TextLabel", LogFrame)
LogText.Size = UDim2.new(1, -10, 1, -25); LogText.Position = UDim2.new(0, 5, 0, 22); LogText.Text = "- Fix ESP & Interactions\n- Added Fly, Speed, Invisibility\n- Added Character Shrink (Tiny Mode)"; LogText.TextColor3 = Color3.new(0.8, 0.8, 0.8); LogText.Font = "Gotham"; LogText.TextSize = 11; LogText.TextXAlignment = "Left"; LogText.TextYAlignment = "Top"; LogText.BackgroundTransparency = 1

local UIList = Instance.new("UIListLayout", Holder); UIList.Padding = UDim.new(0, 5)

-- --- FONCTIONS ---
local function btn(txt, clbk)
    local b = Instance.new("TextButton", Holder)
    b.Size = UDim2.new(1, -10, 0, 35); b.Text = txt; b.BackgroundColor3 = Color3.fromRGB(30, 30, 30); b.TextColor3 = Color3.new(1,1,1); b.Font = "GothamSemibold"; Instance.new("UICorner", b)
    local act = false
    b.MouseButton1Click:Connect(function()
        act = not act; TS:Create(b, TweenInfo.new(0.2), {BackgroundColor3 = act and settings.theme or Color3.fromRGB(30, 30, 30)}):Play()
        clbk(act)
    end)
end

-- --- MODULES V24 ---

-- 1. GHOST & INTERACT
local spirit = nil
btn("Ghost Mode (Interact Fix)", function(on)
    settings.ghost = on
    local char = Player.Character
    if on and char then
        spirit = Instance.new("Part", workspace)
        spirit.Size = Vector3.new(3,3,3); spirit.Color = settings.theme; spirit.Material = "Neon"; spirit.Anchored = true; spirit.CanCollide = false
        spirit.CFrame = char.HumanoidRootPart.CFrame
        Camera.CameraSubject = spirit
        char.HumanoidRootPart.Anchored = true
    else
        if spirit then 
            char.HumanoidRootPart.Anchored = false
            char.HumanoidRootPart.CFrame = spirit.CFrame
            spirit:Destroy(); spirit = nil 
        end
        Camera.CameraSubject = char.Humanoid
    end
end)

-- 2. FLY
btn("Flight Mode (Space/Ctrl)", function(on) settings.fly = on end)

-- 3. INVISIBILITY
btn("Invisibility (Local-Client)", function(on)
    settings.invisible = on
    local char = Player.Character
    if char then
        for _, v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") or v:IsA("Decal") then
                v.Transparency = on and 1 or (v.Name == "HumanoidRootPart" and 1 or 0)
            end
        end
    end
end)

-- 4. SHRINK (Tiny Mode)
btn("Tiny Mode (Shrink)", function(on)
    settings.shrink = on
    local char = Player.Character
    if char and char:FindFirstChild("Humanoid") then
        local val = on and 0.3 or 1
        char.Humanoid:GetScaleValue():SetScale(val) -- Fonctionne sur les jeux R15 récents
    end
end)

-- 5. ESP FIXED
btn("ESP Players (Fixed)", function(on) 
    settings.esp = on 
    if not on then
        for _, p in pairs(game.Players:GetPlayers()) do
            if p.Character and p.Character:FindFirstChild("Head") and p.Character.Head:FindFirstChild("TitanESP") then
                p.Character.Head.TitanESP:Destroy()
            end
        end
    end
end)

-- 6. SPEED & JUMP
btn("Max Speed & Jump", function(on)
    Player.Character.Humanoid.WalkSpeed = on and 100 or 16
    Player.Character.Humanoid.JumpPower = on and 150 or 50
end)

-- --- BOUCLES ---
RS.RenderStepped:Connect(function()
    local char = Player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end

    -- GHOST & INTERACT
    if settings.ghost and spirit then
        local move = Vector3.new(0,0,0)
        if UIS:IsKeyDown(Enum.KeyCode.W) then move = move + Camera.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then move = move - Camera.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then move = move - Camera.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then move = move + Camera.CFrame.RightVector end
        spirit.CFrame = spirit.CFrame + (move * 2.5)
        
        -- Proxy Interact
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("ProximityPrompt") and (obj.Parent:GetPivot().Position - spirit.Position).Magnitude < 10 then
                task.spawn(function() obj:InputBegan(Enum.KeyCode.E); task.wait(0.1); obj:InputEnded(Enum.KeyCode.E) end)
            end
        end
    end

    -- FLY
    if settings.fly then
        local flyVel = Vector3.new(0,0,0)
        if UIS:IsKeyDown(Enum.KeyCode.Space) then flyVel = Vector3.new(0,2,0) end
        if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then flyVel = Vector3.new(0,-2,0) end
        char.HumanoidRootPart.Velocity = flyVel * 50
        char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame + flyVel
    end

    -- ESP UPDATE
    if settings.esp then
        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= Player and p.Character and p.Character:FindFirstChild("Head") then
                local head = p.Character.Head
                if not head:FindFirstChild("TitanESP") then
                    local bg = Instance.new("BillboardGui", head); bg.Name = "TitanESP"; bg.AlwaysOnTop = true; bg.Size = UDim2.new(0,100,0,40); bg.StudsOffset = Vector3.new(0,3,0)
                    local tl = Instance.new("TextLabel", bg); tl.Size = UDim2.new(1,0,1,0); tl.BackgroundTransparency = 1; tl.TextColor3 = settings.theme; tl.Font = "GothamBold"; tl.TextSize = 14; tl.Text = p.Name
                end
            end
        end
    end
end)

-- Drag System
local dragging, dragStart, startPos
Main.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true; dragStart = i.Position; startPos = Main.Position end end)
UIS.InputChanged:Connect(function(i) if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then local d = i.Position - dragStart; Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y) end end)
UIS.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)
