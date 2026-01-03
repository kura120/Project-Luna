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
local VUCA = {Vector2.new(math.random(), math.random()), game.Workspace.CurrentCamera.CFrame}


local Info = {
    WheatFarm = false,
    AutoSell = false,
}

local Farm = Create.New({
    Title = "Farming"
})

Farm.Label({Text = "Wheat Farm"})

Farm.Toggle({
    Text = "Wheat Farm",
    Callback = function(v)
        Info.WheatFarm = v
    end
})

Farm.Toggle({
    Text = "Auto Sell Wheat",
    Callback = function(v)
        Info.AutoSell = v
    end
})

function tp(dist, extra)
    if Creator.Character:FindFirstChild("HumanoidRootPart") and Creator.Character:FindFirstChild("Humanoid") then
        
        Creator.Character:FindFirstChild("Humanoid"):ChangeState(11)
        if extra then
            local tweenInfo = tweeninfo((Creator.Character:FindFirstChild("HumanoidRootPart").Position - dist.Position).magnitude / 1000, Enum.EasingStyle.Linear)
            curTween = TweenService:Create(Creator.Character:FindFirstChild("HumanoidRootPart"), tweenInfo, {CFrame = dist * extra})
        else
            local tweenInfo = tweeninfo((Creator.Character:FindFirstChild("HumanoidRootPart").Position - dist.Position).magnitude / 1000, Enum.EasingStyle.Linear)
            curTween = TweenService:Create(Creator.Character:FindFirstChild("HumanoidRootPart"), tweenInfo, {CFrame = dist})
        end

        curTween:Play()
    end
end

function sell()
    if Info.AutoSell then
        for i,v in pairs(workspace.Sell:GetDescendants()) do
            if v.name == "TouchInterest" and v.Parent then
                firetouchinterest(Creator.Character.HumanoidRootPart, v.Parent, 0)
                task.wait(0.01)
                firetouchinterest(Creator.Character.HumanoidRootPart, v.Parent, 1)
            end
        end
        task.wait()
    end
end

function wheatFarm()
    repeat task.wait()
        if curTween then curTween.Completed:Wait() end
        tp(CFrame.new(272.708984, 46.090004, -363.793274, -0.999818742, 4.18907575e-09, 0.0190387797, 3.62673402e-09, 1, -2.95711882e-08, -0.0190387797, -2.94967784e-08, -0.999818742))
        curTween.Completed:Wait()
        task.wait(1.3)
        tp(CFrame.new(275.08667, 46.1999893, 393.171906, -0.999997675, 1.35999736e-08, -0.00216936949, 1.34995881e-08, 1, 4.62885126e-08, 0.00216936949, 4.62591174e-08, -0.999997675))
        curTween.Completed:Wait()
    until not Info.WheatFarm
    task.wait()
end

function Main()
    while task.wait() do
        task.spawn(function()
            if Info.AutoSell then
                sell()
            end

            if Info.WheatFarm then
                wheatFarm()
            end
        end)
    end
end

Main()