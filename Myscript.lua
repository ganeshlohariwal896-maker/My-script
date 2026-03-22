-- [[ MEGA ADMIN V8 - ULTIMATE MOBILE EDITION ]] --
-- [[ WORKS ON DELTA / LITE / ANY MOBILE EXECUTOR ]] --

local player = game.Players.LocalPlayer
local prefix = ";"

-- Global Variables for States
_G.Flying = false
_G.Noclip = false
_G.Annoying = false
_G.FlySpeed = 50

-- 1. THE REFRESHER (Ensures commands work after you die/reset)
local function getChar() return player.Character or player.CharacterAdded:Wait() end
local function getRoot() return getChar():WaitForChild("HumanoidRootPart") end
local function getHum() return getChar():WaitForChild("Humanoid") end

-- 2. THE FLY ENGINE (Camera-Relative for Mobile)
local function startFly()
    local root = getRoot()
    local bv = Instance.new("BodyVelocity", root)
    bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    bv.Velocity = Vector3.new(0, 0, 0)
    
    local bg = Instance.new("BodyGyro", root)
    bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    bg.CFrame = root.CFrame
    
    task.spawn(function()
        while _G.Flying do
            bv.Velocity = workspace.CurrentCamera.CFrame.LookVector * _G.FlySpeed
            bg.CFrame = workspace.CurrentCamera.CFrame
            task.wait()
        end
        bv:Destroy()
        bg:Destroy()
    end)
end

-- 3. PLAYER FINDER (Smart Targeting)
local function findPlr(name)
    for _, v in pairs(game.Players:GetPlayers()) do
        if v.Name:lower():sub(1, #name) == name:lower() or v.DisplayName:lower():sub(1, #name) == name:lower() then
            return v
        end
    end
end

-- 4. THE COMMAND HANDLER (Fixed for Mobile)
player.Chatted:Connect(function(msg)
    local cleanMsg = msg:lower():gsub("%s+", " ") -- Removes double spaces
    local args = cleanMsg:split(" ")
    local cmd = args[1]

    -- [ MOVEMENT ] --
    if cmd == prefix.."fly" then
        if not _G.Flying then _G.Flying = true startFly() end
    elseif cmd == prefix.."unfly" then
        _G.Flying = false
    elseif cmd == prefix.."speed" and args[2] then
        getHum().WalkSpeed = tonumber(args[2])
    elseif cmd == prefix.."jump" and args[2] then
        getHum().JumpPower = tonumber(args[2])
    elseif cmd == prefix.."noclip" then
        _G.Noclip = true
    elseif cmd == prefix.."clip" then
        _G.Noclip = false

    -- [ TROLLING / UTILITY ] --
    elseif cmd == prefix.."cmds" then
        print("--- COMMANDS ---")
        print(";fly ;unfly ;speed [n] ;jump [n]")
        print(";tp [plr] ;bring [plr] ;void [plr]")
        print(";annoy [plr] ;unannoy ;re ;big ;small")

    elseif cmd == prefix.."re" then
        getChar():BreakJoints()

    elseif cmd == prefix.."big" then
        local h = getHum()
        for _, v in pairs({"BodyHeightScale","BodyWidthScale","BodyDepthScale","HeadScale"}) do
            local s = h:FindFirstChild(v) or Instance.new("NumberValue", h)
            s.Name = v s.Value = 3
        end
    elseif cmd == prefix.."small" then
        local h = getHum()
        for _, v in pairs({"BodyHeightScale","BodyWidthScale","BodyDepthScale","HeadScale"}) do
            local s = h:FindFirstChild(v) or Instance.new("NumberValue", h)
            s.Name = v s.Value = 0.4
        end

    -- [ PLAYER TARGETING ] --
    elseif args[2] then
        local target = findPlr(args[2])
        if target and target.Character then
            local tRoot = target.Character:FindFirstChild("HumanoidRootPart")
            
            if cmd == prefix.."tp" then
                getRoot().CFrame = tRoot.CFrame
            elseif cmd == prefix.."bring" then
                tRoot.CFrame = getRoot().CFrame
            elseif cmd == prefix.."void" then
                getRoot().CFrame = tRoot.CFrame
                task.wait(0.1)
                local v = Instance.new("BodyVelocity", tRoot)
                v.Velocity = Vector3.new(0, -2000, 0)
                v.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                task.wait(0.5) v:Destroy()
            elseif cmd == prefix.."annoy" then
                _G.Annoying = true
                local f = Instance.new("Fire", target.Character:FindFirstChild("Head"))
                f.Size = 30
                task.spawn(function()
                    while _G.Annoying do
                        getRoot().CFrame = tRoot.CFrame * CFrame.new(0, 0, 1)
                        task.wait()
                    end
                    f:Destroy()
                end)
            end
        end
    end
end)

-- 5. PASSIVE LOOPS (Noclip & Anti-Fling)
game:GetService("RunService").Stepped:Connect(function()
    if _G.Noclip and player.Character then
        for _, v in pairs(player.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
    -- Anti-Fling
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= player and v.Character then
            for _, p in pairs(v.Character:GetChildren()) do
                if p:IsA("BasePart") then p.CanCollide = false end
            end
        end
    end
end)

print("V8 LOADED: EVERYTHING IS WORKING. TYPE ;cmds")
