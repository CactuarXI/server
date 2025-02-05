-----------------------------------
-- Spell: Enthunder II
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    if caster:isMob() and caster:hasStatusEffect(xi.effect.ENTHUNDER_II) then
        return 1
    else
        return 0
    end
end

spellObject.onSpellCast = function(caster, target, spell)
    return xi.spells.enhancing.useEnhancingSpell(caster, target, spell)
end

return spellObject
