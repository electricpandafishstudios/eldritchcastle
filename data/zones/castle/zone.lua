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
return {
	name = "Castle",
	level_range = {1, 1},
	-- level_scheme = "player",
	max_level = 3,
	-- decay = {300, 800},
	-- actor_adjust_level = function(zone, level, e) return zone.base_level + e:getRankLevelAdjust() end,
	width = 500, height = 500,
--	all_remembered = true,
	all_lited = true,
	persistent = "zone",
	no_level_connectivity = true,
	no_worldport = true,
	generator =  {
		map = {
			class = "engine.generator.map.Static",
		},
		actor = {},
		object = {},
		trap = {},
	},
	levels =
	{
		[1] = {
			generator = { map = { map = "entrance" }, },
		},
	},
}
