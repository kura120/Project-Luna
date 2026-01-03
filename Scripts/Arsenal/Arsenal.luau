local Players = game:GetService("Players")
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

local Settings = {
    Aimbot = false,
    Teamcheck = false,
    Visiblecheck = false,
    aimtype = nil,
    aimpart = "Head",
    closestplr = nil,
    killAura = false,
    WallBang = false,
    FOV = 50,
    FOVT = false,
    FOVC = Color3.fromRGB(255,255,255),
    FOVTH = 1,
    FOVF = false,
    EL = false,
    TL = false,
    EB = false,
    TB = false,
}

local circle = Drawing.new("Circle")
circle.Transparency = 1
circle.Position = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y / 2)

local Credit = Create.New({
	Title = "Credits"
})

local Main = Create.New({
	Title = "Main"
})

Credit.Label({
    Text = "Thanks for choosing Luna Hub!", 
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
    Text = "Made by Duxkyx#5079 and kura#6311",
    Callback = function()
        setclipboard("https://duxkyx.cf")
    end
})

-- Main

Main.Toggle({
    Text = "Aimbot",
    Callback = function(v)
        Settings.Aimbot = v
    end
})

Main.Toggle({Text = "Kill Aura", Callback = function(v) Settings.killAura = v 
    if v then
        function SwitchToKnife()
            local N = game:GetService("VirtualInputManager")
            N:SendKeyEvent(true, 51, false, game)
            N:SendKeyEvent(false, 51, false, game)
        end

        game:GetService("ReplicatedStorage").wkspc.Status.RoundOver.Value = false
        local Farming = false
        local Hopped = false
        local TimeLeft = 30
        local TurnBack = 4
        local CheckTick = tick()
        local PlayerLocked
        local Back = true

        function DetectPlayer()
            local Blacklist = {
                workspace.CurrentCamera
            }
            if game:GetService("Players").LocalPlayer.Character then
                table.insert(Blacklist, game:GetService("Players").LocalPlayer.Character)
            end
            if workspace:FindFirstChild("Map") then
                table.insert(Blacklist, workspace.Map)
            end
            local RaycastParam = RaycastParams.new()
            RaycastParam.FilterType = Enum.RaycastFilterType.Blacklist
            RaycastParam.FilterDescendantsInstances = Blacklist
            local NewRay = Ray.new(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 1.5, 0), workspace.CurrentCamera.CFrame.LookVector * 50000, RaycastParam)
            local PlayerGot
            if NewRay.Instance then
                if NewRay.Instance:IsDescendantOf(workspace) then
                    if NewRay.Instance.Parent:IsA("Model") then
                        if game:GetService("Players"):GetPlayerFromCharacter(NewRay.Instance.Parent) then
                            PlayerGot = game:GetService("Players"):GetPlayerFromCharacter(NewRay.Instance.Parent)
                        end
                    elseif NewRay.Instance.Parent:IsA("Accessory") then
                        if game:GetService("Players"):GetPlayerFromCharacter(NewRay.Instance.Parent.Parent) then
                            PlayerGot = game:GetService("Players"):GetPlayerFromCharacter(NewRay.Instance.Parent.Parent)
                        end
                    end
                end
                if PlayerGot and PlayerGot.Status.Team.Value ~= game:GetService("Players").LocalPlayer.Status.Team.Value and PlayerGot.NRPBS.Health.Value > 0 then
                    return true
                end
            end
            return false
        end
        function StartAutofarm()
            repeat
                task.wait()
            until game:GetService("ReplicatedStorage").wkspc.Status.RoundOver.Value == false
            Farming = true
            task.spawn(function()
                repeat
                    if game:GetService("Players").LocalPlayer.Status.Team.Value ~= "Spectator" then
                        for i, v in pairs(game:GetService("Players"):GetPlayers()) do
                            if v ~= game:GetService("Players").LocalPlayer then
                                if v.Character then
                                    if v.NRPBS.Health.Value > 0 then
                                        if v.Status.Team.Value ~= "Spectator" then
                                            if v.Character:FindFirstChild("Spawned") and v.Status.Team.Value ~= game:GetService("Players").LocalPlayer.Status.Team.Value then
                                                TimeLeft = 25
                                                TurnBack = 4
                                                Back = true
                                                repeat
                                                    PlayerLocked = v
                                                    SwitchToKnife()
                                                    task.wait(.1)
                                                    TurnBack = TurnBack - 0.1
                                                    if TurnBack <= 0 then
                                                        Back = false
                                                    elseif TurnBack <= -4 then
                                                        break
                                                    end
                                                until game:GetService("ReplicatedStorage").wkspc.Status.RoundOver.Value or not v or not v.Character or not v.Character:FindFirstChild("Spawned") or v.NRPBS.Health.Value <= 0 or v.Status.Team.Value == "Spectator" or v.Status.Alive.Value == false or game:GetService("Players").LocalPlayer.Status.Team.Value == v.Status.Team.Value
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                    task.wait(0.1)
                until game:GetService("ReplicatedStorage").wkspc.Status.RoundOver.Value == true
                task.wait(1)
            end)
        end
        task.spawn(function()
            while task.wait(0.1) do
                if game:GetService("Players").LocalPlayer.NRPBS.Health.Value <= 0 and game:GetService("Players").LocalPlayer.Status.Team.Value ~= "Spectator" then
                    game:GetService("ReplicatedStorage").Events.LoadCharacter:FireServer()
                end
            end
        end)
        local num = 6
        local up = 0
        game:GetService("RunService").RenderStepped:Connect(function()
            if Farming then
                if workspace:FindFirstChild("Map") and PlayerLocked and PlayerLocked.Character and PlayerLocked.NRPBS.Health.Value > 0 and PlayerLocked.Character:FindFirstChild("HeadHB") then
                    workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, PlayerLocked.Character.HeadHB.Position)
                    if Back then
                        num = 2
                        up = 0
                    else
                        num = -2
                        up = 2
                    end
                    
                    game:GetService("Players").LocalPlayer.Character:SetPrimaryPartCFrame(
        PlayerLocked.Character.HumanoidRootPart.CFrame * CFrame.new(-1.0, up, num)
    )
                    local RayParams = RaycastParams.new()
                    RayParams.FilterType = Enum.RaycastFilterType.Blacklist
                    RayParams.FilterDescendantsInstances = {
                        workspace.CurrentCamera,
                        game:GetService("Players").LocalPlayer.Character,
                        workspace.Map.Ignore,
                        workspace.Map.Clips
                    }
                    local Result = workspace:Raycast(workspace.CurrentCamera.CFrame.Position, workspace.CurrentCamera.CFrame.LookVector * 10000, RayParams)
                    local Player
                    if Result and Result.Instance then
                        if Result.Instance:IsDescendantOf(PlayerLocked.Character) then
                            game:GetService("VirtualUser"):Button1Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
                        end
                    end
                end
            end
            if game:GetService("ReplicatedStorage").wkspc.Status.RoundOver.Value == true then
                PlayerLocked = nil
            end
            if not game:GetService("Players").LocalPlayer.Character then
                PlayerLocked = nil
            end
            if game:GetService("Players").LocalPlayer.NRPBS.Health.Value <= 0 then
                PlayerLocked = nil
            end
        end)
        StartAutofarm()
        for i, v in pairs(game.ReplicatedStorage.Weapons:GetChildren()) do
            for i, c in next, v:GetChildren() do
                for i, x in next, getconnections(c.Changed) do
                    x:Disable() -- probably not needed
                end
                if c.Name == "Ammo" or c.Name == "StoredAmmo" then
                    c.Value = 300 -- don't set this above 300 or else your guns wont work
                elseif c.Name == "AReload" or c.Name == "RecoilControl" or c.Name == "EReload" or c.Name == "SReload" or c.Name == "ReloadTime" or c.Name == "EquipTime" or c.Name == "Spread" or c.Name == "MaxSpread" then
                    c.Value = 0
                elseif c.Name == "Range" then
                    c.Value = 9e9
                elseif c.Name == "Auto" then
                    c.Value = true
                elseif c.Name == "FireRate" or c.Name == "BFireRate" then
                    c.Value = 0.02 -- don't set this lower than 0.02 or else your game will crash
                end
            end
        end
        game:GetService('RunService').Stepped:Connect(function() -- Infinite Ammo by Frontman#9917
            game:GetService("Players").LocalPlayer.PlayerGui.GUI.Client.Variables.ammocount.Value = 999 -- dont do it higher then 999
            game:GetService("Players").LocalPlayer.PlayerGui.GUI.Client.Variables.ammocount2.Value = 999
        end)
    else
        game:GetService("ReplicatedStorage").wkspc.Status.RoundOver.Value = true
    end
end})

Main.Toggle({
    Text = "Team Check",
    Callback = function(v)
        Settings.Teamcheck = v
    end
})

Main.Toggle({
    Text = "Visible Check",
    Callback = function(v)
        Settings.Visiblecheck = v
    end
})

Main.Dropdown({
    Text = "Aim Part",
    Callback = function(Value)
        Settings.aimpart = Value
    end,
    Options = {
        "Head", "LowerTorso"
    },
})

Main.Dropdown({
    Text = "Aimbot Style",
    Callback = function(Value)
        _G.aimtype = Value
    end,
    Options = {
        "Smooth", "Snappy"
    },
})


Main.Label({
    Text = 'User'
})

Main.Toggle({Text = "FOV", Callback = function(v)
    Settings.FOVT = v
end})
Main.ColorPicker({Text = "FOV Color", Default = Settings.FOVC, Callback = function(v) Settings.FOVC = v end})
Main.Slider({Text = "FOV Size", Callback = function(v) Settings.FOV = v end, Min = 35, Max = 450, Def = 50})
Main.Slider({Text = "FOV Thickness", Callback = function(v) Settings.FOVTH = v end, Min = 1, Max = 10, Def = 1})
Main.Toggle({Text = "Filled FOV", Callback = function(v) Settings.FOVF = v end})

local GM = Create.New({
    Title = "Gun Mods"
})

GM.Button({
    Text = "Inf Ammo",
    Callback = function()
        for _, v in pairs(game.ReplicatedStorage.Weapons:GetChildren()) do
            for _, c in pairs(v:GetChildren()) do
                if c.Name == 'Ammo' or c.Name == 'StoredAmmo' then
                    c.Value = 300
                end
            end
        end
    end
})

GM.Button({
    Text = "No Recoil",
    Callback = function()
        for _, v in pairs(game.ReplicatedStorage.Weapons:GetChildren()) do
            for _, c in pairs(v:GetChildren()) do
                if c.Name == 'RecoilControl' then
                    c.Value = 0
                end
            end
        end
    end
})

GM.Button({
    Text = "Inf Gun Range",
    Callback = function()
        for _, v in pairs(game.ReplicatedStorage.Weapons:GetChildren()) do
            for _, c in pairs(v:GetChildren()) do
                if c.Name == "Range" then
                    c.Value = 9e9
                end
            end
        end
    end
})

GM.Button({
    Text = "Fast Reload",
    Callback = function()
        for _, v in pairs(game.ReplicatedStorage.Weapons:GetChildren()) do
            for _, c in pairs(v:GetChildren()) do
                if c.Name == "AReload" or c.Name == 'EReload' or c.Name == 'SReload' or c.Name == 'ReloadTime' then
                    c.Value = 0
                end
            end
        end
    end
})

GM.Button({
    Text = "Instant Fire Rate",
    Callback = function()
        for _, v in pairs(game.ReplicatedStorage.Weapons:GetChildren()) do
            for _, c in pairs(v:GetChildren()) do
                if c.Name == "FireRate" or c.Name == "BFireRate" then
                    c.Value = 0.02
                end
            end
        end
    end
})

local ESP = Create.New({Title = "ESP"})
ESP.Toggle({
    Text = "Enemy Box",
    Callback = function(v)
        Settings.EB = v
    end
})

ESP.Toggle({
    Text = "Team Box",
    Callback = function(v)
        Settings.TB = v
    end
})

ESP.Toggle({
    Text = "Enemy Tracers",
    Callback = function(v)
        Settings.EL = v
    end
})

ESP.Toggle({
    Text = "Team Tracers",
    Callback = function(v)
        Settings.TL = v
    end
})

function notify(Text, Time)
    game.StarterGui:SetCore("SendNotification", {
        Title = 'Luna Client';
        Text = Text;
        Duration = Time
    })
end

--Starting ESP
local camera = workspace.CurrentCamera
for i,v in pairs(game.Players:GetPlayers()) do
    local LP = game.Players.LocalPlayer

    local LineOut = Drawing.new('Line')
    LineOut.Visible = false
    LineOut.Color = Color3.fromRGB(0,0,0)
    LineOut.Thickness = 4
    LineOut.Transparency = 1

    local Line = Drawing.new('Line')
    Line.Visible = false
    Line.Color = Color3.fromRGB(255,0,0)
    Line.Thickness = 1
    Line.Transparency = 1

    local BoxOut = Drawing.new("Square")
    BoxOut.Visible = false
    BoxOut.Color = Color3.fromRGB(0,0,0)
    BoxOut.Thickness = 4
    BoxOut.Transparency = 1
    BoxOut.Filled = false

    local Box = Drawing.new("Square")
    Box.Visible = false
    Box.Color = Color3.fromRGB(255,0,0)
    Box.Thickness = 1
    Box.Transparency = 1
    Box.Filled = false
  
    function esp()
        game:GetService("RunService").RenderStepped:Connect(function()
            if v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
                local vector, onScreen = camera:WorldToScreenPoint(v.Character:FindFirstChild("Hitbox").Position)

                local root = v.Character.HumanoidRootPart
                local head = v.Character.Head
                local humPos = camera:WorldToViewportPoint(root.Position)
                local headPosition = camera:WorldToViewportPoint(head.Position + Vector3.new(0, .5, 0))
                local legPos = camera:WorldToViewportPoint(root.Position - Vector3.new(0, 3, 0))

                if onScreen then
                    Line.From = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y)
                    Line.To = Vector2.new(vector.X, vector.Y)

                    LineOut.From = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y)
                    LineOut.To = Vector2.new(vector.X, vector.Y)

                    if v.TeamColor ~= LP.TeamColor and Settings.EB then
                        BoxOut.Size = Vector2.new(4000 / humPos.Z, headPosition.Y - legPos.Y)
                        BoxOut.Position = Vector2.new(humPos.X - BoxOut.Size.X / 2, humPos.Y - BoxOut.Size.Y / 2)
                        BoxOut.Visible = true

                        Box.Size = Vector2.new(4000 / humPos.Z, headPosition.Y - legPos.Y)
                        Box.Position = Vector2.new(humPos.X - Box.Size.X / 2, humPos.Y - Box.Size.Y / 2)
                        Box.Visible = true
                        Box.Color = Color3.fromRGB(255, 0, 0)
                    elseif v.TeamColor == LP.TeamColor and Settings.TB then
                        BoxOut.Size = Vector2.new(4000 / humPos.Z, headPosition.Y - legPos.Y)
                        BoxOut.Position = Vector2.new(humPos.X - BoxOut.Size.X / 2, humPos.Y - BoxOut.Size.Y / 2)
                        BoxOut.Visible = true

                        Box.Size = Vector2.new(4000 / humPos.Z, headPosition.Y - legPos.Y)
                        Box.Position = Vector2.new(humPos.X - Box.Size.X / 2, humPos.Y - Box.Size.Y / 2)
                        Box.Visible = true
                        Box.Color = Color3.fromRGB(0,0,255)
                    else
                        BoxOut.Visible = false
                        Box.Visible = false
                    end


                    if v.TeamColor == LP.TeamColor and Settings.TL then
                        Line.Visible = true
                        Line.Color = Color3.fromRGB(0,0,255)
                        LineOut.Visible = true
                    elseif v.TeamColor ~= LP.TeamColor and Settings.EL then
                        Line.Visible = true
                        Line.Color = Color3.fromRGB(255,0,0)
                        LineOut.Visible = true
                    else
                        Line.Visible = false
                        LineOut.Visible = false
                    end
                else
                    BoxOut.Visible = false
                    Box.Visible = false
                    Line.Visible = false
                    LineOut.Visible = false
                end
            else
                BoxOut.Visible = false
                Box.Visible = false
                Line.Visible = false
                LineOut.Visible = false
            end
        end)
    end
    coroutine.wrap(esp)()
end


game.Players.PlayerAdded:Connect(function(v)
    local LP = game.Players.LocalPlayer

    local LineOut = Drawing.new('Line')
    LineOut.Visible = false
    LineOut.Color = Color3.fromRGB(0,0,0)
    LineOut.Thickness = 4
    LineOut.Transparency = 1

    local Line = Drawing.new('Line')
    Line.Visible = false
    Line.Color = Color3.fromRGB(255,0,0)
    Line.Thickness = 1
    Line.Transparency = 1

    local BoxOut = Drawing.new("Square")
    BoxOut.Visible = false
    BoxOut.Color = Color3.fromRGB(0,0,0)
    BoxOut.Thickness = 4
    BoxOut.Transparency = 1
    BoxOut.Filled = false

    local Box = Drawing.new("Square")
    Box.Visible = false
    Box.Color = Color3.fromRGB(255,0,0)
    Box.Thickness = 1
    Box.Transparency = 1
    Box.Filled = false
  
    function esp()
        game:GetService("RunService").RenderStepped:Connect(function()
            if v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
                local vector, onScreen = camera:WorldToScreenPoint(v.Character:FindFirstChild("Hitbox").Position)

                local root = v.Character.HumanoidRootPart
                local head = v.Character.Head
                local humPos = camera:WorldToViewportPoint(root.Position)
                local headPosition = camera:WorldToViewportPoint(head.Position + Vector3.new(0, .5, 0))
                local legPos = camera:WorldToViewportPoint(root.Position - Vector3.new(0, 3, 0))

                if onScreen then
                    Line.From = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y)
                    Line.To = Vector2.new(vector.X, vector.Y)

                    LineOut.From = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y)
                    LineOut.To = Vector2.new(vector.X, vector.Y)

                    if v.TeamColor ~= LP.TeamColor and Settings.EB then
                        BoxOut.Size = Vector2.new(4000 / humPos.Z, headPosition.Y - legPos.Y)
                        BoxOut.Position = Vector2.new(humPos.X - BoxOut.Size.X / 2, humPos.Y - BoxOut.Size.Y / 2)
                        BoxOut.Visible = true

                        Box.Size = Vector2.new(4000 / humPos.Z, headPosition.Y - legPos.Y)
                        Box.Position = Vector2.new(humPos.X - Box.Size.X / 2, humPos.Y - Box.Size.Y / 2)
                        Box.Visible = true
                        Box.Color = Color3.fromRGB(255, 0, 0)
                    elseif v.TeamColor == LP.TeamColor and Settings.TB then
                        BoxOut.Size = Vector2.new(4000 / humPos.Z, headPosition.Y - legPos.Y)
                        BoxOut.Position = Vector2.new(humPos.X - BoxOut.Size.X / 2, humPos.Y - BoxOut.Size.Y / 2)
                        BoxOut.Visible = true

                        Box.Size = Vector2.new(4000 / humPos.Z, headPosition.Y - legPos.Y)
                        Box.Position = Vector2.new(humPos.X - Box.Size.X / 2, humPos.Y - Box.Size.Y / 2)
                        Box.Visible = true
                        Box.Color = Color3.fromRGB(0,0,255)
                    else
                        BoxOut.Visible = false
                        Box.Visible = false
                    end


                    if v.TeamColor == LP.TeamColor and Settings.TL then
                        Line.Visible = true
                        Line.Color = Color3.fromRGB(0,0,255)
                        LineOut.Visible = true
                    elseif v.TeamColor ~= LP.TeamColor and Settings.EL then
                        Line.Visible = true
                        Line.Color = Color3.fromRGB(255,0,0)
                        LineOut.Visible = true
                    else
                        Line.Visible = false
                        LineOut.Visible = false
                    end
                else
                    BoxOut.Visible = false
                    Box.Visible = false
                    Line.Visible = false
                    LineOut.Visible = false
                end
            else
                BoxOut.Visible = false
                Box.Visible = false
                Line.Visible = false
                LineOut.Visible = false
            end
        end)
    end
    coroutine.wrap(esp)()
end)



function autoFire()
    local plr = getClosestPlayer()

    if workspace.CurrentCamera.CFrame == CFrame.new(workspace.CurrentCamera.CFrame.Position, workspace[plr.Name][tostring(Settings.aimpart)].Position) then
        game:GetService("VirtualInputManager"):SendMouseButtonEvent(500, 500, 0, true, game, 1)
    end
end

function IsPlayerVisible(Player: Player)
    local LP = game.Players.LocalPlayer
    local camera = workspace.Camera

    local GetPartsObscuringTarget = camera.GetPartsObscuringTarget
    pcall(function() if not (workspace[Player.Name] or workspace[LP.Name]) then return end end)

    local enemyChar = workspace[Player.Name]
    
    local root = game.FindFirstChild(enemyChar, Settings.aimpart) or game.FindFirstChild(enemyChar, "HumanoidRootPart")
    
    if not root then return end
    
    local CastPoints, IgnoreList = {root.Position,  workspace[LP.Name], enemyChar}, {workspace[LP.Name], enemyChar}
    local ObscuringObjects = #GetPartsObscuringTarget(camera, CastPoints, IgnoreList)
    
    return ((ObscuringObjects == 0 and true) or (ObscuringObjects > 0 and false))
end

function getClosestPlayer()
    local MaxDist, Closest = math.huge
    local Players = game.Players
    local LocalPlayer = Players.LocalPlayer
    local CurrentCamera = workspace.CurrentCamera
    local Mouse = LocalPlayer:GetMouse()
    
    for i,v in pairs(Players:GetPlayers()) do
        if v == LocalPlayer then continue end
        if not v.Team == LocalPlayer and not Settings.TeamCheck then continue end
        if not v.Character then continue end

        local Head = v.Character.FindFirstChild(v.Character, Settings.aimpart)
        if not Head then continue end

        local Pos, Vis = CurrentCamera.WorldToScreenPoint(CurrentCamera, Head.Position)
        if not Vis and not Settings.Visiblecheck then continue end

        
        local MousePos, TheirPos = Vector2.new(Mouse.X, Mouse.Y), Vector2.new(Pos.X, Pos.Y)
        local Dist = (TheirPos - MousePos).Magnitude
        if Dist < MaxDist then
            MaxDist = Dist
            Closest = v
        end
    end
    return Closest
end

function getPlr()
    local LP = game.Players.LocalPlayer
    local closestPlayer = nil
    local shortestDistance = math.huge
    for i, v in pairs(game.Players:GetPlayers()) do
        if v ~= LP and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health ~= 0 and v.Character:FindFirstChild("HumanoidRootPart") then
            local magnitude = (v.Character.HumanoidRootPart.Position - LP.Character.HumanoidRootPart.Position).Magnitude

            if magnitude < shortestDistance then
                if Settings.Teamcheck then
                    if v.TeamColor ~= LP.TeamColor then
                        closestPlayer = v
                        shortestDistance = magnitude
                    end
                else
                    closestPlayer = v
                    shortestDistance = magnitude
                end
            end
        end
    end

    return closestPlayer
end

function PlayerOnFOV(plr: Player)
    local Creator = game.Players.LocalPlayer
    local charPos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(plr.Character.HumanoidRootPart.Position)
    local newMag = (Vector2.new(Creator:GetMouse().X, Creator:GetMouse().Y) - Vector2.new(charPos.X, charPos.Y)).Magnitude

    if onScreen and newMag < Settings.FOV then
        return true
    end
end

function main()
    task.spawn(function()
        while task.wait() do
            task.spawn(function()
            
            end)

            task.spawn(function()
                circle.Visible = Settings.FOVT
                circle.Radius = Settings.FOV
                circle.Color = Settings.FOVC
                circle.Thickness = Settings.FOVTH
                circle.Filled = Settings.FOVF
            end)

            if Settings.Aimbot then
                pcall(function()
                    local plr = getClosestPlayer()
                    if Settings.Teamcheck then
                        if plr.TeamColor ~= game.Players.LocalPlayer.TeamColor then
                            if Settings.Visiblecheck then
                                if _G.aimtype == "Snappy" then
                                    camera.CFrame = CFrame.new(camera.CFrame.Position, workspace[plr.Name][tostring(Settings.aimpart)].Position)
                                end
                                if _G.aimtype == "Smooth" then
                                    local TS = game.TweenService
                                    local TweenInfo = TweenInfo.new(0.03)
                                    local tween = TS:Create(camera, TweenInfo, {CFrame = CFrame.new(camera.CFrame.Position, workspace[plr.Name][tostring(Settings.aimpart)].Position)})
                                    tween:Play()
                                end
                            elseif not Settings.Visiblecheck then
                                if _G.aimtype == "Snappy" then
                                    camera.CFrame = CFrame.new(camera.CFrame.Position, workspace[plr.Name][tostring(Settings.aimpart)].Position)
                                end
                                if _G.aimtype == "Smooth" then
                                    local TS = game.TweenService
                                    local TweenInfo = TweenInfo.new(0.03)
                                    local tween = TS:Create(camera, TweenInfo, {CFrame = CFrame.new(camera.CFrame.Position, workspace[plr.Name][tostring(Settings.aimpart)].Position)})
                                    tween:Play()
                                end
                            end
                        end
                    else
                        if Settings.Visiblecheck then
                            if _G.aimtype == "Snappy" then
                                camera.CFrame = CFrame.new(camera.CFrame.Position, workspace[plr.Name][tostring(Settings.aimpart)].Position)
                            end
                            if _G.aimtype == "Smooth" then
                                local TS = game.TweenService
                                local TweenInfo = TweenInfo.new(0.03)
                                local tween = TS:Create(camera, TweenInfo, {CFrame = CFrame.new(camera.CFrame.Position, workspace[plr.Name][tostring(Settings.aimpart)].Position)})
                                tween:Play()
                            end
                        elseif not Settings.Visiblecheck then
                            if _G.aimtype == "Snappy" then
                                camera.CFrame = CFrame.new(camera.CFrame.Position, workspace[plr.Name][tostring(Settings.aimpart)].Position)
                            end
                            if _G.aimtype == "Smooth" then
                                local TS = game.TweenService
                                local TweenInfo = TweenInfo.new(0.03)
                                local tween = TS:Create(camera, TweenInfo, {CFrame = CFrame.new(camera.CFrame.Position, workspace[plr.Name][tostring(Settings.aimpart)].Position)})
                                tween:Play()
                            end
                        end
                    end
                end)
            end

        end
    end)
end

main()