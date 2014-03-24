local DamageType = require "engine.DamageType"

newEntity{
	define_as = "BASE_HANDGUN",
	slot = "HAND",
	type = "weapon", subtype="firearm",
	display = "L", color = colors.SLATE,
	encumber = 0,
	rarity = 5,
	combat = {},
	name = "gun",
	desc = [[ Stout and wooden. At least its something. ]],
}
newEntity{
	define_as = "BASE_BULLET",
	type = "ammunition", subtype = "bullet",
	display = ",", color = colors.LIGHT_SLATE,
	encumber = 0,
	rarity = 5,
	combat = {},
	name = "bullet",
	desc == [[ BANG! ]],
}

newEntity{ base = "BASE_HANDGUN",
	name = "Colt .45",
	level_range = {1, 10},
	range = 5,
	require = { stat = { per= 4}, },
	combat = { dam = 4, damtype = DamageType.PIERCING, },
	multicharge = 6,
	use_simple = {
		name = "Fire",
		use = function(self,who)
			self:attackTarget(who, DamageType.PIERCING)
		end
		},
}
newEntity{ base = "BASE_BULLET",
	name = ".45 ACP Rounds",
	level_range = {1, 10},
	multicharge = 10,
	use_simple = {
		name = "fire",
		use = function(self)
			return {used = true, destroy = true}
		end
	},
}