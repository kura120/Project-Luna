local UI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/MaterialLua/master/Module.lua"))()
local Create = UI.Load({
	Title = "Project Luna",
	Style = 1,
	SizeX = 450,
	SizeY = 400,
	Theme = "Dark",
	ColorOverrides = {
        Minimise = Color3.fromRGB(255, 255, 255),
        Maximise = Color3.fromRGB(56, 204, 0),
        MinimiseAccent = Color3.fromRGB(255, 255, 255),
        MaximiseAccent = Color3.fromRGB(56, 204, 0),
		MainFrame = Color3.fromRGB(13, 14, 21),
        TitleBar = Color3.fromRGB(13, 14, 21),
        NavBar = Color3.fromRGB(13, 14, 21),
        Button = Color3.fromRGB(61, 62, 67),
        ButtonAccent = Color3.fromRGB(255,255,255),
        Toggle = Color3.fromRGB(255, 255, 255),
        ToggleAccent = Color3.fromRGB(255, 255, 255),
        ChipSet = Color3.fromRGB(255, 255, 255),
        DataTable = Color3.fromRGB(61, 62, 67),
        Slider = Color3.fromRGB(61, 62, 67),
        Dropdown = Color3.fromRGB(61, 62, 67),
		ColorPicker = Color3.fromRGB(61, 62, 67),
		TextField = Color3.fromRGB(61, 62, 67),
        Content = Color3.fromRGB(25, 25, 25),
	}
})

local Settings = {KillAura = false, Range = 25, Enemy = "", AutoFarm = false, Key1 = false, Key2 = false, IAS = false, AR = false, IJ = false}

local Run = game:GetService("RunService")
local Creator = game.Players.LocalPlayer

local weaponData = require(game:GetService("ReplicatedStorage").WeaponData)
local combatData = game:GetService("ReplicatedStorage").CombatData

local wepName, wepType, WeaponM1Name

function getNPCs()
    local tbl = {}

    for i,v in pairs(game:GetService("Workspace").NPCs:GetChildren()) do
        local formula = string.split(v.Name, "HP")[1]
        if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") and not table.find(tbl, formula) then
            table.insert(tbl, formula)
        end
    end

    table.sort(tbl, function(a, s)
        local a1 = tonumber(string.match(a, "%d+"))
        local b1 = tonumber(string.match(s, "%d+"))

        return a1 < b1
    end)
    
    return tbl
end

function getWeapon(Weapon, y)
    local weaponModule = require(combatData[y])
    
    local Data = {
        Character = Creator.Character,
        Stats = {AS = 1},
        Tools = {Weapon},
        Anim = require(game.ReplicatedStorage.AnimationService),
    }
    
    for i,v in pairs(weaponModule(Data, Weapon)) do
        if v.LMB then
            return v.LMB[1]
        end
    end
end

function getClosestNPC()
    local closestPlayer = nil
    local shortestDistance = math.huge
    for i, v in pairs(workspace.NPCs:GetChildren()) do
        if v ~= Creator and v:FindFirstChild("Humanoid") and v.Humanoid.Health ~= 0 and v:FindFirstChild("HumanoidRootPart") then
            local magnitude = (v.HumanoidRootPart.Position - Creator.Character.HumanoidRootPart.Position).Magnitude

            if magnitude < shortestDistance then
                closestPlayer = v
                shortestDistance = magnitude
            end
        end
    end

    return closestPlayer
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
    "Twin Blade",
    "Trident",
    "Rod",
    "Staff",

}

function isMeleeWeapon(WeaponName)
    if weaponData[WeaponName] and table.find(meleeWeaponNames, weaponData[WeaponName].Type) then
        return true
    end
end

function getWep()
    for i,v in pairs(Creator.Character.Equipment:GetChildren()) do
        if isMeleeWeapon(v.Name) then
            wepName, wepType = v.Name, weaponData[v.Name].Type
            WeaponM1Name = getWeapon(v, wepType)
        end
    end
end

Creator.Character.Equipment.ChildAdded:Connect(function(v)
    if isMeleeWeapon(v.Name) then
        wepName, wepType = v.Name, weaponData[v.Name].Type
        WeaponM1Name = getWeapon(v, wepType)
    end
end)

function DamageMob(mob)
    getWep()
    if mob and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
        Creator.Character.Combat.RemoteEvent:FireServer("Input", wepName, math.random(), WeaponM1Name.."Event", mob.PrimaryPart)
    end
end

local Farm = Create.New({Title = "Farming"})
local Skills = Create.New({Title = "Skills"})
Skills.Label({Text = "Input"})
Skills.Toggle({Text = "Use E Skill", Callback = function(v) Settings.Key1 = v
    while Settings.Key3 do task.wait()
        local VU = game:GetService("VirtualInputManager")
        VU:SendKeyEvent(true, 102, false, game)
        task.wait()
    end
end})
Skills.Toggle({Text = "Use R Skill", Callback = function(v) Settings.Key1 = v
    while Settings.Key1 do task.wait()
        local VU = game:GetService("VirtualInputManager")
        VU:SendKeyEvent(true, 114, false, game)
        task.wait()
    end
end})
Skills.Toggle({Text = "Use F Skill", Callback = function(v) Settings.Key1 = v
    while Settings.Key2 do task.wait()
        local VU = game:GetService("VirtualInputManager")
        VU:SendKeyEvent(true, 102, false, game)
        task.wait()
    end
end})
local Misc = Create.New({Title = "Misc"})
Misc.Label({Text = "User"})
Misc.Toggle({Text = "Auto Rebirth", Callback = function(v)
    Settings.AR = v

    while Settings.AR do task.wait()
        game:GetService("ReplicatedStorage").RemoteEvent:FireServer("Rebirth")
    end
end})
Misc.Toggle({Text = "Infinite Jump", Callback = function(v)
    Settings.IJ = v
    Creator:GetMouse().KeyDown:Connect(function(Key)
        if Settings.IJ and Key == " " then
            Creator.Character:FindFirstChildOfClass('Humanoid'):ChangeState(3)
        end
    end)
end})
Misc.Label({Text = "Game"})
Misc.Button({Text = "Get All Cubits", Callback = function()
    for i,v in pairs(workspace["Client Cubits"]:GetChildren()) do
        if v:IsA("MeshPart") then
            if v:FindFirstChildWhichIsA("ProximityPrompt") then
                fireproximityprompt(v:FindFirstChildWhichIsA("ProximityPrompt"), 1)
            end
        end
    end
end})
Farm.Label({Text = "Auto Farming"})
Farm.Toggle({Text = "Auto Farm", Callback = function(v) Settings.AutoFarm = v
        while Settings.AutoFarm do task.wait()
            pcall(function()
            for i,t in pairs(workspace.NPCs:GetChildren()) do
                if string.match(t.Name, Settings.Enemy) and t:FindFirstChild("HumanoidRootPart") then
                    Creator.Character:WaitForChild("HumanoidRootPart").CFrame = t:FindFirstChild("HumanoidRootPart").CFrame * CFrame.new(0,0,11) * CFrame.Angles(0, math.rad(90), 0)
                    DamageMob(t)
                end
            end
        end)
    end
end})

local y = Farm.Dropdown({Text = "NPC To Farm", Callback = function(v) Settings.Enemy = v end, Options = getNPCs()})
Farm.Button({Text = "Refresh NPCs", Callback = function() y:SetOptions(getNPCs()) end})
Farm.Label({Text = "Kill Aura"})
Farm.Toggle({Text = "Kill Aura", Callback = function(v)
    Settings.KillAura = v

    while Settings.KillAura do task.wait()
        local t = getClosestNPC()

        workspace.NPCs.ChildAdded:Connect(function()
            t = getClosestNPC()
        end)

        if t then
            pcall(function()
                repeat task.wait()
                    DamageMob(t)
                until t.Humanoid.Health == 0 or not Settings.KillAura
            end)
        else
            t = getClosestNPC()
        end
    end
end})
Farm.Slider({Text = "Range", Callback = function(v)
    Settings.Range = v
end, Min = 25, Max = 250, Def = Settings.Range})