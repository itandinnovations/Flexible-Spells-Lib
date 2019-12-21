function setSpellLvl(self, count) -- reduces pressure on server launch, if you have a lot of spells...
	if not count then count = 1 end
	if not self then return end

	local self = Player(self)
	local voc = self:getVocation:getId()

	if self:canLearnSpell(SPELLS_LEVEL_LIST[SPELLS[count]]) then
		player:setStorageValue(SPELLS[count].lvlstorage, 1)
	end
	
	if count < #SPELLS then addEvent(setSpellLvl, 10, self:getId(), count+1) end	
end

function onLogin(player)
if player:getLastLoginSaved() <= 0 then setSpellLvl(player:getId()) end
return true
end
