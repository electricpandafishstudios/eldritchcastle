startx = 9
starty = 11
defineTile(">", "DOWN", nil, nil, nil)
defineTile("#", "WALL", nil, nil, nil)
defineTile("+", "C_DOOR", nil, nil, nil)
defineTile("-", "C_DOOR_OPEN", nil, nil, nil)
defineTile(".", "FLOOR", nil, nil, nil)
defineTile(",", "CARPET", nil, nil, nil)
defineTile("3", "CASTLE_GATE", nil, nil, nil)
defineTile("c", "COBBLESTONE", nil, nil, nil)
defineTile("C", "BROKEN_COBBLESTONE", nil, nil, nil)
defineTile("$", "STONE_RAILING", nil, nil, nil)
defineTile("w", "WINDOW", nil, nil, nil)
defineTile("'", "DIRT", nil, nil, nil)

-- 7x7

return [[
###################
#.................#
#..,,,,,,,,,,,,,..#
#.,,,,,,,,,,,,,,,.#
#..,,,,,,,,,,,,,..#
#.......,,,.......#
###w####+++####w###
''''''#.,,,.#''''''
''''''#.,,,.#''''''
''''''#.,,,.#''''''
''''''#.,,,.#''''''
''''''#..,..#''''''
''''''##333##''''''
'''''''$cCC$'''''''
'''''''$Ccc$'''''''
'''''''$cCc$'''''''
'''''''$ccC$''''''']]
