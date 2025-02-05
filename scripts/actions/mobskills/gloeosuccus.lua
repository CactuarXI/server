-----------------------------------
-- Gloeosuccus
-- Enfeebling
-- Description: Slows down a single target.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local duration = 180
    local master = mob:getMaster()
    local skillID = skill:getID()
    if mob:isPet() then
        if master and master:hasJugPet() then
            local tp = skill:getTP()
            duration = 180
            duration = math.max(280, duration * (tp/1000)) -- Minimum 2:20 minutes. Maximum 4.5 minutes.
        end
    end
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLOW, 1250, 0, duration))

    return xi.effect.SLOW
end

return mobskillObject
