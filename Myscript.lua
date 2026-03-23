-- [[ VORTEX ULTIMATE - FAIL-PROOF MOBILE ]] --
local ScreenGui = Instance.new("ScreenGui")
local MainButton = Instance.new("TextButton")
local Corner = Instance.new("UICorner")

-- 1. STABLE UI SETUP (Will definitely show up)
ScreenGui.Parent = game:GetService("CoreGui")
MainButton.Parent = ScreenGui
MainButton.Name = "VortexToggle"
MainButton.Size = UDim2.new(0, 120, 0, 45)
MainButton.Position = UDim2.new(0.05, 0, 0.2, 0) -- Top Left
MainButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- Red = OFF
MainButton.Text = "AUTO: OFF"
MainButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MainButton.Font = Enum.Font.GothamBold
MainButton.TextSize = 14
MainButton.Active = true
MainButton.Draggable = true -- You can move it!

Corner.CornerRadius = UDim.new(0, 8)
Corner.Parent = MainButton

_G.VortexRunning = false

-- 2. DYNAMIC REMOTE FINDER (The "Pro" Fix)
local function findRemote()
    -- Instead of the ID, we look for the folder that HAS the "Events" inside
    for _, folder in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
        if folder:FindFirstChild("Events") then
            local remote = folder.Events:FindFirstChild("") or folder.Events:GetChildren()[1]
            if remote then return remote end
        end
    end
    return nil
end

-- 3. THE ON/OFF TOGGLE
MainButton.MouseButton1Click:Connect(function()
    _G.VortexRunning = not _G.VortexRunning
    
    if _G.VortexRunning then
        MainButton.Text = "AUTO: ON"
        MainButton.BackgroundColor3 = Color3.fromRGB(0, 200, 100) -- Green = ON
        
        task.spawn(function()
            local target = findRemote()
            if not target then 
                print("Vortex: Remote not found yet. Searching...") 
                _G.VortexRunning = false
                MainButton.Text = "ERROR: RETRY"
                return 
            end
            
            while _G.VortexRunning do
                local args = {
                    CFrame.new(-157.2, 218.3, 215.3), -- Your coordinates
                    12.5,
                    [4] = false
                }
                target:FireServer(unpack(args))
                task.wait() -- Maximum speed for Redmi 13C
            end
        end)
    else
        MainButton.Text = "AUTO: OFF"
        MainButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    end
end)
