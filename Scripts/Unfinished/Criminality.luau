--[[local succ, err = pcall(function()
    task.spawn(function()
        for i, v in pairs(game.ReplicatedStorage:GetDescendants()) do
            if v:IsA("ModuleScript") then
                local scriptname = v
                local script = require(v)
                if type(script) == "table" then
                    for _, z in pairs(script) do
                        if type(z) == "function" then
                            local functionname = debug.getinfo(z).name
                            local instance2 = scriptname,  "fired function named " .. functionname
                            script[functionname] = function()
                                print(scriptname,  "fired function named " .. functionname)
                                return
                            end
                            local previous = {};
                            local max = 12;
                            local p;
                            p = hookfunction(print, function(a)
                                previous[a] = previous[a] or 0;
                                previous[a] = previous[a] +  1;
                                if a == instance2 then  -- if a == args
                                    if (previous[a] < max) then
                                        return p(a);
                                    end
                                end
                            end)
                        end
                    end
                end
            end
        end
    end)
end)]]

function notify(Text, Time)
    game.StarterGui:SetCore("SendNotification", {
        Title = "Luna Client";
        Text = Text;
        Icon = "http://www.roblox.com/asset/?id=10502664319";
        Duration = Time
    })
end

notify("This is a one time supported game, no updates will be added.", 5)

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
		ButtonAccent = Color3.fromRGB(255, 255, 255),
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


local Info = {
    InfStamina = false,
    NoDMG = false
}

task.spawn(function()

    local HealthValueLeftLeg = game:GetService("ReplicatedStorage").CharStats[Creator.Name].HealthValues["Left Leg"]
    local HealthValueRightLeg = game:GetService("ReplicatedStorage").CharStats[Creator.Name].HealthValues["Right Leg"]
    HealthValueLeftLeg.Changed:Connect(function()
        if Info.NoDMG then
            HealthValueLeftLeg.Value = 100
        end
        
    end)
     
    HealthValueRightLeg.Changed:Connect(function()
        if Info.NoDMG then
            HealthValueRightLeg.Value = 100

        end
    end)

    local Sprinting = game:GetService("ReplicatedStorage").CharStats[Creator.Name].Sprinting
    Sprinting.Changed:Connect(function()
        if Info.InfStamina then
            Sprinting.Value = false
        end
    end)
end)

local Misc = Create.New({
	Title = "Misc"
})

Misc.Toggle({
	Text = "Infinite Stamina",
	Callback = function(u)
		Info.InfStamina = u
	end
})

Misc.Toggle({Text = "No Fall Damage", Callback = function(v) Info.NoDMG = v end})

--[[
function getClosestOnFolder(folder, partCheck)
    local closestPlayer = nil
    local shortestDistance = math.huge
    for i, v in pairs(folder:GetChildren()) do
        if v:FindFirstChild(partCheck) then
            local magnitude = (v[partCheck].Position - Creator.Character.HumanoidRootPart.Position).magnitude

            if magnitude < shortestDistance then
                closestPlayer = v
                shortestDistance = magnitude
            end
        end
    end

    return closestPlayer
end

function getClosestSafe(partCheck)
    local closestPlayer = nil
    local shortestDistance = math.huge
    for i, v in pairs(workspace.Map.BredMakurz:GetChildren()) do
        if v:FindFirstChild(partCheck) and string.find(v.Name, "Safe") and v.Values.Broken.Value == false then
            local magnitude = (v[partCheck].Position - Creator.Character.HumanoidRootPart.Position).magnitude

            if magnitude < shortestDistance then
                closestPlayer = v
                shortestDistance = magnitude
            end
        end
    end

    return closestPlayer
end

local function NoclipLoop()
	if clip == false and Creator.Character ~= nil then
		for _, child in pairs(Creator.Character:GetDescendants()) do
			if child:IsA("BasePart") and child.CanCollide == true then
				child.CanCollide = false
			end
		end
	else
		Noclipping = nil
	end
end

function tp(dist)
	if Creator.Character:FindFirstChild("HumanoidRootPart") and Creator.Character:FindFirstChild("Humanoid") then

        for i = 1,25,1 do
            task.wait(0.010)
            Creator.Character.HumanoidRootPart.CFrame = dist
        end
	end
end

function Main()
	while task.wait() do
		task.spawn(function()
            if Info.CashFarm then
                pcall(function()
                    game:GetService("ReplicatedStorage").Storage.GUIs.LockpickGUI.MF["LP_Frame"].Frames.B1.Bar.Size = UDim2.new(0,270,0,270)
                    game:GetService("ReplicatedStorage").Storage.GUIs.LockpickGUI.MF["LP_Frame"].Frames.B2.Bar.Size = UDim2.new(0,270,0,270)
                    game:GetService("ReplicatedStorage").Storage.GUIs.LockpickGUI.MF["LP_Frame"].Frames.B3.Bar.Size = UDim2.new(0,270,0,270)
    
                    repeat task.wait() until Creator.Character
                    local N = game:GetService("VirtualInputManager")
                    
                    if Creator:FindFirstChildWhichIsA("Tool") and Creator:FindFirstChildWhichIsA("Tool").Name ~= "Lockpick" then
                        Creator:FindFirstChildWhichIsA("Tool").Parent = Creator.Backpack
                    end

                    if Creator.Backpack:FindFirstChild("Lockpick") then
                        Creator.Backpack.Lockpick.Parent = Creator.Character
                        
                    elseif not Creator.Character:FindFirstChild("Lockpick") and not Creator.Backpack:FindFirstChild("Lockpick") and Info.CashFarm then    
                        tp(v.MainPart.CFrame * CFrame.new(0,0,-3) * CFrame.Angles(0,math.rad(180),0))
    
                        if not Creator.Backpack:FindFirstChild("Lockpick") and not Creator.Character:FindFirstChild("Lockpick") then
                            for _,g in pairs(getconnections(Creator.PlayerGui.CurrentGUI.ShopFrame.MainFrame.ButtonFrames.MiscButton.TextButton.MouseButton1Down)) do
                                if Info.CashFarm then g.Function() end
                                task.wait(0.15)
                            end
                            task.wait(1)
                            for _,g in pairs(getconnections(Creator.PlayerGui.CurrentGUI.ShopFrame.MainFrame.ListFrame1.MiscFrame.Lockpick.Frame.TextButton.MouseButton1Down)) do
                                if Info.CashFarm then g.Function() end
                                task.wait(0.15)
                            end
                            task.wait(1)
                            for _,g in pairs(getconnections(Creator.PlayerGui.CurrentGUI.ShopFrame.MainFrame.PictureFrame.BuyFrame.Available.TextButton.MouseButton1Down)) do
                                if Info.CashFarm then g.Function() end
                                task.wait(0.15)
                            end
                            for _,g in pairs(getconnections(Creator.PlayerGui.CurrentGUI.ShopFrame.MainFrame.PurchaseFrames.PurchaseFrame.TextButton.MouseButton1Down)) do
                                if Info.CashFarm then g.Function() end
                                task.wait(0.15)
                            end
                            task.wait(1)
                        end
                    end

                    local t = getClosestSafe("MainPart")
                    if t and Creator.Character:FindFirstChild("Lockpick") then
                        task.wait(1)

                        task.spawn(function() tp(t.MainPart.CFrame * CFrame.new(0,0,-3) * CFrame.Angles(0,math.rad(180), 0)) end)

                        if not Creator.PlayerGui:FindFirstChild("LockpickGUI") then
                            workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, t.MainPart.Position)
                            workspace.Camera.FieldOfView = 25
                            task.wait(0.25)
                            mousemoveabs(1000,625)
                            task.wait(0.5)
                            VU:ClickButton1(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                            task.wait(0.5)
                        end
                        for i = 0, t.Values.LockpickBars.Value, 1 do
                            task.wait(1)
                            VU:ClickButton1(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                        end
                        if not Creator.PlayerGui:FindFirstChild("LockpickGUI") then
                            for i,v in pairs(game:GetService("Workspace").Filter.SpawnedBread:GetChildren()) do
                                if v:FindFirstChild("ProximityPrompt") then
                                    fireproximityprompt(v.ProximityPrompt)
                                    task.wait(0.35)
                                end
                            end
                        end
                    end
                end)
            end
		end)
	end
end

Main()]]