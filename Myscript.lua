-- [[ VORTEX TURBO CLICKER - FIXED ID ]] --
getgenv().AutoClick = true

task.spawn(function()
    print("Vortex: Starting Turbo Clicker...")
    
    -- This is the secret path you found in SimpleSpy
    local targetRemote = game:GetService("ReplicatedStorage"):WaitForChild("18ec827d-7b30-43ed-af9b-6e09098cce78"):WaitForChild("Events"):WaitForChild("")

    while getgenv().AutoClick do
        -- These are the exact "Args" you caught
        local args = {
            CFrame.new(-157.205, 218.350, 215.344), -- Your location
            12.5, -- Speed/Power
            [4] = false
        }
        
        -- Sending the click to the server as fast as possible
        targetRemote:FireServer(unpack(args))
        
        -- 0.001 is too fast for Roblox servers, so we use task.wait()
        -- This is the fastest "Safe" speed (about 30-60 clicks per second)
        task.wait() 
    end
end)
