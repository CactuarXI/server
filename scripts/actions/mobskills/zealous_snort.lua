-----------------------------------
-- Zealous Snort
-- Family: Raaz
-- Description: Haste+, MDEF+, Guard+, Counter+
-- Effect handled in xi.effect.COUNTERSTANCE
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.COUNTERSTANCE, 24, 0, 60, 0, 2))
    -- skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.COUNTERSTANCE, 50, 0, math.random(30, 60), 2))

    return xi.effect.COUNTERSTANCE
end

return mobskillObject
