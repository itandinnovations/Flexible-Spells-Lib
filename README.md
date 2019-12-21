# Flexile-Spells-Lib
As many of us know that combat area's need to be set up on beforehand, which reduces the manipulation options if we want to change the size/shape of a certain spell by using factors that can only be calculated when it gets 'casted'.. Glad we can index areas beforehand in combination of the doAreaCombatHealth function to create a more flexible system (and it's more simple if you ask me...). This does means if you want to use it you need to rewrite all your spells, or just the spells that you want to make use of this flexible spell system (e.g. the spell level system).

# Example of Usage
```
local spellname, effect, area, damagetype = "Berserk", CONST_ME_HITAREA, "AREA_SQUARE1X1", COMBAT_PHYSICALDAMAGE

function onCastSpell(creature, variant)
	local lvl, mlvl, skill, attack = creature:getLevel(), creature:getMagicLevel(), creature:getWepSkill(), creature:getAtk()
	local min = (lvl / 5) + ((skill * 2) + attack) * 0.5
	local max = (lvl / 5) + ((skill * 2) + attack) * 1.5	
	return creature:doLevelCombat(variant, spellname, effect, area, damagetype, lvl, mlvl, skill, attack, min, max)
end
```
