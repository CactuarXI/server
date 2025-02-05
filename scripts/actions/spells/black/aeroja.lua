-----------------------------------
-- Spell: Aeroja
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local debuff = target:getStatusEffect(xi.effect.NINJUTSU_ELE_DEBUFF)
    
    if debuff ~= nil and debuff:getSubPower() == xi.mod.WIND_MEVA then
        local power      = debuff:getPower()
        local duration   = debuff:getDuration()
        local remaining  = math.floor(debuff:getTimeRemaining() / 1000) -- from milliseconds
        power = (power + 15)
        duration = (duration-remaining)
        debuff:setDuration(duration * 1000) -- back to milliseconds
        target:addStatusEffectEx(xi.effect.NINJUTSU_ELE_DEBUFF, 0, power, 0, duration, 0, xi.mod.WIND_MEVA, 0)
        -- caster:printToPlayer(string.format('Duration: %s', duration), xi.msg.channel.SYSTEM_3)
        -- caster:printToPlayer(string.format('Power: %s', power), xi.msg.channel.SYSTEM_3)
    else
        if debuff ~= nil and debuff:getSubPower() ~= xi.mod.WIND_MEVA then
            target:delStatusEffect(xi.effect.NINJUTSU_ELE_DEBUFF)
        end
        target:addStatusEffectEx(xi.effect.NINJUTSU_ELE_DEBUFF, 0, 15, 0, 60, 0, xi.mod.WIND_MEVA, 0)
        -- caster:printToPlayer(string.format('Duration: %s', duration), xi.msg.channel.SYSTEM_3)
        -- caster:printToPlayer(string.format('Power: %s', power), xi.msg.channel.SYSTEM_3)
    end

    return xi.spells.damage.useDamageSpell(caster, target, spell)
end

return spellObject
