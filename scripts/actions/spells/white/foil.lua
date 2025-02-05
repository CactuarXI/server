-----------------------------------
-- Spell: Foil
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    if caster:isMob() and target:hasStatusEffect(xi.effect.FOIL) then
        return 1
    else
        return 0
    end
end

-- https://www.ffxiah.com/forum/topic/56696/foil-potency-and-decay-testing/#3625542
spellObject.onSpellCast = function(caster, target, spell)
    return xi.spells.enhancing.useEnhancingSpell(caster, target, spell)
end

return spellObject
