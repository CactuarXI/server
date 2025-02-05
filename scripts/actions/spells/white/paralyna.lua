-----------------------------------
-- Spell: Paralyna
-- Removes paralysis from target.
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    caster:delStatusEffectSilent(xi.effect.MANAWELL)
    if target:getStatusEffect(xi.effect.PARALYSIS) ~= nil then
        target:delStatusEffect(xi.effect.PARALYSIS)
        spell:setMsg(xi.msg.basic.MAGIC_REMOVE_EFFECT)
    else
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    end

    return xi.effect.PARALYSIS
end

return spellObject
