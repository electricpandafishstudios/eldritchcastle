startx = 2
starty = 2
defineTile(">", "DOWN", nil, nil, nil)
defineTile("#", "WALL", nil, nil, nil)
defineTile("+", "DOOR", nil, nil, nil)
defineTile("=", "C_DOOR", nil, nil, nil)
defineTile(".", "FLOOR", nil, nil, nil)
defineTile(",", "CARPET", nil, nil, nil)
defineTile("3", "CASTLE_GATE", nil, nil, nil)

-- 7x7

return [[
###=###
#>,,,.#
#.,,,.#
#.,,,.#
#.,,,.#
#..,..#
##333##]]
