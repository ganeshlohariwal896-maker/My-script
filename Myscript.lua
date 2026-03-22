-- [[ MEGA ADMIN V36 - THE ALL-IN-ONE MASTER ]] --
local player = game.Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")
local runService = game:GetService("RunService")
local prefix = "-"

-- 1. UI SETUP (DARK RED THEME)
if pgui:FindFirstChild("MasterV36") then pgui.MasterV36:Destroy() end
local sg = Instance.new("ScreenGui", pgui); sg.Name = "MasterV36"
local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 260, 0, 440); Main.Position = UDim2.new(0.5, -130, 0.2, 0)
Main.BackgroundColor3 = Color3.fromRGB(15, 0, 0); Main.Active = true; Main.Draggable = true
Instance.new("UIStroke", Main).Thickness = 2

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 40); Title.Text = "🔥 MASTER V36 - EVERYTHING 🔥"
Title.BackgroundColor3 = Color3.fromRGB(120, 0, 0); Title.TextColor3 = Color3.new(1, 1, 1)

local Scroll = Instance.new("ScrollingFrame", Main)
Scroll.Size = UDim2.new(1, -10, 1, -50); Scroll.Position = UDim2.new(0, 5, 0, 45)
Scroll.CanvasSize = UDim2.new(0, 0, 10, 0); Scroll.BackgroundTransparency = 1

local List = Instance.new("TextLabel", Scroll)
List.Size = UDim2.new(1, 0, 1, 0); List.BackgroundTransparency = 1; List.TextColor3 = Color3.new(1, 1, 1)
List.TextXAlignment = "Left"; List.TextYAlignment = "Top"
List.Text = [[
--- [ ALL COMMANDS INCLUDED ] ---
-antifling / -unantifling (PROTECT)
-hugefire (Spawn ground fire)
-annoy [name] (GIGA FIRE 150)
-mimic [name] [text] (Frame)
-stalk [name] / -unstalk
-loopkill [name] / -unloopkill
-fakeban [name] / -fakeerror [name]
-void [name] (Send to abyss)
-forcesit [name] / -unforcesit
-copy [name] / -fit [name]
-fly / -noclip / -speed [n]
-esp / -invis / -rejoin
]]

--- 2. THE MASTER ENGINE ---
_G.Speed = 16
_G.Jump = 50

local function runCommand(msg)
    local args = msg:lower():split(" ")
    local cmd = args[1]
    local char = player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    -- ANTI-FLING TOGGLE
    if cmd == prefix.."antifling" then _G.AntiFling = true
    elseif cmd == prefix.."unantifling" then _G.AntiFling = false
    
    -- HUGE GROUND FIRE
    elseif cmd == prefix.."hugefire" then
        local f = Instance.new("Fire", root); f.Size = 150; f.Heat = 150

    -- MOVEMENT
    elseif cmd == prefix.."speed" then _G.Speed = tonumber(args[2])
    elseif cmd == prefix.."fly" then 
        _G.Flying = true
        local bv = Instance.new("BodyVelocity", root); bv.MaxForce = Vector3.new(9e9,9e9,9e9); bv.Name = "Fly"
        task.spawn(function()
            while _G.Flying do bv.Velocity = workspace.CurrentCamera.CFrame.LookVector * 100 task.wait() end
            bv:Destroy()
        end)
    elseif cmd == prefix.."unfly" then _G.Flying = false

    -- TARGET LOGIC
    elseif args[2] then
        local t = nil
        for _, v in pairs(game.Players:GetPlayers()) do
            if v.Name:lower():find(args[2]) or v.DisplayName:lower():find(args[2]) then t = v break end
        end
        if t and t.Character then
            local tr = t.Character:FindFirstChild("HumanoidRootPart")
            if cmd == prefix.."stalk" then
                _G.Stalking = true
                task.spawn(function() while _G.Stalking and tr do root.CFrame = tr.CFrame * CFrame.new(0,0,-2.5) * CFrame.Angles(0,math.pi,0) task.wait() end end)
            elseif cmd == prefix.."unstalk" then _G.Stalking = false
            elseif cmd == prefix.."annoy" then
                _G.Annoy = true
                task.spawn(function()
                    while _G.Annoy and t.Character do
                        local h = t.Character:FindFirstChild("Head")
                        if h and not h:FindFirstChild("Chaos") then
                            local f = Instance.new("Fire",h); f.Name="Chaos"; f.Size=150; f.Heat=150
                        end
                        task.wait(1)
                    end
                end)
            elseif cmd == prefix.."unannoy" then _G.Annoy = false
            elseif cmd == prefix.."copy" then
                for _, v in pairs(char:GetChildren()) do if v:IsA("Accessory") or v:IsA("Shirt") or v:IsA("Pants") then v:Destroy() end end
                for _, v in pairs(t.Character:GetChildren()) do if v:IsA("Accessory") or v:IsA("Shirt") or v:IsA("Pants") then v:Clone().Parent = char end end
            elseif cmd == prefix.."mimic" then
                local say = msg:sub(#cmd + #args[2] + 3)
                game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(t.Name..": "..say, "All")
            end
        end
    end
end

-- 3. PROTECTION & PHYSICS LOOPS
player.Chatted:Connect(runCommand)
runService
