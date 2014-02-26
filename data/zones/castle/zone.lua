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
	level_range = {1, 5},
	max_level = 10,
	decay = {300, 800},
	width = 100, height = 100,
	persistent = "zone",
	all_lited = true,
	--min_material_level = 3,
	--max_material_level = 4,
	no_worldport = true,
	no_level_connectivity = true,
	generator =  {
		map = {
			class = "engine.generator.map.TileSet",
			tileset = {"7x7/base", "7x7/rooms"},
			--start_tiles = {{tile="side_hall", x=50, y=50}},
			['.'] = "FLOOR",
			[','] = "CARPET",
			['#'] = "WALL",
			--door = "DOOR",
			up = "UP",
			down = "DOWN",
		},
		actor = {
			class = "engine.generator.actor.Random",
--			guardian = "SHADE_OF_ANGMAR", -- The guardian is set in the static map
			nb_npc = {5, 10},
		},
		object = {
			-- class = "engine.generator.object.Random",
			-- nb_object = {1, 5},
		},
	},
	levels = {
		[1] = {
			generator =  { map = {
					class = "engine.generator.map.TileSet",
					tileset = {"7x7/base", "7x7/rooms"},
					start_tiles = {{tile="side_hall", x=10, y=10}}, 
					},},
					},
	},
}