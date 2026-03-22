local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- THE ACTUAL BUFFS
humanoid.WalkSpeed = 100
humanoid.JumpPower = 150

-- NOTIFICATION TO CONFIRM IT WORKED
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "BUFFS ACTIVE";
    Text = "Speed: 100 | Jump: 150";
    Duration = 5;
})
