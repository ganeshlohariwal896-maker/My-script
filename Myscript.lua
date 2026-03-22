-- [[ MEGA ADMIN SCRIPT V3 - DELTA EXECUTOR ]] --
-- [[ Features: Speed, Jump, Fly, Fling, Headsit, GodMode, Click TP ]] --

-- 1. THE POWER ENGINE (Infinite Yield)
task.spawn(function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
end)

-- 2. CLICK TELEPORT TOOL (Appears in your inventory)
local function giveTPTool()
    local tool = Instance.new("Tool")
    tool.Name = "Click TP"
    tool.RequiresHandle = false
    tool.Parent = game.Players.LocalPlayer.Backpack

    tool.Activated:Connect(function()
        local pos = game.Players.LocalPlayer:GetMouse().Hit.p
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(pos + Vector3.new(0, 3, 0))
    end)
end
giveTPTool()

-- 3. GOD MODE & AUTO-CONFIG
local player = game.Players.LocalPlayer
local function basicSetup(char)
    local hum = char:WaitForChild("Humanoid")
    hum.MaxHealth = math.huge
    hum.Health = math.huge
    hum.WalkSpeed = 60 
    hum.JumpPower = 80 
    
    -- Re-give tool if you reset
    task.wait(1)
    giveTPTool()
end

if player.Character then basicSetup(player.Character) end
player.CharacterAdded:Connect(basicSetup)

-- 4. ANTI-AFK
local vu = game:GetService("VirtualUser")
player.Idled:Connect(function()
    vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    task.wait(1)
    vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

-- 5. CUSTOM COMMAND HANDLER
local prefix = ";"

player.Chatted:Connect(function(message)
    local msg = message:lower()
    local char = player.Character
    local hum = char and char:FindFirstChild("Humanoid")
    local root = char and char:FindFirstChild("HumanoidRootPart")

    if msg:sub(1, #prefix + 5) == prefix .. "speed" then
        local val = tonumber(msg:sub(#prefix + 7)) or 16
        if hum then hum.WalkSpeed = val end

    elseif msg:sub(1, #prefix + 4) == prefix .. "jump" then
        local val = tonumber(msg:sub(#prefix + 6)) or 50
        if hum then hum.JumpPower = val end

    elseif msg:sub(1, #prefix + 7) == prefix .. "headsit" then
        local targetName = msg:sub(#prefix + 9)
        for _, p in pairs(game.Players:GetPlayers()) do
            if p.Name:lower():sub(1, #targetName) == targetName:lower() then
                if p.Character and p.Character:FindFirstChild("Head") then
                    hum.Sit = true
                    task.spawn(function()
                        while hum.Sit do
                            root.CFrame = p.Character.Head.CFrame * CFrame.new(0, 1.2, 0)
                            task.wait()
                        end
                    end)
                end
            end
        end

    elseif msg == prefix .. "re" then
        if char then char:BreakJoints() end
    end
end)

-- 6. ANTI-FLING (Passive Protection)
game:GetService("RunService").Stepped:Connect(function()
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= player and v.Character then
            for _, part in pairs(v.Character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end
end)

print("------------------------------------------")
print("V3 MEGA SCRIPT LOADED - CLICK TP ADDED")
print("Check your Backpack for the TP Tool!")
print("Type ;cmds for full command list.")
print("------------------------------------------")


