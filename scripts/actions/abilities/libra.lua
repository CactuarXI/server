-----------------------------------
-- Ability: Libra
-- Description: Examines the target's enmity level.
-- Obtained: SCH Level 76
-- Recast Time: 00:01:00
-----------------------------------
---@type TAbility
local abilityObject = {}

function convertJobToJobName(jobid)
	local jobname = {}
	jobname[0] = 'NON'
	jobname[1] = 'WAR'
	jobname[2] = 'MNK'
	jobname[3] = 'WHM'
	jobname[4] = 'BLM'
	jobname[5] = 'RDM'
	jobname[6] = 'THF'
	jobname[7] = 'PLD'
	jobname[8] = 'DRK'
	jobname[9] = 'BST'
	jobname[10] = 'BRD'
	jobname[11] = 'RNG'
	jobname[12] = 'SAM'
	jobname[13] = 'NIN'
	jobname[14] = 'DRG'
	jobname[15] = 'SMN'
	jobname[16] = 'BLU'
	jobname[17] = 'COR'
	jobname[18] = 'PUP'
	jobname[19] = 'DNC'
	jobname[20] = 'SCH'
	jobname[21] = 'GEO'
	jobname[22] = 'RUN'
	return jobname[jobid]
end

function rmvUs(name)
	return string.gsub(name, '_', ' ')
end

function printLines(player,ln)
	local lncounter = 1
	while ln[lncounter] ~= nil and ln[lncounter] ~= 'empty' do
		player:printToPlayer(ln[lncounter],13)
		lncounter = lncounter + 1
	end
end



abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    local ln = {}
	lncounter = 1
	
	ln[1] = 'empty'
	ln[2] = 'empty'
	ln[3] = 'empty'
	ln[4] = 'empty'
	ln[5] = 'empty'
	ln[6] = 'empty'
	ln[7] = 'empty'
	ln[8] = 'empty'
	ln[9] = 'empty'
	ln[10] = 'empty'
	ln[11] = 'empty'
	ln[12] = 'empty'
	ln[13] = 'empty'
	ln[14] = 'empty'
	ln[15] = 'empty'
	
	local schlvl = 0
	if player:getMainJob() == xi.job.SCH then
		schlvl = player:getMainLvl()
	elseif player:getSubJob() == xi.job.SCH then
		schlvl = player:getSubLvl()
	end
	
	if (target:isPC()) or (target:getMainLvl() > schlvl + 20) then -- or (target:isNM() and target:getMainLvl() > schlvl)
		ln[lncounter] = string.format('  The %s is too strong to gauge its weaknesses!',rmvUs(target:getName()))
		printLines(player,ln)
		return 0
	end
	
	ln[lncounter] = string.format('  %s (%s%i/%s%i)',rmvUs(target:getName()),convertJobToJobName(target:getMainJob()),math.max(target:getMainLvl(),1),convertJobToJobName(target:getSubJob()),math.max(target:getSubLvl(),1))
	lncounter = lncounter + 1
	
	if math.random(1,100) < 60 + player:getStat(xi.mod.INT) - target:getStat(xi.mod.INT) then
		local variance = (schlvl + 325 + schlvl - target:getMainLvl()) / 430 -- 75.81% to 93.02% accurate if lvls are equal
		if variance > 405/430 then -- 94.18% cap
			variance = 405/430
		end
		local inaccuracy = math.random(variance*1000,1000)/1000
		if math.random(0,1) == 1 then
			inaccuracy = 1/inaccuracy
		end
		print(string.format('inacc = %f',inaccuracy))
		if math.random() < 0.12 then
			ln[lncounter] = string.format('  Its HP is about %i.',math.floor(target:getHP()*inaccuracy))
			lncounter = lncounter + 1
		elseif math.random() < 0.12 then
			ln[lncounter] = string.format('  Its MP is about %i.',math.floor(target:getMP()*inaccuracy))
			lncounter = lncounter + 1
		else
			local stat = math.random(8,14)
			if stat == 8 then
				ln[lncounter] = string.format('  Its STR is about %i.',math.floor(target:getStat(stat)*inaccuracy)+math.random(0,1))
				lncounter = lncounter + 1
			elseif stat == 9 then
				ln[lncounter] = string.format('  Its DEX is about %i.',math.floor(target:getStat(stat)*inaccuracy)+math.random(0,1))
				lncounter = lncounter + 1
			elseif stat == 10 then
				ln[lncounter] = string.format('  Its VIT is about %i.',math.floor(target:getStat(stat)*inaccuracy)+math.random(0,1))
				lncounter = lncounter + 1
			elseif stat == 11 then
				ln[lncounter] = string.format('  Its AGI is about %i.',math.floor(target:getStat(stat)*inaccuracy)+math.random(0,1))
				lncounter = lncounter + 1
			elseif stat == 12 then
				ln[lncounter] = string.format('  Its INT is about %i.',math.floor(target:getStat(stat)*inaccuracy)+math.random(0,1))
				lncounter = lncounter + 1
			elseif stat == 13 then
				ln[lncounter] = string.format('  Its MND is about %i.',math.floor(target:getStat(stat)*inaccuracy)+math.random(0,1))
				lncounter = lncounter + 1
			elseif stat == 14 then
				ln[lncounter] = string.format('  Its CHR is about %i.',math.floor(target:getStat(stat)*inaccuracy)+math.random(0,1))
				lncounter = lncounter + 1
			end
		end
	end
	
	--[[
	FIRERES                         = 54,
    ICERES                          = 55,
    WINDRES                         = 56,
    EARTHRES                        = 57,
    THUNDERRES                      = 58,
    WATERRES                        = 59,
    LIGHTRES                        = 60,
    DARKRES                         = 61,
	]]
	
	--[[
	SLASHRES                        = 49,
    PIERCERES                       = 50,
    IMPACTRES                       = 51,
    HTHRES                          = 52,
	]]
	
	local mobresist = {}
	local rescounter = 49
	while rescounter < 62 do
		mobresist[rescounter] = target:getMod(rescounter)
		rescounter = rescounter + 1
	end
	
	if mobresist[54] == mobresist[55] and
	mobresist[55] == mobresist[56] and
	mobresist[56] == mobresist[57] and
	mobresist[57] == mobresist[58] and
	mobresist[58] == mobresist[59] and
	mobresist[59] == mobresist[60] and
	mobresist[60] == mobresist[61] and 
	mobresist[54] > 0 then -- strong to all magic
		ln[lncounter] = '  It seems strong against all magic.'
		lncounter = lncounter + 1
	elseif mobresist[54] == mobresist[55] and
	mobresist[55] == mobresist[56] and
	mobresist[56] == mobresist[57] and
	mobresist[57] == mobresist[58] and
	mobresist[58] == mobresist[59] and
	mobresist[59] == mobresist[60] and
	mobresist[60] == mobresist[61] and 
	mobresist[54] < 0 then -- weak to all magic
		ln[lncounter] = '  It seems weak to all magic.'
		lncounter = lncounter + 1
	elseif mobresist[54] == mobresist[55] and
	mobresist[55] == mobresist[56] and
	mobresist[56] == mobresist[57] and
	mobresist[57] == mobresist[58] and
	mobresist[58] == mobresist[59] and
	mobresist[59] == mobresist[60] and
	mobresist[60] == mobresist[61] and 
	mobresist[54] == 0 then -- none
		-- do nothing
    elseif target:getMod(xi.mod.UDMGMAGIC) <= -9500 then
        ln[lncounter] = '  It currently seems immune to magical attacks.'
        lncounter = lncounter + 1
    elseif target:getMod(xi.mod.UDMGMAGIC) <= -5000 then
        ln[lncounter] = '  It currently seems very strong against magical attacks.'
        lncounter = lncounter + 1
    elseif target:getMod(xi.mod.UDMGMAGIC) >= 5000 then
        ln[lncounter] = '  It currently seems very weak against magical attacks.'
        lncounter = lncounter + 1
    elseif target:getMod(xi.mod.UDMGMAGIC) <= -2500 then
        ln[lncounter] = '  It currently seems strong against magical attacks.'
        lncounter = lncounter + 1
    elseif target:getMod(xi.mod.UDMGMAGIC) >= 2500 then
        ln[lncounter] = '  It currently seems weak against magical attacks.'
        lncounter = lncounter + 1 
	else
		
		if mobresist[54] > 0 then
			ln[lncounter] = '  It seems strong against fire.'
			lncounter = lncounter + 1
		elseif mobresist[54] < 0 then
			ln[lncounter] = '  It seems weak to fire.'
			lncounter = lncounter + 1
		end
		
		if mobresist[55] > 0 then
			ln[lncounter] = '  It seems strong against ice.'
			lncounter = lncounter + 1
		elseif mobresist[55] < 0 then
			ln[lncounter] = '  It seems weak to ice.'
			lncounter = lncounter + 1
		end
		
		if mobresist[56] > 0 then
			ln[lncounter] = '  It seems strong against wind.'
			lncounter = lncounter + 1
		elseif mobresist[56] < 0 then
			ln[lncounter] = '  It seems weak to wind.'
			lncounter = lncounter + 1
		end
		
		if mobresist[57] > 0 then
			ln[lncounter] = '  It seems strong against earth.'
			lncounter = lncounter + 1
		elseif mobresist[57] < 0 then
			ln[lncounter] = '  It seems weak to earth.'
			lncounter = lncounter + 1
		end
		
		if mobresist[58] > 0 then
			ln[lncounter] = '  It seems strong against lightning.'
			lncounter = lncounter + 1
		elseif mobresist[58] < 0 then
			ln[lncounter] = '  It seems weak to lightning.'
			lncounter = lncounter + 1
		end
		
		if mobresist[59] > 0 then
			ln[lncounter] = '  It seems strong against water.'
			lncounter = lncounter + 1
		elseif mobresist[59] < 0 then
			ln[lncounter] = '  It seems weak to water.'
			lncounter = lncounter + 1
		end
		
		if mobresist[60] > 0 then
			ln[lncounter] = '  It seems strong against light.'
			lncounter = lncounter + 1
		elseif mobresist[60] < 0 then
			ln[lncounter] = '  It seems weak to light.'
			lncounter = lncounter + 1
		end
		
		if mobresist[61] > 0 then
			ln[lncounter] = '  It seems strong against dark.'
			lncounter = lncounter + 1
		elseif mobresist[61] < 0 then
			ln[lncounter] = '  It seems weak to dark.'
			lncounter = lncounter + 1
		end
		
	end
	
	if mobresist[49] == mobresist[50] and mobresist[50] == mobresist[51] and mobresist[49] < 1000 then
		ln[lncounter] = '  It seems strong against physical attacks.'
		lncounter = lncounter + 1
	elseif mobresist[49] == mobresist[50] and mobresist[50] == mobresist[51] and mobresist[49] > 1000 then
		ln[lncounter] = '  It seems weak to physical attacks.'
		lncounter = lncounter + 1
	else
	
		if mobresist[49] < 1000 then
			ln[lncounter] = '  It seems strong against slashing attacks.'
			lncounter = lncounter + 1
		elseif mobresist[49] > 1000 then
			ln[lncounter] = '  It seems weak to slashing attacks.'
			lncounter = lncounter + 1
		end
		
		if mobresist[50] < 1000 then
			ln[lncounter] = '  It seems strong against piercing attacks.'
			lncounter = lncounter + 1
		elseif mobresist[50] > 1000 then
			ln[lncounter] = '  It seems weak to piercing attacks.'
			lncounter = lncounter + 1
		end
		
		if mobresist[51] < 1000 then
			ln[lncounter] = '  It seems strong against blunt attacks.'
			lncounter = lncounter + 1
		elseif mobresist[51] > 1000 then
			ln[lncounter] = '  It seems weak to blunt attacks.'
			lncounter = lncounter + 1
		end
        
        if target:getMod(xi.mod.UDMGPHYS) <= -9500 then
            ln[lncounter] = '  It currently seems immune to physical attacks.'
            lncounter = lncounter + 1
        elseif target:getMod(xi.mod.UDMGPHYS) <= -5000 then
            ln[lncounter] = '  It currently seems very strong against physical attacks.'
            lncounter = lncounter + 1
        elseif target:getMod(xi.mod.UDMGPHYS) >= 5000 then
            ln[lncounter] = '  It currently seems very weak against physical attacks.'
            lncounter = lncounter + 1
        elseif target:getMod(xi.mod.UDMGPHYS) <= -2500 then
            ln[lncounter] = '  It currently seems strong against physical attacks.'
            lncounter = lncounter + 1
        elseif target:getMod(xi.mod.UDMGPHYS) >= 2500 then
            ln[lncounter] = '  It currently seems weak against physical attacks.'
            lncounter = lncounter + 1
        end
	end
	
	if not target:isPC() then
	--[[local aggro = target:getAggro()
		local link = target:getLink()
		
		if aggro or link then -- Needs binding
			local sound = target:getMobMod(xi.detects.HEARING)
			local sight = target:getMobMod(xi.detects.SIGHT)
			local blood = target:getMobMod(xi.detects.LOWHP)
			local magic = target:getMobMod(xi.detects.MAGIC)

			local str1 = ' '
			local str2 = ' '
			
			--[[if aggro and not link then
				str1 = '  It appears aggressive, '
			elseif not aggro and link then
				str1 = '  It appears alert, '
			elseif aggro and link then
				str1 = '  It appears aggressive and alert, '
			end
			
			if xi.detects.HEARING then
				if not blood and not magic then
					str2 = 'detecting by sound.'
				elseif blood and not magic then
					str2 = 'detecting by sound and blood.'
				elseif not blood and magic then
					str2 = 'detecting by sound and magic.'
				elseif blood and magic then
					str2 = 'detecting by sound, blood and magic.'
				end
			elseif sight then
				if not blood and not magic then
					str2 = 'detecting by sight.'
				elseif blood and not magic then
					str2 = 'detecting by sight and blood.'
				elseif not blood and magic then
					str2 = 'detecting by sight and magic.'
				elseif blood and magic then
					str2 = 'detecting by sight, blood and magic.'
				end
			else
				if blood and not magic then
					str2 = 'detecting by blood.'
				elseif not blood and magic then
					str2 = 'detecting by magic.'
				elseif blood and magic then
					str2 = 'detecting by blood and magic.'
				end
			end
			
			ln[lncounter] = str1 .. str2
			lncounter = lncounter + 1
			
		end]]
		
		if target:isEngaged() then
		
		local name1 = 'empty'
		local enmityamt1 = 0
		local name2 = 'empty'
		local enmityamt2 = 0
		
		local playercount = 0
		
		local enmitylist = target:getEnmityList()
		for _,enmity in ipairs(enmitylist) do
			if enmity.ce + enmity.ve > enmityamt1 then
				name1 = enmity.entity:getName()
				enmityamt1 = enmity.ce + enmity.ve
				playercount = playercount + 1
			end
		end
		
		if playercount > 1 then
			enmitylist = target:getEnmityList()
			for _,enmity in ipairs(enmitylist) do
				if enmity.ce + enmity.ve > enmityamt2 and enmity.ce + enmity.ve ~= enmityamt1 then
					name2 = enmity.entity:getName()
					enmityamt2 = enmity.ce + enmity.ve
				end
			end
		end
		
		if enmityamt1 ~= 0 and enmityamt2 ~= 0 then
			ln[lncounter] = string.format('  It is currently attacking %s and may attack %s next.',name1,name2)
			lncounter = lncounter + 1
		elseif enmityamt1 ~= 0 then
			ln[lncounter] = string.format('  It is currently attacking %s.',name1)
			lncounter = lncounter + 1
		end
		
    end
	
	end
	
	printLines(player,ln)
	
    return 0
end

return abilityObject
