-- [[ VORTEX V48 - FINAL BOSS EDITION ]] --
local player = game.Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")
local runService = game:GetService("RunService")
local uis = game:GetService("UserInputService") -- Added missing service
local prefix = "-"

-- AUTO-REFRESH CHARACTER LOGIC
local char = player.Character or player.CharacterAdded:Wait()
local root = char:WaitForChild("HumanoidRootPart")
local hum = char:WaitForChild("Humanoid")

player.CharacterAdded:Connect(function(newChar)
    char = newChar
    root = char:WaitForChild("HumanoidRootPart")
    hum = char:WaitForChild("Humanoid")
end)

-- 1. UI SETUP
if pgui:FindFirstChild("VortexV48") then pgui.VortexV48:Destroy() end
local sg = Instance.new("ScreenGui", pgui); sg.Name = "VortexV48"
local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 320, 0, 480); Main.Position = UDim2.new(0.5, -160, 0.1, 0)
Main.BackgroundColor3 = Color3.fromRGB(5, 5, 5); Main.Active = true; Main.Draggable = true
Instance.new("UIStroke", Main).Color = Color3.fromRGB(255, 0, 50)

local Scroll = Instance.new("ScrollingFrame", Main)
Scroll.Size = UDim2.new(1, -20, 1, -60); Scroll.Position = UDim2.new(0, 10, 0, 50)
Scroll.CanvasSize = UDim2.new(0, 0, 6, 0); Scroll.BackgroundTransparency = 1

local List = Instance.new("TextLabel", Scroll)
List.Size = UDim2.new(1, 0, 1, 0); List.BackgroundTransparency = 1; List.TextColor3 = Color3.new(1, 1, 1)
List.TextXAlignment = "Left"; List.TextYAlignment = "Top"; List.TextSize = 12; List.RichText = true
List.Text = [[
<b>--- [ ⚔️ COMBAT ] ---</b>
-antifling / -unantifling
-hitbox [n] / -fling [name]
-orbit [name] / -killall

<b>--- [ 🔥 TROLL ] ---</b>
-annoy [name] / -headsit [name]
-voidall / -unvoid
-lagserver (1500 Fire)
-stalk [name] / -bring [name]

<b>--- [ 🛠️ ADMIN ] ---</b>
-fly / -unfly / -noclip
-speed [n] / -jp [n] / -esp
-btools / -ctrlclick / -invis
]]

--- 2. THE OVERLORD ENGINE ---
_G.Speed = 16; _G.Jump = 50

local function runCommand(msg)
    local args = msg:lower():split(" ")
    local cmd = args[1]
    
    -- [ ADMIN TOOLS ] --
    if cmd == prefix.."fly" then
        _G.Flying = true
        local bv = Instance.new("BodyVelocity", root); bv.MaxForce = Vector3.new(9e9,9e9,9e9); bv.Velocity = Vector3.new(0,0,0)
        task.spawn(function()
            while _G.Flying do bv.Velocity = workspace.CurrentCamera.CFrame.LookVector * 50; task.wait() end
            if bv then bv:Destroy() end
        end)
    elseif cmd == prefix.."unfly" then _G.Flying = false
    elseif cmd == prefix.."speed" then _G.Speed = tonumber(args[2]) or 16
    elseif cmd == prefix.."jp" then _G.Jump = tonumber(args[2]) or 50
    elseif cmd == prefix.."noclip" then 
        _G.NC = true
        runService.Stepped:Connect(function() 
            if _G.NC and char then 
                for _, v in pairs(char:GetDescendants()) do 
                    if v:IsA("BasePart") then v.CanCollide = false end 
                end 
            end 
        end)
    elseif cmd == prefix.."clip" then _G.NC = false

    -- [ TROLL & DESTRUCTION ] --
    elseif cmd == prefix.."lagserver" then
        _G.Lag = true
        task.spawn(function()
            local folder = Instance.new("Folder", workspace); folder.Name = "VortexLag"
            for i = 1, 1500 do 
                if not _G.Lag then break end
                local p = Instance.new("Part", folder); p.Anchored = true; p.Transparency = 1; p.Position = root.Position + Vector3.new(math.random(-100,100), 20, math.random(-100,100))
                Instance.new("Fire", p).Size = 150; if i % 30 == 0 then task.wait() end
            end
        end)
    elseif cmd == prefix.."unlag" then _G.Lag = false; if workspace:FindFirstChild("VortexLag") then workspace.VortexLag:Destroy() end

    elseif cmd == prefix.."voidall" then
        local p = Instance.new("Part", workspace); p.Size = Vector3.new(2000, 2, 2000); p.CFrame = root.CFrame * CFrame.new(0,-4,0); p.Anchored = true; p.Name = "GodFloor"; p.Transparency = 0.5; p.Color = Color3.new(1,0,0)
        for _, v in pairs(workspace:GetDescendants()) do 
            if v:IsA("BasePart") and v.Name ~= "GodFloor" and not v:IsDescendantOf(char) then v.CanCollide = false end 
        end
    elseif cmd == prefix.."unvoid" then
        if workspace:FindFirstChild("GodFloor") then workspace.GodFloor:Destroy() end
        for _, v in pairs(workspace:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = true end end

    -- [ TARGET COMMANDS ] --
    elseif args[2] then
        local t = nil
        for _, v in pairs(game.Players:GetPlayers()) do
            if v.Name:lower():find(args[2]) or v.DisplayName:lower():find(args[2]) then t = v break end
        end
        if t and t.Character and t.Character:FindFirstChild("HumanoidRootPart") then
            if cmd == prefix.."annoy" then
                Instance.new("Fire", t.Character.Head).Size = 150
            elseif cmd == prefix.."fling" then
                local bvel = Instance.new("BodyAngularVelocity", root); bvel.AngularVelocity = Vector3.new(0, 99999, 0); bvel.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
                task.spawn(function() 
                    local oldPos = root.CFrame
                    for i = 1, 60 do root.CFrame = t.Character.HumanoidRootPart.CFrame; task.wait() end
                    bvel:Destroy(); root.CFrame = oldPos
                end)
            elseif cmd == prefix.."headsit" then
                _G.Sit = true; hum.Sit = true
                task.spawn(function() while _G.Sit and t.Character do root.CFrame = t.Character.Head.CFrame * CFrame.new(0, 0.6, 0) task.wait() end end)
            elseif cmd == prefix.."unheadsit" then _G.Sit = false; hum.Sit = false
            end
        end
    end
end

player.Chatted:Connect(runCommand)
runService.Heartbeat:Connect(function()
    pcall(function() hum.WalkSpeed = _G.Speed; hum.JumpPower = _G.Jump end)
end)

game:GetService("StarterGui"):SetCore("SendNotification", {Title = "V48 OVERLORD"; Text = "Full Logic Loaded."; Duration = 5;})
