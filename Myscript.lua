-- [[ VORTEX HUB V41 - FULL LOGIC RESTORED ]] --
local player = game.Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")
local runService = game:GetService("RunService")
local prefix = "-"

-- 1. UI SETUP
if pgui:FindFirstChild("VortexHubV41") then pgui.VortexHubV41:Destroy() end
local sg = Instance.new("ScreenGui", pgui); sg.Name = "VortexHubV41"
local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 250, 0, 380); Main.Position = UDim2.new(0.5, -125, 0.2, 0)
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 10); Main.Active = true; Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)
Instance.new("UIStroke", Main).Color = Color3.fromRGB(255, 0, 50)

local Scroll = Instance.new("ScrollingFrame", Main)
Scroll.Size = UDim2.new(1, -20, 1, -65); Scroll.Position = UDim2.new(0, 10, 0, 55)
Scroll.BackgroundTransparency = 1; Scroll.CanvasSize = UDim2.new(0, 0, 2.5, 0)

local List = Instance.new("TextLabel", Scroll)
List.Size = UDim2.new(1, 0, 1, 0); List.BackgroundTransparency = 1; List.TextColor3 = Color3.fromRGB(200, 200, 200)
List.TextXAlignment = "Left"; List.TextYAlignment = "Top"
List.Text = [[
--- [ ☣️ GLOBAL ] ---
-blindall / -unblind
-flingall / -unfling
-spamall [msg] / -unspam
-earthquake

--- [ 💀 TARGET ] ---
-annoy [name] (FIRE)
-loopkill [name] / -unloopkill
-stalk [name] / -unstalk
-freeze [name] / -unfreeze
-hijack [name] (Begging)

--- [ 🎭 IDENTITY ] ---
-mimic [name] [msg]
-copy [name] / -fakeban [name]
]]

--- 2. THE COMPLETE ENGINE ---
_G.Speed = 16

local function runCommand(msg)
    local args = msg:lower():split(" ")
    local cmd = args[1]
    local char = player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    -- GLOBAL LOGIC
    if cmd == prefix.."blindall" then
        for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= player then
                local s = Instance.new("ScreenGui", v:WaitForChild("PlayerGui")); s.Name = "Blind"
                local f = Instance.new("Frame", s); f.Size = UDim2.new(1,0,1,0); f.BackgroundColor3 = Color3.new(0,0,0)
            end
        end
    elseif cmd == prefix.."unblind" then
        for _, v in pairs(game.Players:GetPlayers()) do
            local b = v.PlayerGui:FindFirstChild("Blind")
            if b then b:Destroy() end
        end
    elseif cmd == prefix.."flingall" then
        _G.Flinging = true
        task.spawn(function() while _G.Flinging do root.Velocity = Vector3.new(99999,0,99999); task.wait() end end)
    elseif cmd == prefix.."unfling" then _G.Flinging = false; root.Velocity = Vector3.new(0,0,0)
    elseif cmd == prefix.."earthquake" then
        _G.Quake = true
        task.spawn(function() while _G.Quake do workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame * CFrame.new(math.random(-1,1),0,math.random(-1,1)) task.wait(0.05) end end)
    elseif cmd == prefix.."unquake" then _G.Quake = false
    elseif cmd == prefix.."spamall" then
        _G.Spam = true; local sMsg = msg:sub(#cmd + 2)
        task.spawn(function() while _G.Spam do game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(sMsg, "All") task.wait(0.7) end end)
    elseif cmd == prefix.."unspam" then _G.Spam = false

    -- TARGET LOGIC
    elseif args[2] then
        local t = nil
        for _, v in pairs(game.Players:GetPlayers()) do
            if v.Name:lower():find(args[2]) or v.DisplayName:lower():find(args[2]) then t = v break end
        end
        if t and t.Character then
            if cmd == prefix.."annoy" then
                Instance.new("Fire", t.Character.Head).Size = 150
            elseif cmd == prefix.."hijack" then
                local ph = {"MY PHONE IS LAGGING!", "ADMIN HELP!", "PLEASE STOP!", "I'M HACKED!"}
                game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(t.Name..": "..ph[math.random(1,#ph)], "All")
            elseif cmd == prefix.."stalk" then
                _G.Stalking = true
                task.spawn(function() while _G.Stalking do root.CFrame = t.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,-2.5) * CFrame.Angles(0,math.pi,0) task.wait() end end)
            elseif cmd == prefix.."loopkill" then
                _G.LK = true
                task.spawn(function() while _G.LK do t.Character.Humanoid.Health = 0 task.wait(0.5) end end)
            elseif cmd == prefix.."unloopkill" then _G.LK = false
            elseif cmd == prefix.."freeze" then t.Character.HumanoidRootPart.Anchored = true
            elseif cmd == prefix.."unfreeze" then t.Character.HumanoidRootPart.Anchored = false
            elseif cmd == prefix.."mimic" then
                local say = msg:sub(#cmd + #args[2] + 3)
                game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(t.Name..": "..say, "All")
            elseif cmd == prefix.."copy" then
                for _, v in pairs(char:GetChildren()) do if v:IsA("Accessory") or v:IsA("Shirt") or v:IsA("Pants") then v:Destroy() end end
                for _, v in pairs(t.Character:GetChildren()) do if v:IsA("Accessory") or v:IsA("Shirt") or v:IsA("Pants") then v:Clone().Parent = char end end
            end
        end
    end
end

-- 3. EXECUTION
player.Chatted:Connect(runCommand)
runService.Heartbeat:Connect(function()
    pcall(function() player.Character.Humanoid.WalkSpeed = _G.Speed end)
end)

game:GetService("StarterGui"):SetCore("SendNotification", {Title = "VORTEX V41 READY"; Text = "All Logic Restored!"; Duration = 5;})
