local Settings = {AutoRebirth = true}

while Settings.AutoRebirth do task.wait(.65)
    game:GetService("ReplicatedStorage").RemoteEvent:FireServer("Rebirth")
end