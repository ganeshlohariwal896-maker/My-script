-- [[ VORTEX PRECISION V10.0 - MULTI-ARG ]] --
local ScreenGui = Instance.new("ScreenGui")
local MainButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

ScreenGui.Parent = game:GetService("CoreGui")
MainButton.Parent = ScreenGui
MainButton.Size = UDim2.new(0, 140, 0, 50)
MainButton.Position = UDim2.new(0.1, 0, 0.5, 0)
MainButton.BackgroundColor3 = Color3.fromRGB(60, 0, 200)
MainButton.Text = "START VORTEX"
MainButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MainButton.Font = Enum.Font.GothamBold
MainButton.Draggable = true
UICorner.Parent = MainButton

_G.VortexRunning = false

MainButton.MouseButton1Click:Connect(function()
    _G.VortexRunning = not _G.VortexRunning
    
    if _G.VortexRunning then
        MainButton.Text = "CLICKING..."
        MainButton.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
        
        task.spawn(function()
            -- Find the Remote again
            local storage = game:GetService("ReplicatedStorage")
            local remote = nil
            for _, v in pairs(storage:GetChildren()) do
                if v:FindFirstChild("Events") then
                    remote = v.Events:FindFirstChild("") or v.Events:GetChildren()[1]
                    break
                end
            end

            while _G.VortexRunning do
                if remote then
                    local pPos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                    
                    -- TRY 1: The SpyHub way (with exact decimals)
                    remote:FireServer(pPos, 12.499996185302734, [4] = false)
                    
                    -- TRY 2: The "Simple" way (Just Position)
                    remote:FireServer(pPos)
                    
                    -- TRY 3: The "Empty" way (Some games just need the trigger)
                    remote:FireServer()
                end
                
                -- SPEED: 0.05 (Safe and Fast)
                task.wait(0.05) 
            end
        end)
    else
        MainButton.Text = "START VORTEX"
        MainButton.BackgroundColor3 = Color3.fromRGB(60, 0, 200)
    end
end)
