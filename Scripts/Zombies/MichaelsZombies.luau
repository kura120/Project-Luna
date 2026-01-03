--BC_WATERMARK("\n\n\tLuna Development\n\n")

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

function notify(Text, Time)
    game.StarterGui:SetCore("SendNotification", {
        Title = "Luna Client";
        Text = Text;
        Icon = "http://www.roblox.com/asset/?id=10502664319";
        Duration = Time
    })
end

local tween = game:GetService("TweenService")
local tweeninfo = TweenInfo.new
local Creator = game.Players.LocalPlayer
local ts = game:GetService("TeleportService")
local VU = game:GetService("VirtualUser")
local TweenService = game:GetService("TweenService")
local curTween
local cEvents = {"MouseButton1Down", "MouseButton1Click", "MouseButton1Up", "Activated"}
math.randomseed(os.time())
local VUCA = {Vector2.new(math.random(), math.random()), game.Workspace.CurrentCamera.CFrame}

local part = Instance.new("Part", workspace)
part.Size = Vector3.new(15,5,15)
part.Transparency = .5
part.CFrame = workspace["_MapComponents"]["MAP_SPAWN"].CFrame * CFrame.new(0, 35, 0)
part.Material = Enum.Material.Plastic
part.Anchored = true

local Info = {
    KillAura = false,
    Speed = 5000,
    Aimlock = false,
    AK = "",
    Weapon = "",
    NoClip = false,
    Safe = false,
    P = false,

}

function getClosestZombie()
    local closestPlayer = nil
    local shortestDistance = math.huge
    for i, v in pairs(workspace.Ignore.Zombies:GetChildren()) do
        if v:FindFirstChild("Humanoid") and v.Humanoid.Health ~= 0 and v:FindFirstChild("Head") then
            local magnitude = (v.Head.Position - Creator.Character.Head.Position).magnitude

            if magnitude < shortestDistance then
                closestPlayer = v
                shortestDistance = magnitude
            end
        end
    end

    return closestPlayer
end


local Credit = Create.New({
	Title = "Credits"
})

Credit.Label({
    Text = "Thanks for choosing Project Luna",
})

Credit.Button({
    Text = "Copy Discord Link",
    Callback = function()
        setclipboard("https://discord.gg/SxTcD8C5QA")
    end
})

Credit.Button({
	Text = "Destroy GUI",
	Callback = function()
        for i,v in pairs(game.CoreGui:GetChildren()) do
            if v.Name == "Project Luna" then
                v:Destroy()
            end
        end
	end,
})

Credit.Button({
    Text = "Made by the kura#0999",
    Callback = function()
        setclipboard("https://wearedevs.net/profile?uid=68402")
    end
})

local Farm = Create.New({
    Title = "Main"
})

local funny = Create.New({
    Title = "Misc"
})

funny.Button({
    Text = "TP to box",
    Callback = function()
        if workspace:FindFirstChild("_MapComponents") then
            Creator.Character.HumanoidRootPart.CFrame = workspace["_MapComponents"].MysteryBox.HumanoidRootPart.CFrame
        end
    end
})

local Misc = Create.New({
	Title = "Local"
})

Misc.Label({
    Text = "Local Player"
})

funny.Toggle({
    Text = "Auto Get Power-Ups",
    Callback = function(v)
        Info.P = v
    end
})

funny.Toggle({
    Text = "Go to Safe Spot",
    Callback = function(v)
        Info.Safe = v
    end
})

Misc.Slider({
	Text = "Walkspeed",
	Callback = function(value)
		Creator.Character.Humanoid.WalkSpeed = tonumber(value)
	end,
	Min = 12,
	Max = 200,
	Def = 16
})

Misc.Slider({
	Text = "Jumppower",
	Callback = function(value)
        Creator.Character.Humanoid.JumpPower = tonumber(value)
	end,
	Min = 12,
	Max = 200,
	Def = 16
})

Misc.Slider({
	Text = "FOV",
	Callback = function(a)
        workspace.CurrentCamera.FieldOfView = a
	end,
	Min = 10,
	Max = 120,
	Def = 70
})

Misc.Toggle({
    Text = "Anti AFK",
    Callback = function(v)
        Info.AntiAFK = v
    end
})

Misc.Toggle({
    Text = "No Clip",
    Callback = function(v)
        Info.NoClip = v
    end
})

Misc.Button({
	Text = "Full Bright",
	Callback = function()
        game.Lighting.OutdoorAmbient = Color3.new(1,1,1)
        game.Lighting.Ambient = Color3.new(1,1,1)
	end,
})

Farm.Label({
    Text = "Farming"
})

Farm.Toggle({
    Text = "Kill Aura",
    Callback = function(v)
        Info.KillAura = v
    end
})

Farm.Button({
    Text = "Auto Reload",
    Callback = function()
        task.spawn(function()
            while task.wait() do
               game:GetService("Players").LocalPlayer.Character.Remotes.Reload:FireServer()
            end
        end)
    end
})

Farm.Label({
    Text = "Farm Settings"
})

function Main()
    while task.wait() do
        task.spawn(function()
            if Info.AntiAFK then
                task.spawn(function()
                    game:GetService("Players").LocalPlayer.Idled:Connect(function()
                        VU:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
                        task.wait(1)
                        VU:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
                    end)
                end)
            end

            if Info.NoClip then
                setfflag("HumanoidParallelRemoveNoPhysicsNoSimulate2", "False")
                setfflag("HumanoidParallelRemoveNoPhysics", "False")
            end

            if Info.Safe then
                if workspace:FindFirstChild("_MapComponents") and workspace["_MapComponents"]:FindFirstChild('MAP_SPAWN') then
                    if Info.Safe then
                        Creator.Character.HumanoidRootPart.CFrame = part.CFrame
                    elseif not Info.Safe then
                        Creator.Character.HumanoidRootPart.CFrame = workspace["_MapComponents"]["MAP_SPAWN"].CFrame * CFrame.new(0,5,0)
                    end
                end 
            end

            if Info.P then
                local pos = Creator.Character.HumanoidRootPart.CFrame
                task.spawn(function()
                    pcall(function()
                        if workspace.Ignore["_Powerups"]:GetChildren()[1] and Info.P then
                            Creator.Character.HumanoidRootPart.CFrame = workspace.Ignore["_Powerups"]:GetChildren()[1].CFrame
                            if not workspace.Ignore["_Powerups"]:GetChildren()[1] then
                                task.wait(0.05)
                                Creator.Character.HumanoidRootPart.CFrame = pos
                            end
                        end
                    end)
                end)
            end

            if Info.KillAura then
                local succ,err = pcall(function()
                    local zombie = getClosestZombie()
                    local arg = {[1] = zombie.Humanoid}
                    repeat task.wait()
                        workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, zombie.HumanoidRootPart.Position)
                        Creator.Character.HumanoidRootPart.CFrame = zombie.HumanoidRootPart.CFrame * CFrame.new(0,0,3) * CFrame.Angles(0, math.rad(90),0)
                        game:GetService("ReplicatedStorage").Framework.Remotes.KnifeHitbox:FireServer(unpack(arg))
                    until zombie.Humanoid.Health == 0 or not Info.KillAura
                    task.wait(0.05)
                    if zombie == nil or not Info.KillAura then
                        Creator.Character.HumanoidRootPart.CFrame = workspace["_MapComponents"]["MAP_SPAWN"].CFrame * CFrame.new(0,5,0)
                    end
                end)
            end
        end)
    end
end

notify("Source Loaded", 5)
Main()