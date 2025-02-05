-----------------------------------
-- Barrier Tusk
-- Enhances defense and magic defense
-- Marids will only use Barrier Tusk if at least one of their tusks remain unbroken
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
        -- if AnimationSub is 0 or if used by Iriz Ima : AnimationSub(2)
    if mob:getAnimationSub() == 0 or (mob:getID() == 16986429 and mob:getAnimationSub() ~= 2) then
        return 0
    else
        return 1
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    xi.mobskills.mobBuffMove(mob, xi.effect.MAGIC_DEF_BOOST, 30, 0, 90)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.DEFENSE_BOOST, 30, 0, 90))

    return xi.effect.DEFENSE_BOOST
end

return mobskillObject
