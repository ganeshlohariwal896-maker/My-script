-- [[ VORTEX FINAL PERFECT V12.0 ]] --
local ScreenGui = Instance.new("ScreenGui")
local MainButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

-- 1. UI SETUP (Guaranteed to Render)
ScreenGui.Parent = game:GetService("CoreGui")
MainButton.Parent = ScreenGui
MainButton.Size = UDim2.new(0, 150, 0, 50)
MainButton.Position = UDim2.new(0.35, 0, 0.15, 0) -- Top Center-ish
MainButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainButton.BorderSizePixel = 2
MainButton.BorderColor3 = Color3.fromRGB(255, 255, 255)
MainButton.Text = "ACTIVATE VORTEX"
MainButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MainButton.Font = Enum.Font.GothamBold
MainButton.TextSize = 14
MainButton.Draggable = true
UICorner.Parent = MainButton

_G.VortexRunning = false

MainButton.MouseButton1Click:Connect(function()
    _G.VortexRunning = not _G.VortexRunning
    
    if _G.VortexRunning then
        MainButton.Text = "VORTEX: ACTIVE"
        MainButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
        
        task.spawn(function()
            -- 2. DYNAMIC REMOTE SEARCH (Finds the hidden 'Post Office')
            local remote = nil
            for _, v in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
                if v:IsA("RemoteEvent") and v.Parent.Name == "Events" then
                    remote = v
                    break
                end
            end
            
            if not remote then
                MainButton.Text = "REMOTE NOT FOUND"
                return
            end

            while _G.VortexRunning do
                pcall(function()
                    -- 3. CHARACTER CHECK
                    local char = game.Players.LocalPlayer.Character
                    if char and char:FindFirstChild("HumanoidRootPart") then
                        -- 4. THE PERFECT ARGS (Based on your SpyHub log)
                        local args = {
                            [1] = char.HumanoidRootPart.CFrame,
                            [2] = 12.499996185302734,
                            [4] = false
                        }
                        
                        -- 5. THE FIRE
                        remote:FireServer(unpack(args))
                    end
                end)
                
                -- 6. THE SPEED (0.05 is the sweet spot for mobile)
                task.wait(0.05) 
            end
        end)
    else
        MainButton.Text = "ACTIVATE VORTEX"
        MainButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    end
end)
