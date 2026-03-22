-- [[ MEGA ADMIN V28 - DASH PREFIX [-] ]] --
local player = game.Players.LocalPlayer
local prefix = "-" 

-- 1. STABLE NOTIFICATION
local function notify(title, msg)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = title;
            Text = msg;
            Duration = 4;
        })
    end)
end

-- 2. UI SETUP (STABLE & DRAGGABLE)
local function buildUI()
    local sg = Instance.new("ScreenGui", player.PlayerGui)
    sg.Name = "MegaAdminV28"
    sg.ResetOnSpawn = false
    
    local btn = Instance.new("TextButton", sg)
    btn.Size = UDim2.new(0, 90, 0, 45)
    btn.Position = UDim2.new(0, 10, 0.5, 0)
    btn.Text = "MENU [-]"
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Draggable = true
    Instance.new("UICorner", btn)

    local frame = Instance.new("Frame", sg)
    frame.Size = UDim2.new(0, 240, 0, 320)
    frame.Position = UDim2.new(0.5, -120, 0.5, -160)
    frame.Visible = false
    frame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    Instance.new("UICorner", frame)

    local scroll = Instance.new("ScrollingFrame", frame)
    scroll.Size = UDim2.new(1, -10, 1, -10)
    scroll.Position = UDim2.new(0, 5, 0, 5)
    scroll.BackgroundTransparency = 1
    scroll.CanvasSize = UDim2.new(0, 0, 3, 0)
    
    local label = Instance.new("TextLabel", scroll)
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.new(1,1,1)
    label.TextXAlignment = "Left"
    label.TextYAlignment = "Top"
    label.TextSize = 14
    label.Text = [[
[ CHAOS ]
-annoy [name] (Fire Screen)
-unannoy
-lagserver / -cleanlag
-walkfling / -unwalkfling
-headsit [name] / -unheadsit
-void [name]

[ MOVEMENT ]
-fly / -unfly
-speed [n] / -jump [n]
-noclip / -clip
-tp [name] / -re

[ CHARACTER ]
-big / -small / -normal
-copy [name]
    ]]

    btn.MouseButton1Click:Connect(function() frame.Visible = not frame.Visible end)
end

-- 3. COMMAND LOGIC
player.Chatted:Connect(function(msg)
    local args = msg:lower():split(" ")
    local cmd = args[1]
    local char = player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChild("Humanoid")

    if not root or not hum then return end

    -- BASIC MOVEMENT
    if cmd == prefix.."speed" then _G.Speed = tonumber(args[2])
    elseif cmd == prefix.."jump" then _G.Jump = tonumber(args[2])
    elseif cmd == prefix.."re" then char:BreakJoints()
    elseif cmd == prefix.."noclip" then _G.Noclip = true
    elseif cmd == prefix.."clip" then _G.Noclip = false
    
    -- FLY
    elseif cmd == prefix.."fly" then
        _G.Flying = true
        local bv = Instance.new("BodyVelocity", root)
        bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        task.spawn(function()
            while _G.Flying do bv.Velocity = workspace.CurrentCamera.CFrame.LookVector * 100 task.wait() end
            bv:Destroy()
        end)
    elseif cmd == prefix.."unfly" then _G.Flying = false

    -- TARGET COMMANDS
    elseif args[2] then
        local t = nil
        for _, v in pairs(game.Players:GetPlayers()) do
            if v.Name:lower():find(args[2]) or v.DisplayName:lower():find(args[2]) then t = v break end
        end

        if t and t.Character then
            local tr = t.Character:FindFirstChild("HumanoidRootPart")
            if cmd == prefix.."annoy" then
                _G.Annoying = true
                task.spawn(function()
                    while _G.Annoying and t.Character do
                        root.CFrame = tr.CFrame * CFrame.new(0, 0, 1.5)
                        if t.Character:FindFirstChild("Head") and not t.Character.Head:FindFirstChild("BlindFire") then
                            for i=1, 20 do Instance.new("Fire", t.Character.Head).Name = "BlindFire" end
                        end
                        task.wait()
                    end
                end)
            elseif cmd == prefix.."tp" then root.CFrame = tr.CFrame
            elseif cmd == prefix.."headsit" then
                _G.Headsitting = true
                hum.Sit = true
                task.spawn(function()
                    while _G.Headsitting and t.Character do
                        root.CFrame = t.Character.Head.CFrame * CFrame.new(0, 1.3, 0)
                        task.wait()
                    end
                end)
            end
        end
    end
end)

-- 4. CHARACTER SCALING (R15)
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
    end
end)

-- 5. THE LOOPS
_G.Speed = 16
_G.Jump = 50
game:GetService("RunService").Heartbeat:Connect(function()
    pcall(function()
        player.Character.Humanoid.WalkSpeed = _G.Speed
        player.Character.Humanoid.JumpPower = _G.Jump
    end)
end)

game:GetService("RunService").Stepped:Connect(function()
    if _G.Noclip then
        for _, v in pairs(player.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end)

buildUI()
notify("V28 PATCHED", "Prefix is now [-]")
