-----------------------------------
--  Shockiavona
--  Description: Deals Lightning damage in an area of effect. Additional effect: Stun / Paralysis
--  Type: Magical
--  Utsusemi/Blink absorb: Ignores shadows
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damageMod = 3
    local damage = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg(), xi.element.THUNDER, damageMod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.THUNDER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.THUNDER)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STUN, 1, 0, math.random(5, 7))
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 25, 0, math.random(30, 60))

    return damage
end

return mobskillObject
