-----------------------------------
-- Spell: Reprisal
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    if caster:isMob() and target:hasStatusEffect(xi.effect.REPRISAL) then
        return 1
    else
        return 0
    end
end

spellObject.onSpellCast = function(caster, target, spell)
    local duration         = calculateDuration(60, spell:getSkillType(), spell:getSpellGroup(), caster, target)
    local reflectedPercent = 33
    caster:delStatusEffectSilent(xi.effect.MANAWELL)
    
    if target:addStatusEffect(xi.effect.REPRISAL, reflectedPercent, 0, duration) then
        spell:setMsg(xi.msg.basic.MAGIC_GAIN_EFFECT)
    else
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    end

    return xi.effect.REPRISAL
end

return spellObject
