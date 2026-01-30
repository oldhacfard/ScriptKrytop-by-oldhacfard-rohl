game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("Oldhacfards FE Gale fighter V1")
game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("enjoy:D")

-- Gale Fighter: Ultimate Fix (Attack + Idle + Walk)
local player = game:GetService("Players").LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")
local tor = char:WaitForChild("Torso")
local rootPart = char:WaitForChild("HumanoidRootPart")
local runService = game:GetService("RunService")
local uis = game:GetService("UserInputService")

-- Eski animasyonları tamamen durdur
local animate = char:FindFirstChild("Animate")
if animate then animate.Disabled = true end

-- Eklemler (R6)
local rootJoint = rootPart:FindFirstChild("RootJoint")
local rShoulder = tor:FindFirstChild("Right Shoulder")
local lShoulder = tor:FindFirstChild("Left Shoulder")
local rHip = tor:FindFirstChild("Right Hip")
local lHip = tor:FindFirstChild("Left Hip")

-- C0 Pozisyon Ayarları (Karakterin yönü düzgün olması için)
local rjC0 = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-90), 0, math.rad(180))
local rsC0 = CFrame.new(1.5, 0.5, 0)
local lsC0 = CFrame.new(-1.5, 0.5, 0)

-- Değişkenler
local timer = 0
local attackTimer = 0 -- Saldırı animasyon süresi
local side = 1 -- 1: Sağ vuruş, 2: Sol vuruş
local canAttack = true

-- 1. SALDIRI ALGILAYICI (En Garanti Yöntem)
local function PerformAttack()
    if not canAttack then return end
    canAttack = false
    attackTimer = 1 -- Animasyonu başlat
    
    -- Hasar ve Efekt Kısmı
    task.spawn(function()
        task.wait(0.1) -- Yumruk ileri uzandığında hasar ver
        local hitRegion = rootPart.CFrame * CFrame.new(0, 0, -3.5)
        for _, v in pairs(workspace:GetChildren()) do
            if v:IsA("Model") and v:FindFirstChild("Humanoid") and v ~= char then
                local enemyRoot = v:FindFirstChild("HumanoidRootPart")
                if enemyRoot and (enemyRoot.Position - hitRegion.Position).Magnitude < 6 then
                    v:BreakJoints() -- Öldür
                    enemyRoot.Velocity = rootPart.CFrame.LookVector * 100 -- Fırlat
                end
            end
        end
        
        task.wait(0.2) -- Vuruşun ekranda kalma süresi
        attackTimer = 0
        side = (side == 1 and 2 or 1) -- Kombo değiştir
        canAttack = true
    end)
end

-- Tıklama ve Dokunmatik Kontrolü
uis.InputBegan:Connect(function(input, proc)
    if proc then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        PerformAttack()
    end
end)

-- 2. ANA ANİMASYON DÖNGÜSÜ
runService.RenderStepped:Connect(function(dt)
    local moveSpeed = hum.MoveDirection.Magnitude
    timer = timer + dt * (moveSpeed > 0 and 12 or 5)
    local sine = math.sin(timer)
    
    -- EĞER SALDIRIYORSA
    if attackTimer > 0 then
        if side == 1 then -- SAĞ YUMRUK
            rShoulder.C0 = rShoulder.C0:Lerp(rsC0 * CFrame.new(-0.5, 0, -1.5) * CFrame.Angles(math.rad(90), 0, math.rad(-40)), 0.3)
            lShoulder.C0 = lShoulder.C0:Lerp(lsC0 * CFrame.Angles(0, 0, math.rad(-20)), 0.2)
            rootJoint.C0 = rootJoint.C0:Lerp(rjC0 * CFrame.Angles(0, 0, math.rad(30)), 0.3)
        else -- SOL YUMRUK
            lShoulder.C0 = lShoulder.C0:Lerp(lsC0 * CFrame.new(0.5, 0, -1.5) * CFrame.Angles(math.rad(90), 0, math.rad(40)), 0.3)
            rShoulder.C0 = rShoulder.C0:Lerp(rsC0 * CFrame.Angles(0, 0, math.rad(20)), 0.2)
            rootJoint.C0 = rootJoint.C0:Lerp(rjC0 * CFrame.Angles(0, 0, math.rad(-30)), 0.3)
        end
    else
        -- IDLE (DURURKEN)
        if moveSpeed <= 0 then
            rootJoint.C0 = rootJoint.C0:Lerp(rjC0 * CFrame.new(0, 0, sine * 0.05), 0.1)
            rShoulder.C0 = rShoulder.C0:Lerp(rsC0 * CFrame.Angles(0, 0, math.rad(10 + sine * 2)), 0.1)
            lShoulder.C0 = lShoulder.C0:Lerp(lsC0 * CFrame.Angles(0, 0, math.rad(-10 - sine * 2)), 0.1)
            rHip.C0 = rHip.C0:Lerp(CFrame.new(0.5, -1, 0) * CFrame.Angles(0, 0, math.rad(5)), 0.1)
            lHip.C0 = lHip.C0:Lerp(CFrame.new(-0.5, -1, 0) * CFrame.Angles(0, 0, math.rad(-5)), 0.1)
        -- WALK (YÜRÜRKEN)
        else
            rootJoint.C0 = rootJoint.C0:Lerp(rjC0 * CFrame.new(0, 0, math.abs(sine) * 0.1) * CFrame.Angles(math.rad(-10), 0, 0), 0.1)
            rShoulder.C0 = rShoulder.C0:Lerp(rsC0 * CFrame.Angles(math.sin(timer) * 0.8, 0, 0), 0.1)
            lShoulder.C0 = lShoulder.C0:Lerp(lsC0 * CFrame.Angles(-math.sin(timer) * 0.8, 0, 0), 0.1)
            rHip.C0 = rHip.C0:Lerp(CFrame.new(0.5, -1 + math.cos(timer) * 0.3, -math.sin(timer) * 0.5) * CFrame.Angles(math.sin(timer), 0, 0), 0.2)
            lHip.C0 = lHip.C0:Lerp(CFrame.new(-0.5, -1 - math.cos(timer) * 0.3, math.sin(timer) * 0.5) * CFrame.Angles(-math.sin(timer), 0, 0), 0.2)
        end
    end
end)
