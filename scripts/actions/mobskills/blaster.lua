-----------------------------------
-- Blaster
--
-- Description: Paralyzes enemy.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows.
-- Range: Melee?
-- Notes: Very potent paralysis xi.effect. Is NOT a Gaze Attack, unlike Chaotic Eye.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local duration = 60
    local master = mob:getMaster()
    local skillID = skill:getID()
    if mob:isPet() then
        if master and master:hasJugPet() then
            local tp = skill:getTP()
            duration = 30
            duration = math.max(45, duration * (tp/1000)) -- Minimum 45 secondss. Maximum 1:30 minutes.
        end
    end
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, math.random(60, 70), 0, duration))

    return xi.effect.PARALYSIS
end

return mobskillObject
