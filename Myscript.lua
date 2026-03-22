-- [[ MEGA ADMIN V26 - EVERYTHING INCLUDED ]] --
local player = game.Players.LocalPlayer
local prefix = "+" 

-- Global States
_G.Speed = 16
_G.Jump = 50
_G.Flying = false
_G.Annoying = false
_G.Noclip = false
_G.Headsitting = false

local function notify(title, msg)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {Title = title; Text = msg; Duration = 3;})
    end)
end

-- 1. UI SETUP
local function buildUI()
    local sg = Instance.new("ScreenGui", player.PlayerGui)
    sg.Name = "MegaAdminV26"
    sg.ResetOnSpawn = false
    
    local btn = Instance.new("TextButton", sg)
    btn.Size = UDim2.new(0, 80, 0, 40)
    btn.Position = UDim2.new(0, 10, 0.5, 0)
    btn.Text = "MENU [+]"
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Draggable = true
    Instance.new("UICorner", btn)

    local frame = Instance.new("Frame", sg)
    frame.Size = UDim2.new(0, 240, 0, 320)
    frame.Position = UDim2.new(0.5, -120, 0.5, -160)
    frame.Visible = false
    frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    Instance.new("UICorner", frame)

    local scroll = Instance.new("ScrollingFrame", frame)
    scroll.Size = UDim2.new(1, -10, 1, -10)
    scroll.Position = UDim2.new(0, 5, 0, 5)
    scroll.BackgroundTransparency = 1
    scroll.CanvasSize = UDim2.new(0, 0, 3.5, 0)
    
    local label = Instance.new("TextLabel", scroll)
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.new(1,1,1)
    label.TextXAlignment = "Left"
    label.TextYAlignment = "Top"
    label.Text = [[
[ CHAOS ]
+annoy [name] (Fire)
+unannoy
+lagserver / +cleanlag
+walkfling / +unwalkfling
+headsit [name] / +unheadsit
+void [name]

[ MOVEMENT ]
+fly / +unfly
+speed [n] / +jump [n]
+noclip / +clip
+tp [name] / +re

[ CHARACTER ]
+big / +small / +normal
+copy [name]
    ]]

    btn.MouseButton1Click:Connect(function() frame.Visible = not frame.Visible end)
end

-- 2. HELPER: FIND PLAYER
local function find(n)
    for _, v in pairs(game.Players:GetPlayers()) do
        if v.Name:lower():find(n:lower()) or v.DisplayName:lower():find(n:lower()) then return v end
    end
end

-- 3. COMMAND LOGIC
player.Chatted:Connect(function(msg)
    local args = msg:lower():split(" ")
    local cmd = args[1]
    local char = player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChild("Humanoid")

    if not root then return end

    -- MOVEMENT
    if cmd == prefix.."speed" then _G.Speed = tonumber(args[2])
    elseif cmd == prefix.."jump" then _G.Jump = tonumber(args[2])
    elseif cmd == prefix.."noclip" then _G.Noclip = true
    elseif cmd == prefix.."clip" then _G.Noclip = false
    elseif cmd == prefix.."re" then char:BreakJoints()
    
    -- FLY
    elseif cmd == prefix.."fly" then
        _G.Flying = true
        local bv = Instance.new("BodyVelocity", root)
        bv.MaxForce = Vector3.new(9e9,9e9,9e9)
        task.spawn(function()
            while _G.Flying do bv.Velocity = workspace.CurrentCamera.CFrame.LookVector * 100 task.wait() end
            bv:Destroy()
        end)
    elseif cmd == prefix.."unfly" then _G.Flying = false

    -- CHAOS
    elseif cmd == prefix.."walkfling" then
        local bav = Instance.new("BodyAngularVelocity", root)
        bav.Name = "WFV"
        bav.MaxTorque = Vector3.new(0, math.huge, 0)
        bav.AngularVelocity = Vector3.new(0, 99999, 0)
    elseif cmd == prefix.."unwalkfling" then
        if root:FindFirstChild("WFV") then root.WFV:Destroy() end

    -- TARGETING
    elseif args[2] then
        local t = find(args[2])
        if t and t.Character then
            local tr = t.Character:FindFirstChild("HumanoidRootPart")
            if cmd == prefix.."annoy" then
                _G.Annoying = true
                task.spawn(function()
                    while _G.Annoying and t.Character do
                        root.CFrame = tr.CFrame * CFrame.new(0,0,1.5)
                        if t.Character:FindFirstChild("Head") and not t.Character.Head:FindFirstChild("BlindFire") then
                            for i=1, 20 do Instance.new("Fire", t.Character.Head).Name = "BlindFire" end
                        end
                        task.wait()
                    end
                end)
            elseif cmd == prefix.."headsit" then
                _G.Headsitting = true
                hum.Sit = true
                task.spawn(function()
                    while _G.Headsitting and t.Character do
                        root.CFrame = t.Character.Head.CFrame * CFrame.new(0,1.3,0)
                        task.wait()
                    end
                end)
            elseif cmd == prefix.."tp" then root.CFrame = tr.CFrame
            elseif cmd == prefix.."copy" then player.CharacterAppearanceId = t.UserId char:BreakJoints()
            elseif cmd == prefix.."void" then
                root.CFrame = tr.CFrame task.wait(0.1)
                local v = Instance.new("BodyVelocity", tr)
                v.Velocity = Vector3.new(0, -10000, 0) v.MaxForce = Vector3.new(9e9,9e9,9e9)
                task.wait(0.5) v:Destroy()
            end
        end
    end
end)

-- 4. CHARACTER SCALING
player.Chatted:Connect(function(msg)
    local hum = player.Character.Humanoid
    if msg == prefix.."big" then
        for _,v in pairs({"BodyHeightScale","BodyWidthScale","BodyDepthScale","HeadScale"}) do
            if hum:FindFirstChild(v) then hum[v].Value = 3 end
        end
    elseif msg == prefix.."small" then
        for _,v in pairs({"BodyHeightScale","BodyWidthScale","BodyDepthScale","HeadScale"}) do
            if hum:FindFirstChild(v) then hum[v].Value = 0.4 end
        end
    elseif msg == prefix.."normal" then
        for _,v in pairs({"BodyHeightScale","BodyWidthScale","BodyDepthScale","HeadScale"}) do
            if hum:FindFirstChild(v) then hum[v].Value = 1 end
        end
    end
end)

-- 5. HEARTBEATS
game:GetService("RunService").Stepped:Connect(function()
    if _G.Noclip then
        for _, v in pairs(player.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end)

game:GetService("RunService").Heartbeat:Connect(function()
    pcall(function() 
        player.Character.Humanoid.WalkSpeed = _G.Speed 
        player.Character.Humanoid.JumpPower = _G.Jump
    end)
end)

buildUI()
notify("V26 ARCHIVE", "Everything is here. Prefix [+]")
