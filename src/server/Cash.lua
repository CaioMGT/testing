local Knit = require(game.ReplicatedStorage.packages.Knit)
local cash = Knit.CreateService{
    Name = "CashService",
    Client = {
        CashChanged = Knit.CreateSignal(),
        Cash = Knit.CreateProperty(0)
    }
}
local cashTracker = {

}
function cash:GetCash(plr : Player)
    return cashTracker[plr] or 0
end

function cash:SetCash(plr : Player, money : number)
    cashTracker[plr] = money
    self.Client.CashChanged:Fire(plr, money)
    self.Client.Cash:SetFor(plr, money)
end

function cash:AddCash(plr : Player, money : number)
    cash:SetCash(plr, cash:GetCash(plr) + money)
end

function cash.Client:GetCash(plr : Player)
    return self.Server:GetCash(plr)
end
return cash