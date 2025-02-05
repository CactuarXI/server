-----------------------------------
-- Sticky Thread
-- Inflicts slow on targets in a fan-shaped area of effect.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power      = 1250
    if mob:getZone():getTypeMask() == xi.zoneType.DYNAMIS then
        power = 1600
    end
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLOW, power, 0, 120))

    return xi.effect.SLOW
end

return mobskillObject
