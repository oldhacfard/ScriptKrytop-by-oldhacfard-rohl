-- made by oldhacfard v1 reanimate if you want (-net) it say it some games not work
local startTime = os.clock() -- Başlangıç zamanı

local lp = game:GetService("Players").LocalPlayer
local hb = game:GetService("RunService").Heartbeat
local gen = game:GetService("TextChatService").TextChannels.RBXGeneral

-- Bildirim eklendi (7 saniye gösterim)
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Reanimate",
    Text = "Loading Reanimate...",
    Duration = 7
})

local char = lp.Character
char.Archivable = true

local parts = {}
local cloneparts = {}
for _,v in pairs(char:GetDescendants()) do
    if v:IsA("BasePart") then
        table.insert(parts,v)
    end
end

local clone = char:Clone()
clone.Name = "reanimate"
clone.Parent = workspace
lp.Character = clone
local oldc = workspace.CurrentCamera.CFrame
workspace.CurrentCamera.CameraSubject = clone
workspace.CurrentCamera.CFrame = oldc
for _,v in pairs(clone:GetDescendants()) do
    if v:IsA("BasePart") then
        table.insert(cloneparts,v)
    end
end

char.Humanoid:ChangeState(15)
task.spawn(function()
    workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
    task.wait()
    workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
    local hrp = clone.HumanoidRootPart
    local hum = clone.Humanoid
    local opos = hrp.CFrame
    for i=1,60 do
        hum:ChangeState(3)
        hrp.CFrame = opos * CFrame.new(1,math.random(-10,10),0)
        hrp.Velocity = Vector3.new(math.random(-100,100),math.random(-100,100),math.random(-100,100))
        hb:Wait()
    end
    gen:SendAsync("-net")
    for i=1,10 do
        hum:ChangeState(3)
        hrp.CFrame = opos * CFrame.new(0,-math.random(-10,10),0)
        hrp.Velocity = Vector3.new(math.random(-100,100),math.random(-100,100),math.random(-100,100))
        hb:Wait()
    end
    hrp.CFrame = opos
    hrp.Velocity = Vector3.zero
    workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
    task.wait()
    workspace.CurrentCamera.CFrame = oldc
end)

task.spawn(function()
    if clone.Animate.Disabled == false then
        clone.Animate.Disabled = true
        task.wait()
        clone.Animate.Disabled = false
    end
end)

for _,v in parts do
    v:GetPropertyChangedSignal("CanCollide"):Connect(function()
        if v.CanCollide == true then
            v.CanCollide = false
        end
    end)
end

while char.Parent == workspace do
    for i,v in parts do
        v.CFrame = cloneparts[i].CFrame
        v.AssemblyLinearVelocity = cloneparts[i].AssemblyLinearVelocity
        v.CanCollide = false
    end
    hb:Wait()
end

clone:Destroy()

-- Bitirme süresini hesapla
local endTime = os.clock()
local elapsed = string.format("%.2f", endTime - startTime)
warn("reanimated in " .. elapsed .. " seconds")
