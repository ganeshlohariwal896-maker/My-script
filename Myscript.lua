
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- This loop keeps the speed and jump active forever
task.spawn(function()
    while task.wait(1) do
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = 100
            humanoid.JumpPower = 150
            humanoid.UseJumpPower = true -- Forces the jump power to work
        end
    end
end)

-- Final Confirmation
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "LOOP ACTIVE";
    Text = "Speed and Jump locked at 100!";
    Duration = 5;
})
