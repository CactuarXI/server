-----------------------------------
-- Petro Eyes
-- Description: Petrifies opponents with a gaze attack.
-- Type: Gaze
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Single gaze
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if
        mob:getLocalVar('debuff_Talon') == 1
    then
        return 1
    else
        return 0
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobGazeMove(mob, target, xi.effect.PETRIFICATION, 1, 0, 60))

    return xi.effect.PETRIFICATION
end

return mobskillObject
