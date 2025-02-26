-----------------------------------
--  Stormwind
--  Description: Creates a whirlwind that deals Wind damage to targets in an area of effect.
--  Type: Magical
--  Utsusemi/Blink absorb: Wipes shadows
--  Range: Unknown radial
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = mob:getWeaponDmg() * 5
    local dmgmod = 1

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.WIND, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.TERROR, 1, 0, 10))

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.WIND)

    return damage
end

return mobskillObject
