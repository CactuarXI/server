-----------------------------------
-- mantid_melee_double
-- 2 hit auto attack.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    if not target:isInfront(mob, 48) or target:checkDistance(mob) > 13  then
        skill:setMsg(xi.msg.basic.NONE)
        return 1
    end

    local numhits = 1
    local accmod  = 1
    local dmgmod  = 2.25
    local info    = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg     = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.DEFENSE_DOWN, 25, 0, 120)
    skill:setMsg(xi.msg.basic.DAMAGE_SECONDARY)
    return dmg
end

return mobskillObject
