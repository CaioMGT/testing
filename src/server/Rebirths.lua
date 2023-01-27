local Knit = require(game.ReplicatedStorage.packages.Knit)
local Rebirths = Knit.CreateService{
    Name = "RebirthService",
    Client = {
        RebirthChanged = Knit.CreateSignal(),
        Rebirths = Knit.CreateProperty(0)
    }
}
local RebirthTracker = {

}
function Rebirths:GetRebirths(plr : Player)
    return RebirthTracker[plr] or 0
end
function Rebirths:SetRebirths(plr : Player, rebirths)
    RebirthTracker[plr] = rebirths
    self.Client.RebirthChanged:Fire(plr, rebirths)
    self.Client.Rebirths:SetFor(plr, rebirths)
end
function Rebirths:AddRebirths(plr : Player, rebirths)
    Rebirths:SetRebirths(plr, Rebirths:GetRebirths(plr) + rebirths)
end
return Rebirths