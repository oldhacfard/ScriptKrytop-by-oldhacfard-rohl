local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local runService = game:GetService("RunService")
local uis = game:GetService("UserInputService")

local dancing = false

-- G tuşuna basınca dansı aç/kapat
uis.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.G then
        dancing = not dancing
    end
end)

-- 1. ADIM: Karakteri Gizle
for _, v in pairs(char:GetChildren()) do
    if v:IsA("BasePart") then
        v.CanCollide = false
        v.Transparency = 1 
    end
end

-- 2. ADIM: Şapkaları Hazırla
local hats = {}
for _, acc in pairs(char:GetDescendants()) do
    if acc:IsA("Accessory") and acc:FindFirstChild("Handle") then
        local h = acc.Handle
        h.Transparency = 0
        h.CanCollide = false
        h.Massless = true
        for _, obj in pairs(h:GetChildren()) do
            if obj:IsA("SpecialMesh") or obj:IsA("MeshPart") then obj:Destroy() end
        end
        for _, w in pairs(h:GetDescendants()) do
            if w:IsA("Weld") or w:IsA("ManualWeld") then w:Destroy() end
        end
        table.insert(hats, h)
    end
end

-- 3. ADIM: Ana Döngü
runService.RenderStepped:Connect(function()
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root or #hats < 1 then return end 
    
    local t = tick()
    local moveSpeed = root.Velocity.Magnitude
    local verticalVel = root.Velocity.Y
    local isMoving = moveSpeed > 2
    local isJumping = math.abs(verticalVel) > 5
    
    -- --- ANIMASYON DEĞERLERİ ---
    local idleSine = math.sin(t * 2) * 0.2
    local walkSine = math.sin(t * 10)
    local danceSine = math.sin(t * 5) -- Dans hızı
    local jumpEffect = math.clamp(verticalVel * 0.05, -0.5, 0.5)
    
    -- Fizik Kilidi
    for _, h in ipairs(hats) do h.Velocity = root.Velocity + Vector3.new(0, 25.1, 0) end
    local g = Color3.fromRGB(163, 162, 165)

    -- Temel Pozisyon (Senin istediğin gibi yukarıda tutuyoruz)
    local baseHeight = 10 + (isMoving and math.abs(math.cos(t * 10)) * 0.5 or idleSine)
    local rootCF = root.CFrame * CFrame.new(0, baseHeight, 0)

    -- DANS EFEKTİ (Gövde sağa sola yatar)
    if dancing and not isMoving and not isJumping then
        rootCF = rootCF * CFrame.Angles(0, 0, math.rad(danceSine * 20)) * CFrame.new(danceSine * 2, 0, 0)
    end

    -- 1. TORSO
    if hats[1] then
        hats[1].Size = Vector3.new(10, 12, 5)
        hats[1].Color = g
        hats[1].CFrame = rootCF * CFrame.Angles(-jumpEffect, 0, 0)
    end

    -- 2. KAFA
    if hats[2] then
        hats[2].Size = Vector3.new(4, 4, 4)
        hats[2].Color = g
        local headOffset = dancing and CFrame.Angles(0, danceSine, 0) or CFrame.new(0, 8.5, 0)
        hats[2].CFrame = rootCF * CFrame.new(0, 8.5, 0) * (dancing and CFrame.Angles(0, danceSine * 0.5, 0) or CFrame.new())
    end

    -- 3. SAĞ KOL
    if hats[3] then
        hats[3].Size = Vector3.new(3, 10, 3)
        local armPos = isJumping and CFrame.new(7, 2, 0) * CFrame.Angles(math.pi/4, 0, 0.2) or
                       isMoving and CFrame.new(7, 0, walkSine * 3) * CFrame.Angles(-walkSine * 0.5, 0, 0) or
                       dancing and CFrame.new(7, 4, 0) * CFrame.Angles(0, 0, math.rad(130 + danceSine * 20)) or
                       CFrame.new(7, 0, 0) * CFrame.Angles(idleSine * 0.2, 0, 0.1)
        hats[3].CFrame = rootCF * armPos
    end

    -- 4. SOL KOL
    if hats[4] then
        hats[4].Size = Vector3.new(3, 10, 3)
        local armPos = isJumping and CFrame.new(-7, 2, 0) * CFrame.Angles(math.pi/4, 0, -0.2) or
                       isMoving and CFrame.new(-7, 0, -walkSine * 3) * CFrame.Angles(walkSine * 0.5, 0, 0) or
                       dancing and CFrame.new(-7, 4, 0) * CFrame.Angles(0, 0, math.rad(-130 - danceSine * 20)) or
                       CFrame.new(-7, 0, 0) * CFrame.Angles(idleSine * 0.2, 0, -0.1)
        hats[4].CFrame = rootCF * armPos
    end

    -- 5. SAĞ BACAK
    if hats[5] then
        hats[5].Size = Vector3.new(4, 11, 4)
        local legPos = isJumping and CFrame.new(2.5, -8, 2) * CFrame.Angles(-math.pi/8, 0, 0) or
                       isMoving and CFrame.new(2.5, -11, -walkSine * 3.5) * CFrame.Angles(walkSine * 0.6, 0, 0) or
                       dancing and CFrame.new(3, -11, 0) * CFrame.Angles(0, 0, math.rad(danceSine * 10)) or
                       CFrame.new(2.5, -11, 0)
        hats[5].CFrame = rootCF * legPos
    end

    -- 6. SOL BACAK
    if hats[6] then
        hats[6].Size = Vector3.new(4, 11, 4)
        local legPos = isJumping and CFrame.new(-2.5, -8, 2) * CFrame.Angles(-math.pi/8, 0, 0) or
                       isMoving and CFrame.new(-2.5, -11, walkSine * 3.5) * CFrame.Angles(-walkSine * 0.6, 0, 0) or
                       dancing and CFrame.new(-3, -11, 0) * CFrame.Angles(0, 0, math.rad(danceSine * 10)) or
                       CFrame.new(-2.5, -11, 0)
        hats[6].CFrame = rootCF * legPos
    end
end)

