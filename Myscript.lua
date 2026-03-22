
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- 1. CREATE THE UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SimpleMobileHub"
ScreenGui.Parent = game:GetService("CoreGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 200, 0, 150)
MainFrame.Position = UDim2.new(0.5, -100, 0.4, -75)
MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MainFrame.BorderSizePixel = 2
MainFrame.Active = true
MainFrame.Draggable = true -- You can move it!
MainFrame.Parent = ScreenGui

local SpeedBtn = Instance.new("TextButton")
SpeedBtn.Size = UDim2.new(0, 180, 0, 40)
SpeedBtn.Position = UDim2.new(0, 10, 0, 10)
SpeedBtn.Text = "Set Speed: 100"
SpeedBtn.Parent = MainFrame

local JumpBtn = Instance.new("TextButton")
JumpBtn.Size = UDim2.new(0, 180, 0, 40)
JumpBtn.Position = UDim2.new(0, 10, 0, 60)
JumpBtn.Text = "Set Jump: 150"
JumpBtn.Parent = MainFrame

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 180, 0, 30)
CloseBtn.Position = UDim2.new(0, 10, 0, 110)
CloseBtn.Text = "Close Menu"
CloseBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
CloseBtn.Parent = MainFrame

-- 2. BUTTON LOGIC
SpeedBtn.MouseButton1Click:Connect(function()
    character.Humanoid.WalkSpeed = 100
end)

JumpBtn.MouseButton1Click:Connect(function()
    character.Humanoid.JumpPower = 150
    character.Humanoid.JumpHeight = 50
    character.Humanoid.UseJumpPower = true
end)

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- 3. LOAD NOTIFICATION
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "MENU LOADED";
    Text = "Use the buttons on screen!";
    Duration = 5;
})
ocal 
