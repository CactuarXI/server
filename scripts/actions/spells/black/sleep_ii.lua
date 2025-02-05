-----------------------------------
-- Spell: Sleep II
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    local sleepPower = target:getStatusEffect(xi.effect.SLEEP_I)
    if
        caster:isMob() and
        target:hasStatusEffect(xi.effect.SLEEP_I) and
        sleepPower:getPower() >= 2
    then
        return 1
    else
        return 0
    end
end

spellObject.onSpellCast = function(caster, target, spell)
    return xi.spells.enfeebling.useEnfeeblingSpell(caster, target, spell)
end

return spellObject
