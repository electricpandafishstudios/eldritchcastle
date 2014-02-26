newEntity{
	define_as = "CASTLE_GATE",
	name = "castle gate", image = "terrain/granite_wall1.png",
	display = '#', color_r=142, color_g=69, color_b=0, back_color=colors.GREY,
	always_remember = true,
	does_block_move = true,
	can_pass = {pass_wall=1},
	block_sight = true,
	air_level = -20,
	dig = "FLOOR",
}