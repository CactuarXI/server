-----------------------------------
-- Putrid Breath
-- Description: Deals breath damage to enemies around the target..
-- Type: Magical
-- Utsusemi/Blink absorb: Ignores Shadows
-- Range: 15' Conal
-- Notes: Only used by Cirrate Christelle
-----------------------------------

-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getLocalVar('itemDebuff_Root') == 0 then
        return 1
    else
    return 0
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = mob:getWeaponDmg() * 8

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.DARK, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 1)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.BREATH, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.BREATH, xi.damageType.DARK)

    return damage
end

return mobskillObject
