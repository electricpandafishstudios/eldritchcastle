newEntity{
	define_as = "CASTLE_GATE",
	name = "castle gate", image = "terrain/granite_wall1.png",
	display = '#', color_r=142, color_g=69, color_b=0, back_color=colors.GREY,
	always_remember = true,
	does_block_move = true,
	can_pass = {pass_wall=1},
	block_sight = false,
	air_level = -20,
	dig = "FLOOR",
}

newEntity{
	define_as = "COBBLESTONE",
	name = "cobblestone", image = "terrain/marble_floor.png",
	display = '.', color_r=209, color_g=209, color_b=209, back_color=colors.DARK_GREY,
}
newEntity{
	define_as = "BROKEN_COBBLESTONE",
	name = "broken cobblestone", image = "terrain/marble_floor.png",
	display = '.', color_r=90, color_g=90, color_b=90, back_color=colors.DARK_GREY,
}

newEntity{
	define_as = "STONE_RAILING",
	name = "stone railing", image = "terrain/granite_wall1.png",
	display = '|', color_r=127, color_g=127, color_b=127, back_color=colors.LIGHT_DARK,
	always_remember = true,
	does_block_move = true,
	can_pass = {pass_wall=1},
	block_sight = false,
	air_level = -20,
	dig = "FLOOR",
}

newEntity{
	define_as = "WINDOW",
	name = "window", image = "terrain/granite_wall1.png",
	display = '――', color_r=127, color_g=255, color_b=212, back_color=colors.LIGHT_DARK,
	always_remember = true,
	does_block_move = true,
	can_pass = {pass_wall=1},
	block_sight = false,
	air_level = -20,
	dig = "FLOOR",
}

newEntity{
	define_as = "DIRT",
	name = "dirt", image = "terrain/marble_floor.png",
	display = '.', color_r=209, color_g=209, color_b=209, back_color=colors.UMBER,
}