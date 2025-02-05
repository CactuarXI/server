-----------------------------------
-- Lodesong
-- Description: Weighs down targets in an area of effect.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if
        mob:getName() == 'Aitvaras' or
        mob:getName() == 'Lost_Aitvaras' or
        mob:getName() == 'Apocalyptic_Beast' and
        not mob:hasStatusEffect(xi.effect.SILENCE) and
        mob:getLocalVar('debuff_Heart') == 0
    then
        return 0
    elseif
        -- can only use if not silenced
        mob:getMainJob() == xi.job.BRD and
        not mob:hasStatusEffect(xi.effect.SILENCE)
    then
        return 0
    
    else
        return 1
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.WEIGHT, 50, 0, 50))

    return xi.effect.WEIGHT
end

return mobskillObject
