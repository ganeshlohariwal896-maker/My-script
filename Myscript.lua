-- [[ VORTEX FINAL V7.0 - STEALTH & FIX ]] --
local ScreenGui = Instance.new("ScreenGui")
local MainButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

ScreenGui.Parent = game:GetService("CoreGui")
MainButton.Parent = ScreenGui
MainButton.Size = UDim2.new(0, 120, 0, 50)
MainButton.Position = UDim2.new(0.1, 0, 0.4, 0)
MainButton.BackgroundColor3 = Color3.fromRGB(100, 0, 255)
MainButton.Text = "START VORTEX"
MainButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MainButton.Font = Enum.Font.GothamBold
MainButton.Draggable = true
UICorner.Parent = MainButton

_G.VortexActive = false

MainButton.MouseButton1Click:Connect(function()
    _G.VortexActive = not _G.VortexActive
    
    if _G.VortexActive then
        MainButton.Text = "RUNNING..."
        MainButton.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        
        task.spawn(function()
            -- We find the Remote once to save memory on your Redmi 13C
            local remote = game:GetService("ReplicatedStorage"):WaitForChild("18ec827d-7b30-43ed-af9b-6e09098cce78", 5)
            if remote then remote = remote.Events:FindFirstChild("") end
            
            if not remote then
                MainButton.Text = "PATH ERROR"
                return
            end

            while _G.VortexActive do
                -- We use the LOCAL PLAYER'S actual position 
                -- This stops the "Static CFrame" kick
                local pPos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                
                local args = {
                    pPos, -- Dynamic position
                    12.5,
                    [4] = false
                }
                
                remote:FireServer(unpack(args))
                
                -- SPEED: 0.05 is the "Sweet Spot" (20 clicks per second)
                -- Fast enough to get rich, slow enough to stay unbanned.
                task.wait(0.05) 
            end
        end)
    else
        MainButton.Text = "START VORTEX"
        MainButton.BackgroundColor3 = Color3.fromRGB(100, 0, 255)
    end
end)
