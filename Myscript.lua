-- [[ KNIT AUTO-FARM ENGINE V2.0 - STABLE ]] --

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local LocalPlayer = Players.LocalPlayer

-- Check if Knit exists before starting to prevent errors
local success, KnitPath = pcall(function()
    return ReplicatedStorage:WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.7.0"):WaitForChild("knit"):WaitForChild("Services")
end)

if not success then return print("Knit Path not found. Game might have updated.") end

local RunningService = KnitPath:WaitForChild("RunningService"):WaitForChild("RF")

-- Settings
getgenv().AutoFarm = true
getgenv().AutoBuySpeed = true
getgenv().TargetBlockName = "base13" 

-- Advanced: Find blocks anywhere in Workspace
local function getTargetBlock()
    local target = nil
    local dist = math.huge
    for _, v in pairs(workspace:GetDescendants()) do -- Use GetDescendants to find blocks inside folders
        if v:IsA("BasePart") and (v.Name == getgenv().TargetBlockName or v.Name:find("Lucky")) then
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local d = (v.Position - char.HumanoidRootPart.Position).Magnitude
                if d < dist then
                    dist = d
                    target = v
                end
            end
        end
    end
    return target
end

task.spawn(function()
    print("--- [ FARMING STARTED ] ---")
    while getgenv().AutoFarm do
        local success, err = pcall(function()
            local block = getTargetBlock()
            
            -- 1. TP & Position Update (Using the specific remote from your log)
            local pos = block and block.CFrame or CFrame.new(507.15, 45.58, -2041.99)
            RunningService.UpdateCFrame:InvokeServer(pos)
            
            -- 2. Open & Action
            RunningService.StartMove:InvokeServer()
            RunningService.OpenLuckyBlock:InvokeServer(getgenv().TargetBlockName)
            
            -- 3. The ID Fix: If the item ID changes, this script tries to "grab" it
            -- For now, using your logged ID:
            RunningService.Collected:InvokeServer("10555251111")
            
            -- 4. Auto-Upgrades (Common Knit Names)
            if getgenv().AutoBuySpeed then
                for _, name in pairs({"BuyUpgrade", "UpgradeSpeed", "PurchaseSpeed"}) do
                    local remote = RunningService:FindFirstChild(name)
                    if remote then remote:InvokeServer("Speed") end
                end
            end
        end)
        
        if not success then warn("Loop Error: " .. err) end
        task.wait(0.2) -- Slight delay to prevent server-side lag kicks
    end
end)

-- Anti-AFK
LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

print("--- [ SCRIPT FULLY LOADED ] ---")
