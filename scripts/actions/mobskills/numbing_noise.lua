-----------------------------------
-- Numbing Noise
-- Description: Creates an unsettling sound. Additional effect: Stun
-- Type: Physical
-- Utsusemi/Blink absorb: Ignore
-- Range: 10' cone
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getZone():getTypeMask() == xi.zoneType.DYNAMIS and not mob:isPet() then
        skill:setAoE(1)
    end
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STUN, 1, 0, 5))

    return xi.effect.STUN
end

return mobskillObject
