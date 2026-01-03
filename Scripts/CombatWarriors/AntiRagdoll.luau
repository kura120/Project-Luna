local ncall
local Creator = game.Players.LocalPlayer
ncall = hookmetamethod(game, "__namecall", function(self, ...)
    local args = {...}
    if not checkcaller() then
        local method = getnamecallmethod()

        if method == "FireServer" and self.Name == "RagdollRemoteEvent" then
            workspace.PlayerCharacters[Creator.Name].Humanoid.RagdollRemoteEvent:FireServer(false)
        end
    end
    return ncall(self, unpack(args))
end)