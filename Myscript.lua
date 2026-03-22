local player = game.Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")

-- 1. DELETE OLD UI
if pgui:FindFirstChild("MobileForceHub") then pgui.MobileForceHub:Destroy() end

-- 2. CREATE THE UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MobileForceHub"
ScreenGui.Parent = pgui

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 220, 0, 200)
Main.Position = UDim2.new(0.5, -110, 0.4, 0)
Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Main.BorderSizePixel = 2
Main.Active = true
Main.Draggable = true 
Main.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "FORCE ADJUSTER"
Title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Parent = Main

-- INPUT BOXES
local SpeedBox = Instance.new("TextBox")
SpeedBox.Size = UDim2.new(0, 200, 0, 40)
SpeedBox.Position = UDim2.new(0, 10, 0, 40)
SpeedBox.PlaceholderText = "Set Speed (Try 100)"
SpeedBox.Text = "16"
SpeedBox.Parent = Main

local JumpBox = Instance.new("TextBox")
JumpBox.Size = UDim2.new(0, 200, 0, 40)
JumpBox.Position = UDim2.new(0, 10, 0, 90)
JumpBox.PlaceholderText = "Set Jump (Try 150)"
JumpBox.Text = "50"
JumpBox.Parent = Main

local Apply = Instance.new("TextButton")
Apply.Size = UDim2.new(0, 200, 0, 50)
Apply.Position = UDim2.new(0, 10, 0, 140)
Apply.Text = "ACTIVATE FORCE"
Apply.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
Apply.TextColor3 = Color3.new(1, 1, 1)
Apply.Parent = Main

-- 3. THE FORCE LOOP (This is what makes it work!)
local targetSpeed = 16
local targetJump = 50

Apply.MouseButton1Click:Connect(function()
    targetSpeed = tonumber(SpeedBox.Text) or 16
    targetJump = tonumber(JumpBox.Text) or 50
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "FORCE ENABLED";
        Text = "Speed: "..targetSpeed.." | Jump: "..targetJump;
        Duration = 3;
    })
end)

-- This runs every single frame to beat the game's anti-reset
game:GetService("RunService").RenderStepped:Connect(function()
    local char = player.Character
    if char and char:FindFirstChild("Humanoid") then
        local hum = char.Humanoid
        hum.WalkSpeed = targetSpeed
        -- Set both Jump systems to be safe
        hum.JumpPower = targetJump
        hum.JumpHeight = targetJump / 2 -- Formula for JumpHeight games
        hum.UseJumpPower = true
    end
end)
