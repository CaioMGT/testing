local Knit = require(game.ReplicatedStorage.packages.Knit)
local dataService
local cash = Knit.CreateService{
    Name = "CashService",
    Client = {
        CashChanged = Knit.CreateSignal(),
        Cash = Knit.CreateProperty(0)
    }
}
function cash:GetCash(plr : Player)
    return dataService:GetData(plr).Data.Cash
end

function cash:SetCash(plr : Player, money : number)
    if not dataService then return "Not ready" end
    dataService:GetData(plr).Data.Cash = money
    self.Client.CashChanged:Fire(plr, money)
    self.Client.Cash:SetFor(plr, money)
end

function cash:AddCash(plr : Player, money : number)
    cash:SetCash(plr, cash:GetCash(plr) + money)
end

function cash.Client:GetCash(plr : Player)
    return self.Server:GetCash(plr)
end
function cash:KnitStart()
    dataService = Knit.GetService("DataService")
end
return cash