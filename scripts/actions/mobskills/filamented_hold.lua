-----------------------------------
-- Filamented Hold
-- Reduces the attack speed of enemies within a fan-shaped area originating from the caster.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local duration = 120
    local master = mob:getMaster()
    local skillID = skill:getID()
    if mob:isPet() then
        if master and master:hasJugPet() then
            local tp = skill:getTP()
            duration = 120
            duration = math.max(140, duration * (tp/1000)) -- Minimum 2:20 minutes. Maximum 6 minutes.
        end
    end
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLOW, 5000, 0, duration))

    return xi.effect.SLOW
end

return mobskillObject
