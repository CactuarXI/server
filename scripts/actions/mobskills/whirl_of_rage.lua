-----------------------------------
-- Whirl of Rage
-- Delivers an area attack that stuns enemies. Damage varies with TP.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local ftp    = 2.0
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded * math.random(2, 3))

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.STUN, 1, 0, 4)
    if mob:getName() == 'Nightmare_Weapon' then
        xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.WEIGHT, 40, 0, 30)
        xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.SILENCE, 1, 0, 30)
    end

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    return dmg
end

return mobskillObject
