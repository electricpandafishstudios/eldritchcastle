-- ToME - Tales of Middle-Earth
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
-- darkgod@te4.org


newTalentType{ type="role/combat", name = "combat", description = "Combat techniques" }
newTalentType{ type="attack/mob", name = "mob", description = "Mob auto-attacks" }

newTalent{
	name = "Mad",
	type = {"role/combat", 1},
	points = 1,
	cooldown = 2,
	sanity = 1,
	range = 1,
	mode = "passive",
	getAttack = function(self, t) return self:getTalentLevel(t) * 10 end,
	action = function(self, t) end,
	info = function(self, t)
		return "Zshhhhhhhhh!"
	end,
}

newTalent{
	name = "Attack",
	type = {"role/combat", 1},
	points = 1,
	cooldown = 0,
	sanity = 0,
	range = 1,
	action = function(self, t)
		local tg = {type="hit", range=self:getTalentRange(t)}
		local x, y, target = self:getTarget(tg)
		if not x or not y or not target then return nil end
		if core.fov.distance(self.x, self.y, x, y) > 1 then return nil end

		self:bumpInto(target)
		return true
	end,
	info = function(self, t)
		return "Attack!"
	end,
}


newTalent{
	name = "Fire",
	type = {"role/combat", 1},
	points = 1,
	cooldown = 0,
	sanity = 0,
	range = 5,
	action = function(self, t)
		local tg = {type="bolt", range=self:getTalentRange(t)}
		local x, y, target = self:getTarget(tg)
		local weapon = self:getWeaponFromSlot("HAND")
		if not x or not y or not target then return nil end
		if not weapon then return nil end
		
		local inventory = self:getInven("INVEN")
		local bullet = self:findInInventory(inventory, ".45 ACP Rounds")
		if bullet then
			self:useActionPoints(5)
			self:playerUseItem(bullet, ".45 ACP Rounds", inventory)
			self:project(tg, x, y, DamageType.PHYSICAL, weapon.combat.dam, nil)
		end
	end,
	info = function(self, t)
		return "Fire!"
	end,
}

--Unused / boxed
--newTalent{
--	name = "Kick",
--	type = {"role/combat", 1},
--	points = 1,
--	cooldown = 6,
--	sanity = 0,
--	range = 1,
--	action = function(self, t)
--		local tg = {type="hit", range=self:getTalentRange(t)}
--		local x, y, target = self:getTarget(tg)
--		if not x or not y or not target then return nil end
--		if core.fov.distance(self.x, self.y, x, y) > 1 then return nil end
--
--		target:knockback(self.x, self.y, 2 + self:getCon())
--		return true
--	end,
--	info = function(self, t)
--		return "Kick!"
--	end,
--}
--newTalent{
--	name = "Particles",
--	type = {"role/combat", 1},
--	points = 1,
--	cooldown = 0,
--	sanity = 0,
--	range = 10,
--	action = function(self, t)
--		local tg = {type="ball", range=self:getTalentRange(t), radius=1, talent=t}
--		local x, y = self:getTarget(tg)
--		if not x or not y then return nil end
--		self:project(tg, x, y, DamageType.ACID, 1 + self:getMen(), {type="acid"})
--		return true
--	end,
--	info = function(self, t)
--		return "Zshhhhhhhhh!"
--	end,
--}

