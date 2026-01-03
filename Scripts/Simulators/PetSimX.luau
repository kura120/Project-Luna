repeat task.wait() until game:IsLoaded()


local kys = {
    --Misc
    ['VIP'] = {'VIP'};
    --Spawn
    ['Town'] = {'Town', 'Town FRONT'}; ['Forest'] = {'Forest', 'Forest FRONT'}; ['Beach'] = {'Beach', 'Beach FRONT'}; ['Mine'] = {'Mine', 'Mine FRONT'}; ['Winter'] = {'Winter', 'Winter FRONT'}; ['Glacier'] = {'Glacier', 'Glacier Lake'}; ['Desert'] = {'Desert', 'Desert FRONT'}; ['Volcano'] = {'Volcano', 'Volcano FRONT'};
    -- Fantasy init
    ['Enchanted Forest'] = {'Enchanted Forest', 'Enchanted Forest FRONT'}; ['Ancient'] = {'Ancient Island'}; ['Samurai'] = {'Samurai Island', 'Samurai Island FRONT'}; ['Candy'] = {'Candy Island'}; ['Haunted'] = {'Haunted Island', 'Haunted Island FRONT'}; ['Hell'] = {'Hell Island'}; ['Heaven'] = {'Heaven Island'};
    -- Tech
    ['Ice Tech'] = {'Ice Tech'}; ['Tech City'] = {'Tech City'; 'Tech City FRONT'}; ['Dark Tech'] = {'Dark Tech'; 'Dark Tech FRONT'}; ['Steampunk'] = {'Steampunk'; 'Steampunk FRONT'}, ['Alien Forest'] = {"Alien Forest"; "Alien Forest FRONT"}, ['Alien Lab'] = {"Alien Lab"; "Alien Lab FRONT"}, ['Glitch'] = {"Glitch"; "Glitch FRONT"}; ['Hacker Portal'] = {"Hacker Portal", "Hacker Portal FRONT"};
    -- Axolotl
    ['Axolotl Ocean'] = {'Axolotl Ocean', 'Axolotl Ocean FRONT'}; ['Axolotl Deep Ocean'] = {'Axolotl Deep Ocean', 'Axolotl Deep Ocean FRONT'}; ['Axolotl Cave'] = {'Axolotl Cave', 'Axolotl Cave FRONT'};
    -- Minecraft
    ['Pixel Forest'] = {'Pixel Forest', 'Pixel Forest FRONT'}; ['Pixel Kyoto'] = {'Pixel Kyoto', 'Pixel Kyoto FRONT'}; ['Pixel Alps'] = {'Pixel Alps', 'Pixel Alps FRONT'} ; ['Pixel Vault'] = {'Pixel Vault', 'Pixel Vault FRONT'};
}

local Chests = {
    -- Spawn
    "Magma Chest",
    -- Fantasy
    "Enchanted Chest", "Hell Chest", "Haunted Chest", "Angel Chest", "Grand Heaven Chest",
    -- Tech
    "Giant Tech Chest"; "Giant Steampunk Chest"; "Giant Alien Chest"; "Giant Hacker Chest";
    -- exolot
   "Giant Ocean Chest";
   -- Minecraft
   "Giant Pixel Chest";
}

function getAreas()
    local tbl = {}
    for i,v in pairs(game:GetService("ReplicatedStorage").Directory.Areas:GetChildren()) do
        local t = require(v)
        for _,b in pairs(t) do
            if not _.isShop and string.split(_," ")[2] ~= "Chest" then
                table.insert(tbl, tostring(_))
            end
        end
    end
    return tbl
end


local areas = getAreas()

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
    AutoGetOrbs = false,
    AutoFarmCoins = false,
    Radius = 175,
    AntiAFK = false,
    FarmingArea = "",
    FarmType = "",
    selectedEgg = "",
    autoBuyEgg = false,
    TrippleCoins = false,
    TrippleDamage = false,
    SuperLucky = false,
    UltraLucky = false,
    PetStorage = false,
    PlayerWalkspeed = false,
    MoreDiamonds = false,
    PetWalkspeed = false,
    PetStrength = false,
    selectedGUI = "",
    Chest = "",
}

function notify(Text, Time)
    game.StarterGui:SetCore("SendNotification", {
        Title = "Luna Client";
        Text = Text;
        Icon = "http://www.roblox.com/asset/?id=10502664319";
        Duration = Time
    })
end

notify("This scripts is a WIP, if you encounter any bugs please let us know on our discord", 15)

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

function getOrbs()
    for i,v in pairs(workspace["__THINGS"].Orbs:GetChildren()) do
        if v:IsA("Part") and workspace["__THINGS"].Orbs:GetChildren()[1] then
            local args = { [1] = { [1] = { [1] = tostring(v.Name) } } }

            workspace.__THINGS.__REMOTES:FindFirstChild("claim orbs"):FireServer(unpack(args))
        end
    end
end

local function fetchIds()
    local tbl = {}
    
    local lib = require(game:GetService("ReplicatedStorage"):WaitForChild("Framework"):WaitForChild("Library"))

    for i,v in pairs(lib.Save.Get().Pets) do
        if v.e then
            table.insert(tbl, v.uid)
        end
    end
    return tbl
end

function getCoins(area)
    local tbl = {}
    local coins = workspace['__THINGS']['__REMOTES']["get coins"]:InvokeServer({})[1]
    for i,v in pairs(coins) do
        if table.find(kys[Info.FarmingArea], v.a) then
            local ahh = v
            ahh["index"] = i
            table.insert(tbl, ahh)
         end
    end
    return tbl
end

local AWTable = {}
for _,worlds in pairs(game.ReplicatedStorage.Game.Coins:GetChildren()) do
    for t,v in pairs(worlds:GetChildren()) do
        table.insert(AWTable, v.Name)
    end
    table.insert(AWTable, worlds.Name)
end

function getChests()
    local tbl = {}

    local coins = workspace["__THINGS"]["__REMOTES"]["get coins"]:InvokeServer({ })[1]

    for i,v in pairs(coins) do
        local t = v
        t.index = i
        for _,y in pairs(AWTable) do
            if string.find(v.n, y) or string.find(v.n, "Giant") then
                local b = string.gsub(v.n, y .. " ", "")
                if table.find(Chests, b) then
                    t.n = b
                    table.insert(tbl, t)
                end
            end
        end
    end
    return tbl
end

function farmCoin(CoinID, PetID)
    workspace['__THINGS']['__REMOTES']["join coin"]:InvokeServer({[1] = CoinID, [2] = {[1] = PetID}})
    workspace['__THINGS']['__REMOTES']["farm coin"]:FireServer({[1] = CoinID, [2] = PetID})
end

function CoinFarm()
    local curFarmingPets = {}
    local petIDs = fetchIds()
    if Info.AutoFarmCoins and Info.FarmingArea ~= "" and Info.FarmType == "Normal" then
        local coins = getCoins(Info.FarmingArea)

        for c = 1, #coins do
            if c%#petIDs == #petIDs-1 then task.wait() end

            if not curFarmingPets[petIDs[c%#petIDs+1]] or curFarmingPets[petIDs[c%#petIDs+1]] == nil then
                if Info.AutoFarmCoins then
                    task.wait(0.1)
                    task.spawn(function()
                        curFarmingPets[petIDs[c%#petIDs+1]] = "Farming"
                        farmCoin(coins[c].index, petIDs[c%#petIDs+1])
                        repeat task.wait() until not workspace["__THINGS"].Coins:FindFirstChild(coins[c].index) or
                        #workspace["__THINGS"].Coins:FindFirstChild(coins[c].index).Pets:GetChildren() == 0 or not Info.AutoFarmCoins
                        curFarmingPets[petIDs[c%#petIDs+1]] = nil
                    end)
                end
            end
        end
    end

    if Info.AutoFarmCoins and Info.FarmingArea ~= "" and Info.FarmType == "Chests" then
        for i,v in pairs(getChests()) do
            if v.n == Info.Chest and Info.AutoFarmCoins then
                for t,y in pairs(petIDs) do
                    coroutine.wrap(function()
                        farmCoin(v.index, y)
                    end)()
               end
            end
            repeat task.wait() until not workspace["__THINGS"].Coins:FindFirstChild(v.index) or 
            #workspace["__THINGS"].Coins:FindFirstChild(v.index).Pets:GetChildren() == 0 or not Info.AutoFarmCoins
        end
    end
end

function getAreasTP()
    local artbl = {}
        for _,v in pairs(game.Workspace["__MAP"].Teleports:GetChildren()) do
            table.insert(artbl, v.Name)
        end
    return artbl
end

function getCannonTP()
    local cannonTPtbl = {}
        for _,bbc in pairs(game.Workspace["__MAP"].Cannons:GetChildren()) do
            table.insert(cannonTPtbl, bbc.Name)
        end
    return cannonTPtbl
end

function buyAreas()
    for i,v in pairs(workspace["__MAP"].Areas:GetChildren()) do
        if v:IsA("Folder") and v.Name ~= "VIP" then
            local args = {
                [1] = {
                    [1] = tostring(v.Name)
                }
            }
        
            workspace.__THINGS.__REMOTES:FindFirstChild("buy area"):InvokeServer(unpack(args))
        end
    end
end

function openGUI(framename)
    game.Players.LocalPlayer.PlayerGui[framename].Enabled = true
end

function buyEgg(eggtype)
    local args = {[1] = "b",[2] = "buy egg"}
    workspace.__THINGS.__REMOTES.MAIN:FireServer(unpack(args))
    task.wait()
    local argsv1 = {[1] = {[1] = eggtype,[2] = false}}
    workspace.__THINGS.__REMOTES:FindFirstChild("buy egg"):InvokeServer(unpack(argsv1))
end

function ActivateBoost(Type) -- "Tripple Damage", "Tripple Coins", "Super Lucky", "Ultra Lucky"
    local args = {[1] = {[1] = Type}}
    workspace.__THINGS.__REMOTES:FindFirstChild("activate boost"):FireServer(unpack(args))
end

function Upgrades(Ting) -- "Pet Storage", "Player Walkspeed", "More Diamonds", "Pet Walkspeed", "Pet Strength"
    local args = {[1] = {[1] = Ting}}
    workspace.__THINGS.__REMOTES:FindFirstChild("buy upgrade"):InvokeServer(unpack(args))
end

local Credit = Create.New({
    Title = "Credits"
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
    Text = "Made by kura#6311 & Duxkyx#5079", 
    Callback = function()
        setclipboard("https://duxkyx.cf")
    end
})

local Farm = Create.New({
    Title = "Farming"
})

local Buy = Create.New({
    Title = "Misc"
})
local Misc = Create.New({
	Title = "Local"
})
local Other = Create.New({
    Title = "Other"
})

local TP = Create.New({
    Title = "Teleport"
})

TP.Label({
    Text = "Auto updates when game updates", 
})

TP.Label({
    Text = "Area Teleports", 
})

local b = TP.Dropdown({
    Text = "Select Area",
    Callback = function(Value)
        _G.selectedArea = Value
    end,
    Options = 
        getAreasTP()
    ,
})

TP.Button({
    Text = "Teleport to Selected Area", 
    Callback = function()
        local Root = Creator.Character.HumanoidRootPart
        for _,c in pairs(workspace["__MAP"].Teleports:GetChildren()) do
            if c:IsA("Part") and c.Name == _G.selectedArea then
                Root.CFrame = c.CFrame * CFrame.new(0,50,0)
            end
        end
    end
})

workspace.ChildRemoved:Connect(function(v)
    if v.Name == "__MAP" then
        task.wait(1)
        b:SetOptions(getAreasTP())
    end
end)

TP.Label({
    Text = "Cannon Teleports",
})

local nut = TP.Dropdown({
    Text = "Select Cannon",
    Callback = function(Value)
        _G.selectedCannon = Value
    end,
    Options = 
        getCannonTP()
    ,
})

TP.Button({
    Text = "Teleport to Selected Cannon", 
    Callback = function()
        local Root = game.Players.LocalPlayer.Character.HumanoidRootPart
        for _,c in pairs(game.Workspace["__MAP"].Cannons:GetChildren()) do
            if c:IsA("MeshPart") and c.Name == _G.selectedCannon then
                Root.CFrame = c.CFrame * CFrame.new(0,50,0)
            end
        end
    end
})

workspace.ChildRemoved:Connect(function(v)
    if v.Name == "__MAP" then
        task.wait(1)
        nut:SetOptions(getCannonTP())
    end
end)

Other.Label({
    Text = "GUIs"
})

Other.Dropdown({
    Text = "Select GUI",
    Callback = function(Value)
        Info.selectedGUI = Value
    end,
    Options = {
        "Bank", "Golden", "Rainbow", "FusePets", "DarkMatter", "Merchant", "Teleport"
    },
})

Other.Button({
    Text = "Open GUI",
    Callback = function()
        openGUI(Info.selectedGUI)
    end,
})

Misc.Label({
    Text = "Local Player"
})

Misc.Slider({
	Text = "Walkspeed",
	Callback = function(value)
		Creator.Character.Humanoid.WalkSpeed = tonumber(value)
	end,
	Min = 12,
	Max = 200,
	Def = 16
})

Misc.Slider({
	Text = "Jumppower",
	Callback = function(value)
        Creator.Character.Humanoid.JumpPower = tonumber(value)
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

Misc.Toggle({
    Text = "Anti AFK",
    Callback = function(v)
        Info.AntiAFK = v
    end
})

Misc.Button({
	Text = "Full Bright",
	Callback = function()
        game.Lighting.OutdoorAmbient = Color3.new(1,1,1)
        game.Lighting.Ambient = Color3.new(1,1,1)
	end,
})

Buy.Button({
    Text = "Buy All Areas",
    Callback = function()
        buyAreas()
    end
})

Buy.Button({
    Text = "Give all gamepasses",
    Callback = function()
        local p = require(game:GetService("ReplicatedStorage").Framework.Client["5 | Gamepasses"])
        p.Owns = function() return true end
        
        p.GetAll()
    end
})

Buy.Label({
    Text = "Eggs"
})

Buy.Dropdown({
    Text = "Select Egg",
    Callback = function(Value)
        Info.selectedEgg = Value
    end,
    Options = {
        "Cracked Egg","Spotted Egg","Golden Cracked Egg","Golden Spotted Egg","Wood Egg","Grass Egg","Golden Wood Egg","Golden Grass Egg","Beachball Egg","Coconut Egg","Golden Beachball Egg","Golden Coconut Egg","Rock Egg","Geode Egg","Golden Rock Egg","Golden Geode Egg","Snow Egg","Ice Egg","Golden Snow","Golden Ice Egg","Icicle Egg","Yeti Egg","Golden Icicle Egg","Golden Yeti Egg","Cactus Egg","Spiked Egg","Golden Cactus Egg","Golden Spiked Egg","Obsidian Egg","Magma Egg","Golden Obsidian Egg","Golden Magma Egg","Enchanted Egg","Golden Enchanted Egg","Relic Egg","Golden Relic Egg","Samurai Egg","Golden Samurai Egg","Rainbow Egg","Golden Rainbow Egg","Haunted Egg","Golden Haunted Egg","Hell Egg","Golden Hell Egg","Heaven Egg","Golden Heaven Egg","Empyrean Egg","Golden Empyrean Egg","Metal Egg", "Golden Metal Egg", "Tech Egg", "Golden Tech Egg", "Titanium Egg", "Golden Titanium Egg", "Dark Tech Egg", "Golden Dark Tech Egg", "Steampunk Egg", "Golden Steampunk Egg", "Mechanical Egg", "Golden Mechanical Egg", "Lab Egg", "Golden Lab Egg", "Chemical Egg", "Golden Chemical Egg", "Alien Egg", "Golden Alien Egg", "Martian Egg", "Golden Martian Egg", "Planet Egg", "Golden Planet Egg", "Glitch Egg", "Golden Glitch Egg"
    },
})

Buy.Toggle({
    Text = "Auto Buy Selected Egg",
    Callback = function(bool)
        Info.autoBuyEgg = bool
    end
})

Buy.Button({
	Text = "Buy Egg (x1)",
	Callback = function()
		buyEgg(Info.selectedEgg)
	end,
})

Buy.Label({
    Text = "Luck (FREE)"
})

Buy.Toggle({
    Text = "Auto Use Tripple Damage",
    Callback = function(bool)
        Info.TrippleDamage = bool
    end
})

Buy.Toggle({
    Text = "Auto Use Tripple Coins",
    Callback = function(bool)
        Info.TrippleCoins = bool
    end
})

Buy.Toggle({
    Text = "Auto Use Super Lucky",
    Callback = function(bool)
        Info.SuperLucky = bool
    end
})

Buy.Toggle({
    Text = "Auto Use Ultra Lucky",
    Callback = function(bool)
        Info.UltraLucky = bool
    end
})

Buy.Label({
    Text = "Upgrades"
})

Buy.Toggle({
    Text = "Auto Upgrade Pet Storage",
    Callback = function(bool)
        Info.PetStorage = bool
    end
})

Buy.Toggle({
    Text = "Auto Upgrade Player Walkspeed",
    Callback = function(bool)
        Info.PlayerWalkspeed = bool
    end
})

Buy.Toggle({
    Text = "Auto Upgrade More Diamonds",
    Callback = function(bool)
        Info.MoreDiamonds = bool
    end
})

Buy.Toggle({
    Text = "Auto Upgrade Pet Walkspeed",
    Callback = function(bool)
        Info.PetWalkspeed = bool
    end
})

Buy.Toggle({
    Text = "Auto Upgrade Pet Strength",
    Callback = function(bool)
        Info.PetStrength = bool
    end
})

Farm.Label({
    Text = "Farming"
})
Farm.Toggle({
    Text = "Auto Farm Coins",
    Callback = function(v)
        Info.AutoFarmCoins = v
    end
})

Farm.Toggle({
    Text = "Auto Collect Orbs",
    Callback = function(v)
        Info.AutoGetOrbs = v
    end
})

Farm.Label({
    Text = "Farm Settings"
})

Farm.Dropdown({
    Text = "Farm Type",
    Callback = function(v)
        Info.FarmType = v
    end,
    Options = {"Normal", "Chests"}
})

Farm.Dropdown({
    Text = "Chests",
    Callback = function(v)
        Info.Chest = v
    end,
    Options = Chests
})

Farm.Dropdown({
    Text = "Farm Island",
    Callback = function(v)
        Info.FarmingArea = v
    end,
    Options = areas
})

function Main()
    task.spawn(function()
        while task.wait() do

            if Info.TrippleDamage then
                ActivateBoost("Tripple Damage")
                task.wait(5)
            end
            if Info.TrippleCoins then
                ActivateBoost("Tripple Coins")
                task.wait(5)
            end
            if Info.SuperLucky then
                ActivateBoost("Super Lucky")
                task.wait(5)
            end
            if Info.UltraLucky then
                ActivateBoost("Ultra Lucky")
                task.wait(5)
            end
            if Info.PetStorage then
                Upgrades("Pet Storage")
            end
            if Info.PlayerWalkspeed then
                Upgrades("Player Walkspeed")
            end
            if Info.MoreDiamonds then
                Upgrades("More Diamonds")
            end
            if Info.PetWalkspeed then
                Upgrades("Pet Walkspeed")
            end
            if Info.PetStrength then
                Upgrades("Pet Strength")
            end
            if Info.autoBuyEgg then
                buyEgg(Info.selectedEgg)
            end

            if Info.AutoFarmCoins then
                CoinFarm()
            end

            if Info.AutoGetOrbs then
                getOrbs()
            end

            if Info.AntiAFK then
                task.spawn(function()
                    game:GetService("Players").LocalPlayer.Idled:Connect(function()
                        VU:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
                        task.wait(1)
                        VU:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
                    end)
                end)
            end
        end
    end)
end

Main()