-----------------------------------
--  Silence Gas
--  Description: Emits a noxious cloud in a fan-shaped area of effect, dealing Dark damage to all targets. Additional effect: Silence
--  Type: Magical Dark (Element)
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)

    local duration = 60
    local master = mob:getMaster()
    local skillID = skill:getID()
    if mob:isPet() then
        if master and master:hasJugPet() then
            local tp = skill:getTP()
            duration = 40
            duration = math.max(30, duration * (tp/1000)) -- Minimum 4:40 minutes. Maximum 9 minutes.
        end
    end
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SILENCE, 1, 0, duration)

    local dmgmod = xi.mobskills.mobBreathMove(mob, target, skill, 0.25, 2, xi.element.WIND, 800)
    local dmg    = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.WIND, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.DARK)
    return dmg
end

return mobskillObject
