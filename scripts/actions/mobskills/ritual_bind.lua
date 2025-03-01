-----------------------------------
-- Ritual Bind
-- Description: AOE. Additional effect: Paralysis and 'Bind'.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 25, 0, 60))

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BIND, 1, 0, 60)

    return xi.effect.PARALYSIS
end

return mobskillObject
