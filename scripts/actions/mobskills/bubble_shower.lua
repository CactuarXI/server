-----------------------------------
-- Bubble Shower
-- Deals Water damage in an area of effect. Additional effect: STR Down
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.STR_DOWN
    local power      = 10
    local bubbleCap = 0
    local hpdmg = 1 / 16

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STR_DOWN, 10, 10, 180)

    if mob:getMaster() then
        bubbleCap = 2000
    else
        bubbleCap = 200
    end

    if mob:getZone():getTypeMask() == xi.zoneType.DYNAMIS then
        power = 20
    end

    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, power, 3, 120)

    local dmgmod = xi.mobskills.mobBreathMove(mob, target, skill, hpdmg, 1, xi.element.WATER, bubbleCap)

    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.WATER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.WATER)

    xi.mobskills.handleMobBurstMsg(mob, target, skill, xi.element.WATER)

    return dmg
end

return mobskillObject
