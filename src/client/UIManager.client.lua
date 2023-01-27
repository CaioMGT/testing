local knit = require(game.ReplicatedStorage.packages.Knit)
local gui = game.Players.LocalPlayer.PlayerGui
knit.Start():catch(warn):await()
local cash = knit.GetService("CashService")
local rebirths = knit.GetService("RebirthService")
cash.Cash:Observe(function(cash)
    gui.Cash.Text = `Cash: {cash}`
end)
rebirths.Rebirths:Observe(function(rebirths)
    gui.Rebirths.text = `Rebirths: {rebirths}`
end)