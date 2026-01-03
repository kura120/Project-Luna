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
    RiceFarm = false,
    Weapon = "",
    NPC = "",
    BossFarm = false,
    FF = false,
    LF = false,
    AutoLoot = false,
    FishFarm = false,
    FarmAll = false,
    Meditate = false,
    Speed = 150,
    AS = false,
    FishCount = 0,
    WalkSpeed = 16,
    JumpPower = 50
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

function bossTP(bName)
    local v = function()
        for _,boss in pairs(workspace.Mobs.Bosses:GetDescendants()) do
            if boss.Name == bName then
                return boss
            end
        end
    end

    local t = v()

    if t and t:IsA("Model") then
        tp(t.HumanoidRootPart.CFrame)
    end
end

function getClosestNPC(name, folder)
    local closest
    local closestMag
    local mag

    local get = function()
        local v = folder:FindFirstChild(name)
         
        return v
    end

    if folder then
        local newG = get()
        for i,v in pairs(folder:GetChildren()) do
            if newG then
                if v == newG and v:FindFirstChild("HumanoidRootPart") then
                    if closest then
                        mag = math.floor((Creator.Character:FindFirstChild("HumanoidRootPart").Position - v.HumanoidRootPart.Position).magnitude)
                        if mag < closestMag then
                            closest = v
                            closestMag = mag
                        end
                    elseif not closest then
                        closest = v
                        closestMag = math.floor((Creator.Character:FindFirstChild("HumanoidRootPart").Position - v.HumanoidRootPart.Position).magnitude)
                    end
                end
            end
        end
    end

    return closest
end

function FFD(parent, child)
    return parent:FindFirstChild(child, true)
end

function GodMode()
    task.spawn(function()
        local r = require(game:GetService("ReplicatedStorage").Modules.Server["Server_Modules"]["Change_Transparency"])
        r = function(p1, p2, p3)
            if typeof(p2) == "table" then
                for v2, v3 in pairs(p2) do
                    v3[1].Transparency = v3[2]
                end
            end
        end

        for i,v in pairs(Creator.Character:GetDescendants()) do
            if v:IsA("MeshPart") or v:IsA("Part") then
                local ohString1 = "Change_Transparency"
                local ohTable2 = {
                    [1] = {
                        [1] = v,
                        [2] = 1
                    }
                }
                r(ohString1, ohTable2)
            end
        end
    end)
end

function getClosestItem(name, folder)
    local closest
    local closestMag
    local mag

    local get = function()
        local v = folder:FindFirstChild(name)
         
        return v
    end

    if folder then
        local newG = get()
        for i,v in pairs(folder:GetChildren()) do
            if newG then
                if v == newG then
                    if closest then
                        mag = math.floor((Creator.Character:FindFirstChild("HumanoidRootPart").Position - v.Position).magnitude)
                        if mag < closestMag then
                            closest = v
                            closestMag = mag
                        end
                    elseif not closest then
                        closest = v
                        closestMag = math.floor((Creator.Character:FindFirstChild("HumanoidRootPart").Position - v.Position).magnitude)
                    end
                end
            end
        end
    end

    return closest
end

function collidesWith(gui1, gui2)
    local gui1_topLeft = gui1.AbsolutePosition
    local gui1_bottomRight = gui1_topLeft + gui1.AbsoluteSize

    local gui2_topLeft = gui2.AbsolutePosition
    local gui2_bottomRight = gui2_topLeft + gui2.AbsoluteSize

    return ((gui1_topLeft.x < gui2_bottomRight.x and gui1_bottomRight.x > gui2_topLeft.x) and (gui1_topLeft.y < gui2_bottomRight.y and gui1_bottomRight.y > gui2_topLeft.y))
end

function notify(Text, Time)
    game.StarterGui:SetCore("SendNotification", {
        Title = "Luna Client";
        Text = Text;
        Icon = "http://www.roblox.com/asset/?id=10502664319";
        Duration = Time
    })
end

function getweapons()
    local tbl = {}

    for i,v in pairs(Creator.Backpack:GetChildren()) do
        if v:IsA("Tool") then
            if v:FindFirstChild("CombatIsEquiped") or v:FindFirstChild("SwordIsEquiped") then
                table.insert(tbl, tostring(v.Name))
            end
        end
    end

    return tbl
end

local Credit = Create.New({
	Title = "Credits"
})

Credit.Label({
    Text = "Thanks for choosing Project Slayers!", 
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
    Text = "Made by the kura#0999",
    Callback = function()
        setclipboard("https://wearedevs.net/profile?uid=68402")
    end
})

local Farm = Create.New({
    Title = "Auto Farm"
})

Farm.Toggle({
    Text = "Farm All Bosses",
    Callback = function(v)
        Info.FarmAll = v
    end
})

local Money = Create.New({
    Title = "Money"
})
local TP = Create.New({
    Title = "TP"
})

local Misc = Create.New({
    Title = "Misc"
})

Misc.Button({
    Text = "Buy Fish Rod",
    Callback = function()
        local rod = Creator.Backpack:FindFirstChild("Fishing Rod")
        local Dialogue = Creator.PlayerGui["Npc_Dialogue"]
        local opt = Dialogue.ButtonsHolder.Option1

        if rod then
            notify("Fishing rod already bought.", 5)
        end

        if not rod then
            setfflag("HumanoidParallelRemoveNoPhysicsNoSimulate2", "False")
            setfflag("HumanoidParallelRemoveNoPhysics", "False")
            tp(CFrame.new(-522.101379, 275.425903, -3486.19775))
            curTween.Completed:Wait()
            task.wait(.5)
            VU:SetKeyDown("0x65")
            task.wait()
            VU:SetKeyUp("0x65")

            for _,eve in pairs(cEvents) do
                repeat task.wait() until opt.BackgroundTransparency == 0
                for _,CONNECT in pairs(getconnections(opt[eve])) do
                    task.wait(1.5)
                    CONNECT.Function()
                end
            end
        end
        setfflag("HumanoidParallelRemoveNoPhysics", "True")
        setfflag("HumanoidParallelRemoveNoPhysicsNoSimulate2", "True")
    end
})

Misc.Button({
    Text = "Infinite Stamina (don't click more than once)",
    Callback = function()
        task.spawn(function()
            local PlayerValues = game:GetService("ReplicatedStorage").PlayerValues[Creator.Name]
            local Stamina = PlayerValues.Stamina
            
            oldIndexV2 = hookmetamethod(game, "__newindex", function(s, index, value)
                if checkcaller() == false then
                    if s == Stamina and index == "Value" then
                        value = Stamina.MaxValue
                    end
                end
                return oldIndexV2(s, index, value)
            end)
        end)
    end
})

Misc.Button({
    Text = "No Sun Damage (don't click more than once)",
    Callback = function()
        task.spawn(function()
            local OldNameCall = nil
            OldNameCall = hookmetamethod(game, "__namecall", function(self, ...)
                if not checkcaller() and getnamecallmethod() == "FireServer" and self.Name == "Sun_Damage" then
                    return
                end
                
                return OldNameCall(self, ...)
            end)
        end)
    end
})

Misc.Button({
    Text = "Infinite Breathing (don't click more than once)",
    Callback = function()
        task.spawn(function()
            local PlayerValues = game:GetService("ReplicatedStorage").PlayerValues[Creator.Name]
            local Breath = PlayerValues.Breath
            
            oldIndex = hookmetamethod(game, "__newindex", function(s, index, value)
                if checkcaller() == false then
                    if s == Breath and index == "Value" then
                        value = Breath.MaxValue
                    end
                end
                return oldIndex(s, index, value)
            end)
        end)
        
    end
})

Misc.Toggle({
    Text = "Auto Meditate",
    Callback = function(v)
        Info.Meditate = v
    end
})

local b1 = game:GetService("ReplicatedStorage")["Player_Data"][Creator.Name].BreathingProgress["1"].Value
local b2 = game:GetService("ReplicatedStorage")["Player_Data"][Creator.Name].BreathingProgress["2"].Value
local BPro = Misc.Label({
    Text = "Breathing Progress: " .. b1 .. "/" .. b2
})

local d1 = game:GetService("ReplicatedStorage")["Player_Data"][Creator.Name].DemonProgress["1"].Value
local d2 = game:GetService("ReplicatedStorage")["Player_Data"][Creator.Name].DemonProgress["2"].Value
local DPro = Misc.Label({
    Text = "Demon Progress: " .. d1 .. "/" .. d2
})

Money.Label({
    Text = "Farm"
})

Money.Toggle({
    Text = "Fish Farm",
    Callback = function(v)
        Info.FishFarm = v
        if curTween then
            curTween:Cancel()
        end
    end
})

local FishLabel = Money.Label({Text = "Fish Farmed: 0"})

TP.Label({
    Text = "Trainers"
})


TP.Button({
    Text = "Thunder Trainer",
    Callback = function(v)
        if curTween then
            repeat task.wait()
                curTween:Cancel()
            until curTween == nil
        end

        setfflag("HumanoidParallelRemoveNoPhysics", "False")
        setfflag("HumanoidParallelRemoveNoPhysicsNoSimulate2", "False")
        tp(CFrame.new(-319.431122, 426.94455, -2383.9563))
        curTween.Completed:Wait()
        setfflag("HumanoidParallelRemoveNoPhysics", "True")
        setfflag("HumanoidParallelRemoveNoPhysicsNoSimulate2", "True")
    end
})

TP.Button({
    Text = "Water Trainer",
    Callback = function(v)
        if curTween then
            repeat task.wait()
                curTween:Cancel()
            until curTween == nil
        end

        setfflag("HumanoidParallelRemoveNoPhysics", "False")
        setfflag("HumanoidParallelRemoveNoPhysicsNoSimulate2", "False")
        tp(CFrame.new(713.321533, 261.001953, -2392.60205))
        curTween.Completed:Wait()
        setfflag("HumanoidParallelRemoveNoPhysics", "True")
        setfflag("HumanoidParallelRemoveNoPhysicsNoSimulate2", "True")
    end
})

TP.Button({
    Text = "Wind Trainer",
    Callback = function(v)
        if curTween then
            repeat task.wait()
                curTween:Cancel()
            until curTween == nil
        end

        setfflag("HumanoidParallelRemoveNoPhysics", "False")
        setfflag("HumanoidParallelRemoveNoPhysicsNoSimulate2", "False")
        tp(CFrame.new(1793.97522, 334.369202, -3523.81226))
        curTween.Completed:Wait()
        setfflag("HumanoidParallelRemoveNoPhysics", "True")
        setfflag("HumanoidParallelRemoveNoPhysicsNoSimulate2", "True")
    end
})

TP.Button({
    Text = "Insect Trainer",
    Callback = function(v)
        if curTween then
            repeat task.wait()
                curTween:Cancel()
            until curTween == nil
        end

        setfflag("HumanoidParallelRemoveNoPhysics", "False")
        setfflag("HumanoidParallelRemoveNoPhysicsNoSimulate2", "False")
        tp(CFrame.new(2872.69995, 316.985046, -3919.52515))
        curTween.Completed:Wait()
        setfflag("HumanoidParallelRemoveNoPhysics", "True")
        setfflag("HumanoidParallelRemoveNoPhysicsNoSimulate2", "True")
    end
})

TP.Label({
    Text = "Other"
})

TP.Button({
    Text = "Horse Guy",
    Callback = function(v)
        if curTween then
            repeat task.wait()
                curTween:Cancel()
            until curTween == nil
        end


        for i,y in pairs(workspace:GetChildren()) do
            if y.Name == "Model" and y:IsA("Model") and y:FindFirstChild("Customization data ting") then
                if y["Customization data ting"]:FindFirstChild("HumanoidRootPart") then
                    tp(y["Customization data ting"].HumanoidRootPart.CFrame)
                end
            end
        end
    end
})

TP.Button({
    Text = "Muzan",
    Callback = function(v)
        if curTween then
            repeat task.wait()
                curTween:Cancel()
            until curTween == nil
        end

        pcall(function()
            setfflag("HumanoidParallelRemoveNoPhysics", "False")
            setfflag("HumanoidParallelRemoveNoPhysicsNoSimulate2", "False")
            tp(CFrame.new(workspace.Muzan.SpawnPos.Value))
            curTween.Completed:Wait()
            setfflag("HumanoidParallelRemoveNoPhysics", "True")
            setfflag("HumanoidParallelRemoveNoPhysicsNoSimulate2", "True")
        end)

    end
})

TP.Toggle({
    Text = "Lily Flower",
    Callback = function(v)
        if curTween then
            repeat task.wait()
                curTween:Cancel()
            until curTween == nil
        end
        Info.LF = v
    end
})



Money.Toggle({
    Text = "Rice Farm",
    Callback = function(v)
        if curTween then
            repeat task.wait()
                curTween:Cancel()
            until curTween == nil
        end

        Info.RiceFarm = v

        if not v then
            setfflag("HumanoidParallelRemoveNoPhysics", "True")
            setfflag("HumanoidParallelRemoveNoPhysicsNoSimulate2", "True")
        end
    end
})

Money.Label({
    Text = "Selling"
})

Money.Button({
    Text = "Sell Fish",
    Callback = function()
        if curTween then
            repeat task.wait()
                curTween:Cancel()
            until curTween == nil
        end

        local old = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame

        tp(CFrame.new(-514.311951, 274.43689, -3476.42749))
        curTween.Completed:Wait()
        task.wait(0.5)
        VU:SetKeyDown("0x65")
        task.wait()
        VU:SetKeyUp("0x65")
        repeat task.wait() until Creator.PlayerGui["Npc_Dialogue"].Guis:FindFirstChild("Sell_Fish")
        repeat task.wait() until Creator.PlayerGui["Npc_Dialogue"].Guis:FindFirstChild("Sell_Fish").Fishes_Holder.Footer.TextButton.BackgroundTransparency
        for i,v in pairs(cEvents) do
            task.wait(0.5)
            for _,m in pairs(getconnections(
                Creator.PlayerGui["Npc_Dialogue"].Guis:FindFirstChild("Sell_Fish").Fishes_Holder.Footer.TextButton[v]
            )) do
                m.Function()
            end
        end
        task.wait(1)
        for i,v in pairs(cEvents) do
            task.wait(0.5)
            for _,m in pairs(getconnections(
                Creator.PlayerGui["Npc_Dialogue"].ButtonsHolder.Option2[v]
            )) do
                m.Function()
            end
        end
        task.wait(1)
        tp(old)
    end
})

Farm.Label({
    Text = "Auto Farm"
})

Farm.Toggle({
    Text = "Initiate Boss Farm",
    Callback = function(v)
        if v then
            notify("We recommend your distance between you and the boss is not way too far", 5)
        end
        Info.BossFarm = v
    end
})

Farm.Toggle({
    Text = "Auto Loot Chest",
    Callback = function(v)
        Info.AutoLoot = v
    end
})

Farm.Toggle({
    Text = "Fist Mastery",
    Callback = function(v)
        Info.FF = v
    end
})

Farm.Label({
    Text = "Settings"
})

Farm.Dropdown({
    Text = "Boss NPC",
    Callback = function(v)
        Info.NPC = v
    end,
    Options = {"Giyu", "Sabito", "Zanegutsu Kuuchie", "Shiron", "Nezuko", "Sanemi", "Bandit Zoku", "Susamaru", "Yahaba", "Slasher", "Bandit Kaden"}
})

Farm.Button({
    Text = "God Mode (version v182 and below)",
    Callback = function()
        GodMode()
    end
})

Farm.Dropdown({
    Text = "Weapon",
    Callback = function(v)
        Info.Weapon = v
    end,
    Options = {"Fists", "Sword"}
})

local Settings = Create.New({
    Title = "Settings"
})

Settings.Slider({
    Text = "Player WalkSpeed",
    Callback = function(v)
        Info.WalkSpeed = v
    end,
    Min = 16,
    Max = 1000,
    Def = Info.WalkSpeed
})

Settings.Slider({
    Text = "Player JumpPower",
    Callback = function(v)
        Creator.Character.Humanoid.JumpPower = v
    end,
    Min = 50,
    Max = 100,
    Def = Info.WalkSpeed
})

Settings.Slider({
    Text = "Tween Speed",
    Callback = function(v)
        Info.Speed = v
    end,
    Min = 100,
    Max = 400,
    Def = 150,
})


-- rejoin on kick
task.spawn(function()
	getgenv().rejoin = game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(child)
		if child.Name == 'ErrorPrompt' and child:FindFirstChild('MessageArea') and child.MessageArea:FindFirstChild("ErrorFrame") then
			game:GetService("TeleportService"):Teleport(game.PlaceId)
			repeat
				task.wait()
			until game:IsLoaded()
		end
	end)
end)

-- checking to join main game

if game.PlaceId ~= 6152116144 then
    ts:Teleport(6152116144, Creator)
end

local Main = function()
    task.spawn(function()
        while task.wait() do
            getgenv().tyrew, getgenv().errror = pcall(function()
                if Info.RiceFarm then
                    repeat task.wait() until Creator.PlayerGui["localscript_cache"]["Game_Play"]["Humanoid_Changer"].HeartBeat.Playing == false
    
                    local Sarah = workspace.Sarah
                    local questGUI = Creator.PlayerGui.Menu.Quest.Holder
                    local function getMission()
                        for i,v in pairs(questGUI:GetChildren()) do
                            if v.Name ~= "pick 4 strings of rice" then
                                local args = {
                                    [1] = "removequest",
                                    [2] = game:GetService("ReplicatedStorage").Player_Data[Creator.Name].Quest
                                }
            
                                game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S:FireServer(unpack(args))
                            end
            
                            if not questGUI:FindFirstChildWhichIsA("Frame") and Sarah:FindFirstChild("HumanoidRootPart") then
                                if Creator.Character:FindFirstChild("HumanoidRootPart").CFrame ~= Sarah.HumanoidRootPart.CFrame then
        
                                    local Dialogue = Creator.PlayerGui["Npc_Dialogue"]
                                    local opt = Dialogue.ButtonsHolder.Option1
        
                                    tp(Sarah.HumanoidRootPart.CFrame)
                                    setfflag("HumanoidParallelRemoveNoPhysics", "False")
                                    setfflag("HumanoidParallelRemoveNoPhysicsNoSimulate2", "False")
                                    curTween.Completed:Wait()
                                    task.wait(0.5)
                                    VU:SetKeyDown("0x65")
                                    task.wait(.1)
                                    VU:SetKeyUp("0x65")
                                    task.wait(.7)
        
                                    if Dialogue.Background.ImageTransparency == 0 then
                                        for i,v in pairs(Dialogue["Text_Holder"]:GetDescendants()) do
                                            if v:IsA("TextLabel") then
                                                if v.TextColor3 == Color3.fromRGB(255,30,30) then
                                                    notify("waiting for cooldown to finish", 10)
                                                    return
                                                end
                                            end
                                        end
        
                                        for _,eve in pairs(cEvents) do
                                            repeat task.wait() until opt.BackgroundTransparency == 0
                                            for _,CONNECT in pairs(getconnections(opt[eve])) do
                                                task.wait(2)
                                                CONNECT.Function()
                                                repeat task.wait() until opt.BackgroundTransparency == 0
                                                CONNECT.Function()
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
        
                    local rice = getClosestItem("RiceString", workspace["StarterVillage_RiceStrings"])
                    if rice.ClassName == "Part" and rice:FindFirstChildWhichIsA("ProximityPrompt") and questGUI:FindFirstChildWhichIsA("Frame") then
                        tp(rice.CFrame)
                        curTween.Completed:Wait()
                        VU:SetKeyDown("0x65")
                        task.wait(6)
                        VU:SetKeyUp("0x65")
                        task.wait(.15)
                    end
                    if not questGUI:FindFirstChild("pick 4 strings of rice") then
    
                        getMission()
                    end
                end
        
                if Info.BossFarm then
                    repeat task.wait() until Creator.PlayerGui["localscript_cache"]["Game_Play"]["Humanoid_Changer"].HeartBeat.Playing == false
    
                    local Mobs = workspace.Mobs
    
                    local isSpawned = function()
                        local y = false
    
                        if FFD(Mobs, Info.NPC) then
                            y = true
                        end
                        return y
                    end
                    repeat task.wait() until isSpawned() == true
                    task.wait(1)
                    if Info.BossFarm then
                        for _,t in pairs(Mobs:GetDescendants()) do
                            if t:IsA("Model") and t.Name == Info.NPC then
                                repeat task.wait()
                                tp(CFrame.new(t:FindFirstChild('Humanoid').WalkToPoint))
                                setfflag("HumanoidParallelRemoveNoPhysics", "False")
                                setfflag("HumanoidParallelRemoveNoPhysicsNoSimulate2", "False")
                                until t:FindFirstChild("HumanoidRootPart") or not Info.BossFarm
                                curTween.Completed:Wait()
                            end
                        end
                    end
    
                    for _,npc in pairs(Mobs:GetDescendants()) do
                        if npc:IsA("Model") and npc.Name == Info.NPC then
                            local t = require(npc.Parent["Npc_Configuration"])
                            t.Cancel_All_Skills(true)
                            local combat = function()
                                if not Info.BossFarm then return end
                                if Info.Weapon == "Sword" then
                                    for i,t in pairs(Creator.Backpack:GetDescendants()) do
                                        if t.Name == "SwordIsEquiped" then
                                            t.Parent.Parent = Creator.Character
                                        end
                                    end
                                    local args = {
                                        [1] = "Sword_Combat_Slash",
                                        [2] = Creator,
                                        [3] = Creator.Character,
                                        [4] = Creator.Character:FindFirstChild("HumanoidRootPart"),
                                        [5] = Creator.Character:FindFirstChild("Humanoid"),
                                        [6] = 1
                                    }
                                
                                    for i = 0, 14 do
                                        game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S_:InvokeServer(unpack(args))
                                    end
                
                                    repeat tp(npc:FindFirstChild("HumanoidRootPart").CFrame, CFrame.new(0, 0, -45) * CFrame.Angles(0, math.rad(180), 0))
                                        task.wait() until Creator:FindFirstChild("combotangasd123").Value <= 0
                                end
    
                                if Info.Weapon == "Fists" then
                                    if Creator.Backpack:FindFirstChild("Combat") then
                                        Creator.Backpack.Combat.Parent = Creator.Character                       
                                    end
    
                                    local args = {
                                        [1] = "fist_combat",
                                        [2] = Creator,
                                        [3] = Creator.Character,
                                        [4] = Creator.Character:FindFirstChild("HumanoidRootPart"),
                                        [5] = Creator.Character:FindFirstChild("Humanoid"),
                                        [6] = 1
                                    }
                                
                                    for i = 0, 14 do
                                        game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S_:InvokeServer(unpack(args))
                                    end
    
                                    repeat  tp(npc:FindFirstChild("HumanoidRootPart").CFrame, CFrame.new(0, 0, -45) * CFrame.Angles(0, math.rad(180), 0))
                                        task.wait() until Creator:FindFirstChild("combotangasd123").Value <= 0
                                end
                            end
                            
                            task.spawn(function()
                                if Creator.Character:FindFirstChild("Humanoid") then
                                    Creator.Character:FindFirstChild("Humanoid"):ChangeState(11)
                                end
    
                                local v = 0
                                function aTP()
                                    pcall(function()
                                        if npc:FindFirstChild("HumanoidRootPart") and npc:FindFirstChild("Humanoid") then
                                            if npc:FindFirstChild("Humanoid").FloorMaterial ~= Enum.Material.Air then
                                                tp(npc:FindFirstChild("HumanoidRootPart").CFrame, CFrame.new(0, 0, -3) * CFrame.Angles(0, math.pi, 0))
                                                for x = 0, 354, 6 do
                                                    task.wait()
                                                    local Orient = npc:FindFirstChild("HumanoidRootPart").CFrame * CFrame.Angles(0,math.rad(x),0)
                                                    local Facing = CFrame.lookAt(npc:FindFirstChild("HumanoidRootPart").CFrame.Position, Creator.Character.HumanoidRootPart.CFrame.Position)
                                                    local NewCF = npc:FindFirstChild("HumanoidRootPart").CFrame + ((Orient.LookVector * 4.5) + Vector3.new(0,0, 0))
                                                    tp(NewCF * CFrame.Angles(0, math.rad(x), 0) * CFrame.Angles(0, math.rad(180), 0))
                                                end
                                                setfflag("HumanoidParallelRemoveNoPhysics", "False")
                                                setfflag("HumanoidParallelRemoveNoPhysicsNoSimulate2", "False")
                                            end
                                        end
                                    end) 
                                end
    
                                repeat aTP()
                                    task.wait()
                                until npc.Humanoid.Health == 0 or not Info.BossFarm
                            end)
                            local succ,err = pcall(function()
                                repeat
                                    combat()
                                    task.wait()
                                until npc.Humanoid.Health == 0 or not Info.BossFarm
                            end)
    
                            if succ or err then
                                repeat task.wait() until isSpawned() == true and Creator.PlayerGui["localscript_cache"]["Game_Play"]["Humanoid_Changer"].HeartBeat.Playing == false
                                or not Info.BossFarm
                                setfflag("HumanoidParallelRemoveNoPhysics", "True")
                                setfflag("HumanoidParallelRemoveNoPhysicsNoSimulate2", "True")
                            end
                        end
                    end
                end
    
                if Info.FF then
                    local log = workspace:FindFirstChild("punchinglogs"):FindFirstChild("Log"):FindFirstChild("HumanoidRootPart")
                    tp(log.CFrame, CFrame.new(0, 0, 2))
                    curTween.Completed:Wait()
    
                    local args = {
                        [1] = "fist_combat",
                        [2] = Creator,
                        [3] = Creator.Character,
                        [4] = Creator.Character:FindFirstChild("HumanoidRootPart"),
                        [5] = Creator.Character:FindFirstChild("Humanoid"),
                        [6] = 1
                    }
                
                    for i = 0, 15 do
                        game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S_:InvokeServer(unpack(args))
                    end
    
                    repeat
                        task.wait() until Creator:FindFirstChild("combotangasd123").Value <= 0
                end
    
                if Info.LF then
            
                    repeat task.wait() until Creator.PlayerGui["localscript_cache"]["Game_Play"]["Humanoid_Changer"].HeartBeat.Playing == false
    
                    task.spawn(function()
                        for _,t in pairs(workspace["Demon_Flowers_Spawn"]:GetChildren()) do
                            if t:FindFirstChild("Cube.002") then
                                tp(t:FindFirstChildWhichIsA("MeshPart").CFrame)
                                curTween.Completed:Wait()
                                task.wait(1.5)
                                VU:SetKeyDown("0x65")
                                task.wait(0.5)
                                VU:SetKeyUp("0x65")
                            end
                        end
                    end)
                end
    
                if Info.AutoLoot then
                    repeat task.wait() until Creator.PlayerGui["localscript_cache"]["Game_Play"]["Humanoid_Changer"].HeartBeat.Playing == false
                    task.spawn(function()
                        repeat task.wait()
                            local toLoot = workspace.Debree:FindFirstChild("Loot_Chest")
                            if toLoot ~= nil then
                                local m = {}
        
                                for i,v in pairs(toLoot.Drops:GetChildren()) do
                                    if v:IsA("StringValue") then table.insert(m, v.Name) end
                                end
                                
                                for _,drops in pairs(m) do
                                    local v, s = pcall(function()
                                        repeat toLoot.Add_To_Inventory:InvokeServer(drops)
                                        until not toLoot.Drops:FindFirstChild(drops)
                                    end)
                                    if v and not s then
                                        notify("Luna Client", "you recieved " .. drops, 5)
                                    end
                                end
                            end
                        until not Info.AutoLoot
                    end)
                end
                if Info.FishFarm then
    
    
                    tp(CFrame.new(673.92218, 284.574951, -2757.46191))
                    curTween.Completed:Wait()
    
                    if Creator.Character:FindFirstChild("Fishing Rod") then
                        Creator.Character:FindFirstChild("Fishing Rod").Parent = Creator.Backpack
                        task.wait(.5)
                    end
    
                    local t = Creator.Backpack["Fishing Rod"]["Fishing_Rod_Shcrip"]["Fish_Minigame"].Holder.LocalScript:FindFirstChild("Value")
                    if t then t:Destroy() end
                    task.wait(0.15)
                    local new = Instance.new("IntConstrainedValue")
                    new.Name = "Value"
                    new.MaxValue = 100
                    new.Value = 97
                    new.Parent = Creator.Backpack["Fishing Rod"]["Fishing_Rod_Shcrip"]["Fish_Minigame"].Holder.LocalScript
    
                    local rod = Creator.Backpack:FindFirstChild("Fishing Rod")
                    rod.Parent = Creator.Character
    
                    task.wait(.45)
                    while Info.FishFarm do
                        if Info.FishFarm then
                            Info.FishCount = Info.FishCount + 1
                            print(Info.FishCount)
                            tp(CFrame.new(673.92218, 284.574951, -2757.46191))
                            curTween.Completed:Wait()
                            task.wait(.15)
                            VU:ClickButton1(VUCA[1], VUCA[2])
                            task.wait(.35)
                            local fishGame = getsenv(Creator.Character["Fishing Rod"]["Fishing_Rod_Shcrip"])
                            fishGame.Start_Fish_Minigame()
                            task.wait(.5)
                            repeat task.wait(.15)
                                for i,v in pairs(workspace[Creator.Name]:GetChildren()) do
                                    if v.Name == "fishgcooldown123123" then v:Destroy() end
                                end
    
                                repeat Creator.PlayerGui["Fish_Minigame"].Holder.Slide.SliderBar.Goal.Size = UDim2.new(1,0,1,0)
                                    Creator.PlayerGui["Fish_Minigame"].Holder.Slide.SliderBar.Goal.Position = UDim2.new(.5,0,.5,0)
                                        task.wait()
                                until collidesWith(Creator.PlayerGui["Fish_Minigame"].Holder.Slide.SliderBar.Goal, Creator.PlayerGui["Fish_Minigame"].Holder.Slide.SliderBar.Bar)
                                for _,t in pairs(getconnections(Creator.PlayerGui:FindFirstChild("Fish_Minigame").Holder.Slide.Button.MouseButton1Click)) do
                                    t.Function()
                                    task.wait(0.05)
                                end
                            until Creator.PlayerGui:FindFirstChild("Fish_Minigame") == nil
                            local fishGame = getsenv(Creator.Character["Fishing Rod"]["Fishing_Rod_Shcrip"])
                            task.wait()
                            fishGame.Stop_Fishing()
                            task.wait(.35)
                            VU:SetKeyDown("0x65")
                            task.wait(.15)
                            VU:SetKeyUp("0x65")
                            task.wait(.15)
    
                            FishLabel.SetText("Fish Farmed: " .. tostring(Info.FishCount))
                        end
                        task.wait()
                    end
                end
    
                if Info.FarmAll then
                    repeat task.wait() until Creator.PlayerGui["localscript_cache"]["Game_Play"]["Humanoid_Changer"].HeartBeat.Playing == false
                    
                    local mob = ""
                    local t = {"Giyu", "Sabito", "Zanegutsu Kuuchie", "Shiron", "Nezuko", "Sanemi", "Bandit Zoku", "Susamaru", "Yahaba", "Slasher", "Bandit Kaden"}
                    local Mobs = workspace.Mobs
    
                    for j,k in pairs(t) do
                        for i,o in pairs(Mobs:GetDescendants()) do
                            if o.Name == k and o:FindFirstChild("Humanoid") then
                                mob = o.Name
                            end
                        end
    
                        task.wait(1)
                        for _,t in pairs(Mobs:GetDescendants()) do
                            if t:IsA("Model") and t.Name == mob and Info.FarmAll then
                                repeat task.wait()
                                tp(CFrame.new(t:FindFirstChild('Humanoid').WalkToPoint))
                                setfflag("HumanoidParallelRemoveNoPhysics", "False")
                                setfflag("HumanoidParallelRemoveNoPhysicsNoSimulate2", "False")
                                until t:FindFirstChild("HumanoidRootPart") or not Info.FarmAll
                                curTween.Completed:Wait()
                            end
                        end
        
                        for _,npc in pairs(Mobs:GetDescendants()) do
                            if npc:IsA("Model") and npc.Name == mob and Info.FarmAll then
                                local combat = function()
                                    if not Info.FarmAll then return end
                                    if Info.Weapon == "Sword" then
                                        for i,t in pairs(Creator.Backpack:GetDescendants()) do
                                            if t.Name == "SwordIsEquiped" then
                                                t.Parent.Parent = Creator.Character
                                            end
                                        end
                                        local args = {
                                            [1] = "Sword_Combat_Slash",
                                            [2] = Creator,
                                            [3] = Creator.Character,
                                            [4] = Creator.Character:FindFirstChild("HumanoidRootPart"),
                                            [5] = Creator.Character:FindFirstChild("Humanoid"),
                                            [6] = 1
                                        }
                                    
                                        for i = 0, 15 do
                                            game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S_:InvokeServer(unpack(args))
                                        end
                    
                                        repeat tp(npc:FindFirstChild("HumanoidRootPart").CFrame, CFrame.new(0, 0, -45) * CFrame.Angles(0, math.rad(180), 0))
                                            task.wait() until Creator:FindFirstChild("combotangasd123").Value <= 0
                                    end
        
                                    if Info.Weapon == "Fists" then
                                        if Creator.Backpack:FindFirstChild("Combat") then
                                            Creator.Backpack.Combat.Parent = Creator.Character                       
                                        end
    
                                        local args = {
                                            [1] = "fist_combat",
                                            [2] = Creator,
                                            [3] = Creator.Character,
                                            [4] = Creator.Character:FindFirstChild("HumanoidRootPart"),
                                            [5] = Creator.Character:FindFirstChild("Humanoid"),
                                            [6] = 1
                                        }
                                    
                                        for i = 0, 15 do
                                            game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S_:InvokeServer(unpack(args))
                                        end
    
                                        repeat  tp(npc:FindFirstChild("HumanoidRootPart").CFrame, CFrame.new(0, 0, -45) * CFrame.Angles(0, math.rad(180), 0))
                                            task.wait() until Creator:FindFirstChild("combotangasd123").Value <= 0
                                    end
                                end
                                
                                task.spawn(function()
                                    if Creator.Character:FindFirstChild("Humanoid") then
                                        Creator.Character:FindFirstChild("Humanoid"):ChangeState(11)
                                    end
    
    
                                    function aTP()
                                        if npc:FindFirstChild("HumanoidRootPart") and npc:FindFirstChild("Humanoid") then
                                            if npc:FindFirstChild("Humanoid").FloorMaterial ~= Enum.Material.Air then
                                                tp(npc:FindFirstChild("HumanoidRootPart").CFrame, CFrame.new(0, 0, -3) * CFrame.Angles(0, math.rad(180), 0))
                                                setfflag("HumanoidParallelRemoveNoPhysics", "False")
                                                setfflag("HumanoidParallelRemoveNoPhysicsNoSimulate2", "False")
                                            end
                                        end
                                    end
        
                                    repeat aTP()
                                        task.wait()
                                    until npc.Humanoid.Health == 0 or not Info.FarmAll
                                end)
                                local succ,err = pcall(function()
                                    repeat
                                        combat()
                                        task.wait()
                                    until npc.Humanoid.Health == 0 or not Info.FarmAll
                                end)
        
                                if succ or err then
                                    repeat task.wait() until Creator.PlayerGui["localscript_cache"]["Game_Play"]["Humanoid_Changer"].HeartBeat.Playing == false
                                    or not Info.FarmAll
                                    setfflag("HumanoidParallelRemoveNoPhysics", "True")
                                    setfflag("HumanoidParallelRemoveNoPhysicsNoSimulate2", "True")
                                end
                            end
                        end
                    end
                end
    
                if Info.Meditate then
                    local p,t = pcall(function()
                        repeat task.wait()
                            tp(CFrame.new(2872.69995, 316.985046, -3919.52515))

                            for i,v in pairs(game:GetService("Workspace").Map:GetDescendants()) do
                                if v.Name == "Meditate_Mat" and not v:FindFirstChild("CancelDetection") then
                                    tp(v.CFrame)
                                    setfflag("HumanoidParallelRemoveNoPhysics", "False")
                                    setfflag("HumanoidParallelRemoveNoPhysicsNoSimulate2", "False")
                                    curTween.Completed:Wait()
                                    break
                                end
                            end
                            repeat VU:SetKeyDown("0x65")
                                task.wait(.3)
                                VU:SetKeyUp("0x65")
                                task.wait() until Creator.PlayerGui.ExcessGuis:FindFirstChild("Meditate_gui") or not Info.Meditate
                            local v,t = pcall(function()
                                repeat task.wait()                            
                                    repeat Creator.PlayerGui.ExcessGuis["Meditate_gui"].Holder.Slide.SliderBar.Goal.Size = UDim2.new(1,0,1,0)
                                        Creator.PlayerGui.ExcessGuis["Meditate_gui"].Holder.Slide.SliderBar.Goal.Position = UDim2.new(.5,0,.5,0)
                                         task.wait()
                                         until
                                    collidesWith(Creator.PlayerGui.ExcessGuis["Meditate_gui"].Holder.Slide.SliderBar.Goal,
                                    Creator.PlayerGui.ExcessGuis["Meditate_gui"].Holder.Slide.SliderBar.Bar) or not Info.Meditate
                                    for i,v in pairs(cEvents) do
                                        for _,t in pairs(getconnections(
                                            Creator.PlayerGui.ExcessGuis["Meditate_gui"].Holder.Slide.Button[v]
                                        )) do
                                            t.Function()
                                            task.wait(.25)
                                        end
                                    end
                                until not Creator.PlayerGui.ExcessGuis:FindFirstChild("Meditate_gui") or not Info.Meditate
                            end)
        
                            if not v and t then break end
        
                            if v and not t then break end
        
                        until not Info.Meditate
                    end)
                    if t then print(t) end
                end
            end)
        end
    end)
end

task.spawn(function()
    local Namecall
    Namecall = hookmetamethod(game, '__namecall', function(self, ...)
    local Args = {...}
    
    if getnamecallmethod() == 'FireServer' and tostring(self) == 'moddelteasdasd123' then
        return
    elseif getnamecallmethod() == 'FireServer' and tostring(self) == 'moddelteasdasd1232' then
        return
    elseif getnamecallmethod() == 'InvokeServer' and tostring(self) == 'reporthackerasdasd' then
        return
    elseif getnamecallmethod() == 'FireServer' and tostring(self) == 'To_Server_commends' then
        if Args[1] == 'set_platform_stand' then
            return
        end
    elseif string.lower(getnamecallmethod()) == 'kick' then
        return
    end
    
    return Namecall(self, ...)
    end)

    local Index

    Index = hookmetamethod(game, '__index', function(self, key)
    
    if key == 'WalkSpeed' then
        self.WalkSpeed = Info.WalkSpeed
        return 16
    end
    
    return Index(self, key)
    end)
end)

game.Players.LocalPlayer.CharacterAdded:Connect(function()
    task.wait(3)
    Main()
end)

Main()