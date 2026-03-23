-- [[ VORTEX UNIVERSAL V8.0 - ZERO-ID MODE ]] --
local ScreenGui = Instance.new("ScreenGui")
local MainButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

ScreenGui.Parent = game:GetService("CoreGui")
MainButton.Parent = ScreenGui
MainButton.Size = UDim2.new(0, 140, 0, 50)
MainButton.Position = UDim2.new(0.1, 0, 0.5, 0)
MainButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainButton.Text = "READY TO SCAN"
MainButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MainButton.Font = Enum.Font.GothamBold
MainButton.Draggable = true
UICorner.Parent = MainButton

_G.VortexActive = false

-- This function "Hunts" for the correct Remote automatically
local function findActiveRemote()
    -- Look in ReplicatedStorage for any RemoteEvent with "Click", "Tap", or "Add"
    for _, v in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
        if v:IsA("RemoteEvent") and (v.Name:lower():find("click") or v.Name:lower():find("tap") or v.Name:lower():find("add")) then
            return v
        end
    end
    -- If no name matches, look for any folder with "Events" in it
    for _, folder in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
        if folder:FindFirstChild("Events") then
            return folder.Events:GetChildren()[1]
        end
    end
end

MainButton.MouseButton1Click:Connect(function()
    _G.VortexActive = not _G.VortexActive
    
    if _G.VortexActive then
        local target = findActiveRemote()
        
        if not target then
            MainButton.Text = "NO REMOTE FOUND"
            _G.VortexActive = false
            task.wait(2)
            MainButton.Text = "READY TO SCAN"
            return
        end

        MainButton.Text = "FARMING: " .. target.Name
        MainButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
        
        task.spawn(function()
            while _G.VortexActive do
                -- Use your CURRENT position (safer)
                local pos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                
                -- Send the "Click" signal
                target:FireServer(pos, 12.5, false)
                
                -- SAFE SPEED: 0.1s (10 clicks/sec) 
                -- Start slow to see if you get kicked. If safe, we go faster later.
                task.wait(0.1) 
            end
        end)
    else
        MainButton.Text = "READY TO SCAN"
        MainButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    end
end)
