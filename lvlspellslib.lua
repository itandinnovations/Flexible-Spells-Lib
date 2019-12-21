SPELLS_LEVEL_LIST = {
	["Berserk"] = {lvlstorage = 1000, dmgmultiplier = 1.1, increasSize = true, maxlvl = 5} -- multiplier for every lvl!
	["Energy Beam"] = {lvlstorage = 1001, dmgmultiplier = 1.5, increasSize = false, maxlvl = 100}
	["Eternal Winter"] = {lvlstorage = 1002, dmgmultiplier = 1.2, increasSize = false, maxlvl = 200}
}

function Player:doLevelCombat(variant, spellname, effect, area, damagetype, lvl, mlvl, skill, attack, min, max)
local spelllvl = SPELLS_LEVEL_LIST[spellname].lvlstorage
local mox = self:lvlDmg(spellname, SPELLS_LEVEL_LIST[spellname].lvlstorage, min, max)
		if doAreaCombatHealth(self, damagetype, variant:getNumber() > 0 and variant:getPosition() or self:getPosition(), getSpellArea(area, spellname, self:getStorageValue(spelllvl)), -mox, -mox, effect) == true then
			if SPELLS_LEVEL_LIST[spellname] then
				if self:getStorageValue(spelllvl) < SPELLS_LEVEL_LIST[spellname].maxlvl then
					self:addCustomSkillTry(spellname, spelllvl)
				end
			end
		return true				
		end
		
return false		
end

function getSpellArea(defaultarea, spellname, level)
	level = level - 1


	for i = 1, #SPELLS_LEVEL_AREAS do
		if SPELLS_LEVEL_AREAS[i] == defaultarea then	
			if SPELLS_LEVEL_LIST[spellname] then
				if not SPELLS_LEVEL_LIST[spellname].increasSize then
					return arrs[i]
				end
			end
				if i+level < #SPELLS_LEVEL_AREAS then -- to prevent bug if reached last array..
					return arrs[i+level]
				else
					print(">> Spell level system warning: Spell has reached maximum potential, create more areas or lower max level limit.")	
					return arrs[#arrs] -- just use biggest area then...
				end
		end
	end
end

function Player:lvlDmg(spellname, lvlstorage, min, max)
	if SPELLS_LEVEL_LIST[spellname] then
		local level, mult = self:getStorageValue(SPELLS_LEVEL_LIST[spellname].lvlstorage), (SPELLS_LEVEL_LIST[spellname].dmgmultiplier - 1)
			min = min * (1 + ((level * mult)))
			max = max * (1 + ((level * mult)))
		return math.random(min, max)
	end
	print(">> Spell level system warning: This spell isn't registered yet.")
	return math.random(min, max)
end

function Player:getAtk()
	local hands = {CONST_SLOT_LEFT, CONST_SLOT_RIGHT}
	for i = 1, #hands do
		local wep = self:getSlotItem(i)
		if wep then
			if wep:getType():getAttack() > 0 and wep:getType():getWeaponType() > 0 then
			return wep:getType():getAttack(), wep:getType():getWeaponType()
			end
		end
	end
	return 0
end

function Player:getWepSkill()		
	local hands = {CONST_SLOT_LEFT, CONST_SLOT_RIGHT}
	for i = 1, #hands do
		local wep = self:getSlotItem(i)
			if wep == 1 then return self:getEffectiveSkillLevel(SKILL_SWORD)
			elseif wep == 2 then return self:getEffectiveSkillLevel(SKILL_CLUB)	
			elseif wep == 3 then return self:getEffectiveSkillLevel(SKILL_AXE)
			end
	end
return 10
end
