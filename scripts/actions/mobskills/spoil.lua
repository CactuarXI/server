-----------------------------------
-- Spoil
--
-- Description: Lowers the strength of target.
-- Type: Enhancing
-- Utsusemi/Blink absorb: Ignore
-- Range: Self
-- Notes: Very sharp evasion increase.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power = target:getStat(xi.mod.STR) * 0.25
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STR_DOWN, power, 10, 300))

    return xi.effect.STR_DOWN
end

return mobskillObject
