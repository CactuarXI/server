-----------------------------------
-- Scream
-- 15' Reduces MND of players in area of effect.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power = target:getStat(xi.mod.MND) * 0.25
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.MND_DOWN, power, 10, 180))
    if mob:getZone():getTypeMask() == xi.zoneType.DYNAMIS then
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.TERROR, 30, 0, 10)

        mob:timer(4000, function(mobArg)
            mob:messageBasic(xi.msg.basic.IS_EFFECT, 306, xi.effect.TERROR, target)
        end)
    end

    return xi.effect.MND_DOWN
end

return mobskillObject
