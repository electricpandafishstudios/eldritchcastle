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

function _M:attackTarget(target, no_actions)
	local weapon = self:getWeaponFromSlot("HAND")
	
	if weapon then
		local damage_type = weapon.combat.damtype or self.combat.damtype or DamageType.PHYSICAL
		local weapon_damage = weapon.combat.dam or 0
		local super_modifier = self:getSuperModifier(weapon, target)
		local sub_modifier = self:getSubModifier(weapon, target)
		self:attackTargetWith(target, damage_type, weapon_damage, super_modifier, sub_modifier)
	else
		local damage_type = self.combat.damtype or DamageType.PHYSICAL
		self:attackTargetWith(target, damage_type)
	end
	
	if not no_actions then
		self:useActionPoints(5)
	end
end

function _M:attackTargetWith(target, damage_type, weapon_damage, super_modifier, sub_modifier)
	local weapon_damage = weapon_damage or 0
	local super_modifier = super_modifier or 0
	local sub_modifier = sub_modifier or 0
	
	
	if (super_modifier > 0) and (sub_modifier > 0) then
		local hit_type = "super crit"
	elseif (super_modifier > 0) or (sub_modifier > 0) then
		local hit_type = "crit"
	elseif not (super_modifier < 0) or (sub_modifier < 0) then
		local hit_type = "normal"
	else
		local hit_type = "weak"
	end
	
	local wpn = weapon_damage * self:getCon()
	local dam = (self.combat.dam + self:getCon()) + (wpn + super_modifier + sub_modifier)
	DamageType:get(damage_type).projector(self, target.x, target.y, damage_type, dam, hit_type)
	self:onHit(damage_type, dam, target)
end

function _M:getSuperModifier(weapon, target)
	local damage = weapon.combat.dam or 0
	if DamageType:get(target.combat.weakness).supertype ==  nil then return end
	if DamageType:get(weapon.combat.damtype).supertype == nil then return end
	if weapon.combat.dam then
		damage = damage * self:getCon()
		if DamageType:get(weapon.combat.damtype).supertype == DamageType:get(target.combat.weakness).supertype then
			return (damage * 0.50)
		end
		if DamageType:get(weapon.combat.damtype).supertype == DamageType:get(target.combat.strength).supertype then
			return (damage * -0.50)
		end
	end
end

function _M:getSubModifier(weapon, target)
	local damage = weapon.combat.dam or 0
	if weapon.combat.dam then
		damage = damage * self:getCon()
		if DamageType:get(weapon.combat.damtype).subtype == DamageType:get(target.combat.weakness).subtype then
			return damage 
		end
		if DamageType:get(weapon.combat.damtype).subtype == DamageType:get(target.combat.strength).subtype then
			return -damage
		end
	end
end

function _M:onHit(damtype, dam, target)
	if damtype == DamageType.ELDRITCH then
			target:setEffect(game.player.EFF_MADNESS, 1, {power = ((dam / 1) * 0.25)})
		end
		
		if damtype == DamageType.SANGUINE then
			self:heal(0.50 * dam, self)
		end
		
		if damtype == DamageType.INFECTED then
			target:setEffect(game.player.EFF_POISON, 5, {power = (dam * 0.25)})
		end
end
