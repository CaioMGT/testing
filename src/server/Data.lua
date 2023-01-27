local Knit = require(game.ReplicatedStorage.packages.Knit)
local profs = {}
local profServ = require(script.Parent.ProfileService)
local profStore
local data = Knit.CreateService{
    Name = "DataService"
}
local template = {
    Cash = 50,
    Rebirths = 0
}

function data:SetTemplate(Template : table)
    template = Template
end

function data:RegisterPlayer(plr : Player)
    local profile = profStore:LoadProfileAsync(tostring(plr.UserId))
	if not (profile == nil) then
		profile:AddUserId(plr.UserId)
		profile:Reconcile()
		profile:ListenToRelease(function()
			profs[plr] = nil --if player was in another server somehow
			plr:Kick("You are in another server, we think")
			return false
		end)
		if plr:IsDescendantOf(game.Players) then
			-- return profile
			--profile.Data = template
			profs[plr] = profile
			return profile
		else
			profile:Release()
		end
	else
		plr:Kick("Profile couldn't be loaded")
		return false
	end
end

function data:GetData(plr : Player)
    return profs[plr]
end


function data:WipeData(id)
	local plr = game.Players:GetPlayerByUserId(id)
	profStore:WipeProfileAsync(tostring(id))
	if plr then
		plr:Kick("Data erasure")
	end
end
function data:KnitInit()
    game.Players.PlayerRemoving:Connect(function(plr)
        local profile = profs[plr]
        if profile ~= nil then
            profile:Release()
        end
    end)
	if game["Run Service"]:IsStudio() then
        profStore = profServ.GetProfileStore("data-STUDIO-b1", template)
    else
        profStore = profServ.GetProfileStore("data-b1", template)
    end
end
function data:KnitStart()
	local cash = Knit.GetService("CashService")
	local rebirth = Knit.GetService("RebirthService")
	game.Players.PlayerAdded:Connect(function(plr)
		local plrData = data:RegisterPlayer(plr)
		if plrData then
			cash:SetCash(plr, plrData.Data.Cash)
			rebirth:SetRebirths(plr, plrData.Data.Rebirths)
		end
	end)
end
return data