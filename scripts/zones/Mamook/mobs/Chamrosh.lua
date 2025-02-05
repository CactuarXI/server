-----------------------------------
-- Area: Mamook
--  ZNM: Chamrosh (Tier-1 ZNM)
-- Does not use normal colibri mimic mechanics, changes form every
-- 2.5 mins. st form mimics all spells 2nd form cast spells from list only
-- todo: when mimics a spell will cast the next tier spell
-----------------------------------
mixins = { require('scripts/mixins/rage') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar('[rage]timer', 3600) -- 60 minutes
    mob:setLocalVar('changeTime', 150)
    mob:setLocalVar('useWise', math.random(25, 50))
    mob:addMod(xi.mod.UFASTCAST, 150)
end

entity.onMobFight = function(mob, target)
    local delay = mob:getLocalVar('delay')
    local lastCast = mob:getLocalVar('LAST_CAST')
    local spell = mob:getLocalVar('COPY_SPELL')
    local changeTime = mob:getLocalVar('changeTime')

    if spell > 0 and not mob:hasStatusEffect(xi.effect.SILENCE) then
        if delay >= 3 then
            mob:castSpell(spell, target)
            mob:setLocalVar('COPY_SPELL', 0)
            mob:setLocalVar('delay', 0)
        else
            mob:setLocalVar('delay', delay + 1)
        end
    end

    if
        mob:getHPP() < mob:getLocalVar('useWise') and
        mob:getLocalVar('usedMainSpec') == 0
    then
        mob:useMobAbility(1702)
        mob:setLocalVar('usedMainSpec', 1)
    end

    if mob:getBattleTime() == changeTime then
        if mob:getAnimationSub() == 0 then
            mob:setAnimationSub(1)
            mob:setSpellList(0)
            mob:setLocalVar('changeTime', mob:getBattleTime() + 150)
        else
            mob:setAnimationSub(0)
            mob:setSpellList(302)
            mob:setLocalVar('changeTime', mob:getBattleTime() + 150)
        end
    end
end

local function determineSpellUpgrade(spellID)
    if (spellID == 21) then -- Holy
        return spellID + 1
    elseif (spellID >= 23 and spellID <= 24) then -- Dia I & II
        return spellID + 1
    elseif (spellID >= 28 and spellID <= 30) then -- Banish I - III
        return spellID + 1
    elseif (spellID >= 33 and spellID <= 34) then -- Diaga I & III
        return spellID + 1
    elseif (spellID == 56) then -- Slow
        return 79
    elseif (spellID == 58) then -- Paralyze
        return 80
    elseif (spellID >= 144 and spellID <= 146) then -- Fire I - III
        return spellID + 1
    elseif (spellID == 147) then -- Fire IV
        return 204
    elseif (spellID >= 149 and spellID <= 151) then -- Blizzard I - III
        return spellID + 1
    elseif (spellID == 152) then -- Blizzard IV
        return 206
    elseif (spellID >= 154 and spellID <= 156) then -- Aero I - III
        return spellID + 1
    elseif (spellID == 157) then -- Aero IV
        return 208
    elseif (spellID >= 159 and spellID <= 161) then -- Stone I - III
        return spellID + 1
    elseif (spellID == 162) then -- Stone IV
        return 210
    elseif (spellID >= 164 and spellID <= 166) then -- Thunder I - III
        return spellID + 1
    elseif (spellID == 167) then -- Thunder IV
        return 212
    elseif (spellID >= 169 and spellID <= 171) then -- Water I - III
        return spellID + 1
    elseif (spellID == 172) then -- Water IV
        return 214
    elseif (spellID >= 174 and spellID <= 175) then -- Firaga I & II
        return spellID + 1
    elseif (spellID >= 179 and spellID <= 180) then -- Blizzaga I & II
        return spellID + 1
    elseif (spellID >= 184 and spellID <= 185) then -- Aeroga I & II
        return spellID + 1
    elseif (spellID >= 189 and spellID <= 190) then -- Stonega I & II
        return spellID + 1
    elseif (spellID >= 194 and spellID <= 195) then -- Thundaga I & II
        return spellID + 1
    elseif (spellID >= 199 and spellID <= 200) then -- Waterga I & II
        return spellID + 1
    elseif (spellID == 204 or spellID == 206 or spellID == 208 or spellID == 210 or spellID == 212) then -- AMs
        return spellID + 1
    elseif (spellID >= 220 and spellID <= 221) then -- Poison I & II
        return spellID + 1
    elseif (spellID >= 225 and spellID <= 226) then -- Poisonga I & II
        return spellID + 1
    elseif (spellID >= 230 and spellID <= 231) then -- Bio I & II
        return spellID + 1
    elseif (spellID == 245 or spellID == 247) then -- Drain and Aspir
        return spellID + 1
    elseif (spellID == 253) then -- Sleep
        return 259
    elseif (spellID == 254) then -- Blind
        return 276
    elseif (spellID == 320) then -- Katon
        return spellID + 1
    elseif (spellID == 323) then -- Hyoton
        return spellID + 1
    elseif (spellID == 326) then -- Huton
        return spellID + 1
    elseif (spellID == 329) then -- Doton
        return spellID + 1
    elseif (spellID == 332) then -- Raiton
        return spellID + 1
    elseif (spellID == 335) then -- Suiton
        return spellID + 1
    elseif (spellID == 341) then -- Jubaku
        return spellID + 1
    elseif (spellID == 344) then -- Hojo
        return spellID + 1
    elseif (spellID == 347) then -- Kurayami
        return spellID + 1
    elseif (spellID == 350) then -- Dokomori
        return spellID + 1
    elseif (spellID >= 368 and spellID <= 373) then -- Requiem
        return spellID + 1
    elseif (spellID >= 421 and spellID <= 422) then -- Elegy
        return spellID + 1
    end

    return spellID
end

entity.onMagicHit = function(caster, target, spell)
    local spellID = spell:getID()
    if
        spell:tookEffect() and
        target:getAnimationSub() == 1 and
        (caster:isPC() or caster:isPet()) and
        (spellID ~= 533)
    then
        target:setLocalVar('COPY_SPELL', determineSpellUpgrade(spellID))
        target:setLocalVar('LAST_CAST', target:getBattleTime())
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity