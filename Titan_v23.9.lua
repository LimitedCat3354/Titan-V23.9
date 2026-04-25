--[[ 
    TITAN V23.9 (Auto-Update Compatible)
    Fix: Ghost Interaction & Movement Bypass
--]]

local Player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local TS = game:GetService("TweenService")
local Camera = workspace.CurrentCamera

-- Protection contre les exécutions multiples
if CoreGui:FindFirstChild("TitanV23_9") then CoreGui.TitanV23_9:Destroy() end

local settings = {
    ghost = false, esp = false, noclip = false, cage = false,
    theme = Color3.fromRGB(0, 255, 255),
    version = "V23.9"
}

local sg = Instance.new("ScreenGui", CoreGui); sg.Name = "TitanV23_9"

-- --- UI CLAIRE ET SCANNEBLE ---
local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 450, 0, 400); Main.Position = UDim2.new(0.5, -225, 0.4, 0)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 18); Main.BorderSizePixel = 0; Main.Active = true
Instance.new("UICorner", Main)

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 50); Title.Text = "Titan " .. settings.version; Title.TextColor3 = Color3.new(1,1,1); Title.Font = "GothamBold"; Title.TextSize = 18; Title.BackgroundTransparency = 1

local Holder = Instance.new("ScrollingFrame", Main)
Holder.Size = UDim2.new(1, -20, 1, -70); Holder.Position = UDim2.new(0, 10, 0, 60); Holder.BackgroundTransparency = 1; Holder.ScrollBarThickness = 0
Instance.new("UIListLayout", Holder).Padding = UDim.new(0, 6)

-- --- FONCTIONS ---
local function btn(txt, clbk)
    local b = Instance.new("TextButton", Holder)
    b.Size = UDim2.new(1, -10, 0, 40); b.Text = txt; b.BackgroundColor3 = Color3.fromRGB(25, 25, 30); b.TextColor3 = Color3.new(1,1,1); b.Font = "GothamSemibold"; Instance.new("UICorner", b)
    local act = false
    b.MouseButton1Click:Connect(function()
        act = not act; TS:Create(b, TweenInfo.new(0.2), {BackgroundColor3 = act and settings.theme or Color3.fromRGB(25, 25, 30)}):Play()
        b.TextColor3 = act and Color3.new(0,0,0) or Color3.new(1,1,1); clbk(act)
    end)
end

-- --- GHOST BYPASS V2 ---
local spirit = nil
btn("Ghost Mode (Proxy Interact)", function(on)
    settings.ghost = on
    local char = Player.Character
    if on and char then
        spirit = Instance.new("Part", workspace)
        spirit.Size = Vector3.new(3,3,3); spirit.Color = settings.theme; spirit.Material = "ForceField"; spirit.Anchored = true; spirit.CanCollide = false
        spirit.CFrame = char.HumanoidRootPart.CFrame
        Camera.CameraSubject = spirit
        char.HumanoidRootPart.Anchored = true -- Fixe le corps pour éviter le rubberband
    else
        if spirit then 
            char.HumanoidRootPart.Anchored = false
            char.HumanoidRootPart.CFrame = spirit.CFrame
            spirit:Destroy(); spirit = nil 
        end
        Camera.CameraSubject = char.Humanoid
    end
end)

btn("ESP Players", function(on) settings.esp = on end)
btn("Global NoClip", function(on) settings.noclip = on end)

-- --- LOOP DE RÉPLICATION ---
RS.RenderStepped:Connect(function()
    local char = Player.Character
    if not char then return end

    if settings.ghost and spirit then
        -- Mouvement de l'esprit
        local move = Vector3.new(0,0,0)
        if UIS:IsKeyDown(Enum.KeyCode.W) then move = move + Camera.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then move = move - Camera.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then move = move - Camera.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then move = move + Camera.CFrame.RightVector end
        spirit.CFrame = spirit.CFrame + (move * 2.5)

        -- INTERACTION PROXY
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("ProximityPrompt") then
                if (obj.Parent:GetPivot().Position - spirit.Position).Magnitude < 10 then
                    -- On simule l'interaction SANS TP le RootPart (Bypass anti-cheat)
                    task.spawn(function()
                        obj:InputBegan(Enum.KeyCode.E)
                        task.wait(obj.HoldDuration + 0.1)
                        obj:InputEnded(Enum.KeyCode.E)
                    end)
                end
            end
        end
    end

    if settings.noclip then
        for _, v in pairs(char:GetChildren()) do if v:IsA("BasePart") then v.CanCollide = false end end
    end
end)

-- Système de Dragging
local dragging, dragStart, startPos
Main.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true; dragStart = i.Position; startPos = Main.Position end end)
UIS.InputChanged:Connect(function(i) if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then local d = i.Position - dragStart; Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y) end end)
UIS.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)

print("Titan V23.9 chargé avec succès via Application.")
