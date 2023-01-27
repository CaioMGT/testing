local knit = require(game.ReplicatedStorage.packages.Knit)
local gui = game.Players.LocalPlayer.PlayerGui:WaitForChild("ScreenGui")
knit.Start():catch(warn):await()
local cashService = knit.GetService("CashService")
local rebirthsService = knit.GetService("RebirthService")
cashService.Cash:Observe(function(cash)
    gui.Cash.Text = `Cash: {cash}`
end)
rebirthsService.Rebirths:Observe(function(rebirths)
    gui.Rebirths.Text = `Rebirths: {rebirths}`
end)