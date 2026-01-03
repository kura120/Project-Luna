local Info = {
    AutoFarm = false,
    Skills = {
        ["1"] = false,
        ["2"] = false,
        ["3"] = false,
        ["4"] = false
    },
    USkill = false,
    M1 = false,
    Both = false,
}

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

function tp(dist, extra)
    if Creator.Character:FindFirstChild("HumanoidRootPart") and Creator.Character:FindFirstChild("Humanoid") then
        
        Creator.Character:FindFirstChild("Humanoid"):ChangeState(11)
        if extra then
            Creator.Character.HumanoidRootPart.CFrame = dist * extra
        else
            Creator.Character.HumanoidRootPart.CFrame = dist

        end
    end
end

function notify(Text, Time)
    game.StarterGui:SetCore("SendNotification", {
        Title = "Luna Client";
        Text = Text;
        Icon = "http://www.roblox.com/asset/?id=10502664319";
        Duration = Time
    })
end

function useSkills(enemy)
    local Numbers = {
        ["1"] = 0x31,
        ["2"] = 0x32,
        ["3"] = 0x33,
        ["4"] = 0x34,
    }
    local skills = {}

    for i,v in pairs() do
        if Info.Skills[i] then
            print(v)
            keypress(v)
            task.wait(1)
            keyrelease(v)
        end
        task.wait()
    end
end

if game.Players.LocalPlayer.Name ~= "Morissette3505" then
    if game.PlaceId == 7177496972 then
        notify("User must be in a dungeon to run this script", 5)
        return
    end
end

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

local Farm = Create.New({
    Title = "Farming"
})

Farm.Toggle({
    Text = "Initiate Farm",
    Callback = function(v)
        Info.AutoFarm = v
    end
})

Farm.Label({
    Text = "Farm Settings"
})

Farm.Toggle({
    Text = "Use M1",
    Callback = function(v)
        Info.M1 = v
    end
})

Farm.Toggle({
    Text = "Use Skills",
    Callback = function(v)
        Info.USkill = v
    end
})

Farm.Toggle({
    Text = "Use Both",
    Callback = function(v)
        Info.Both = v
    end
})

Farm.Label({
    Text = "Skills"
})

Farm.ChipSet({
    Text = "Skills",
    Callback = function(v)
        for t,y in pairs(v) do
            local formula = t:split(" ")
            Info.Skills[formula[3]] = y
        end
    end,
    Options = {["Use Skill 1"] = false, ["Use Skill 2"] = false, ["Use Skill 3"] = false, ["Use Skill 4"] = false}
})

local Main = function()
    pcall(function()
        task.spawn(function()
            while task.wait() do
                if Info.AutoFarm then
                    for i,v in pairs(workspace.Live["NPCs"]:GetChildren()) do
                        for _,y in pairs(v:GetDescendants()) do if y.Name == "Meshes/marrine hat _Cube.004 (2)" then
                                v:Destroy()
                                return
                            end
                        end
                        if v:FindFirstChild("HumanoidRootPart") and Info.AutoFarm then

                            task.spawn(function()
                                if Creator.Character:FindFirstChild("Humanoid") then
                                    Creator.Character:FindFirstChild("Humanoid"):ChangeState(11)
                                end


                                function ATP()
                                    if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") then
                                        tp(v.HumanoidRootPart.CFrame, CFrame.new(0, -6, 0) * CFrame.Angles(math.rad(90), 0, 0))
                                        setfflag("HumanoidParallelRemoveNoPhysics", "False")
                                        setfflag("HumanoidParallelRemoveNoPhysicsNoSimulate2", "False")
                                    end
                                end
                                
                                repeat ATP()
                                    task.wait()
                                until v.Humanoid.Health == 0 or not Info.AutoFarm
                            end)


                            function combat()
                                if Info.M1 then
                                    game:GetService("Players").LocalPlayer.ClientInputEvents.M1:Fire()
                                end

                                if Info.USkill then
                                    useSkills(v.HumanoidRootPart.CFrame)
                                end

                                if Info.Both then
                                    game:GetService("Players").LocalPlayer.ClientInputEvents.M1:Fire()
                                    game:GetService("Players").LocalPlayer.ClientInputEvents.M1:Fire()
                                    game:GetService("Players").LocalPlayer.ClientInputEvents.M1:Fire()
                                    game:GetService("Players").LocalPlayer.ClientInputEvents.M1:Fire()
                                    game:GetService("Players").LocalPlayer.ClientInputEvents.M1:Fire()
                                    task.wait(1)
                                    useSkills()
                                end
                            end

                            local succ, err = pcall(function()
                                repeat combat()
                                    task.wait()
                                until v.Humanoid.Health == 0 or not Info.AutoFarm
                            end)

                            if succ or err then
                                if Info.AutoFarm then
                                    if not workspace.Live["NPCs"]:GetChildren()[1] then
                                        repeat task.wait() until workspace.Live["NPCs"]:GetChildren()[1]
                                    end

                                    Info.AutoFarm = false
                                    task.wait(0.5)
                                    Info.AutoFarm = true
                                end
                            end
                        end
                    end
                end
            end
        end)
    end)
end

Main()