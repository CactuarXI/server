-----------------------------------
-- Geist Wall
-- Description: Dispels one effects from targets in an area of effect.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: 10' radial
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local dispel  = target:dispelStatusEffect()
    local total = 0
    if dispel ~= xi.effect.NONE then
        total = total + 1
        skill:setMsg(xi.msg.basic.NONE)
        mob:messageBasic(xi.msg.basic.SKILL_ERASE, 516, dispel, target)
    else
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT) -- no effect
    end

    if mob:getZone():getTypeMask() == xi.zoneType.DYNAMIS then -- Nightmare Efts can dispel up to 2 additional effects.
        local dispel2 = target:dispelStatusEffect()
        local dispel3 = target:dispelStatusEffect()

        if dispel2 ~= xi.effect.NONE then
            total = total + 1
            mob:messageBasic(xi.msg.basic.SKILL_ERASE, 516, dispel2, target)
        else
            mob:messageBasic(xi.msg.basic.NONE, 0, 0, 0)
        end

        if dispel3 ~= xi.effect.NONE then
            total = total + 1
            mob:messageBasic(xi.msg.basic.SKILL_ERASE, 516, dispel3, target)
        else
            mob:messageBasic(xi.msg.basic.NONE, 0, 0, 0)
        end
    end

    return total
end

return mobskillObject
