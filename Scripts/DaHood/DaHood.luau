local Info = {}

Info.cashPickup = false
Info.shoeClean = false
Info.cashierFarm = false
Info.aimbot = false
Info.spectate = false
Info.aimbotclosest = false
Info.hospitalFarm = false
Info.attach = false
Info.spin = false
Info.iflow = false

repeat task.wait() until game:IsLoaded()

_G.range = 20
_G.playerinput = nil
_G.aimbotplayer = nil
_G.farmwait = 4
_G.cashwait = 3
_G.closestplr = nil
_G.walkspeed = 70
_G.minhealth = 10

function notify(Title, Text, Time)
    game.StarterGui:SetCore("SendNotification", {
        Title = Title;
        Text = Text;
        Duration = Time
    })
end

spawn(function ()
    while wait() do
        repeat task.wait()
            repeat task.wait() until game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
            game.Players.LocalPlayer.Character:FindFirstChild("Humanoid").Name = "Humz"
        until false == true
    end
end)

task.wait(1)
local humanoid = game.Players.LocalPlayer.Character.Humz

notify("Luna Client", "Script is in BETA, expect bugs.", 15)

local LP = game.Players.LocalPlayer
local Root = LP.Character.HumanoidRootPart
local VU = game:GetService("VirtualUser")
local tool = game.Players.LocalPlayer.Backpack.Combat
local UIS = game.UserInputService
local camera = game.workspace.CurrentCamera
local cam = workspace.CurrentCamera
local GameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name

local TS = game.TweenService
local tweenInfo = TweenInfo.new(0.25)

local UI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/MaterialLua/master/Module.lua"))()
local X = UI.Load({
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
        ChipSet = Color3.fromRGB(61, 62, 67),
        DataTable = Color3.fromRGB(61, 62, 67),
        Slider = Color3.fromRGB(61, 62, 67),
        Dropdown = Color3.fromRGB(61, 62, 67),
        ColorPicker = Color3.fromRGB(61, 62, 67),
        TextField = Color3.fromRGB(61, 62, 67),
        Content = Color3.fromRGB(25, 25, 25),
    }
})

local Credit = X.New({
	Title = "Credits"
})

local Farm = X.New({
	Title = "Money"
})

local Target = X.New({
	Title = "Target"
})

local PVP = X.New({
	Title = "PVP"
})

local Misc = X.New({
	Title = "Local"
})

local TP = X.New({
	Title = "Teleports"
})

local Buy = X.New({
	Title = "Buy"
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

Farm.Label({
    Text = "Automatic"
})

Farm.Toggle({
    Text = "Auto Collect Drop Cash",
    Callback = function(bool)
        Info.cashPickup = bool
    end
})

Farm.Toggle({
    Text = "Shoe Clean Farm",
    Callback = function(bool)
        Info.shoeClean = bool
    end
})

Farm.Toggle({
    Text = "Cashier Farm",
    Callback = function(bool)
        Info.cashierFarm = bool
    end
})

Farm.Toggle({
    Text = "Hospital Farm",
    Callback = function(bool)
        Info.hospitalFarm = bool
    end
})

Farm.Label({
    Text = "Manual"
})

Farm.Button({
	Text = "Get Money (x1)",
	Callback = function()
		getMoneyAroundMe(_G.range) 
	end,
})

Farm.Slider({
	Text = "Get Money Distance",
	Callback = function(a)
		_G.range = a
	end,
	Min = 5,
	Max = 2000,
	Def = 20
})

Farm.Button({
	Text = "Check for Dropped Money",
	Callback = function()
        local drop = game.Workspace.Ignored.Drop:FindFirstChild("MoneyDrop")
        if drop then
		    notify("Luna Client", "Found!", "3")
        else
            notify("Luna Client", "No money found.", "3")
        end
	end,
})

Farm.Label({
    Text = "Wait Time"
})

Farm.Slider({
	Text = "Cash Collect Wait (may kick if below 3)",
	Callback = function(a)
		_G.cashwait = a
	end,
	Min = 1,
	Max = 10,
	Def = 3
})

Farm.Slider({
	Text = "Cashier Farm Wait",
	Callback = function(a)
		_G.farmwait = a
	end,
	Min = 0,
	Max = 10,
	Def = 3
})


Target.Label({
    Text = "Player Target"
})

Target.TextField({
	Text = "Player Input",
	Callback = function(Value)
		_G.playerinput = Value
	end,
})

Target.Button({
	Text = "Check Money",
	Callback = function()
        local money = game.Players[_G.playerinput].DataFolder.Currency.Value
		notify("Luna Client", tostring(money), "3")
	end,
})

Target.Button({
	Text = "Check Bounty",
	Callback = function()
        local bounty = game.Players[_G.playerinput].DataFolder.Information.Wanted.Value
		notify("Luna Client", bounty, "3")
	end,
})

Target.Button({
	Text = "Teleport To",
	Callback = function()
        Root.CFrame = game.Players[_G.playerinput].Character.HumanoidRootPart.CFrame
	end,
})

Target.Button({
	Text = "Check Crew",
	Callback = function()
        local crew = game.Players[_G.playerinput].DataFolder.Information.Crew.Value
        if crew then
            notify("Luna Client", tostring(crew), "3")
        else
            notify("Luna Client", "User not in crew.", "3")
        end
	end,
})

Target.Toggle({
    Text = "Spectate Player",
    Callback = function(bool)
        Info.spectate = bool
    end
})

Target.Toggle({
    Text = "Attach to Player",
    Callback = function(bool)
        Info.attach = bool
    end
})

PVP.TextField({
	Text = "Player Input",
	Callback = function(Value)
		_G.aimbotplayer = Value
	end,
})

PVP.Toggle({
    Text = "Hitbox Expander",
    Callback = function(bool)
        Info.aimbot = bool
        notify("Luna Client", "This is a work in Progress, expect bugs", 3)
    end
})

PVP.Toggle({
    Text = "Spin bot",
    Callback = function(bool)
        Info.spin = bool
    end
})

PVP.Label({
    Text = "Auto Save"
})

PVP.Toggle({
    Text = "Auto Save Player (TP to admin base)",
    Callback = function(bool)
        Info.iflow = bool
    end
})

PVP.Slider({
	Text = "Minimum Health to Save",
	Callback = function(a)
		_G.minhealth = a
	end,
	Min = 1,
	Max = 100,
	Def = 10
})

local ESP = loadstring(game:HttpGet("https://aerosoftworks.tk/uilib/esp.lua"))()
ESP:Toggle(true)

ESP.Tracers = false
ESP.Names = false
ESP.Boxes = false

PVP.Label({
    Text = "All Players"
})

PVP.Toggle({
    Text = "Box ESP",
    Callback = function(bool)
        ESP.Boxes = bool
    end
})
PVP.Toggle({
    Text = "Name ESP",
    Callback = function(bool)
        ESP.Names = bool
    end
})
PVP.Toggle({
    Text = "Tracers ESP",
    Callback = function(bool)
        ESP.Tracers = bool
    end
})

Misc.Label({
    Text = "Functions"
})


Misc.Label({
    Text = "Local Player"
})

Misc.Slider({
	Text = "Walkspeed",
	Callback = function(value)
		game.Players.LocalPlayer.Character.Humz.WalkSpeed = tonumber(value)
	end,
	Min = 12,
	Max = 200,
	Def = 16
})

Misc.Slider({
	Text = "Jumppower",
	Callback = function(value)
        game.Players.LocalPlayer.Character.Humz.JumpPower = tonumber(value)
	end,
	Min = 12,
	Max = 200,
	Def = 16
})

Misc.Slider({
	Text = "FOV",
	Callback = function(a)
        workspace.CurrentCamera.FieldOfView = a
	end,
	Min = 10,
	Max = 120,
	Def = 70
})

Misc.Button({
	Text = "Reset",
	Callback = function()
		game.Players.LocalPlayer.Character.Humz:Destroy()
	end,
})

Misc.Toggle({
    Text = "Anti AFK",
    Callback = function(bool)
        Info.antiafk = bool
    end
})

Misc.Button({
	Text = "Full Bright",
	Callback = function()
        game.Lighting.OutdoorAmbient = Color3.new(1,1,1)
        game.Lighting.Ambient = Color3.new(1,1,1)
	end,
})

TP.Label({
    Text = "Shops"
})

TP.Button({
	Text = "Barber Shop",
	Callback = function()
        Root.CFrame = CFrame.new(3.63884258, 21.9748363, -91.8015442, 0.999191642, -1.66254441e-08, -0.04019963, 1.81509989e-08, 1, 3.75844742e-08, 0.04019963, -3.82837584e-08, 0.999191642)
	end,
})

TP.Button({
	Text = "Gun Store [UP]",
	Callback = function()
        Root.CFrame = CFrame.new(482.865479, 48.0704994, -621.338013, 0.999981463, 5.89660019e-08, -0.00608461862, -5.86669024e-08, 1, 4.93350569e-08, 0.00608461862, -4.89771779e-08, 0.999981463)
	end,
})

TP.Button({
	Text = "Gun Store [DOWN]",
	Callback = function()
        Root.CFrame = CFrame.new(-579.433167, 8.31478119, -736.050354, 0.0173828639, -6.35812896e-08, 0.999848902, -8.55640891e-09, 1, 6.37396553e-08, -0.999848902, -9.66309432e-09, 0.0173828639)
	end,
})

TP.Button({
	Text = "Da Furniture",
	Callback = function()
        Root.CFrame = CFrame.new(-489.72525, 22.0746899, -110.472885, -0.99974966, -2.33559501e-08, 0.0223737396, -2.24933423e-08, 1, 3.88061245e-08, -0.0223737396, 3.82931518e-08, -0.99974966)
	end,
})

TP.Button({
	Text = "Food Store [UP]",
	Callback = function()
        Root.CFrame = CFrame.new(298.165924, 49.5074959, -611.742981, 0.999200821, -3.62860746e-08, -0.0399710536, 3.47456606e-08, 1, -3.92329866e-08, 0.0399710536, 3.78128107e-08, 0.999200821)
	end,
})

TP.Button({
	Text = "Food Store [DOWN]",
	Callback = function()
        Root.CFrame = CFrame.new(-337.224152, 23.682642, -297.98642, -0.0249029286, 1.03975886e-07, -0.999689877, -2.29223041e-08, 1, 1.04579151e-07, 0.999689877, 2.55195225e-08, -0.0249029286)
	end,
})

TP.Button({
	Text = "Taco Shop",
	Callback = function()
        Root.CFrame = CFrame.new(588.73114, 51.0613976, -479.001678, 0.0109467916, 6.14128908e-08, 0.999940097, -3.85843961e-08, 1, -6.09941679e-08, -0.999940097, -3.79143934e-08, 0.0109467916)
	end,
})

TP.Label({
    Text = "Imporant"
})

TP.Button({
	Text = "Bank",
	Callback = function()
        Root.CFrame = CFrame.new(-379.857635, 21.4748344, -289.037323, 0.146452963, 2.22251693e-08, -0.989217639, -2.6644809e-08, 1, 1.85226767e-08, 0.989217639, 2.36448141e-08, 0.146452963)
	end,
})

TP.Button({
	Text = "Police Station",
	Callback = function()
        Root.CFrame = CFrame.new(-269.106567, 21.2555904, -135.809708, 0.911676824, 9.49020347e-08, -0.410908014, -1.05778653e-07, 1, -3.73297837e-09, 0.410908014, 4.68685641e-08, 0.91167682)
	end,
})

TP.Button({
	Text = "Fire Station",
	Callback = function()
        Root.CFrame = CFrame.new(-153.364517, 22.8094635, -86.8483963, 0.997448623, -3.36726202e-08, -0.0713882819, 3.12239941e-08, 1, -3.54160505e-08, 0.0713882819, 3.30966614e-08, 0.997448623)
	end,
})

TP.Button({
	Text = "Gas Station",
	Callback = function()
        Root.CFrame = CFrame.new(586.085205, 49.0000343, -258.449982, 0.999689043, 1.82069577e-08, -0.0249373373, -1.87209679e-08, 1, -2.03786144e-08, 0.0249373373, 2.08391278e-08, 0.999689043)
	end,
})

TP.Button({
	Text = "Hospital",
	Callback = function()
        Root.CFrame = CFrame.new(100.748314, 22.7999916, -484.854553, 0.999924064, 1.00337864e-07, -0.0123256706, -1.0055772e-07, 1, -1.72178005e-08, 0.0123256706, 1.84559337e-08, 0.999924064)
	end,
})

TP.Button({
	Text = "Shack",
	Callback = function()
        Root.CFrame = CFrame.new(-963.012817, -0.984459043, 468.56781, 0.052499827, -5.92205538e-08, 0.998620927, -5.73583456e-08, 1, 6.23178025e-08, -0.998620927, -6.05509172e-08, 0.052499827)
	end,
})

TP.Button({
	Text = "Hood Fitness",
	Callback = function()
        Root.CFrame = CFrame.new(-76.8513947, 22.700285, -633.783508, -0.999792516, -9.12269726e-09, -0.0203705374, -1.08173737e-08, 1, 8.30823339e-08, 0.0203705374, 8.32854568e-08, -0.999792516)
	end,
})

TP.Label({
    Text = "Others"
})

TP.Button({
	Text = "Basketball Court",
	Callback = function()
        Root.CFrame = CFrame.new(-932.058472, 22.0998154, -482.237854, -0.0351893641, 6.41250537e-08, -0.999380648, -1.6662522e-08, 1, 6.47515037e-08, 0.999380648, 1.89307663e-08, -0.0351893641)
	end,
})

TP.Button({
	Text = "Safe Zone",
	Callback = function()
        Root.CFrame = CFrame.new(207.48085, 38.2499886, 200014.953, -0.127381414, -2.49513921e-08, -0.991853833, -2.44039033e-09, 1, -2.48429082e-08, 0.991853833, -7.44014184e-10, -0.127381414)
	end,
})

TP.Button({
	Text = "Church",
	Callback = function()
        Root.CFrame = CFrame.new(205.625854, 23.779995, -25.5319176, -0.999776602, 3.1097968e-11, 0.0211373959, -1.33374412e-09, 1, -6.45559268e-08, -0.0211373959, -6.456969e-08, -0.999776602)
	end,
})

TP.Button({
	Text = "Grave Yard",
	Callback = function()
        Root.CFrame = CFrame.new(185.998535, 21.7499924, 54.8304405, -0.782208681, 1.66606124e-08, 0.623016536, -5.37361515e-08, 1, -9.42085734e-08, -0.623016536, -1.07169271e-07, -0.782208681)
	end,
})


TP.Button({
	Text = "Admin Lair",
	Callback = function()
        Root.CFrame = CFrame.new(-798.345764, -39.6492119, -885.242859, -0.00473513454, 6.98227538e-08, -0.999988794, -3.84332068e-08, 1, 7.00055267e-08, 0.999988794, 3.87642594e-08, -0.00473513454)
	end,
})

TP.Button({
	Text = "Nuclear Bunker",
	Callback = function()
        Root.CFrame = CFrame.new(-116.703949, -58.7000732, 146.875168, 0.999750376, 1.96359693e-08, -0.0223431978, -2.05828172e-08, 1, -4.21474446e-08, 0.0223431978, 4.25968096e-08, 0.999750376)
	end,
})

TP.Button({
	Text = "Park",
	Callback = function()
        Root.CFrame = CFrame.new(367.941132, 50.4392738, -404.56369, -0.999737203, 4.27645936e-08, -0.0229253825, 4.22134185e-08, 1, 2.45261109e-08, 0.0229253825, 2.35519053e-08, -0.999737203)
	end,
})


TP.Button({
	Text = "Train Station",
	Callback = function()
        Root.CFrame = CFrame.new(-427.225464, -21.2500057, 58.0802917, -0.999932408, 5.97070766e-08, -0.0116241518, 5.95162888e-08, 1, 1.67588112e-08, 0.0116241518, 1.60658526e-08, -0.999932408)
	end,
})


TP.Button({
	Text = "UFO",
	Callback = function()
        Root.CFrame = CFrame.new(80.4460602, 138.999954, -660.823181, 0.965562284, -2.49735987e-09, 0.260172009, 2.82072179e-08, 1, -9.50850421e-08, -0.260172009, 9.91492541e-08, 0.965562284)
	end,
})

TP.Button({
	Text = "Casino",
	Callback = function()
        Root.CFrame = CFrame.new(-889.272949, 21.7499981, -129.234467, 0.999749124, 4.51521736e-08, -0.0223995075, -4.36966623e-08, 1, 6.54690666e-08, 0.0223995075, -6.44738591e-08, 0.999749124)
	end,
})



Buy.Label({
    Text = "Weapons"
})

Buy.Dropdown({
    Text = "Select Gun",
    Callback = function(Value)
        _G.selectedgun = Value
    end,
    Options = {
        "[TacticalShotgun] - $1750",
        "[P90] - $1000",
        "[AUG] - $1950",
        "[AR] - $1000",
        "[Revolver] - $1300",
        "[LMG] - $3750",
        "[Double-Barrel SG] - $1400",
        "[RPG] - $20000",
        "[RPG] - $6000",
        "[SMG] - $750",
        "[Flamethrower] - $25000",
        "[AK47] - $2250",
        "[Glock] - $300",
        "[Glock] - $500",
        "[GrenadeLauncher] - $10000",
        "[AR] - $1000",
        "[Shotgun] - $1250",
        "[Taser] - $1000",
        "[DrumGun] - $3000",
        "[Money Gun] - $777",
    },
})

Buy.Button({
	Text = "Buy Item",
	Callback = function()
        buyGun(_G.selectedgun)
	end,
})

Buy.Label({
    Text = "-"
})

Buy.Dropdown({
    Text = "Select Attachments / Ammo",
    Callback = function(Value)
        _G.selectedattachment = Value
    end,
    Options = {
        "20 [TacticalShotgun Ammo] - $60",
        "120 [P90 Ammo] - $60",
        "90 [AUG Ammo] - $80",
        "30 [Glock Ammo] - $60",
        "100 [AR Ammo] - $75",
        "12 [Revolver Ammo] - $75",
        "200 [LMG Ammo] - $300",
        "20 [Shotgun Ammo] - $60",
        "25 [Silencer Ammo] - $50",
        "18 [Double-Barrel SG Ammo] - $60",
        "5 [RPG Ammo] - $1000",
        "140 [Flamethrower Ammo] - $1550",
        "90 [AK47 Ammo] - $80",
        "80 [SMG Ammo] - $60",
        "12 [GrenadeLauncher Ammo] - $3000",
        "100 [DrumGun Ammo] - $200",
        "[Flashbang] - $550",
        "[Grenade] - $700",
        "[Silencer] - $400",
        "[SilencerAR] - $1250",
    },
})

Buy.Button({
	Text = "Buy Attachment / Ammo",
	Callback = function()
        buyGun(_G.selectedattachment)
	end,
})

Buy.Label({
    Text = "-"
})

Buy.Dropdown({
    Text = "Melee",
    Callback = function(Value)
        _G.selectedmelee = Value
    end,
    Options = {
        "[Knife] - $150",
        "[PepperSpray] - $75",
        "[LockPicker] - $125",
        "[Bat] - $275",
        "[Bat] - $250",
        "[Pitchfork] - $320",
        "[SledgeHammer] - $350",
        "[Flashlight] - $10",
        "[StopSign] - $300",
        "[Nunchucks] - $450",
        "[Shovel] - $320",
    },
})

Buy.Button({
	Text = "Buy Melee Item",
	Callback = function()
        buyGun(_G.selectedmelee)
	end,
})

Buy.Label({
    Text = "Other"
})

Buy.Dropdown({
    Text = "Armour / Clothing",
    Callback = function(Value)
        _G.selectedarmour = Value
    end,
    Options = {
        "[Medium Armor] - $1000",
        "[Ninja Mask] - $60",
        "[Surgeon Mask] - $25",
        "[Riot Mask] - $60",
        "[Bat] - $250",
        "[Pitchfork] - $320",
        "[Hockey Mask] - $60",
        "[Breathing Mask] - $60",
        "[Skull Mask] - $60",
        "[Nunchucks] - $450",
        "[Shovel] - $320",
        "[Paintball Mask] - $60",
    },
})

Buy.Button({
	Text = "Buy Armour / Clothing",
	Callback = function()
        buyGun(_G.selectedarmour)
	end,
})

Buy.Label({
    Text = "-"
})

Buy.Dropdown({
    Text = "Food",
    Callback = function(Value)
        _G.selectedfood = Value
    end,
    Options = {
        "[Cranberry] - $3",
        "[Taco] - $2",
        "[Hamburger] - $5",
        "[Lemonade] - $3",
        "[Popcorn] - $7",
        "[Chicken] - $7",
        "[Pizza] - $5",
        "[Donut] - $5",
        "[HotDog] - $8",
    },
})

Buy.Button({
	Text = "Buy Selected Food",
	Callback = function()
        buyGun(_G.selectedfood)
	end,
})



-- Functions

function tweento(pathname, timetaken)
    tweenService, tweenInfo = game:GetService("TweenService"), TweenInfo.new(timetaken, Enum.EasingStyle.Linear)
    tween = tweenService:Create(game:GetService("Players")["LocalPlayer"].Character.HumanoidRootPart, tweenInfo, {CFrame = CFrame.new(pathname.Position)})
    tween:Play()
end

function getMoneyAroundMe(studs) 
    spawn(function()
        wait(0.5)
        local drop = game.Workspace.Ignored.Drop:FindFirstChild("MoneyDrop")
            
        if drop and (drop.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= studs then
            wait()
            Root.CFrame = drop.CFrame * CFrame.new(0,3,0)
            wait(3)
            fireclickdetector(drop.ClickDetector)
            wait(1)
        end
    end)
end

function buyGun(item)
    spawn(function()
        for i,v in pairs(game.Workspace.Ignored.Shop:GetChildren()) do
            if v.Name == item then
                local originalPos = Root.CFrame
                Root.CFrame = v.Head.CFrame * CFrame.new(0,5,0)
                wait(1)
                fireclickdetector(game:GetService("Workspace").Ignored.Shop[item].ClickDetector)
                wait(1)
                Root.CFrame = originalPos
            end
        end
    end)
end

function main()
    pcall(function()
        task.spawn(function()
            while task.wait() do

                local LP = game.Players.LocalPlayer
                local Root = LP.Character:WaitForChild("HumanoidRootPart")
    
                if Info.cashPickup == true then
                    wait()
                    
                    repeat
                        wait()
    
                        local drop = game.Workspace.Ignored.Drop:FindFirstChild("MoneyDrop")
    
                        if drop then
                            Root.CFrame = drop.CFrame * CFrame.new(0,3,0)
                            wait(_G.cashwait)
                            repeat task.wait() until drop:FindFirstChild("ClickDetector")
                            fireclickdetector(drop.ClickDetector)
                            wait(1)
                        end
                    until Info.cashPickup == false
                end
    
                if Info.shoeClean == true then
                    
                    repeat 
                        wait()
                        local shoe = game.Workspace.Ignored.Drop:FindFirstChild("MeshPart")
    
                        if shoe then
                            Root.CFrame = shoe.CFrame
                            wait()
                            repeat task.wait() until shoe:FindFirstChild("ClickDetector")
                            fireclickdetector(shoe.ClickDetector)
                            wait(.5)
                            fireclickdetector(Workspace.Ignored["Clean the shoes on the floor and come to me for cash"].ClickDetector)
                        end
    
                    until Info.shoeClean == false
    
                end
    
                if Info.cashierFarm == true then
    
                    repeat
                        wait()
                        for i,v in pairs(game.Workspace.Cashiers:GetChildren()) do
                            if v.Humanoid.Health > 0 and Info.cashierFarm ~= false then
                                Root.CFrame = v.Open.CFrame * CFrame.new(0,0,2)
                                humanoid:EquipTool(tool)
                                wait(1)
        
                                while v.Humanoid.Health > 0 do
                                    Root.CFrame = v.Open.CFrame * CFrame.new(0,0,2)
                                    tool:Activate()
                                    wait(2)
                                end
        
                                wait()
                                for i, v in pairs(game.Workspace.Ignored.Drop:GetChildren()) do
                                    if v.Name == "MoneyDrop" and (v.Position - Root.Position).magnitude <= 18 then
                                        game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = v.CFrame
                                        repeat task.wait() until v:FindFirstChild("ClickDetector")
                                        fireclickdetector(v.ClickDetector)
                                        wait(0.5)
                                    end  
                                end 
        
                                wait(_G.farmwait)
                            end
                        end
                    until Info.cashierFarm == false
        
                end
    
                if Info.hospitalFarm == true then
                    wait()
                    local bollol = CFrame.new(116.073158, 23.0248318, -478.243866, 0.105827384, 1.03604918e-07, 0.994384527, 2.49280241e-08, 1, -1.06842961e-07, -0.994384527, 3.60949528e-08, 0.105827384)
    
                    repeat
                        wait()
                        for i, v in pairs(game.Workspace.Ignored.HospitalJob:GetChildren()) do
                            if v.Name == "Can I get the Red bottle" and Info.hospitalFarm == true then
                                Root.CFrame = bollol
                                fireclickdetector(game.Workspace.Ignored.HospitalJob.Red.ClickDetector)
                                wait(.5)
                                fireclickdetector(v:FindFirstChild("ClickDetector"))
                                
                            elseif v.Name == "Can I get the Blue bottle" and Info.hospitalFarm == true then
                                Root.CFrame = bollol
                                fireclickdetector(game.Workspace.Ignored.HospitalJob.Blue.ClickDetector)
                                wait(.5)
                                fireclickdetector(v:FindFirstChild("ClickDetector"))
                                
                            elseif v.Name == "Can I get the Green bottle" and Info.hospitalFarm == true then
                                Root.CFrame = bollol
                                fireclickdetector(game.Workspace.Ignored.HospitalJob.Green.ClickDetector)
                                wait(.5)
                                fireclickdetector(v:FindFirstChild("ClickDetector"))
                                
                            end
                        end
                    until Info.hospitalFarm == false
    
                end
    
    
                if Info.spectate ~= false then
                    workspace.CurrentCamera.CameraSubject = game.Players[_G.playerinput].Character.Humanoid
                else
                    workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character:WaitForChild("Humz")
                end
    
                if Info.antiafk == true then
                    spawn(function()
                        game:GetService("Players").LocalPlayer.Idled:Connect(function()
                            VU:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
                            task.wait(1)
                            VU:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
                        end)
                    end)
                end
    
    
                if Info.attach == true then
                    wait()
                    if Info.attach ~= false then
                        Root.CFrame = game.Players[_G.playerinput].Character.HumanoidRootPart.CFrame * CFrame.new(0,0,3)
                    end
                end
    
                if Info.aimbot then
                    task.wait()

                    for i,v in pairs(game.Players:GetPlayers()) do
                        if v.Character:FindFirstChild("HumanoidRootPart") and v ~= game.Players.LocalPlayer then
                            v.Character.HumanoidRootPart.Size = Vector3.new(7,7,7)
                            v.Character.HumanoidRootPart.Material = Enum.Material.SmoothPlastic
                            v.Character.HumanoidRootPart.CanCollide = false
                            v.Character.HumanoidRootPart.Transparency = .15
                        end
                    end
                    game.Players.PlayerAdded:Connect(function(v)
                        v.Character.HumanoidRootPart.Size = Vector3.new(7,7,7)
                        v.Character.HumanoidRootPart.Material = Enum.Material.SmoothPlastic
                        v.Character.HumanoidRootPart.CanCollide = false
                        v.Character.HumanoidRootPart.Transparency = .15
                    end)
                end
    
                if Info.iflow == true then
                    wait()
                    if LP.Character.Humz.Health <= _G.minhealth then
                        Root.CFrame = CFrame.new(-798.345764, -39.6492119, -885.242859, -0.00473513454, 6.98227538e-08, -0.999988794, -3.84332068e-08, 1, 7.00055267e-08, 0.999988794, 3.87642594e-08, -0.00473513454)
                    end
                end
    
                if Info.spin == true then
                    wait()
                    Root.CFrame *= CFrame.Angles(0, math.rad(60), 0)
                end
            end
        end)
    end)
end

main()

game.Players.LocalPlayer.CharacterAdded:Connect(function()
    task.wait(3)
    main()
end)