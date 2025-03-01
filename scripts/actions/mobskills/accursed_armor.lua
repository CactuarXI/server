-----------------------------------
-- Accursed Armor
-- Family: Behemoth
-- Description: Applies Curse Spikes
-- Type: Enhancing
-- Utsusemi/Blink absorb: N/A
-- Range: Self
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    xi.mobskills.mobBuffMove(mob, xi.effect.CURSE_SPIKES, 20, 0, 180)
    skill:setMsg(xi.msg.basic.NONE)

    return xi.effect.CURSE_SPIKES
end

return mobskillObject
