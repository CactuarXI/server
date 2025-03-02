-----------------------------------
--  Quake Blast
--  Description: Deals Earth damage to enemies within area of effect. Additional effect: Unequip All Equipment
--  Type: Magical
--  Utsusemi/Blink absorb: Wipes shadows
--  Range: 20' radial
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = mob:getWeaponDmg() * 3

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.EARTH, 1, xi.mobskills.magicalTpBonus.NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.EARTH, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.EARTH)

    for i = xi.slot.MAIN, xi.slot.BACK do
        target:unequipItem(i)
    end

    return damage
end

return mobskillObject
