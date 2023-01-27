local Knit = require(game.ReplicatedStorage.packages.Knit)
local dataService
local Rebirths = Knit.CreateService{
    Name = "RebirthService",
    Client = {
        RebirthChanged = Knit.CreateSignal(),
        Rebirths = Knit.CreateProperty(0)
    }
}
function Rebirths:GetRebirths(plr : Player)
    return dataService:GetData(plr).Data.Rebirths
end
function Rebirths:SetRebirths(plr : Player, rebirths)
    if not dataService then return "Not ready" end
    dataService:GetData(plr).Data.Rebirths = rebirths
    self.Client.RebirthChanged:Fire(plr, rebirths)
    self.Client.Rebirths:SetFor(plr, rebirths)
end
function Rebirths:AddRebirths(plr : Player, rebirths)
    Rebirths:SetRebirths(plr, Rebirths:GetRebirths(plr) + rebirths)
end

function Rebirths:KnitStart()
    dataService = Knit.GetService("DataService")
end
return Rebirths