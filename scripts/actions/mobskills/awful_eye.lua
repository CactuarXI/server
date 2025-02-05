-----------------------------------
-- Awful Eye
-- 15' Reduces STR of players in area of effect.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    if mob:getName() == 'Nightmare_Bugard' then
    skill:setMsg(xi.mobskills.mobGazeMove(mob, target, xi.effect.PETRIFICATION, 1, 0, 20))
    end
    skill:setMsg(xi.mobskills.mobGazeMove(mob, target, xi.effect.STR_DOWN, 33, 3, 120))
    return xi.effect.STR_DOWN
end

return mobskillObject
