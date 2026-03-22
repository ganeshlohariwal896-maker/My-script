-- [[ MEGA ADMIN V16 - CLEAN UI & NOTIFY ]] --
local player = game.Players.LocalPlayer
local prefix = ";"

-- Global States
_G.Flying = false
_G.Speed = 16

-- 1. NOTIFICATION SYSTEM
local function notify(title, text)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = title;
        Text = text;
        Duration = 3;
    })
end

-- 2. CLEAN UI CREATION
local function createUI()
    local sg = Instance.new("ScreenGui", player.PlayerGui)
    sg.Name = "MegaAdminUI"
    
    local frame = Instance.new("Frame", sg)
    frame.Size = UDim2.new(0, 220, 0, 300)
    frame.Position = UDim2.new(0.5, -110, 0.5, -150)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.Draggable = true
    frame.Visible = false -- Hidden by default
    
    -- Rounded Corners
    local corner = Instance.new("UICorner", frame)
    corner.CornerRadius = UDim.new(0, 10)

    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1, 0, 0, 40)
    title.Text = "MEGA ADMIN V16"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 16
    Instance.new("UICorner", title).CornerRadius = UDim.new(0, 10)

    local scroll = Instance.new("ScrollingFrame", frame)
    scroll.Size = UDim2.new(1, -10, 1, -50)
    scroll.Position = UDim2.new(0, 5, 0, 45)
    scroll.BackgroundTransparency = 1
    scroll.CanvasSize = UDim2.new(0, 0, 1.5, 0)
    scroll.ScrollBarThickness = 4

    local list = Instance.new("TextLabel", scroll)
    list.Size = UDim2.new(1,
