-----------------------------------
-- Gnash
-- Description: Chews on a single target, reducing HP to one half.
-- Type: Physical
-- Notes: Retail testing shows this is more like 45% to 55% of the targets current HP
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    local hpp = mob:getHPP()
    if mob:getID() == 16998874 then
        if hpp > 50 then
    return 0
        else
            return 1
end
    else
        return 0
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = math.floor(target:getHP() * (math.random(45, 55) / 100))
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(damage, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    mob:resetEnmity(target)

    return damage
end

return mobskillObject
