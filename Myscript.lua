-- [[ VORTEX ENGINE V5.0 - KNIT AUTO-DETECTOR ]] --
local ScreenGui = Instance.new("ScreenGui")
local MainButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

ScreenGui.Parent = game:GetService("CoreGui")
MainButton.Parent = ScreenGui
MainButton.Size = UDim2.new(0, 120, 0, 50)
MainButton.Position = UDim2.new(0.1, 0, 0.4, 0)
MainButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainButton.Text = "WAITING..."
MainButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MainButton.Font = Enum.Font.GothamBold
MainButton.Draggable = true

UICorner.Parent = MainButton

_G.Clicking = false

-- This function finds the Knit "RunningService" automatically
local function findKnitRemote()
    local rs = game:GetService("ReplicatedStorage")
    -- We look for any folder that contains "Events" or "Services"
    for _, v in pairs(rs:GetDescendants()) do
        if v.Name == "RF" or v.Name == "RE" or v.Parent.Name == "Events" then
            if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
                return v
            end
        end
    end
    return nil
end

MainButton.MouseButton1Click:Connect(function()
    _G.Clicking = not _G.Clicking
    
    if _G.Clicking then
        MainButton.Text = "ACTIVE"
        MainButton.BackgroundColor3 = Color3.fromRGB(0, 255, 120)
        
        task.spawn(function()
            -- We try to find the remote you caught, but if it fails, we search
            local remote = game:GetService("ReplicatedStorage"):WaitForChild("18ec827d-7b30-43ed-af9b-6e09098cce78", 2)
            if remote then remote = remote.Events:FindFirstChild("") end
            
            if not remote then
                remote = findKnitRemote()
            end

            while _G.Clicking do
                if remote then
                    local args = {
                        CFrame.new(-157, 218, 215),
                        12.5,
                        [4] = false
                    }
                    -- Fire the remote
                    if remote:IsA("RemoteEvent") then
                        remote:FireServer(unpack(args))
                    else
                        remote:InvokeServer(unpack(args))
                    end
                end
                task.wait() -- Maximum MS speed
            end
        end)
    else
        MainButton.Text = "STOPPED"
        MainButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    end
end)

MainButton.Text = "START VORTEX"
