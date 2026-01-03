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

local tween = game:GetService("TweenService")
local tweeninfo = TweenInfo.new
local Creator = game.Players.LocalPlayer
local ts = game:GetService("TeleportService")
local VU = game:GetService("VirtualUser")
local TweenService = game:GetService("TweenService")
local curTween
local cEvents = {"MouseButton1Down", "MouseButton1Click", "MouseButton1Up", "Activated"}
math.randomseed(os.time())
local VUCA = {Vector2.new(math.random(), math.random()), workspace.CurrentCamera.CFrame}

local Info = {
    AutoFarm = false,
    Enemy = false,
    Speed = 175,
}

function tp(dist, extra)
    if Creator.Character:FindFirstChild("HumanoidRootPart") and Creator.Character:FindFirstChild("Humanoid") then
        
        Creator.Character:FindFirstChild("Humanoid"):ChangeState(11)
        if extra then
            local tweenInfo = tweeninfo((Creator.Character:FindFirstChild("HumanoidRootPart").Position - dist.Position).magnitude / Info.Speed, Enum.EasingStyle.Linear)
            curTween = TweenService:Create(Creator.Character:FindFirstChild("HumanoidRootPart"), tweenInfo, {CFrame = dist * extra})
        else
            local tweenInfo = tweeninfo((Creator.Character:FindFirstChild("HumanoidRootPart").Position - dist.Position).magnitude / Info.Speed, Enum.EasingStyle.Linear)
            curTween = TweenService:Create(Creator.Character:FindFirstChild("HumanoidRootPart"), tweenInfo, {CFrame = dist})
        end

        curTween:Play()
    end
end

local AutoFarm = Create.New({
    Title = "Auto Farm"
})

AutoFarm.Toggle({
    Text = "Initiate Farm",
    Callback = function(v)
        Info.AutoFarm = v
    end
})

AutoFarm.Dropdown({
    Text = "NPC to Farm",
    Callback = function(v)
        Info.Enemy = v
    end,
    Options = {"Zombie", "Thug", "Dio Brando (Teen)", "Brawler", "Graveyard Zombie", "Dio Brando"}
})

local Settings = Create.New({
    Title = "Settings"
})

Settings.Slider({
    Text = "Tween Speed",
    Callback = function(v)
        Info.Speed = v
    end,
    Min = 100,
    Max = 400,
    Def = 175,
})
local Main = function()
    task.spawn(function()
        pcall(function()
            while task.wait() do
                if Info.AutoFarm then
                    for i,v in pairs(game:GetService("Workspace").NPCs.Hostile:GetChildren()) do
                        if v:IsA("Model") and v.Name == Info.Enemy and Info.AutoFarm then
                            task.spawn(function()
                                repeat task.wait()
                                    tp(v.HumanoidRootPart.CFrame, CFrame.new(0, 6, 0) * CFrame.Angles(math.rad(-90), 0, 0))
                                    setfflag("HumanoidParallelRemoveNoPhysics", "False")
                                    setfflag("HumanoidParallelRemoveNoPhysicsNoSimulate2", "False")
                                    Creator.Character.Humanoid:ChangeState(11)
                                until v.Humanoid.Health == 0 or not Info.AutoFarm
                            end)
                            for t = 0,4 do
                                if v.Humanoid.Health ~= 0 then
                                    game:GetService("Players").LocalPlayer.Backpack.Events.HotkeyEvent:FireServer("Light Punch", true, false)
                                end
                            end
                            task.wait(0.5)
                            game:GetService("Players").LocalPlayer.Backpack.Events.HotkeyEvent:FireServer("Kick", true, false, "Forward")
                        end
                    end
                end
            end
        end)
    end)
end

Main()