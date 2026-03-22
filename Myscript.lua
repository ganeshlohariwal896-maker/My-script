-- [[ CUSTOM CHAOS ADMIN V6 - WITH UI ]] --
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")
local root = char:WaitForChild("HumanoidRootPart")

local prefix = ";"
local annoying = false

-- [[ UI SYSTEM ]] --
local function createUI()
    local sg = Instance.new("ScreenGui", player.PlayerGui)
    sg.Name = "CustomCmdsUI"
    
    local frame = Instance.new("Frame", sg)
    frame.Size = UDim2.new(0, 200, 0, 250)
    frame.Position = UDim2.new(0.5, -100, 0.5, -125)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.BorderSizePixel = 2
    frame.Visible = false
    frame.Active = true
    frame.Draggable = true -- So you can move it on mobile

    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1, 0, 0, 30)
    title.Text = "Commands List"
    title.TextColor3 = Color3.new(1, 1, 1)
    title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

    local list = Instance.new("TextLabel", frame)
    list.Size = UDim2.new(1, 0, 1, -30)
    list.Position = UDim2.new(0, 0, 0, 30)
    list.Text = ";fly / ;unfly\n;speed [num]\n;jump [num]\n;big / ;small / ;normal\n;tp [name]\n;bring [name]\n;annoy [name]\n;void [name]\n;copy [name]\n;noclip / ;clip\n;re"
    list.TextColor3 = Color3.new(0.8, 0.8, 0.8)
    list.BackgroundTransparency = 1
    list.TextWrapped = true
    
    return frame
end

local cmdFrame = createUI()

-- [[ SCALE FUNCTION ]] --
local function setSize(targetChar, scale)
    local hs = targetChar:FindFirstChild("Humanoid")
    if hs then
        local parts = {"BodyHeightScale", "BodyWidthScale", "BodyDepthScale", "HeadScale"}
        for _, v in pairs(parts) do
            local val = hs:FindFirstChild(v) or Instance.new("NumberValue", hs)
            val.Name = v
            val.Value = scale
        end
    end
end

-- [[ COMMAND HANDLER ]] --
player.Chatted:Connect(function(msg)
    local args = msg:lower():split(" ")
    local cmd = args[1]
    local targetName = args[2]

    -- NEW: ;cmds UI TOGGLE
    if cmd == prefix.."cmds" then
        cmdFrame.Visible = not cmdFrame.Visible

    -- ANNOY (Blind Screen)
    elseif cmd == prefix.."annoy" then
        annoying = true
        for _, p in pairs(game.Players:GetPlayers()) do
            if p.Name:lower():find(targetName) and p.Character then
                task.spawn(function()
                    local head = p.Character:FindFirstChild("Head")
                    local f = Instance.new("Fire", head)
                    local s = Instance.new("Smoke", head)
                    f.Size, s.Size = 25, 25
                    while annoying do
                        root.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,1.5)
                        task.wait()
                    end
                    f:Destroy() s:Destroy()
                end)
            end
        end
    elseif cmd == prefix.."unannoy" then
        annoying = false

    -- SIZE
    elseif cmd == prefix.."big" then setSize(char, 3)
    elseif cmd == prefix.."small" then setSize(char, 0.4)
    elseif cmd == prefix.."normal" then setSize(char, 1)

    -- TP & BRING
    elseif cmd == prefix.."tp" then
        for _, p in pairs(game.Players:GetPlayers()) do
            if p.Name:lower():find(targetName) then root.CFrame = p.Character.HumanoidRootPart.CFrame end
        end
    elseif cmd == prefix.."bring" then
        for _, p in pairs(game.Players:GetPlayers()) do
            if p.Name:lower():find(targetName) then p.Character.HumanoidRootPart.CFrame = root.CFrame end
        end

    -- VOID
    elseif cmd == prefix.."void" then
        for _, p in pairs(game.Players:GetPlayers()) do
            if p.Name:lower():find(targetName) then
                local tRoot = p.Character.HumanoidRootPart
                root.CFrame = tRoot.CFrame
                task.wait(0.1)
                local bv = Instance.new("BodyVelocity", tRoot)
                bv.Velocity = Vector3.new(0, -1000, 0)
                bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                task.wait(0.5)
                bv:Destroy()
            end
        end

    -- RESET
    elseif cmd == prefix.."re" then char:BreakJoints()
    end
end)

print("V6 LOADED - TYPE ;cmds TO SEE THE MENU")

