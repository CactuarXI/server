-----------------------------------
--  Sarsal Slam
--  Family: Diremite
--  Description: Deals damage to a single target reducing their HP to 1. Resets enmity.
--  Type: Physical
--  Utsusemi/Blink absorb: No
--  Range: Single Target
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)

    local currentHP = target:getHP()
    local damage    = currentHP - 1

    -- if have more hp then 30%, then reduce to 5%
    if currentHP / target:getMaxHP() > 0.1 then
        damage = currentHP * 0.99
    else
        -- else you die
        damage = currentHP
    end

    local dmg = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    mob:resetEnmity(target)
    return dmg
end

return mobskillObject
