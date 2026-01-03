--BC_WATERMARK("\n\nProject Luna\n\n")

local UI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/MaterialLua/master/Module.lua"))()
local Create = UI.Load({
	Title = "Project Luna",
	Style = 1,
	SizeX = 500,
	SizeY = 550,
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
    aimtype = "Snappy",
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
    SilentAim = false,
    DSilentAim = false,

    TeamColour = Color3.fromRGB(0,0,255),
    TeamOutlineColour = Color3.fromRGB(255,255,255),
    TeamOpacity = 0.5,

    EnemyColour = Color3.fromRGB(255,0,0),
    EnemyOutlineColour = Color3.fromRGB(255,255,255),
    EnemyOpacity = 0.5,

    VisibleColour = Color3.fromRGB(101, 139, 101),

    AutoBuyCrate = false,
    SelectedCase = nil,
    AutoFireWait = 0.25,
    AutoFire = false,
    KillAll = false,
    FakeRacFeed = false,
    SkyID = nil,

    KAW = nil,

    EC = nil,
    TC = nil,
}

function notify(Text, Time)
    game.StarterGui:SetCore("SendNotification", {
        Title = 'Project Luna';
        Text = Text;
        Icon = "rbxassetid://10770668804";
        Duration = Time;
    })
end

notify('Made by kura#6311', 10)

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
    Text = "Made by kura#6311",
    Callback = function()
        setclipboard("https://duxkyx.cf")
    end
})

-- Main
Main.Label({
    Text = "Aimbot", 
})


Main.Toggle({
    Text = "Aimbot",
    Callback = function(v)
        Settings.Aimbot = v
    end
})

Main.Toggle({
    Text = "Auto Fire (0.5s wait)",
    Callback = function(v)
        Settings.AutoFire = v
    end
})

Main.Label({
    Text = "Silent Aim"
})

Main.Toggle({
    Text = "Init Silent Aim",
    Callback = function(v)
        Settings.SilentAim = v
    end
})

Main.Toggle({
    Text = "Init Dynamic Silent Aim",
    Callback = function(v)
        Settings.DSilentAim = v
    end
})

Main.Label({
    Text = "Settings"
})

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
    Text = "Aimbot Style",
    Callback = function(Value)
        _G.aimtype = Value
    end,
    Options = {
        "Smooth", "Snappy"
    },
})

Main.Dropdown({
    Text = "Aim Part",
    Callback = function(Value)
        Settings.aimpart = Value
    end,
    Options = {
        "Head", "HumanoidRootPart",
    },
})

Main.Label({
    Text = "Auto Farm (Turn off Auto Fire)", 
})

Main.Toggle({
    Text = "Loop Kill All",
    Callback = function(v)
        Settings.KillAll = v
    end
})

Main.Dropdown({
    Text = "Kill All Weapon",
    Callback = function(Value)
        Settings.KAW = Value
    end,
    Options = {
        "Primary", "Secondary", "Knife"
    },
})



local ESP = Create.New({Title = "ESP"})

ESP.Label({
    Text = "Enemy", 
})

ESP.ColorPicker({
    Text = "Enemy Colour", 
    Default = Settings.EnemyColour, 
    Callback = function(v) 
        Settings.EnemyColour = Color3.new(v.R * 255, v.G * 255, v.B * 255)
    end
})

ESP.ColorPicker({
    Text = "Chams Outline Colour", 
    Default = Settings.EnemyOutlineColour, 
    Callback = function(v) 
        Settings.EnemyOutlineColour = Color3.new(v.R * 255, v.G * 255, v.B * 255)
    end
})

ESP.ColorPicker({
    Text = "Visible Colour", 
    Default = Settings.VisibleColour, 
    Callback = function(v) 
        Settings.VisibleColour = Color3.new(v.R * 255, v.G * 255, v.B * 255)
    end
})

ESP.Toggle({
    Text = "Enemy Chams",
    Callback = function(v)
        Settings.EC = v
    end
})

ESP.Slider({
    Text = "Chams Opacity", 
    Callback = function(v) 
        Settings.EnemyOpacity = v
    end, 
    Min = 0, 
    Max = 1, 
    Def = 0.5
})

ESP.Toggle({
    Text = "Enemy Box",
    Callback = function(v)
        Settings.EB = v
    end
})

ESP.Toggle({
    Text = "Enemy Tracers",
    Callback = function(v)
        Settings.EL = v
    end
})

ESP.Label({
    Text = "Team", 
})

ESP.ColorPicker({
    Text = "Team Colour", 
    Default = Settings.TeamColour, 
    Callback = function(v) 
        Settings.TeamColour = Color3.new(v.R * 255, v.G * 255, v.B * 255)
    end
})

ESP.ColorPicker({
    Text = "Chams Outline Colour", 
    Default = Settings.TeamOutlineColour, 
    Callback = function(v) 
        Settings.TeamOutlineColour = Color3.new(v.R * 255, v.G * 255, v.B * 255)
    end
})

ESP.Toggle({
    Text = "Team Chams",
    Callback = function(v)
        Settings.TC = v
    end
})

ESP.Slider({
    Text = "Chams Opacity", 
    Callback = function(v) 
        Settings.TeamOpacity = v
    end, 
    Min = 0, 
    Max = 1, 
    Def = 0.5
})

ESP.Toggle({
    Text = "Team Box",
    Callback = function(v)
        Settings.TB = v
    end
})


ESP.Toggle({
    Text = "Team Tracers",
    Callback = function(v)
        Settings.TL = v
    end
})

local User = Create.New({
	Title = "User"
})

User.Label({
    Text = "View", 
})

User.ColorPicker({
    Text = "Hud Colour", 
    Default = Color3.new(255,255,255), 
    Callback = function(v) 
        local r,g,b = math.floor((v.R * 255) + 0.5), math.floor((v.G * 255) + 0.5), math.floor((v.B * 255) + .5)
        game.Players.LocalPlayer.HudColor.Color.Value = Color3.fromRGB(r,g,b)
    end
})

User.Slider({
    Text = "Time Of Day", 
    Callback = function(v) 
        game.Lighting.TimeOfDay = v .. ':00:00'
    end, 
    Min = 0, 
    Max = 24, 
    Def = 3
})

User.Slider({
    Text = "FOV", 
    Callback = function(v) 
        while v do
            task.wait()
            workspace.Camera.FieldOfView = v
        end
    end, 
    Min = 40, 
    Max = 120, 
    Def = 70
})

User.ColorPicker({
    Text = "Game Colour", 
    Default = Color3.new(255,255,255), 
    Callback = function(v) 
        local r,g,b = math.floor((v.R * 255) + 0.5), math.floor((v.G * 255) + 0.5), math.floor((v.B * 255) + .5)
        game.Lighting.ColorCorrection.TintColor = Color3.fromRGB(r,g,b)
    end
})

User.Label({
    Text = "Teams", 
})

User.Button({
    Text = 'Join CT',
    Callback = function()
        local args = {[1] = "CT"}
        game:GetService("ReplicatedStorage").Events.JoinTeam:FireServer(unpack(args))
    end
})

User.Button({
    Text = 'Join T',
    Callback = function()
        local args = {[1] = "T"}
        game:GetService("ReplicatedStorage").Events.JoinTeam:FireServer(unpack(args))
    end
})


local Other = Create.New({
	Title = "Other"
})

Other.Label({
    Text = "Other", 
})

Other.TextField({
	Text = "Input Fake Ban Name",
	Callback = function(Value)
		Settings.FakeRacFeed = Value
	end,
})

Other.Button({
    Text = 'Send Fake Ban Message',
    Callback = function()
        game.Workspace.RacBanFeed.Value = Settings.FakeRacFeed
    end
})

function delHighlight(v)
    for _,v in pairs(v.Character:GetChildren()) do
        if v:IsA('Highlight') then
            v:Remove()
        end
    end
end

function IsPlayerVisible(Player)
    local LP = game.Players.LocalPlayer
    if workspace[LP.Name] then
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
end

--Starting ESP
local camera = workspace.CurrentCamera
for i,v in pairs(game.Players:GetPlayers()) do
    local LP = game.Players.LocalPlayer

    local LineOut = Drawing.new('Line')
    LineOut.Visible = false
    LineOut.Color = Settings.TeamColour
    LineOut.Thickness = 4
    LineOut.Transparency = 1

    local Line = Drawing.new('Line')
    Line.Visible = false
    Line.Color = Settings.EnemyColour
    Line.Thickness = 1
    Line.Transparency = 1

    local BoxOut = Drawing.new("Square")
    BoxOut.Visible = false
    BoxOut.Color = Settings.TeamColour
    BoxOut.Thickness = 4
    BoxOut.Transparency = 1
    BoxOut.Filled = false

    local Box = Drawing.new("Square")
    Box.Visible = false
    Box.Color = Settings.EnemyColour
    Box.Thickness = 1
    Box.Transparency = 1
    Box.Filled = false

    local EnemyChams = Instance.new('Highlight')
    EnemyChams.FillTransparency = Settings.EnemyOpacity
    EnemyChams.OutlineTransparency = 0.5
    EnemyChams.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    EnemyChams.FillColor = Settings.EnemyColour
    EnemyChams.OutlineColor = Settings.EnemyOutlineColour

    local TeamChams = Instance.new('Highlight')
    TeamChams.FillTransparency = Settings.TeamOpacity
    TeamChams.OutlineTransparency = 0.5
    TeamChams.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    TeamChams.FillColor = Settings.TeamColour
    TeamChams.OutlineColor = Settings.TeamOutlineColour

  
    function esp()
        game:GetService("RunService").RenderStepped:Connect(function()
            if v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
                local vector, onScreen = camera:WorldToScreenPoint(v.Character:FindFirstChild("LowerTorso").Position)

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
                        Box.Color = Settings.EnemyColour
                    elseif v.TeamColor == LP.TeamColor and v ~= LP and Settings.TB then
                        BoxOut.Size = Vector2.new(4000 / humPos.Z, headPosition.Y - legPos.Y)
                        BoxOut.Position = Vector2.new(humPos.X - BoxOut.Size.X / 2, humPos.Y - BoxOut.Size.Y / 2)
                        BoxOut.Visible = true

                        Box.Size = Vector2.new(4000 / humPos.Z, headPosition.Y - legPos.Y)
                        Box.Position = Vector2.new(humPos.X - Box.Size.X / 2, humPos.Y - Box.Size.Y / 2)
                        Box.Visible = true
                        Box.Color = Settings.TeamColour
                    else
                        BoxOut.Visible = false
                        Box.Visible = false
                    end


                    if v.TeamColor == LP.TeamColor and Settings.TL then
                        Line.Visible = true
                        Line.Color = Settings.TeamColour
                        LineOut.Visible = true
                    elseif v.TeamColor ~= LP.TeamColor and Settings.EL then
                        Line.Visible = true
                        Line.Color = Settings.EnemyColour
                        LineOut.Visible = true
                    else
                        Line.Visible = false
                        LineOut.Visible = false
                    end

                    if v.TeamColor == LP.TeamColor and Settings.TC then
                        TeamChams.Adornee = v.Character
                        TeamChams.Name = v.Name
                        TeamChams.Parent = v.Character

                        TeamChams.FillTransparency = Settings.TeamOpacity
                        TeamChams.FillColor = Settings.TeamColour
                        TeamChams.OutlineColor = Settings.TeamOutlineColour

                    elseif v.TeamColor ~= LP.TeamColor and Settings.EC then
                        task.spawn(function()
                            pcall(function()
                                if workspace[LP.Name] then
                                    if IsPlayerVisible(v) then
                                        EnemyChams.FillColor = Settings.VisibleColour
                                        EnemyChams.OutlineColor = Settings.EnemyOutlineColour
                                    else
                                        EnemyChams.FillColor = Settings.EnemyColour
                                        EnemyChams.OutlineColor = Settings.EnemyOutlineColour
                                    end
                                end
                            end)
                        end)

                        EnemyChams.Adornee = v.Character
                        EnemyChams.Name = v.Name
                        EnemyChams.Parent = v.Character

                        EnemyChams.FillTransparency = Settings.EnemyOpacity
                    else
                        pcall(function()
                            delHighlight(v)
                        end)
                    end
                else
                    BoxOut.Visible = false
                    Box.Visible = false
                    Line.Visible = false
                    LineOut.Visible = false
                    pcall(function()
                        delHighlight(v)
                    end)
                end
            else
                BoxOut.Visible = false
                Box.Visible = false
                Line.Visible = false
                LineOut.Visible = false
                pcall(function()
                    delHighlight(v)
                end)
            end
        end)
    end
    coroutine.wrap(esp)()
end


game.Players.PlayerAdded:Connect(function(v)
    local LP = game.Players.LocalPlayer

    local LineOut = Drawing.new('Line')
    LineOut.Visible = false
    LineOut.Color = Settings.TeamColour
    LineOut.Thickness = 4
    LineOut.Transparency = 1

    local Line = Drawing.new('Line')
    Line.Visible = false
    Line.Color = Settings.EnemyColour
    Line.Thickness = 1
    Line.Transparency = 1

    local BoxOut = Drawing.new("Square")
    BoxOut.Visible = false
    BoxOut.Color = Settings.TeamColour
    BoxOut.Thickness = 4
    BoxOut.Transparency = 1
    BoxOut.Filled = false

    local Box = Drawing.new("Square")
    Box.Visible = false
    Box.Color = Settings.EnemyColour
    Box.Thickness = 1
    Box.Transparency = 1
    Box.Filled = false

    local EnemyChams = Instance.new('Highlight')
    EnemyChams.FillTransparency = Settings.EnemyOpacity
    EnemyChams.OutlineTransparency = 0.5
    EnemyChams.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    EnemyChams.FillColor = Settings.EnemyColour
    EnemyChams.OutlineColor = Settings.EnemyOutlineColour

    local TeamChams = Instance.new('Highlight')
    TeamChams.FillTransparency = Settings.TeamOpacity
    TeamChams.OutlineTransparency = 0.5
    TeamChams.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    TeamChams.FillColor = Settings.TeamColour
    TeamChams.OutlineColor = Settings.TeamOutlineColour

  
    function esp()
        game:GetService("RunService").RenderStepped:Connect(function()
            if v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
                local vector, onScreen = camera:WorldToScreenPoint(v.Character:FindFirstChild("LowerTorso").Position)

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
                        Box.Color = Settings.EnemyColour
                    elseif v.TeamColor == LP.TeamColor and v ~= LP and Settings.TB then
                        BoxOut.Size = Vector2.new(4000 / humPos.Z, headPosition.Y - legPos.Y)
                        BoxOut.Position = Vector2.new(humPos.X - BoxOut.Size.X / 2, humPos.Y - BoxOut.Size.Y / 2)
                        BoxOut.Visible = true

                        Box.Size = Vector2.new(4000 / humPos.Z, headPosition.Y - legPos.Y)
                        Box.Position = Vector2.new(humPos.X - Box.Size.X / 2, humPos.Y - Box.Size.Y / 2)
                        Box.Visible = true
                        Box.Color = Settings.TeamColour
                    else
                        BoxOut.Visible = false
                        Box.Visible = false
                    end


                    if v.TeamColor == LP.TeamColor and Settings.TL then
                        Line.Visible = true
                        Line.Color = Settings.TeamColour
                        LineOut.Visible = true
                    elseif v.TeamColor ~= LP.TeamColor and Settings.EL then
                        Line.Visible = true
                        Line.Color = Settings.EnemyColour
                        LineOut.Visible = true
                    else
                        Line.Visible = false
                        LineOut.Visible = false
                    end

                    if v.TeamColor == LP.TeamColor and Settings.TC then
                        TeamChams.Adornee = v.Character
                        TeamChams.Name = v.Name
                        TeamChams.Parent = v.Character

                        TeamChams.FillTransparency = Settings.TeamOpacity
                        TeamChams.FillColor = Settings.TeamColour
                        TeamChams.OutlineColor = Settings.TeamOutlineColour

                    elseif v.TeamColor ~= LP.TeamColor and Settings.EC then
                        task.spawn(function()
                            pcall(function()
                                if workspace[LP.Name] then
                                    if IsPlayerVisible(v) then
                                        EnemyChams.FillColor = Settings.VisibleColour
                                        EnemyChams.OutlineColor = Settings.VisibleColour
                                    else
                                        EnemyChams.FillColor = Settings.EnemyColour
                                        EnemyChams.OutlineColor = Settings.EnemyOutlineColour
                                    end
                                end
                            end)
                        end)

                        EnemyChams.Adornee = v.Character
                        EnemyChams.Name = v.Name
                        EnemyChams.Parent = v.Character

                        EnemyChams.FillTransparency = Settings.EnemyOpacity
                    else
                        pcall(function()
                            delHighlight(v)
                        end)
                    end
                else
                    BoxOut.Visible = false
                    Box.Visible = false
                    Line.Visible = false
                    LineOut.Visible = false
                    pcall(function()
                        delHighlight(v)
                    end)
                end
            else
                BoxOut.Visible = false
                Box.Visible = false
                Line.Visible = false
                LineOut.Visible = false
                pcall(function()
                    delHighlight(v)
                end)
            end
        end)
    end
    coroutine.wrap(esp)()
end)

function getClosestPlayer()
    local LP = game.Players.LocalPlayer
    local closestPlayer = nil
    local shortestDistance = math.huge
    for i, v in pairs(game.Players:GetPlayers()) do
        if v ~= LP and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health ~= 0 and v.Character:FindFirstChild("HumanoidRootPart") then
            local magnitude = (v.Character.HumanoidRootPart.Position - LP.Character.HumanoidRootPart.Position).Magnitude
            if (IsPlayerVisible(v) and Settings.Visiblecheck) or (not Settings.Visiblecheck and true)  then
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
    end

    return closestPlayer
end

local CurrentCamera = workspace.CurrentCamera
local Players = game.Players
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

function ClosestPlayer()
    local MaxDist, Closest = math.huge
    for i,v in pairs(Players.GetPlayers(Players)) do
        if v == LocalPlayer then continue end
        if not v.Team == LocalPlayer and not Settings.TeamCheck then continue end
        if not v.Character then continue end

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
    return Closest
end

local function Filter(v)
    if string.find(v.Name, "Gun") then
        return
    end
    if v:IsA("Part") or v:IsA("MeshPart") then
        return true
    end
end

local BodyPart = nil

function DynamicClosestPlayer()
    local ClosestDistance, part, plr = math.huge
    for i,v in pairs(Players:GetPlayers()) do
        if v == LocalPlayer then continue end
        if not v.Team == LocalPlayer and not Settings.TeamCheck then continue end
        if not v.Character then continue end

        for k,  x in pairs(v.Character:GetChildren()) do
            if Filter(x) then
                local vec,vis = CurrentCamera:WorldToScreenPoint(x.Position)
                local new = Vector2.new(vec.X, vec.Y)
                
                if (vis and Settings.Visiblecheck or not Settings.Visiblecheck) then
                    local Distance = (new - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
                    if Distance < ClosestDistance then
                        ClosestDistance = Distance
                        BodyPart = x
                    end
                end
            end
        end
    end
    return plr, part
end

function autoFire()
    if Settings.Aimbot then
        local plr = getClosestPlayer()
        if camera.CFrame == CFrame.new(camera.CFrame.Position, workspace[plr.Name][tostring(Settings.aimpart)].Position) then
            if IsPlayerVisible(plr) then
                game:GetService("VirtualInputManager"):SendMouseButtonEvent(500, 500, 0, true, game, 1)
                task.wait(0.15)
            end
        end
    end
end

function SwitchToSelected()
    local N = game:GetService("VirtualInputManager")
    if Settings.KAW == 'Primary' then
        N:SendKeyEvent(true, 49, false, game)
        N:SendKeyEvent(false, 49, false, game)

    elseif Settings.KAW == 'Secondary' then
        N:SendKeyEvent(true, 50, false, game)
        N:SendKeyEvent(false, 50, false, game)

    elseif Settings.KAW == 'Knife' then
        N:SendKeyEvent(true, 51, false, game)
        N:SendKeyEvent(false, 51, false, game)
        
    end
end

function autoFarmStart()
    local LP = game.Players.LocalPlayer
    for _, plr in pairs(game.Players:GetPlayers()) do
        if plr ~= LP and plr.TeamColor ~= LP.TeamColor and plr.Character and plr.Character.Humanoid and plr.Character.Humanoid.Health > 0 and workspace[plr.Name] then
            if game.Workspace.Status.Preparation.Value == false then
                SwitchToSelected()
                LP.Character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(180), 0) * CFrame.new(0, 0,-2.5)
                camera.CFrame = CFrame.new(camera.CFrame.Position, workspace[plr.Name].Head.Position)
                game:GetService("VirtualInputManager"):SendMouseButtonEvent(500, 500, 0, true, game, 1)
            end
        end
    end
end

function main()
    task.spawn(function()
        while task.wait() do

            if Settings.Aimbot then
                pcall(function()
                    
                    local plr = getClosestPlayer()
                    if _G.aimtype == "Snappy" then
                        camera.CFrame = CFrame.new(camera.CFrame.Position, workspace[plr.Name][tostring(Settings.aimpart)].Position)
                    elseif _G.aimtype == "Smooth" then
                        local TS = game.TweenService
                        local TweenInfo = TweenInfo.new(0.03)
                        local tween = TS:Create(camera, TweenInfo, {CFrame = CFrame.new(camera.CFrame.Position, workspace[plr.Name][tostring(Settings.aimpart)].Position)})
                        tween:Play()
                    end
                    
                end)
            end

            if Settings.KillAll then
                pcall(function() autoFarmStart() end)
            end

            if Settings.AutoFire then
                pcall(function() autoFire() end)
            end

        end
    end)
end

local old; old = hookmetamethod(game, "__namecall", function(Self, ...)
    local Args, Method = {...}, getnamecallmethod()

    if Method == "FindPartOnRayWithIgnoreList" and Settings.SilentAim then
        local CP = ClosestPlayer()
        if CP and CP.Character and CP.Character.Humanoid.Health > 0 and CP.Character[Settings.aimpart] then

            Args[1] = Ray.new(CurrentCamera.CFrame.Position, (CP.Character[Settings.aimpart].Position - CurrentCamera.CFrame.Position).Unit * 2500)
            return old(Self, unpack(Args))
        end
    end
    if Method == "FindPartOnRayWithIgnoreList" and BodyPart ~= nil and Settings.DSilentAim then
        Args[1] = Ray.new(CurrentCamera.CFrame.Position, (BodyPart.Position - CurrentCamera.CFrame.Position).Unit * 2500)
        return old(Self, unpack(Args))
    end
    return old(Self, ...)
end)

local oldv2; oldv2 = hookmetamethod(game, "__index", function(self, key)
    if key == "Clips" then
        return workspace.Map
    end
    return oldv2(self, key)
end)

local RunService = game:GetService("RunService")
RunService.RenderStepped:Connect(DynamicClosestPlayer)

main()