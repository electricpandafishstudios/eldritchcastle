--[[ ToME - Tales of Middle-Earth
-- Copyright (C) 2009, 2010, 2011, 2012, 2013 Nicolas Casalini
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.
--
-- Nicolas Casalini "DarkGod"
-- darkgod@te4.org ]]
-- The basic stuff used to damage a grid
setDefaultProjector(function(src, x, y, type, dam)
	local target = game.level.map(x, y, Map.ACTOR)
	if target then
	
		local flash = game.flash.NEUTRAL
		if target == game.player then flash = game.flash.BAD end
		if src == game.player then flash = game.flash.GOOD end
		wpn = src:getWeaponDam()
		local wkn = target.combat.weakness
		local str = target.combat.strength
		local critical = false
		dam = dam + wpn

		if src == game.player and not target == game.player then
			if wkn == type then
				if DamageType:get(type).supertype == nil then
					dam = dam + wpn * 1.00
				else
					dam = dam + (wpn * 1.00) + (wpn * 0.50)
					game.logSeen(target, flash, "%s lands a Critical hit on %s, dealing %s %% damage!#LAST#", src.name:capitalize(), target.name, 250)
				end
			else
				if DamageType:get(target.combat.weakness).subtype == DamageType:get(type).subtype then
						dam = dam + (wpn * 1.00)
				end
				if DamageType:get(target.combat.weakness).supertype == DamageType:get(type).supertype then
					if DamageType:get(type).supertype then
						dam = dam + (wpn * 0.50)
					end
				end
			end
			if str == type then
				if DamageType:get(type).supertype == nil then
					dam = dam - wpn * 1.00
				else
					dam = dam - (wpn * 1.00) - (wpn * 0.50)
				end
			else
				if DamageType:get(target.combat.strength).subtype == DamageType:get(type).subtype then
						dam = dam - (wpn * 1.00)
				end
				if DamageType:get(target.combat.strength).supertype == DamageType:get(type).supertype then
					if DamageType:get(type).supertype then
						dam = dam - (wpn * 0.50)
					end
				end
			end
		end
		
		
		--Move to somewhere's abouts inside of the Combat Damage Class
		if src.combat.damtype == DamageType.ELDRITCH then
			game.player:setEffect(game.player.EFF_MADNESS, 1, {power = ((dam / 1) * 0.25)})
		end
		
		if src.combat.damtype == DamageType.SANGUINE then
			src:heal(0.50 * dam, src)
		end
		
		if src.combat.damtype == DamageType.INFECTED then
			game.player:setEffect(game.player.EFF_POISON, 5, {power = (dam * 0.25)})
		end
		--
		
		
		-- setDefaultProjector()
		game.logSeen(target, flash, "%s hits %s for %s%0.2f %s damage %s %s#LAST#.", src.name:capitalize(), target.name, DamageType:get(type).text_color or "#aaaaaa#", dam, DamageType:get(type).name, DamageType:get(type).supertype, DamageType:get(type).subtype)
		local sx, sy = game.level.map:getTileToScreen(x, y)
		if target:takeHit(dam, src) then
			if src == game.player or target == game.player then
				game.flyers:add(sx, sy, 30, (rng.range(0,2)-1) * 0.5, -3, "Kill!", {255,0,255})
			end
		else
			if src == game.player then
				game.flyers:add(sx, sy, 30, (rng.range(0,2)-1) * 0.5, -3, tostring(-math.ceil(dam)), {0,255,0})
			elseif target == game.player then
				game.flyers:add(sx, sy, 30, (rng.range(0,2)-1) * 0.5, -3, tostring(-math.ceil(dam)), {255,0,0})
			end
		end
		--
			
		return dam
	end
	return 0
end)

--Physical damage types
newDamageType{
	name = "physical", type = "PHYSICAL",
	supertype = nil, subtype = "PHYSICAL",
}
newDamageType{
	name = "bashing", type = "BASHING", text_color = "#UMBER#",
	supertype = nil, subtype = "BASHING",
}
newDamageType{
	name = "slashing", type = "SLASHING",
	supertype = nil, subtype = "SLASHING",
}
newDamageType{
	name = "stabbing", type = "STABBING",
	supertype = nil, subtype = "PIERCING",
}

--Physical (Ranged) types
newDamageType{
	name = "piercing", type = "PIERCING",
	supertype = nil, subtype = "PIERCING",
}

--Physical (Silver) damage types
newDamageType{
	name = "silver bashing", type = "SILVER_BASHING", text_color = "#LIGHT_SLATE#",
	supertype = "SILVER", subtype = "BASHING",
}
newDamageType{
	name = "silver slashing", type = "SILVER_SLASHING", text_color = "#LIGHT_SLATE#",
	supertype = "SILVER", subtype = "SLASHING",
}
newDamageType{
	name = "silver stabbing", type = "SILVER_STABBING", text_color = "#LIGHT_SLATE#",
	supertype = "SILVER", subtype = "PIERCING",
}

--Physical (Silver - Ranged) types
newDamageType{
	name = "silver piercing", type = "SILVER_PIERCING", text_color = "#LIGHT_SLATE#",
	supertype = "SILVER", subtype = "PIERCING",
}

--Holy and Unholy
newDamageType{
	name = "holy", type = "HOLY", text_color = "#OLD_LACE#",
	supertype = "HOLY", subtype = nil,
}
newDamageType{
	name = "unholy", type = "UNHOLY", text_color = "#DARK_GREY#",
	supertype = "UNHOLY", subtype = nil,
}

--'Weird' damage types
newDamageType{
	name = "eldritch", type = "ELDRITCH", text_color = "#LIGHT_GREEN#",
	supertype = "ELDRITCH", subtype = nil,
}
newDamageType{	
	name = "sanguine", type = "SANGUINE", text_color = "#RED#",
	supertype = "SANGUINE", subtype = nil,
}
newDamageType{
	name = "infected", type = "INFECTED", text_color = "#GREY#",
	supertype = "INFECTED", subtype = nil,
}


-- Acid destroys potions
--newDamageType{
	--name = "acid", type = "ACID", text_color = "#GREEN#",
--}