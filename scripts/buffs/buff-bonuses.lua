function estimate_buff_bonuses(buffname)
	local buffarray = {
		["Sole Soul"] = { ["Item Drops from Monsters"] = math.min(buffturns("Sole Soul"), 300) },
		["The HeyDezebound Heart"] = { ["Item Drops from Monsters"] = math.min(buffturns("The HeyDezebound Heart"), 300) },
		["Bubble Vision"] = { ["Item Drops from Monsters"] = math.max(101 - buffturns("Bubble Vision"), 0) },
		["Polka Face"] = { ["Item Drops from Monsters"] = math.min(55, 5 * level()), ["Meat from Monsters"] = math.min(55, 5 * level()) },
		["Withered Heart"] = { ["Item Drops from Monsters"] = math.min(buffturns("Withered Heart"), 20) },
		["Fortunate Resolve"] = { ["Item Drops from Monsters"] = 5, ["Meat from Monsters"] = 5, ["Combat Initiative"] = 5 },
		-- ["Limber as Mortimer"] = ...,
		["Voracious Gorging"] = { ["Item Drops from Monsters"] = math.min(40, math.ceil(fullness() / 5) * 10) },

		["Cunctatitis"] = { ["Combat Initiative"] = -1000 },

		["Buy!  Sell!  Buy!  Sell!"] = { ["Meat from Monsters"] = math.max(202 - 2 * buffturns("Buy!  Sell!  Buy!  Sell!"), 0) },
		["Sweet Heart"] = { ["Meat from Monsters"] = math.min(2 * buffturns("Sweet Heart"), 40) },

		["Ur-Kel's Aria of Annoyance"] = { ["Monster Level"] = math.min(2 * level(), 60) },
		["Mysteriously Handsome"] = { ["Monster Level"] = 6 }, -- Not for men
		["A Little Bit Evil"] = { ["Monster Level"] = 2 },

		["Amorous Avarice"] = { ["Meat from Monsters"] = 25 * math.min(math.floor(drunkenness() / 5), 4) },

		["Whitesloshed"] = { ["Item Drops from Monsters (Dreadsylvania only)"] = 500 },
		["You've Got a Stew Going!"] = { ["Item Drops from Monsters (Dreadsylvania only)"] = 500 },
	}

	if buffarray[buffname] then
		return make_bonuses_table(buffarray[buffname])
	elseif datafile("buffs")[buffname] then
		return make_bonuses_table(datafile("buffs")[buffname].bonuses or {})
	else
		-- unknown
		return make_bonuses_table {}
	end
end

function estimate_current_buff_bonuses()
	local bonuses = {}
	for buff, _ in pairs(buffslist()) do
		add_modifier_bonuses(bonuses, estimate_buff_bonuses(buff))
	end
	return bonuses
end
