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

require "engine.class"
local DamageType = require "engine.DamageType"
local Map = require "engine.Map"
local Target = require "engine.Target"
local Talents = require "engine.interface.ActorTalents"

--- Interface to add ToME combat system
module(..., package.seeall, class.make)

--- Checks what to do with the target
-- Talk ? attack ? displace ?
function _M:bumpInto(target)
	local reaction = self:reactionToward(target)
	if reaction < 0 then
		if self:getActions() >= 5 then
			return self:attackTarget(target)
		elseif self == game.player then 
			game.flash(game.flash.BAD, "I don't have enough Action Points to do that. (5 Required)")
			game.log("Low Action Points!")
		else
			self:useActionPoints(self:getActions())
		end
	elseif reaction >= 0 then
		if self.move_others then
			-- Displace
			game.level.map:remove(self.x, self.y, Map.ACTOR)
			game.level.map:remove(target.x, target.y, Map.ACTOR)
			game.level.map(self.x, self.y, Map.ACTOR, target)
			game.level.map(target.x, target.y, Map.ACTOR, self)
			self.x, self.y, target.x, target.y = target.x, target.y, self.x, self.y
		end
	end
end

--- Makes the death happen!
function _M:attackTarget(target, damtype, mult)
	if not damtype then
		damtype = self:getDamType()
	end
	if self.combat then
		local dam = self:getCon() + 1
		DamageType:get(damtype).projector(self, target.x, target.y, damtype, math.max(0, dam))
	end
		self:useActionPoints(5)
end

function _M:damageBonuses()
	local dam = damage
	if weakness == damTyp then
		dam = dam + typBonus + specBonus
	end
	if not damTyp.superType == nil then
		if weakness.superType == damTyp.superType then
			dam = dam + specBonus
		end
		if not damTyp.subType == nil then
			if tweakness.subType == damTyp.subType then
				dam = dam + typBonus
			end
		end
	end
end

function _M:damagePenalties(tg, damtype)
	local dam = 0
		if tg.strength == damtype then
			dam = dam + self:typeDamage() + self:specialDamage()
		else
			if not damtype.superType == nil then
				if tg.strength.superType == damType.superType then
					dam = dam + self:specialDamage()
				end
			end
			if not damtype.subType == nil then
				if tg.strength.subType == damType.subType then
					dam = dam + self:typeDamage()
				end
			end
		end
end

function _M:typeDamage()
if not self:getInven("HAND") then return 0 end
	local weapon = self:getInven("HAND")[1]
	if not weapon then return 0 end
	return weapon.combat.dam * self:getCon()
end

function _M:specialDamage()
if not self:getInven("HAND") then return 0 end
	local weapon = self:getInven("HAND")[1]
	if not weapon then return 0 end
	return (weapon.combat.dam * 0.50) * self:getCon()
end

function _M:getDamageType()
	if not self:getInven("HAND") then
		if not self.combat.damtype  then
			return DamageType.PHYSCIAL
		end
		return self.combat.damtype
	end
	local weapon = self:getInven("HAND")[1]
	if not weapon then 
		if not self.combat.damtype  then
			return DamageType.PHYSICAL 
		end
		return self.combat.damtype
	end
	return weapon.combat.damtype
end