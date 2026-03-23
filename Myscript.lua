-- [[ VORTEX HUB V3.0 - STABLE MOBILE ]] --
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "VORTEX HUB",
   LoadingTitle = "Loading Vortex...",
   LoadingSubtitle = "by Ganesh",
   ConfigurationSaving = {
      Enabled = false
   }
})

local MainTab = Window:CreateTab("Main Farm", 4483362458) -- Farm Icon

local Toggle = MainTab:CreateToggle({
   Name = "Auto Clicker",
   CurrentValue = false,
   Flag = "Toggle1",
   Callback = function(Value)
      getgenv().AutoClick = Value
      
      if Value then
          task.spawn(function()
              -- This is the "Post Office" address you caught
              local Remote = game:GetService("ReplicatedStorage"):WaitForChild("18ec827d-7b30-43ed-af9b-6e09098cce78"):WaitForChild("Events"):WaitForChild("")
              
              while getgenv().AutoClick do
                  local args = {
                      CFrame.new(-157.2, 218.3, 215.3),
                      12.5,
                      [4] = false
                  }
                  Remote:FireServer(unpack(args))
                  task.wait(0.01) -- Super fast clicks
              end
          end)
      end
   end,
})

Rayfield:Notify({
   Title = "Vortex Loaded",
   Content = "Toggle the switch to start clicking!",
   Duration = 5,
   Image = 4483362458,
})
