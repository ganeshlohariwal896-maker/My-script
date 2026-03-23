-- [[ VORTEX GHOST V9.0 - DYNAMIC POS ]] --
local ScreenGui = Instance.new("ScreenGui")
local MainButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

ScreenGui.Parent = game:GetService("CoreGui")
MainButton.Parent = ScreenGui
MainButton.Size = UDim2.new(0, 130, 0, 50)
MainButton.Position = UDim2.new(0.1, 0, 0.5, 0)
MainButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
MainButton.Text = "START VORTEX"
MainButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MainButton.Font = Enum.Font.GothamBold
MainButton.Draggable = true
UICorner.Parent = MainButton

_G.VortexRunning = false

MainButton.MouseButton1Click:Connect(function()
    _G.VortexRunning = not _G.VortexRunning
    
    if _G.VortexRunning then
        MainButton.Text = "RUNNING..."
        MainButton.BackgroundColor3 = Color3.fromRGB(0, 255, 150)
        
        task.spawn(function()
            -- We search for the "Events" folder directly to bypass the changing ID
            local storage = game:GetService("ReplicatedStorage")
            local remote = nil
            
            -- This loop finds the folder even if the ID changes
            for _, v in pairs(storage:GetChildren()) do
                if v:FindFirstChild("Events") then
                    remote = v.Events:FindFirstChild("") or v.Events:GetChildren()[1]
                    break
                end
            end

            if not remote then
                MainButton.Text = "NOT FOUND"
                return
            end

            while _G.VortexRunning do
                -- GET CURRENT CHARACTER POSITION (The Anti-Kick Secret)
                local char = game.Players.LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    local currentPos = char.HumanoidRootPart.CFrame
                    
                    -- Exactly what SpyHub saw, but with YOUR real position
                    local args = {
                        currentPos,
                        12.5,
                        [4] = false
                    }
                    
                    remote:FireServer(unpack(args))
                end
                
                -- SPEED: 0.03 is the "Pro" limit. Fast but stable.
                task.wait(0.03) 
            end
        end)
    else
        MainButton.Text = "START VORTEX"
        MainButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    end
end)
