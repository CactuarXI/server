-----------------------------------
-- Heavy Bellow
-- Description: Additional effect: 'Stun.'
-- Type: Physical (Blunt)
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getZone():getTypeMask() == xi.zoneType.DYNAMIS then
        skill:setAoE(4)
    end
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STUN, 1, 0, 6))

    return xi.effect.STUN
end

return mobskillObject
