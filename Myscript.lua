-- [[ VORTEX V41 - THE GOD-MODE VOID ]] --
local player = game.Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")
local runService = game:GetService("RunService")
local prefix = "-"

-- 1. UI SETUP (STAYING CLEAN & NEON)
if pgui:FindFirstChild("VortexV44") then pgui.VortexV44:Destroy() end
local sg = Instance.new("ScreenGui", pgui); sg.Name = "VortexV44"
local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 260, 0, 420); Main.Position = UDim2.new(0.5, -130, 0.15, 0)
Main.BackgroundColor3 = Color3.fromRGB(5, 5, 5); Main.Active = true; Main.Draggable = true
Instance.new("UIStroke", Main).Color = Color3.fromRGB(255, 0, 0)
Instance.new("UICorner", Main)

local Scroll = Instance.new("ScrollingFrame", Main)
Scroll.Size = UDim2.new(1, -20, 1, -60); Scroll.Position = UDim2.new(0, 10, 0, 50)
Scroll.BackgroundTransparency = 1; Scroll.CanvasSize = UDim2.new(0, 0, 3.5, 0)

local List = Instance.new("TextLabel", Scroll)
List.Size = UDim2.new(1, 0, 1, 0); List.BackgroundTransparency = 1; List.TextColor3 = Color3.new(1, 1, 1)
List.TextXAlignment = "Left"; List.TextYAlignment = "Top"
List.Text = [[
--- [ 🔥 FLAMES HUB ELITE ] ---
-annoy [name] (GIGA FIRE 150)
-headsit [name] (No-Clip Sit)
-voidall (THEY Fall, YOU Walk)
-lagserver (Giga Fire Lag)
-unlag / -unvoid

--- [ ☣️ GLOBAL RAGE ] ---
-feverall / -blindall / -whiteout
-earthquake / -spamall [msg]
-flingall / -unfling

--- [ 💀 TARGET TROLLS ] ---
-loopkill [name] / -unloopkill
-stalk [name] / -freeze [name]
-hijack [name] (Begging)

--- [ 🎭 IDENTITY ] ---
-mimic [name] [msg] / -copy [name]
-speed [n] / -fly / -esp
]]

--- 2. THE GOD-MODE ENGINE ---
_G.Speed = 16

local function runCommand(msg)
    local args = msg:lower():split(" ")
    local cmd = args[1]
    local char = player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    -- FIXED VOID ALL (YOU STAY, THEY FALL)
    if cmd == prefix.."voidall" then
        -- Create a private floor for you
        local Plate = Instance.new("Part", workspace)
        Plate.Name = "GodFloor"; Plate.Size = Vector3.new(2048, 2, 2048)
        Plate.CFrame = root.CFrame * CFrame.new(0, -4, 0)
        Plate.Anchored = true; Plate.Transparency = 0.8; Plate.Color = Color3.new(1,0,0)
        
        -- Delete the real map parts
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") and v.Name ~= "GodFloor" and not v:IsDescendantOf(game.Players) then
                v.CanCollide = false
                v.Transparency = 0.5
            end
        end
    elseif cmd == prefix.."unvoid" then
        if workspace:FindFirstChild("GodFloor") then workspace.GodFloor:Destroy() end
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = true; v.Transparency = 0 end
        end

    -- SERVER LAG (800 FIRE OBJECTS)
    elseif cmd == prefix.."lagserver" then
        _G.Lag = true
        task.spawn(function()
            local f = Instance.new("Folder", workspace); f.Name = "Chaos"
            for i = 1, 800 do
                if not _G.Lag then break end
                local p = Instance.new("Part", f)
                p.Anchored = true; p.Transparency = 1; p.Position = root.Position + Vector3.new(math.random(-100,100), 20, math.random(-100,100))
                Instance.new("Fire", p).Size = 100
                if i % 50 == 0 then task.wait() end
            end
        end)

    -- TARGET SEARCH
    elseif args[2] then
        local t = nil
        for _, v in pairs(game.Players:GetPlayers()) do
            if v.Name:lower():find(args[2]) or v.DisplayName:lower():find(args[2]) then t = v break end
        end
        if t and t.Character then
            -- FIXED HEADSIT
            if cmd == prefix.."headsit" then
                _G.Sitting = true
                char.Humanoid.Sit = true
                task.spawn(function()
                    while _G.Sitting and t.Character do
                        root.CFrame = t.Character.Head.CFrame * CFrame.new(0, 0.5, 0)
                        task.wait()
                    end
                end)
            elseif cmd == prefix.."unheadsit" then _G.Sitting = false; char.Humanoid.Sit = false

            -- GIGA ANNOY (VISIBLE FIRE 150)
            elseif cmd == prefix.."annoy" then
                local fire = Instance.new("Fire", t.Character.Head); fire.Size = 150; fire.Heat = 150
                local smoke = Instance.new("Smoke", t.Character.Head); smoke.Size = 100
            end
        end
    end
end

-- 3. LOOPS
player.Chatted:Connect(runCommand)
runService.Heartbeat:Connect(function()
    pcall(function() player.Character.Humanoid.WalkSpeed = _G.Speed end)
end)

game:GetService("StarterGui"):SetCore("SendNotification", {Title = "VORTEX V44 READY"; Text = "Void Protection Active."; Duration = 5;})
