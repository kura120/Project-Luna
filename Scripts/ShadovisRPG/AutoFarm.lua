local Settings = {AutoFarm = true, Range = 50, Enemy = "Berserker Master Lv 125"}
local Run = game:GetService("RunService")
local Creator = game.Players.LocalPlayer

local weaponData = require(game:GetService("ReplicatedStorage").WeaponData)
local combatData = game:GetService("ReplicatedStorage").CombatData

local WeaponName, WeaponType, WeaponM1Name

function getWeapon(wep, type)
    local weaponModule = require(combatData[type])
    
    local Data = {
        Character = game.Players.LocalPlayer.Character,
        Stats = {AS = 1},
        Tools = {wep},
        Anim = require(game.ReplicatedStorage.AnimationService),
    }
    
    for i,v in pairs(weaponModule(Data, wep)) do
        if v.LMB then
            return v.LMB[1]
        end
    end
end

local meleeWeaponNames = {
    "Sword",
    "Club",
    "Longsword",
    "Axe",
    "Katana",
    "Spear",
    "Axe",
    "Knife",
    "Mallet",
    "Blade",
    "Gauntlets",
    "Lance",
    "Scythe",
    "Twin Blade"
}

local function isMeleeWeapon(wep)
    if weaponData[wep] and table.find(meleeWeaponNames, weaponData[wep].Type) then
        return true
    end
end

for i,v in pairs(Creator.Character.Equipment:GetChildren()) do
    if isMeleeWeapon(v.Name) then
        WeaponName, WeaponType = v.Name, weaponData[v.Name].Type
        WeaponM1Name = getWeapon(v, WeaponType)
    end
end

Creator.Character.Equipment.ChildAdded:Connect(function(v)
    if isMeleeWeapon(v.Name) then
        WeaponName, WeaponType = v.Name, weaponData[v.Name].Type
        WeaponM1Name = getWeapon(v, WeaponType)
    end
end)

local function DamageMob(mob)
    if mob and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
        Creator.Character.Combat.RemoteEvent:FireServer("Input", WeaponName, math.random(), WeaponM1Name.."Event", mob.PrimaryPart)
    end
end

while Settings.AutoFarm do task.wait()
    for i,t in pairs(workspace.NPCs:GetChildren()) do
        if t.Name == Settings.Enemy and t:FindFirstChild("HumanoidRootPart") then
            Creator.Character:WaitForChild("HumanoidRootPart").CFrame = t:FindFirstChild("HumanoidRootPart").CFrame * CFrame.new(0,0,7) * CFrame.Angles(0, math.rad(180), 0)
            DamageMob(t)
        end
    end
end