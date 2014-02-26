newEntity{
	define_as = "CARPET",
	name = "carpet", image = "terrain/marble_floor.png",
	display = '.', color_r=100, color_g=0, color_b=0, back_color=colors.RED,
}

newEntity{
	define_as = "C_DOOR",
	name = "c door", image = "terrain/granite_door1.png",
	display = '+', color_r=238, color_g=154, color_b=77, back_color=colors.RED,
	notice = true,
	always_remember = true,
	block_sight = true,
	door_opened = "C_DOOR_OPEN",
	dig = "C_DOOR_OPEN",
}

newEntity{
	define_as = "C_DOOR_OPEN",
	name = "c open door", image = "terrain/granite_door1_open.png",
	display = "'", color_r=238, color_g=154, color_b=77, back_color=colors.RED,
	always_remember = true,
	door_closed = "C_DOOR",
}