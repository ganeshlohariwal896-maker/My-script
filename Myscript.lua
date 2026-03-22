
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local SpeedInput = Instance.new("TextBox")
local JumpInput = Instance.new("TextBox")
local ApplyButton = Instance.new("TextButton")
local CloseButton = Instance.new("TextButton")

-- Parent the GUI
ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "MyMobileHub"

-- Main Frame Setup
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.5, -100, 0.5, -75)
MainFrame.Size = UDim2.new(0, 200, 0, 180)
MainFrame.Active = true
MainFrame.Draggable = true -- You can move it around your screen

-- Title
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "Mobile Script Hub"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

-- Speed Input Box
SpeedInput.Parent = MainFrame
SpeedInput.PlaceholderText = "Enter Speed (e.g. 100)"
SpeedInput.Position = UDim2.new(0, 10, 0, 40)
SpeedInput.Size = UDim2.new(0, 180, 0, 30)

-- Jump Input Box
JumpInput.Parent = MainFrame
JumpInput.PlaceholderText = "Enter Jump (e.g. 150)"
JumpInput.Position = UDim2.new(0, 10, 0, 80)
JumpInput.Size = UDim2.new(0, 180, 0, 30)

-- Apply Button
ApplyButton.Parent = MainFrame
ApplyButton.Text = "APPLY BUFFS"
ApplyButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
ApplyButton.Position = UDim2.new(0, 10, 0, 120)
ApplyButton.Size = UDim2.new(0, 180, 0, 40)

-- Close Button
CloseButton.Parent = MainFrame
CloseButton.Text = "X"
CloseButton.BackgroundColor3 = Color3.new(1, 0, 0)
CloseButton.Position = UDim2.new(1, -25, 0, 5)
CloseButton.Size = UDim2.new(0, 20, 0, 20)

-- FUNCTIONALITY
ApplyButton.MouseButton1Click:Connect(function()
    local hum = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.WalkSpeed = tonumber(SpeedInput.Text) or 16
        hum.JumpPower = tonumber(JumpInput.Text) or 50
        hum.JumpHeight = tonumber(JumpInput.Text) or 50
        hum.UseJumpPower = true
    end
end)

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Delocal S
