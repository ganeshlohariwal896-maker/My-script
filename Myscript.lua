-- [[ MEGA ADMIN V21 - SERVER FREEZE & LAG ]] --
local player = game.Players.LocalPlayer
local prefix = "+" 

-- Global States
_G.Flying = false
_G.WF = false
_G.Annoying = false
_G.Headsitting = false
_G.Speed = 16

local function notify(title, msg)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = title;
        Text = msg;
        Duration = 3;
    })
end

-- 1. UI SETUP
local function createUI()
    local sg = Instance.new("ScreenGui", player.PlayerGui)
    sg.Name = "MegaAdminV21"
    sg.ResetOnSpawn = false

    local frame = Instance.new("Frame", sg)
    frame.Size = UDim2.new(0, 260, 0, 360)
    frame.Position = UDim2.new(0.5, -130, 0.5, -180)
    frame.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
    frame.Active = true
    frame.Draggable = true
    frame.Visible = false
    Instance.new("UICorner", frame)

    local scroll = Instance.new("ScrollingFrame", frame)
    scroll.Size = UDim2.new(1, -20, 1, -60)
    scroll.Position = UDim2.new(0, 10, 0, 50)
    scroll.BackgroundTransparency = 1
    scroll.CanvasSize = UDim2.new(0, 0, 3.5, 0)
    
    local txt = Instance.new("TextLabel", scroll)
    txt.Size = UDim2.new(1, 0, 1, 0)
    txt.BackgroundTransparency = 1
    txt.TextColor3 = Color3.new(1, 1, 1)
    txt.TextSize = 13
    txt.TextXAlignment = "Left"
    txt.TextYAlignment = "Top"
    txt.Text = [[
[ NEWEST ]
+lagserver (Spams 50 Cars)
+cleanlag (Fixes Server)
+annoy [name] (Blind Fire)
+unannoy

[ CHAOS ]
+walkfling / +unwalkfling
+fling [name]
+headsit [name] / +unheadsit
+void [name]
+fireground / +cleanfire

[ MOVEMENT ]
+fly / +unfly
+speed [n] / +jump [n]
+noclip / +clip
+re / +tp [name]
+copy [name]
    ]]

    local toggle = Instance.new("TextButton", sg)
    toggle.Size = UDim2.new(0, 80, 0, 40)
    toggle.Position = UDim2.new(0, 10, 0.5, 0)
    toggle.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    toggle.Text = "MENU"
    toggle.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", toggle)
    toggle.MouseButton1Click:Connect(function() frame.Visible = not frame.Visible end)
    return frame
end
local menuFrame = createUI()

-- 2. COMMAND LOGIC
player.Chatted:Connect(function(msg)
    local args = msg:lower():split(" ")
    local cmd = args[1]
    local char = player.Character
    local root = char:FindFirstChild("HumanoidRootPart")

    -- [ SERVER LAG: CAR SPAM ] --
    if cmd == prefix.."lagserver" then
        notify("Lag System", "Initiating Server Freeze...")
        local carModel = nil
        for _, v in pairs(game:GetDescendants()) do
            if v:IsA("Model") and v:FindFirstChild("DriveSeat") then carModel = v break end
        end
        
        if carModel then
            task.spawn(function()
                for i = 1, 50 do
                    local clone = carModel:Clone()
                    clone.Name = "LagCar"
                    clone.Parent = workspace
                    clone:MoveTo(root.Position + Vector3.new(0, 20, 0))
                    task.wait(0.05) -- Small delay so YOU don't crash
                end
                notify("Lag System", "50 Cars Spawned. Server Lagging.")
            end)
        else
            notify("Error", "No car found to spam.")
        end

    elseif cmd == prefix.."cleanlag" then
        for _, v in pairs(workspace:GetChildren()) do
            if v.Name == "LagCar" then v:Destroy() end
        end
        notify("Lag System", "Lag Cars Cleared.")

    -- [ BLIND ANNOY ] --
    elseif cmd == prefix.."annoy" and args[2] then
        _G.Annoying = true
        local t = nil
        for _,v in pairs(game.Players:GetPlayers()) do if v.Name:lower():find(args[2]) then t = v end end
        if t and t.Character then
            task.spawn(function()
                while _G.Annoying and t.Character do
                    root.CFrame = t.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,1.5)
                    local h = t.Character:FindFirstChild("Head")
                    if h and not h:FindFirstChild("BlindFire") then
                        for i=1,30 do Instance.new("Fire", h).Name = "BlindFire" end
                    end
                    task.wait()
                end
            end)
        end
    elseif cmd == prefix.."unannoy" then _G.Annoying = false

    -- [ BASIC COMMANDS ] --
    elseif cmd == prefix.."fly" then 
        _G.Flying = true 
        local bv = Instance.new("BodyVelocity", root)
        bv.MaxForce = Vector3.new(9e9,9e9,9e9)
        task.spawn(function()
            while _G.Flying do bv.Velocity = workspace.CurrentCamera.CFrame.LookVector * 80 task.wait() end
            bv:Destroy()
        end)
    elseif cmd == prefix.."unfly" then _G.Flying = false
    elseif cmd == prefix.."speed" then _G.Speed = tonumber(args[2])
    elseif cmd == prefix.."re" then char:BreakJoints()
    end
end)

-- 3. PERSISTENCE
game:GetService("RunService").Heartbeat:Connect(function()
    pcall(function() player.Character.Humanoid.WalkSpeed = _G.Speed end)
end)

notify("Ultimate V21", "Loaded! Prefix [+]. Lag/Annoy Ready.")
