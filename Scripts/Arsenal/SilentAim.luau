local Settings = {TeamCheck = true, aimpart = "Head", VisibilityCheck = true, SilentAim = true}

local CurrentCamera = workspace.CurrentCamera
local Players = game.Players
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

function getClosestPlayer()
    local MaxDist, Closest = math.huge
    for i,v in pairs(Players.GetPlayers(Players)) do
        if v ~= LocalPlayer then
            local Head = v.Character.FindFirstChild(v.Character, Settings.aimpart)
            if not Head then continue end

            local Pos, Vis = CurrentCamera.WorldToScreenPoint(CurrentCamera, Head.Position)
            if not Vis then continue end

            
            local MousePos, TheirPos = Vector2.new(Mouse.X, Mouse.Y), Vector2.new(Pos.X, Pos.Y)
            local Dist = (TheirPos - MousePos).Magnitude
            
            if Dist < MaxDist then
                MaxDist = Dist
                Closest = v
            end
        end
    end
    return Closest
end

local old; old = hookmetamethod(game, "__namecall", function(self, ...)
    local args, method = {...}, getnamecallmethod()

    if method == "FindPartOnRayWithIgnoreList" and Settings.SilentAim then
        local v = getClosestPlayer()
        args[1] = Ray.new(workspace.CurrentCamera.CFrame.Position,
        (v.Character[Settings.aimpart].Position - game.Workspace.CurrentCamera.CFrame.Position).Unit * 6000)

        return old(self, unpack(args))
    end
    
    return old(self, ...)
end)