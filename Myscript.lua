-- [[ VORTEX HUB V2.0 - PRO MOBILE UI ]] --
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-backups/main/mavo"))()

-- Create the Window
local Window = Library:CreateWindow("VORTEX HUB")

-- Create the Tab
local MainTab = Window:CreateTab("Main Farm")

-- 1. THE ON/OFF TOGGLE
MainTab:CreateToggle("Start Auto Clicker", function(state)
    getgenv().AutoClick = state
    
    if state then
        task.spawn(function()
            -- Your secret Remote Path
            local targetRemote = game:GetService("ReplicatedStorage"):WaitForChild("18ec827d-7b30-43ed-af9b-6e09098cce78"):WaitForChild("Events"):WaitForChild("")
            
            while getgenv().AutoClick do
                local args = {
                    CFrame.new(-157.205, 218.350, 215.344),
                    12.5,
                    [4] = false
                }
                targetRemote:FireServer(unpack(args))
                
                -- This uses the Speed we set (default 0.01)
                task.wait(getgenv().ClickSpeed or 0.01) 
            end
        end)
    end
end)

-- 2. THE SPEED SLIDER (Pro Feature)
MainTab:CreateSlider("Click Speed", 0.001, 1, function(value)
    getgenv().ClickSpeed = value
end)
