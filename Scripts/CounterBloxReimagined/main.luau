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

    TeamColour = Color3.fromRGB(0,0,255),
    TeamOutlineColour = Color3.fromRGB(0,0,255),

    EnemyColour = Color3.fromRGB(255,0,0),
    EnemyOutlineColour = Color3.fromRGB(255,0,0),

    VisibleColour = Color3.fromRGB(16, 190, 16),

    AutoBuyCrate = false,
    SelectedCase = nil,
    AutoFireWait = 0.25,
    AutoFire = false,
    KillAll = false,

    KAW = nil,

    EC = nil,
    TC = nil,
}

for i,v in pairs(game.ReplicatedFirst:GetChildren()) do
    if v:IsA('LocalScript') then
        v:Remove()
    end
end

function notify(Text, Time)
    game.StarterGui:SetCore("SendNotification", {
        Title = 'Project Luna';
        Text = Text;
        Duration = Time;
        Icon = "rbxassetid://10736708509"
    })
end

notify('Currently Undetected', 10)
notify('Last Updated: 27/08/22', 10)

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
    Text = "Made by Duxkyx#5079",
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

Main.Toggle({
    Text = "Auto Fire (0.5s wait)",
    Callback = function(v)
        Settings.AutoFire = v
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

local Weapons = Create.New({
	Title = "Weapons"
})

Weapons.Label({
    Text = "In-Game", 
})

Weapons.Button({
    Text = 'Free Gun Shop',
    Callback = function()
        local a = require(game.ReplicatedStorage.GetPrices)
        a.getprice = function() return 0 end
    end
})

Weapons.Button({
    Text = 'Inf Ammo',
    Callback = function()
        for _, guns in pairs(game.ReplicatedStorage.Weapons:GetChildren()) do
            if guns.Name == 'Ammo' or guns.Name == 'StoredAmmo' then
                guns.Value = '300'
            end
        end
    end
})

Weapons.Button({
    Text = 'No Recoil',
    Callback = function()
        for _, guns in pairs(game.ReplicatedStorage.Weapons:GetChildren()) do
            if guns.Name == 'Recoil' or guns.Name == 'Spread' then
                guns.Value = '0'
            end
        end
    end
})

Weapons.Label({
    Text = "Cases", 
})

Weapons.Dropdown({
    Text = "Selected Case",
    Callback = function(Value)
        Settings.SelectedCase = Value
    end,
    Options = {
        "Handwraps Crate", "Fluorescent Case", "Fingerless Gloves Crate", "Epicness Box", "Eli Box", "Bayonets M9 Crate", "Aesthetic & Fade 24 Box", "[LIMITED] Independence 2022 Box", "[LIMITED] Dragon King Case", "White 1648 Case", "Twitch Case", "Strapped Gloves Crate", "Stiletto Crate", "Sport Gloves Crate", "Nikitos Games Box", "Karambits Crate", "Kuro to shiro Box", "Faz Case", "Weeb Box"
    },
})

Weapons.Button({
    Text = 'Buy Case (x1) FREE!',
    Callback = function()
        buycrate(Settings.SelectedCase)
    end
})

Weapons.Toggle({
    Text = "Auto Buy Crate, FREE!",
    Callback = function(v)
        Settings.AutoBuyCrate = v
    end
})

local Other = Create.New({
	Title = "Other"
})

Other.Label({
    Text = "Hud", 
})

Other.ColorPicker({
    Text = "Hud Colour", 
    Default = Color3.new(255,255,255), 
    Callback = function(v) 
        local r,g,b = math.floor((v.R * 255) + 0.5), math.floor((v.G * 255) + 0.5), math.floor((v.B * 255) + .5)
        game.Players.LocalPlayer.HudColor.Color.Value = Color3.fromRGB(r,g,b)
    end
})

Other.Label({
    Text = "Teams", 
})

Other.Button({
    Text = 'Join CT',
    Callback = function()
        local args = {[1] = "CT"}
        game:GetService("ReplicatedStorage").Events.JoinTeam:FireServer(unpack(args))
    end
})

Other.Button({
    Text = 'Join T',
    Callback = function()
        local args = {[1] = "T"}
        game:GetService("ReplicatedStorage").Events.JoinTeam:FireServer(unpack(args))
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
    EnemyChams.FillTransparency = 0.5
    EnemyChams.OutlineTransparency = 0.5
    EnemyChams.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    EnemyChams.FillColor = Settings.EnemyColour
    EnemyChams.OutlineColor = Settings.EnemyOutlineColour

    local TeamChams = Instance.new('Highlight')
    TeamChams.FillTransparency = 0.5
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

                        TeamChams.FillColor = Settings.TeamColour
                        TeamChams.OutlineColor = Settings.TeamOutlineColour

                    elseif v.TeamColor ~= LP.TeamColor and Settings.EC then
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

                        EnemyChams.Adornee = v.Character
                        EnemyChams.Name = v.Name
                        EnemyChams.Parent = v.Character
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
    EnemyChams.FillTransparency = 0.5
    EnemyChams.OutlineTransparency = 0.5
    EnemyChams.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    EnemyChams.FillColor = Settings.EnemyColour
    EnemyChams.OutlineColor = Settings.EnemyOutlineColour

    local TeamChams = Instance.new('Highlight')
    TeamChams.FillTransparency = 0.5
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

                        TeamChams.FillColor = Settings.TeamColour
                        TeamChams.OutlineColor = Settings.TeamOutlineColour

                    elseif v.TeamColor ~= LP.TeamColor and Settings.EC then
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

                        EnemyChams.Adornee = v.Character
                        EnemyChams.Name = v.Name
                        EnemyChams.Parent = v.Character
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

function autoFire()
    local plr = getClosestPlayer()
    if camera.CFrame == CFrame.new(camera.CFrame.Position, workspace[plr.Name][tostring(Settings.aimpart)].Position) then
        if IsPlayerVisible(plr) then
            game:GetService("VirtualInputManager"):SendMouseButtonEvent(500, 500, 0, true, game, 1)
            task.wait(0.5)
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
            SwitchToSelected()
            if game.Workspace.Status.Preparation.Value == false then
                LP.Character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame * CFrame.new(0,5,0)
                camera.CFrame = CFrame.new(camera.CFrame.Position, workspace[plr.Name].Head.Position)
                game:GetService("VirtualInputManager"):SendMouseButtonEvent(500, 500, 0, true, game, 1)
            end
        end
    end
end

function buycrate(name)
    local args = {[1] = {[1] = "BuyCase",[2] = name}}
    game:GetService("ReplicatedStorage").Events.DataEvent:FireServer(unpack(args))
end

function main()
    task.spawn(function()
        while task.wait() do

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

            if Settings.KillAll then
                pcall(function() autoFarmStart() end)
            end

            if Settings.AutoFire then
                pcall(function() autoFire() end)
            end

            if Settings.AutoBuyCrate then
                buycrate(Settings.SelectedCase)
                task.spawn(function() task.wait(0.5) end)
            end

        end
    end)
end

main()