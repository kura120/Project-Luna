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

local Creator = game.Players.LocalPlayer
local currentCamera = game.Workspace.CurrentCamera

local Settings = {
    Visiblecheck = false,
    Teamcheck = false,
    Aimbot = false,
    Aimpart = "",
}

local Aim = Create.New({Title = "Aim"})
Aim.Label({Text = "Aim"})
Aim.Toggle({Text = "Aimbot", Callback = function(v) Settings.Aimbot = v end})
Aim.Dropdown({Text = "Aim Part", Callback = function(v) Settings.Aimpart = v end, Options = {"Head", "HumanoidRootPart"}})
Aim.Label({Text = "Aim Settings"})
Aim.Toggle({Text = "Visibility Check", Callback = function(v) Settings.Visiblecheck = v end})
Aim.Toggle({Text = "Team Check", Callback = function(v) Settings.Teamcheck = v end})

function IsPlayerVisible(Player)
    local GetPartsObscuringTarget = currentCamera.GetPartsObscuringTarget
    pcall(function() if not (game.Workspace[Player.Name] or game.Workspace[Creator.Name]) then return end end)

    local enemyChar = game.Workspace[Player.Name]
    
    local root = game.FindFirstChild(enemyChar, Settings.Aimpart) or game.FindFirstChild(enemyChar, "HumanoidRootPart")
    
    if not root then return end
    
    local CastPoints, IgnoreList = {root.Position,  game.Workspace[Creator.Name], enemyChar}, {game.Workspace[Creator.Name], enemyChar}
    local ObscuringObjects = #GetPartsObscuringTarget(currentCamera, CastPoints, IgnoreList)
    
    return ((ObscuringObjects == 0 and true) or (ObscuringObjects > 0 and false))
end

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


function main()
    task.spawn(function()
        while task.wait() do
            if Settings.Aimbot then
                pcall(function()
                    local v = getClosestPlayer()
                    print(v.Name)
                    print(IsPlayerVisible(v))
                    if IsPlayerVisible(v) then
                        currentCamera.CFrame = CFrame.new(currentCamera.CFrame.Position, v.Character[Settings.Aimpart].Position)
                    end
                end)
            end
        end
    end)
end

main()
