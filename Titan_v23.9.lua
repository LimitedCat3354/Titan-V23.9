--[[
    TITAN V24.8 - RECOVERY VERSION
    Cette version est simplifiée au maximum pour FORCER l'affichage.
--]]

print("--- TITAN STARTING ---")

local Player = game:GetService("Players").LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Nettoyage des anciens restes (très important)
for _, v in pairs(PlayerGui:GetChildren()) do
    if v.Name == "TitanV25" or v.Name == "TitanV24" then v:Destroy() end
end

-- CRÉATION DU MENU (On utilise PlayerGui pour être sûr que ça s'affiche)
local Screen = Instance.new("ScreenGui")
Screen.Name = "TitanV24"
Screen.Parent = PlayerGui -- CHANGEMENT ICI : On évite CoreGui
Screen.ResetOnSpawn = false

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(0, 400, 0, 300)
Main.Position = UDim2.new(0.5, -200, 0.5, -150)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true -- Pour pouvoir le bouger
Main.Parent = Screen

local Corner = Instance.new("UICorner", Main)
local Stroke = Instance.new("UIStroke", Main)
Stroke.Color = Color3.fromRGB(0, 255, 150)
Stroke.Thickness = 2

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Text = "TITAN RECOVERY"
Title.TextColor3 = Color3.fromRGB(0, 255, 150)
Title.Font = "GothamBold"
Title.TextSize = 20
Title.BackgroundTransparency = 1

local Status = Instance.new("TextLabel", Main)
Status.Size = UDim2.new(1, 0, 0, 100)
Status.Position = UDim2.new(0, 0, 0.4, 0)
Status.Text = "SI TU VOIS CA, LE GITHUB MARCHE !\n\nOuvre la console (F9) et dis moi\ns'il y a du texte BLANC ou ROUGE."
Status.TextColor3 = Color3.new(1, 1, 1)
Status.BackgroundTransparency = 1

print("--- TITAN DISPLAYED SUCCESSFULLY ---")local Pages = Instance.new("Frame", Main)
Pages.Size = UDim2.new(1, -160, 1, -10); Pages.Position = UDim2.new(0, 155, 0, 5); Pages.BackgroundTransparency = 1

local function createPage(name)
    local p = Instance.new("ScrollingFrame", Pages)
    p.Name = name; p.Size = UDim2.new(1, 0, 1, 0); p.BackgroundTransparency = 1; p.Visible = false
    p.ScrollBarThickness = 2; p.CanvasSize = UDim2.new(0, 0, 2, 0)
    Instance.new("UIListLayout", p).Padding = UDim.new(0, 8)
    return p
end

-- --- FONCTION POUR CRÉER UN ONGLET ---
local function addTab(name, pageTarget)
    local btn = Instance.new("TextButton", TabContainer)
    btn.Size = UDim2.new(0, 130, 0, 35); btn.Text = name; btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    btn.TextColor3 = Color3.new(0.7, 0.7, 0.7); btn.Font = "GothamSemibold"; btn.TextSize = 14
    Instance.new("UICorner", btn)

    btn.MouseButton1Click:Connect(function()
        for _, p in pairs(Pages:GetChildren()) do p.Visible = false end
        for _, b in pairs(TabContainer:GetChildren()) do 
            if b:IsA("TextButton") then TS:Create(b, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(30, 30, 30), TextColor3 = Color3.new(0.7, 0.7, 0.7)}):Play() end
        end
        pageTarget.Visible = true
        TS:Create(btn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(0, 255, 150), TextColor3 = Color3.new(0, 0, 0)}):Play()
    end)
end

-- --- CRÉATION DES PAGES ---
local pMovement = createPage("Mouvement")
local pVisuals = createPage("Visuels")
local pGames = createPage("Jeux")
local pConfig = createPage("Paramètres")

addTab("Mouvement", pMovement)
addTab("Visuels", pVisuals)
addTab("Jeux (Brainrot)", pGames)
addTab("Paramètres", pConfig)

-- --- AJOUT DE BOUTONS (EXEMPLE) ---
local function addButton(parent, text, callback)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(1, -10, 0, 40); b.Text = text; b.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    b.TextColor3 = Color3.new(1,1,1); b.Font = "Gotham"; b.TextSize = 14
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(callback)
end

-- Page Mouvement
addButton(pMovement, "Vitesse x2", function() Player.Character.Humanoid.WalkSpeed = 32 end)
addButton(pMovement, "Saut x2", function() Player.Character.Humanoid.JumpPower = 100 end)

-- Page Jeux (Placeholder pour ton script Brainrot)
addButton(pGames, "Attente du script Brainrot...", function() print("Envoie-moi le script !") end)

-- Page Paramètres
addButton(pConfig, "Détruire Titan", function() Titan:Destroy() end)

-- Drag System
local dragging, dragStart, startPos
Main.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true; dragStart = i.Position; startPos = Main.Position end end)
UIS.InputChanged:Connect(function(i) if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then local d = i.Position - dragStart; Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y) end end)
UIS.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)

-- Ouvrir la première page par défaut
pMovement.Visible = truelocal MainStroke = Instance.new("UIStroke", Main); MainStroke.Color = settings.theme; MainStroke.Thickness = 2

-- --- BARRE DE TITRE ---
local TitleBar = Instance.new("Frame", Main)
TitleBar.Size = UDim2.new(1, 0, 0, 40); TitleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20); TitleBar.BorderSizePixel = 0

local Title = Instance.new("TextLabel", TitleBar)
Title.Size = UDim2.new(1, -100, 1, 0); Title.Position = UDim2.new(0, 15, 0, 0); Title.Text = "TITAN " .. settings.version; Title.TextColor3 = Color3.new(1,1,1); Title.Font = "GothamBold"; Title.TextSize = 16; Title.TextXAlignment = "Left"; Title.BackgroundTransparency = 1

local CloseBtn = Instance.new("TextButton", TitleBar)
CloseBtn.Size = UDim2.new(0, 40, 0, 40); CloseBtn.Position = UDim2.new(1, -40, 0, 0); CloseBtn.Text = "X"; CloseBtn.TextColor3 = Color3.new(1,1,1); CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50); CloseBtn.Font = "GothamBold"; CloseBtn.BackgroundTransparency = 1
CloseBtn.MouseButton1Click:Connect(function() sg:Destroy() end)

local MinBtn = Instance.new("TextButton", TitleBar)
MinBtn.Size = UDim2.new(0, 40, 0, 40); MinBtn.Position = UDim2.new(1, -80, 0, 0); MinBtn.Text = "-"; MinBtn.TextColor3 = Color3.new(1,1,1); MinBtn.Font = "GothamBold"; MinBtn.BackgroundTransparency = 1

MinBtn.MouseButton1Click:Connect(function()
    settings.minimized = not settings.minimized
    TS:Create(Main, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {Size = settings.minimized and UDim2.new(0, 550, 0, 40) or UDim2.new(0, 550, 0, 600)}):Play()
end)

-- --- CONTENU ---
local Holder = Instance.new("ScrollingFrame", Main)
Holder.Size = UDim2.new(1, -30, 1, -180); Holder.Position = UDim2.new(0, 15, 0, 50); Holder.BackgroundTransparency = 1; Holder.ScrollBarThickness = 3; Holder.CanvasSize = UDim2.new(0,0,3,0)
Instance.new("UIListLayout", Holder).Padding = UDim.new(0, 10)

-- --- SYSTÈME DE COMPOSANTS ---
local function createCategory(name)
    local cat = Instance.new("TextLabel", Holder)
    cat.Size = UDim2.new(1, -10, 0, 25); cat.Text = "  " .. name:upper(); cat.TextColor3 = settings.theme; cat.Font = "GothamBold"; cat.TextSize = 13; cat.TextXAlignment = "Left"; cat.BackgroundTransparency = 1; cat.Name = "Cat_" .. name
end

local function btn(txt, clbk)
    local b = Instance.new("TextButton", Holder)
    b.Size = UDim2.new(1, -10, 0, 40); b.Text = txt; b.BackgroundColor3 = Color3.fromRGB(25, 25, 25); b.TextColor3 = Color3.new(1,1,1); b.Font = "GothamSemibold"; Instance.new("UICorner", b)
    local act = false
    b.MouseButton1Click:Connect(function()
        act = not act; TS:Create(b, TweenInfo.new(0.3), {BackgroundColor3 = act and settings.theme or Color3.fromRGB(25, 25, 25)}):Play()
        b.TextColor3 = act and Color3.new(0,0,0) or Color3.new(1,1,1); clbk(act)
    end)
end

local function navBtn(txt, targetName)
    local b = Instance.new("TextButton", Holder)
    b.Size = UDim2.new(1, -10, 0, 35); b.Text = "GO TO: " .. txt; b.BackgroundColor3 = Color3.fromRGB(35, 35, 45); b.TextColor3 = settings.theme; b.Font = "GothamBold"; Instance.new("UICorner", b); Instance.new("UIStroke", b).Color = settings.theme
    b.MouseButton1Click:Connect(function()
        local target = Holder:FindFirstChild("Cat_" .. targetName)
        if target then TS:Create(Holder, TweenInfo.new(0.5), {CanvasPosition = Vector2.new(0, target.AbsolutePosition.Y - Holder.AbsolutePosition.Y + Holder.CanvasPosition.Y)}):Play() end
    end)
end

local function slider(txt, min, max, start, clbk)
    local container = Instance.new("Frame", Holder); container.Size = UDim2.new(1, -10, 0, 50); container.BackgroundColor3 = Color3.fromRGB(25, 25, 25); Instance.new("UICorner", container)
    local label = Instance.new("TextLabel", container); label.Size = UDim2.new(1, 0, 0, 20); label.Position = UDim2.new(0, 10, 0, 5); label.Text = txt .. " : " .. start; label.TextColor3 = Color3.new(1,1,1); label.Font = "GothamSemibold"; label.TextXAlignment = "Left"; label.BackgroundTransparency = 1
    local slideBack = Instance.new("Frame", container); slideBack.Size = UDim2.new(1, -20, 0, 6); slideBack.Position = UDim2.new(0, 10, 0, 35); slideBack.BackgroundColor3 = Color3.fromRGB(40, 40, 40); Instance.new("UICorner", slideBack)
    local fill = Instance.new("Frame", slideBack); fill.Size = UDim2.new((start-min)/(max-min), 0, 1, 0); fill.BackgroundColor3 = settings.theme; Instance.new("UICorner", fill)
    local function update(input)
        local pos = math.clamp((input.Position.X - slideBack.AbsolutePosition.X) / slideBack.AbsoluteSize.X, 0, 1)
        fill.Size = UDim2.new(pos, 0, 1, 0)
        local val = math.floor(min + (max - min) * pos)
        if max <= 10 then val = math.round((min + (max - min) * pos) * 10) / 10 end
        label.Text = txt .. " : " .. val; clbk(val)
    end
    slideBack.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then update(input) end end)
    UIS.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement and UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then pcall(function() update(input) end) end end)
end

-- --- MODULES ---

createCategory("Jeux")
navBtn("Steal A BRAINROT", "Steal A BRAINROT")
btn("Server Hop (Join Small Server)", function()
    local Servers = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
    for _, v in pairs(Servers.data) do
        if v.playing < v.maxPlayers and v.id ~= game.JobId then
            TeleportService:TeleportToPlaceInstance(game.PlaceId, v.id, Player)
            break
        end
    end
end)

createCategory("Steal A BRAINROT")
btn("ESP Brainrots (Coming Soon)", function() end)

createCategory("Mouvement & Physique")
btn("Ghost Mode (Proxy Interaction)", function(on)
    settings.ghost = on
    if on and Player.Character then
        spirit = Instance.new("Part", workspace); spirit.Size = Vector3.new(3,3,3); spirit.Color = settings.theme; spirit.Material = "ForceField"; spirit.Anchored = true; spirit.CanCollide = false
        spirit.CFrame = Player.Character.HumanoidRootPart.CFrame; Camera.CameraSubject = spirit; Player.Character.HumanoidRootPart.Anchored = true
    else
        if spirit then Player.Character.HumanoidRootPart.Anchored = false; Player.Character.HumanoidRootPart.CFrame = spirit.CFrame; spirit:Destroy() end
        Camera.CameraSubject = Player.Character.Humanoid
    end
end)
btn("Flight Mode (Space/Ctrl)", function(on) settings.fly = on end)
slider("Vitesse", 0, 300, 16, function(v) settings.speed = v end)
slider("Puissance Saut", 0, 500, 50, function(v) settings.jump = v end)
btn("Global NoClip", function(on) settings.noclip = on end)

createCategory("Personnalisation Perso")
slider("Taille Perso", 0.1, 3, 1, function(v) pcall(function() Player.Character.Humanoid:GetScaleValue():SetScale(v) end) end)
btn("Invisibility (Bypass Client)", function(on)
    for _, v in pairs(Player.Character:GetDescendants()) do if v:IsA("BasePart") or v:IsA("Decal") then v.Transparency = on and 1 or (v.Name == "HumanoidRootPart" and 1 or 0) end end
end)

createCategory("Visuals & World")
btn("ESP Players (Auto-Refresh)", function(on) settings.esp = on end)
btn("FullBright (Vision Nocturne)", function(on)
    Lighting.Brightness = on and 2 or 1; Lighting.OutdoorAmbient = on and Color3.new(1,1,1) or Color3.fromRGB(127, 127, 127)
end)

-- --- JOURNAL ---
local LogFrame = Instance.new("Frame", Main); LogFrame.Size = UDim2.new(1, -30, 0, 100); LogFrame.Position = UDim2.new(0, 15, 1, -115); LogFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20); Instance.new("UICorner", LogFrame)
local LogText = Instance.new("TextLabel", LogFrame); LogText.Size = UDim2.new(1, -10, 1, -10); LogText.Position = UDim2.new(0, 5, 0, 5); LogText.BackgroundTransparency = 1; LogText.TextColor3 = Color3.new(0.7,0.7,0.7); LogText.Font = "Gotham"; LogText.TextSize = 10; LogText.TextXAlignment = "Left"; LogText.TextYAlignment = "Top"
LogText.Text = "TITAN V24.6 UPDATES:\n- Sliders Vitesse/Saut/Taille\n- Catégorie JEUX & Navigation\n- Server Hop fonctionnel\n- Ghost Mode & Proxy Interaction v2"

-- --- BOUCLES ---
RS.RenderStepped:Connect(function()
    local char = Player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    if settings.ghost and spirit then
        local m = Vector3.new(0,0,0)
        if UIS:IsKeyDown(Enum.KeyCode.W) then m = m + Camera.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then m = m - Camera.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then m = m - Camera.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then m = m + Camera.CFrame.RightVector end
        spirit.CFrame = spirit.CFrame + (m * 2.5)
    end
    if settings.fly then
        local f = Vector3.new(0,0,0)
        if UIS:IsKeyDown(Enum.KeyCode.Space) then f = Vector3.new(0,2,0) end
        if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then f = Vector3.new(0,-2,0) end
        char.HumanoidRootPart.Velocity = Vector3.new(0,0,0); char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame + f + (char.Humanoid.MoveDirection * (settings.speed/15))
    end
    if settings.esp then
        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= Player and p.Character and p.Character:FindFirstChild("Head") and not p.Character.Head:FindFirstChild("TitanESP") then
                local bg = Instance.new("BillboardGui", p.Character.Head); bg.Name = "TitanESP"; bg.AlwaysOnTop = true; bg.Size = UDim2.new(0,100,0,40); bg.StudsOffset = Vector3.new(0,3,0)
                local tl = Instance.new("TextLabel", bg); tl.Size = UDim2.new(1,0,1,0); tl.BackgroundTransparency = 1; tl.TextColor3 = settings.theme; tl.Font = "GothamBold"; tl.TextSize = 14; tl.Text = p.Name
            end
        end
    end
    char.Humanoid.WalkSpeed = settings.speed; char.Humanoid.JumpPower = settings.jump
    if settings.noclip then for _, v in pairs(char:GetChildren()) do if v:IsA("BasePart") then v.CanCollide = false end end end
end)

-- Drag System
local dragging, dragStart, startPos
TitleBar.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true; dragStart = i.Position; startPos = Main.Position end end)
UIS.InputChanged:Connect(function(i) if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then local d = i.Position - dragStart; Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y) end end)
UIS.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)Holder.Size = UDim2.new(1, -20, 1, -150); Holder.Position = UDim2.new(0, 10, 0, 50); Holder.BackgroundTransparency = 1; Holder.ScrollBarThickness = 2

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
