local Creator = game.Players.LocalPlayer

local Run = game:GetService("RunService")

Run.Stepped:Connect(function()
    if Creator.Character and Creator.Character:FindFirstChild("Humanoid") and Creator.Character.Humanoid.Health > 0 then
        for i, v in pairs(game.Workspace.Fountains.Fountain:GetDescendants()) do
            if v:IsA("TouchTransmitter") and v.Parent then
                firetouchinterest(Creator.Character:WaitForChild("HumanoidRootPart"), v.Parent, 0)
                firetouchinterest(Creator.Character:WaitForChild("HumanoidRootPart"), v.Parent, 1)
            end
        end
    end
end)
