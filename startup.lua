dofile('data/spells/lib/spells.lua')

SPELLS_LEVEL_AREAS = { -- areas.. higher number is higher level, where spell starts is based on 'base area' exori starts at 1, gfb at 4...
	[1] = "AREA_SQUARE1X1", 
	[2] = "AREA_SQUARE2X2", 
	[3] = "AREA_CIRCLE2X2", 
	[4] = "AREA_CIRCLE3X3", 
	[5] = "AREA_CROSS5X5"
}

arrs = {}

for y = 1, #SPELLS_LEVEL_AREAS do
	table.insert(arrs, createCombatArea(_G[SPELLS_LEVEL_AREAS[y]]))
end
