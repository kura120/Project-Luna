-- UI Code
local ESP = Drawing.new("Circle")
ESP.Thickness = 1
ESP.NumSides = 100
ESP.Radius = 180
ESP.Filled = false
ESP.Visible = false
ESP.ZIndex = 999
ESP.Transparency = 1
ESP.Color = Color3.fromRGB(54, 57, 241)

local Settings = {SilentAim = false, aimpart = "Head", HitChance = 100, TeamCheck = false, VisibleCheck = false, Radius = 150, Visible = false}

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xaxaxaxaxaxaxaxaxa/Libraries/main/UI's/Linoria/Source.lua"))()
Library:SetWatermark("discord.gg/AQkYRVUXsZ | Project Luna")

local W = Library:CreateWindow("Project Luna")
local GeneralTab = W:AddTab("Aim")
local box = GeneralTab:AddLeftTabbox("Main") do
    local Main = box:AddTab("Main")
    
    Main:AddToggle("SilentAim", {Text = "Silent Aim", Default = Settings.SilentAim}):OnChanged(function()
        Settings.SilentAim = Toggles.SilentAim.Value
    end)

    Main:AddToggle("TeamCheck", {Text = "Team Check", Default = Settings.TeamCheck}):OnChanged(function()
        Settings.TeamCheck = Toggles.TeamCheck.Value
    end)
    Main:AddToggle("VisibleCheck", {Text = "Visible Check", Default = Settings.VisibleCheck}):OnChanged(function()
        Settings.VisibleCheck = Toggles.VisibleCheck.Value
    end)
    Main:AddDropdown("TargetPart", {Text = "Target Part", Default = Settings.aimpart, Values = {"Head", "HumanoidRootPart", "Random"}}):OnChanged(function()
        Settings.aimppart = Options.TargetPart.Value
    end)

    Main:AddSlider('HitChance', {
        Text = 'Hit chance',
        Default = 100,
        Min = 0,
        Max = 100,
        Rounding = 1,
    
        Compact = false,
    })
    Options.HitChance:OnChanged(function()
        Settings.HitChance = Options.HitChance.Value
    end)
end

local FieldOfViewBOX = GeneralTab:AddLeftTabbox("Field Of View") do
    local Main = FieldOfViewBOX:AddTab("Visuals")
    
    Main:AddToggle("Visible", {Text = "Show FOV Circle"}):AddColorPicker("Color", {Default = Color3.fromRGB(54, 57, 241)}):OnChanged(function()
        ESP.Visible = Toggles.Visible.Value
        Settings.Visible = Toggles.Visible.Value
    end)
    Main:AddSlider("Radius", {Text = "FOV Circle Radius", Min = 0, Max = 360, Default = 130, Rounding = 0}):OnChanged(function()
        ESP.Radius = Options.Radius.Value
        Settings.Radius = Options.Radius.Value
    end)
end

local RenderStepped = game:GetService("RunService").RenderStepped
local UserInputService = game:GetService("UserInputService")
local GetMouseLocation = UserInputService.GetMouseLocation

local ValidTargetParts = {"Head", "HumanoidRootPart"}

local ExpectedArguments = {
    FindPartOnRayWithIgnoreList = {
        ArgCountRequired = 3,
        Args = {
            "Instance", "Ray", "table", "boolean", "boolean"
        }
    },
}

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

local function getPositionOnScreen(Vector)
    local Vec3, OnScreen = workspace.CurrentCamera.WorldToScreenPoint(workspace.CurrentCamera, Vector)
    return Vector2.new(Vec3.X, Vec3.Y), OnScreen
end

local function getMousePosition()
    return GetMouseLocation(UserInputService)
end


local function getClosestPlayer()
    local Closest
    local DistanceToMouse
    local LocalPlayer = game.Players.LocalPlayer
    for _, Player in pairs(game.Players:GetPlayers()) do
        if Player == LocalPlayer then continue end
        if Settings.TeamCheck and Player.Team == LocalPlayer.Team then continue end

        local Character = Player.Character
        if not Character then continue end
        
        if Settings.VisibleCheck and not IsPlayerVisible(Player) then continue end

        local HumanoidRootPart = game.FindFirstChild(Character, "HumanoidRootPart")
        local Humanoid = game.FindFirstChild(Character, "Humanoid")
        if not HumanoidRootPart or not Humanoid or Humanoid and Humanoid.Health <= 0 then continue end

        local ScreenPosition, OnScreen = getPositionOnScreen(HumanoidRootPart.Position)
        if not OnScreen then continue end

        local Distance = (getMousePosition() - ScreenPosition).Magnitude
        if Distance <= (DistanceToMouse or Settings.Radius or 2000) then
            Closest = ((Settings.aimpart == "Random" and Character[ValidTargetParts[math.random(1, #ValidTargetParts)]]) or Character[Settings.aimpart])
            DistanceToMouse = Distance
        end
    end
    return Closest
end

function getDirection(Origin, Position)
    return (Position - Origin).Unit * 1000
end

function CalculateChance(Percentage)
    -- // Floor the percentage
    Percentage = math.floor(Percentage)

    -- // Get the chance
    local chance = math.floor(Random.new().NextNumber(Random.new(), 0, 1) * 100) / 100

    -- // Return
    return chance <= Percentage / 100
end

function ValidateArguments(Args, RayMethod)
    local Matches = 0
    if #Args < RayMethod.ArgCountRequired then
        return false
    end
    for Pos, Argument in next, Args do
        if typeof(Argument) == RayMethod.Args[Pos] then
            Matches = Matches + 1
        end
    end
    return Matches >= RayMethod.ArgCountRequired
end

function PlayerOnFOV(plr: Player)
    local Creator = game.Players.LocalPlayer
    local charPos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(plr.Character.HumanoidRootPart.Position)
    local newMag = (Vector2.new(Creator:GetMouse().X, Creator:GetMouse().Y) - Vector2.new(charPos.X, charPos.Y)).Magnitude

    if onScreen and newMag < Settings.FOV then
        return true
    end
end


task.spawn(function()
    RenderStepped:Connect(function()
        if Toggles.Visible.Value then
            ESP.Visible = Toggles.Visible.Value
            ESP.Color = Options.Color.Value
            ESP.Position = getMousePosition()
        end
    end)
end)


local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(...)
    local mthd = getnamecallmethod()
    local args = {...}
    local self = args[1]
    local chance = CalculateChance(Settings.HitChance)
    if Settings.SilentAim and self == workspace and not checkcaller() and chance == true then
        if mthd == "FindPartOnRayWithIgnoreList" then
            if ValidateArguments(args, ExpectedArguments.FindPartOnRayWithIgnoreList) then
                local A_Ray = args[2]

                local HitPart = getClosestPlayer()
                print(HitPart.Name)
                if HitPart then
                    if Settings.Visible then
                        if PlayerOnFOV(HitPart.Parent) then
                            print('ooo')
                            local Origin = A_Ray.Origin
                            local Direction = getDirection(Origin, HitPart.Position)
                            args[2] = Ray.new(Origin, Direction)

                            return oldNamecall(unpack(args))
                        end
                    elseif not Settings.Visible then
                        print('waaaaaaaaaa')
                        local Origin = A_Ray.Origin
                        local Direction = getDirection(Origin, HitPart.Position)
                        args[2] = Ray.new(Origin, Direction)

                        return oldNamecall(unpack(args))
                    end
                end
            end
        end
    end
    return oldNamecall(...)
end))