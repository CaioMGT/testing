local knit = require(game.ReplicatedStorage.packages.Knit)
local modules = script.Parent
for _, module in modules:GetChildren() do
    if module:IsA("ModuleScript") then
        require(module)
    end
end
knit.Start():catch(warn):await()
local cash = knit.GetService("CashService")
local rebirths = knit.GetService("RebirthService")
workspace.AddCash.ProximityPrompt.Triggered:Connect(function(plr)
    cash:AddCash(plr, 10)
end)
workspace.AddRebirths.ProximityPrompt.Triggered:Connect(function(plr)
    rebirths:AddRebirths(plr, 1)
end)