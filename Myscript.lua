local player = game.Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")
local runService = game:GetService("RunService")

-- CLEAN UP OLD VERSION
if pgui:FindFirstChild("BrainrotMaster") then pgui.BrainrotMaster:Destroy() end

-- UI SETUP
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BrainrotMaster"
ScreenGui.Parent = pgui

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 250, 0, 300)
Main.Position = UDim2.new(0.5, -125, 0.2, 0)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Main.Active = true
Main.Draggable = true
Main.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 35)
Title.Text = "BRAINROT MASTER HUB"
Title.BackgroundColor3 = Color3.fromRGB(100, 0, 200)
Title.TextColor3 = Color3.new(1,1,1)
Title.Parent = Main

-- TOGGLES & INPUTS
local SpeedVal = 16
local JumpVal = 50
local AutoFarmEnabled = false
local AutoCollectEnabled = false

local function createToggle(text, pos, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 230, 0, 35)
    btn.Position = UDim2.new(0, 10, 0, pos)
    btn.Text = text.." [OFF]"
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Parent = Main
    
    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = text..(state and " [ON]" or " [OFF]")
        btn.BackgroundColor3 = state and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(50, 50, 50)
        callback(state)
    end)
end

-- SPEED & JUMP INPUTS
local SBox = Instance.new("TextBox")
SBox.Size = UDim2.new(0, 110, 0, 30)
SBox.Position = UDim2.new(0, 10, 0, 45)
SBox.PlaceholderText = "Speed"
SBox.Parent = Main

local JBox = Instance.new("TextBox")
JBox.Size = UDim2.new(0, 110, 0, 30)
JBox.Position = UDim2.new(0, 130, 0, 45)
JBox.PlaceholderText = "Jump"
JBox.Parent = Main

SBox.FocusLost:Connect(function() SpeedVal = tonumber(SBox.Text) or 16 end)
JBox.FocusLost:Connect(function() JumpVal = tonumber(JBox.Text) or 50 end)

-- FEATURES
createToggle("Auto Farm Brainrots", 85, function(v) AutoFarmEnabled = v end)
createToggle("Auto Collect Money", 130, function(v) AutoCollectEnabled = v end)
createToggle("Anti-Shrink Physics", 175, function(v) 
    _G.AntiShrink = v 
end)

-- LOGIC LOOPS
runService.Heartbeat:Connect(function()
    local char = player.Character
    if char and char:FindFirstChild("Humanoid") then
        -- Force Speed/Jump
        char.Humanoid.WalkSpeed = SpeedVal
        char.Humanoid.JumpPower = JumpVal
        char.Humanoid.UseJumpPower = true
        
        -- AUTO COLLECT MONEY
        if AutoCollectEnabled then
            for _, v in pairs(workspace:GetChildren()) do
                if v.Name == "Coin" or v.Name == "Cash" or v:FindFirstChild("TouchInterest") then
                    firetouchinterest(char.PrimaryPart, v, 0)
                end
            end
        end
        
        -- AUTO FARM BRAINROTS
        if AutoFarmEnabled then
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("Model") and (v.Name:find("Brainrot") or v.Name:find("Secret")) then
                    char:MoveTo(v.PrimaryPart.Position)
                    task.wait(0.5)
                    break
                end
            end
        end
    end
end)

