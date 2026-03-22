local player = game.Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")

-- 1. DELETE OLD VERSION IF IT EXISTS
if pgui:FindFirstChild("MobileHub") then
    pgui.MobileHub:Destroy()
end

-- 2. CREATE THE UI (Stored in PlayerGui for Delta)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MobileHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = pgui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 220, 0, 150)
MainFrame.Position = UDim2.new(0.5, -110, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 3
MainFrame.Active = true
MainFrame.Draggable = true 
MainFrame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "DELTA MENU"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Title.Parent = MainFrame

local SpeedBtn = Instance.new("TextButton")
SpeedBtn.Size = UDim2.new(0, 200, 0, 40)
SpeedBtn.Position = UDim2.new(0, 10, 0, 40)
SpeedBtn.Text = "SPEED: 100"
SpeedBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
SpeedBtn.TextColor3 = Color3.new(1, 1, 1)
SpeedBtn.Parent = MainFrame

local JumpBtn = Instance.new("TextButton")
JumpBtn.Size = UDim2.new(0, 200, 0, 40)
JumpBtn.Position = UDim2.new(0, 10, 0, 90)
JumpBtn.Text = "JUMP: 150"
JumpBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 120)
JumpBtn.TextColor3 = Color3.new(1, 1, 1)
JumpBtn.Parent = MainFrame

-- 3. THE LOGIC
SpeedBtn.MouseButton1Click:Connect(function()
    local char = player.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = 100
        print("Speed set to 100")
    end
end)

JumpBtn.MouseButton1Click:Connect(function()
    local char = player.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.JumpPower = 150
        char.Humanoid.JumpHeight = 50
        char.Humanoid.UseJumpPower = true
        print("Jump set to 150")
    end
end)

-- NOTIFICATION
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "SUCCESS";
    Text = "Menu is on your screen!";
    Duration = 5;
})
print("Script Fully Loaded!")
