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

local Info = {
    autoKill = false,
    Aimbot = false,
    AimPart = "",
    Spread = 0,
    WC = false,
    A1 = false,
    FOV = 50,
    FOVT = false,
    FOVC = Color3.fromRGB(255,255,255),
    FOVTH = 1,
    FOVF = false
}

local camera = workspace.CurrentCamera
local VU = game:GetService("VirtualUser")
math.randomseed(os.time())
local Creator = game.Players.LocalPlayer
local cEvents = {"MouseButton1Down", "MouseButton1Click", "MouseButton1Up", "Activated"}

local circle = Drawing.new("Circle")
circle.Transparency = 1
circle.Position = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)

task.spawn(function()
	getgenv().rejoin = game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(child)
		if child.Name == 'ErrorPrompt' and child:FindFirstChild('MessageArea') and child.MessageArea:FindFirstChild("ErrorFrame") then
			game:GetService("TeleportService"):Teleport(game.PlaceId)
			if syn and syn.queue_on_teleport then
                syn.queue_on_teleport([[
                    task.spawn(function()
                        getgenv().rejoin = game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(child)
                            if child.Name == 'ErrorPrompt' and child:FindFirstChild('MessageArea') and child.MessageArea:FindFirstChild("ErrorFrame") then
                                game:GetService("TeleportService"):Teleport(game.PlaceId)
                                repeat task.wait() until game:IsLoaded()
                            end
                        end)
                    end)
                ]])
            end
		end
	end)
end)

function notify(Text, Time)
    game.StarterGui:SetCore("SendNotification", {
        Title = "Luna Client";
        Text = Text;
        Icon = "http://www.roblox.com/asset/?id=10502664319";
        Duration = Time
    })
end

function autoPlay()
    local p = Creator.PlayerGui.MainUI.MainMenu.Main.Ranked

    for i,v in pairs(cEvents) do
        if game:GetService("Players").Mystiilol.PlayerGui.MainUI.MainMenu.Visible then
            for _,con in pairs(getconnections(p[v])) do
                if p.Text ~= "WAITING FOR VALID MATCH" then
                    con.Fire()
                end
            end
        end
    end
end


function IsPlayerVisible(Player)
    local enemyChar = Player.Character
    local GetPartsObscuringTarget = camera.GetPartsObscuringTarget

 
    if not (enemyChar or Creator.Character) then return end
 
    local root = game.FindFirstChild(enemyChar, Info.AimPart) or game.FindFirstChild(enemyChar, "HumanoidRootPart")
 
    if not root then return end
 
    local CastPoints, IgnoreList = {root.Position, Creator.Character, enemyChar}, {Creator.Character, enemyChar}
    local ObscuringObjects = #GetPartsObscuringTarget(camera, CastPoints, IgnoreList)
 
    return ((ObscuringObjects == 0 and true) or (ObscuringObjects > 0 and false))
end

function PlayerOnFOV(plr)
    local charPos, onScreen = camera:WorldToViewportPoint(plr.Character.HumanoidRootPart.Position)
    local newMag = (Vector2.new(Creator:GetMouse().X, Creator:GetMouse().Y) - Vector2.new(charPos.X, charPos.Y)).Magnitude

    if onScreen and newMag < Info.FOV then
        return true
    end
end

function getClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = math.huge
    for i, v in pairs(game.Players:GetPlayers()) do
        if v ~= Creator and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health ~= 0 and v.Character:FindFirstChild("HumanoidRootPart") then
            local magnitude = (v.Character.HumanoidRootPart.Position - Creator.Character.HumanoidRootPart.Position).Magnitude

            if magnitude < shortestDistance then
                closestPlayer = v
                shortestDistance = magnitude
            end
        end
    end

    return closestPlayer
end

function getParts()
    local tbl = {}
    for _,parts in pairs(Creator.Character:GetChildren()) do
        if parts.Name == "Head" or parts.Name == "HumanoidRootPart" then
            table.insert(tbl, parts.Name)
        end
    end
    return tbl
end

local Main = Create.New({Title = "Main"})
Main.Label({Text = "Main"})
Main.Toggle({Text = "Auto Kill", Callback = function(v) Info.autoKill = v end})
Main.Toggle({Text = "Aimbot", Callback = function(v) Info.Aimbot = v end})
Main.Label({Text = "Settings"})
Main.Toggle({Text = "Wall check", Callback = function(v) Info.WC = v end})
local t = Main.Dropdown({Text = "Aim Part", Callback = function(v) Info.AimPart = v end, Options = getParts()})
Main.Label({Text = "FOV"})
Main.Toggle({Text = "FOV", Callback = function(v)
    Info.FOVT = v
end})
Main.ColorPicker({Text = "FOV Color", Default = Info.FOVC, Callback = function(v) Info.FOVC = v end})
Main.Slider({Text = "FOV Size", Callback = function(v) Info.FOV = v end, Min = 35, Max = 450, Def = 50})
Main.Slider({Text = "FOV Thickness", Callback = function(v) Info.FOVTH = v end, Min = 1, Max = 10, Def = 1})
Main.Toggle({Text = "Filled FOV", Callback = function(v) Info.FOVF = v end})

local src = function()
    while task.wait() do
        task.spawn(function()
            task.spawn(function()
                circle.Visible = Info.FOVT
                circle.Radius = Info.FOV
                circle.Color = Info.FOVC
                circle.Thickness = Info.FOVTH
                circle.Filled = Info.FOVF
            end)

            if Info.Aimbot then
                pcall(function()
                    repeat task.wait()
                    local v = getClosestPlayer()
                    if v ~= Creator and v.Character:FindFirstChild("HumanoidRootPart") then           
                        if Info.FOVT then
                            if Info.WC then
                                if IsPlayerVisible(v) and PlayerOnFOV(v) then
                                    camera.CFrame = CFrame.new(camera.CFrame.Position, v.Character[Info.AimPart].Position)
                                end
                            else
                                camera.CFrame = CFrame.new(camera.CFrame.Position, v.Character[Info.AimPart].Position)
                            end
                        else
                            if Info.WC then
                                if IsPlayerVisible(v) then
                                    camera.CFrame = CFrame.new(camera.CFrame.Position, v.Character[Info.AimPart].Position)
                                end
                            else
                                camera.CFrame = CFrame.new(camera.CFrame.Position, v.Character[Info.AimPart].Position)
                            end
                        end
                    end
                    until v.Humanoid.Health == 0 or not Info.Aimbot
                end)
            end

            if Info.A1 then
                autoPlay()
            end

            if Info.autoKill then
                local v = getClosestPlayer()
                local succ,err = pcall(function()
                    if Info.autoKill and v.Humanoid.Health > 0 then
                        if v.Character:FindFirstChildWhichIsA("Model") and Creator.Character then
                            camera.CFrame = CFrame.new(camera.CFrame.Position, v.Character.Head.Position)
                            Creator.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,5)
                            task.wait()
                            if not v.Character:FindFirstChild("ForceField") then
                                VU:ClickButton1(Vector2.new(Creator:GetMouse().X, Creator:GetMouse().Y), workspace.CurrentCamera.CFrame)
                            end
                            task.wait()
                        end
                    end
                end)
            end
        end)
    end
end

src()