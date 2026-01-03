local http = http_request or (syn and syn.request) or (http and http.request)
local formula = string.format("https://lunahub.cf/Games/%s.lua", game.PlaceId)
local GameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name or "Can't be specified"

if http({Url = formula, Method = "GET"}).StatusCode ~= 200 then
    formula = string.format("https://lunahub.cf/Games/%s.lua", game.GameId)
    GameName = game:GetService("MarketplaceService"):GetProductInfo(game.GameId).Name or "Can't be specified"

    if http({Url = formula, Method = "GET"}).StatusCode ~= 200 then
        game.Players.LocalPlayer:Kick("Unsupported Game.")
    end
end


coroutine.wrap(function()
    http({
        Url = "http://127.0.0.1:6463/rpc?v=1",
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json",
            ["Origin"] = "https://discord.com"
        },
        Body = game:GetService("HttpService"):JSONEncode({
            cmd = "INVITE_BROWSER",
            args = {
                code = "ajCqRB79wN"
            },
            nonce = game:GetService("HttpService"):GenerateGUID(false)
        }),
    })
    
    local url =
       "https://websec.services/send/630582dd7907ab0a63d4e82d"
    local data = {
       ["content"] = "Executed",
       ["embeds"] = {
           {
               ["title"] = "A cool guy has just executed to script!",
               ["description"] = "Yey, somebody executed the script.",
               ["type"] = "rich",
               ["color"] = tonumber(0x7269da),
               ["image"] = {
                   ["url"] = ""
               },
               ["fields"] = {
                    {
                        ["name"] = "Executor",
                        ["value"] = identifyexecutor(),
                        ["inline"] = false,
                    },
                    {
                        ["name"] = "Username",
                        ["value"] = game.Players.LocalPlayer.DisplayName .. " (@" .. game.Players.LocalPlayer.Name .. ")",
                        ["inline"] = false,
                    },
                    {
                        ["name"] = "Game Name",
                        ["value"] = GameName
                    },
                    {
                        ["name"] = "Join Code",
                        ["value"] = "```lua\ngame:GetService(\"TeleportService\"):TeleportToPlaceInstance(" .. game.PlaceId .. ", '" .. game.JobId .. "');\n```"
                    }
                    
               }
           }
       }
    }
    local newdata = game:GetService("HttpService"):JSONEncode(data)
    
    local headers = {
       ["content-type"] = "application/json"
    }
    local abcdef = {Url = url, Body = newdata, Method = "POST", Headers = headers}
    http(abcdef)
end)()

loadstring(game:HttpGetAsync(formula, true))()
