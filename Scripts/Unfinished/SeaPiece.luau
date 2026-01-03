getgenv().autoFarm = true

local cEvents = {"MouseButton1Down", "MouseButton1Click", "MouseButton1Up", "Activated"}

task.spawn(function()
    while getgenv().autoFarm do task.wait()
        if game.Players.LocalPlayer.Backpack:FindFirstChild("Fists") then
            game.Players.LocalPlayer.Backpack:FindFirstChild("Fists").Parent = game.Players.LocalPlayer.Character
        end

        for i,v in pairs(game:GetService("Workspace").Live:GetChildren()) do
            if v.Name == "Bandit" then
                task.spawn(function()
                    repeat task.wait(.05)
                        game:GetService("Players").LocalPlayer.Character:FindFirstChild("Client Handler").Requests.Left:FireServer()
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0,0,2)
                    until v.Humanoid.Health == 0 or not getgenv().autoFarm
                end)
            end

            --[[for _,t in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Quest.Holder:GetChildren()) do
                if not t:FindFirstChildWhichIsA("Frame") then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Interactable["Bandit Quest"].HumanoidRootPart.CFrame
                    if not game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Dialogue") then
                        fireclickdetector(game:GetService("Workspace").Interactable["Bandit Quest"].ClickPart.ClickDetector)
                    end

                    repeat task.wait() until game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Dialogue")

                    pcall(function()
                        for oi,gt in pairs(cEvents) do
                            print(game:GetService("Players").LocalPlayer.PlayerGui.Dialogue.Holder.Accept:WaitForChild("Label").Text)
                            for o,con in pairs(getconnections(
                                game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Dialogue").Holder.Accept.Label[gt]
                                )) do
                                task.wait(2)
                                con.Function()
                            end
                        end
                    end)
                end]]
        end
    end
end)