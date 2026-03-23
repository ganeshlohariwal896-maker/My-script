-- [[ VORTEX ATOMIC V13.0 ]] --
for _, v in pairs(game:GetService("CoreGui"):GetChildren()) do
    if v.Name == "VortexGui" then v:Destroy() end
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VortexGui"
ScreenGui.Parent = game:GetService("CoreGui")

local Main = Instance.new("TextButton")
Main.Parent = ScreenGui
Main.Size = UDim2.new(0, 200, 0, 60)
Main.Position = UDim2.new(0.5, -100, 0.2, 0)
Main.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
Main.Text = "TAP TO START VORTEX"
Main.TextColor3 = Color3.fromRGB(255, 255, 255)
Main.Font = Enum.Font.SourceSansBold
Main.TextSize = 20
Main.Active = true
Main.Draggable = true

local function GetRemote()
    for _, folder in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
        if folder:FindFirstChild("Events") then
            return folder.Events:FindFirstChild("") or folder.Events:GetChildren()[1]
        end
    end
    return nil
end

_G.Running = false
Main.MouseButton1Click:Connect(function()
    _G.Running = not _G.Running
    if _G.Running then
        Main.Text = "RUNNING (STAY CLOSE)"
        Main.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        task.spawn(function()
            local remote = GetRemote()
            while _G.Running do
                pcall(function()
                    local pos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                    remote:FireServer(pos, 12.5, {[4] = false})
                end)
                task.wait(0.1)
            end
        end)
    else
        Main.Text = "TAP TO START VORTEX"
        Main.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    end
end)
