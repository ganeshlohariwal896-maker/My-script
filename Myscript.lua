-- [[ VORTEX TURBO V4.0 - DIRECT PATH ]] --
local ScreenGui = Instance.new("ScreenGui")
local MainButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

ScreenGui.Parent = game:GetService("CoreGui")
MainButton.Parent = ScreenGui
MainButton.Size = UDim2.new(0, 120, 0, 50)
MainButton.Position = UDim2.new(0.1, 0, 0.1, 0)
MainButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
MainButton.Text = "OFF"
MainButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MainButton.Font = Enum.Font.GothamBold
MainButton.Draggable = true

UICorner.Parent = MainButton

_G.Clicking = false

MainButton.MouseButton1Click:Connect(function()
    _G.Clicking = not _G.Clicking
    
    if _G.Clicking then
        MainButton.Text = "CLICKING..."
        MainButton.BackgroundColor3 = Color3.fromRGB(50, 255, 50)
        
        task.spawn(function()
            -- DIRECT PATH TRIPLE-CHECKED
            local rs = game:GetService("ReplicatedStorage")
            local folder = rs:FindFirstChild("18ec827d-7b30-43ed-af9b-6e09098cce78")
            
            if not folder then
                warn("Vortex Error: Remote Folder Missing!")
                MainButton.Text = "RE-SPY NEEDED"
                _G.Clicking = false
                return
            end
            
            local remote = folder.Events:FindFirstChild("")
            
            while _G.Clicking do
                -- Sending exactly what SpyHub caught
                local args = {
                    CFrame.new(-157.2, 218.3, 215.3),
                    12.5,
                    [4] = false
                }
                
                remote:FireServer(unpack(args))
                
                -- This is the fastest "MS" speed (approx 0.001s in logic)
                task.wait() 
            end
        end)
    else
        MainButton.Text = "OFF"
        MainButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    end
end)
