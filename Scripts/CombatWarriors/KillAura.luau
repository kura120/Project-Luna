loadstring(game:HttpGet("https://www.catware.xyz/assets/scripts/combat-warriors.lua"))()

local Settings = {Radius = 15000, Farm = true}

local CurrentCamera = workspace.CurrentCamera
local Players = game.Players
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local tween = game:GetService("TweenService")
local tweeninfo = TweenInfo.new
local curTween

function tp(dist, extra)
    if extra then
        workspace.PlayerCharacters[LocalPlayer.Name].HumanoidRootPart.CFrame = dist * extra
    else
        workspace.PlayerCharacters[LocalPlayer.Name].HumanoidRootPart.CFrame = dist
    end
end

function ClosestPlayer()
    local MaxDist, Closest = Settings.Radius
    for i,v in pairs(Players.GetPlayers(Players)) do
        if v == LocalPlayer then continue end
        if not v.Team == LocalPlayer then continue end
        if not v.Character then continue end

        local Head = v.Character.FindFirstChild(v.Character, "HumanoidRootPart")
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
    return Closest
end

function getWeapon()
    for i,v in pairs(workspace.PlayerCharacters[LocalPlayer.Name]:GetChildren()) do
        if v:IsA("Tool") and v:FindFirstChild("Hitboxes") then
            return v, false
        else
            for _,c in pairs(LocalPlayer.Backpack:GetChildren()) do
                if c:IsA("Tool") and c:FindFirstChild("Hitboxes") then
                    return c, true
                end
            end
        end
    end
end

local wep, isOnBackpack = getWeapon()

if isOnBackpack then
    wep.Parent = workspace.PlayerCharacters[LocalPlayer.Name]
end
repeat task.wait() until workspace.PlayerCharacters[LocalPlayer.Name]:FindFirstChild(wep.Name)
task.wait(.15)
wep.Hitboxes.Hitbox.Transparency = 0.5
wep.Hitboxes.Hitbox.Size = Vector3.new(3.5, 13, 4.2)

pcall(function()
    while task.wait() do
        local Closest = ClosestPlayer()
        if Closest then
            repeat task.wait()
                tp(workspace.PlayerCharacters[Closest.Name].HumanoidRootPart.CFrame * CFrame.new(0, 0, 1))
                task.wait(0.03)
                game:GetService("VirtualInputManager"):SendMouseButtonEvent(500, 500, 0, true, game, 1)
                task.wait(.45)
                repeat task.wait()
                    tp(workspace.PlayerCharacters[Closest.Name].HumanoidRootPart.CFrame * CFrame.new(0, 0, 10))
                until wep.CooldownProgress.Value == 0

                tp(workspace.PlayerCharacters[Closest.Name].HumanoidRootPart.CFrame * CFrame.new(0, 0, 1))

                task.wait(0.15)
                game:GetService("VirtualInputManager"):SendMouseButtonEvent(500, 500, 0, false, game, 1)
                task.wait()
            until workspace.PlayerCharacters[Closest.Name].Humanoid.Health == 0 or getgenv().farm == false
        end
    end
end)