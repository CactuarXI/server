-----------------------------------
-- Cacophony
-- Description: Self Buff, Only used while standing.
-- Gives the user the effect of counterstance and haste
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
        -- animsub 1 = standing, animsub 0 = all fours
        if mob:getAnimationSub() == 0 then
            return 1
        end
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    xi.mobskills.mobBuffMove(mob, xi.effect.COUNTERSTANCE, 30, 0, 60)
    xi.mobskills.mobBuffMove(mob, xi.effect.HASTE, 30, 0, 60)
    skill:setMsg(xi.msg.basic.NONE)
    return 0
end

return mobskillObject
