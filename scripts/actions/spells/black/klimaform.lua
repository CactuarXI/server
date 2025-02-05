-----------------------------------
-- Spell: Klimaform
-- Increases magic accuracy for spells of the same element as current weather
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    if caster:isMob() and target:hasStatusEffect(xi.effect.KLIMAFORM) then
        return 1
    else
        return 0
    end
end

spellObject.onSpellCast = function(caster, target, spell)
    target:addStatusEffect(xi.effect.KLIMAFORM, 1, 0, 180)

    return xi.effect.KLIMAFORM
end

return spellObject
