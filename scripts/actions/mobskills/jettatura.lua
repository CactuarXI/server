-----------------------------------
-- Jettatura
-- Family: Hippogryph
-- Description: Enemies within a fan-shaped area originating from the caster are frozen with fear.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Cone gaze
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local duration = 10
    local master   = mob:getMaster()
    local skillID  = skill:getID()
    if mob:isPet() then
        if master and master:hasJugPet() then
            local tp = skill:getTP()
            duration = 9
            duration = math.max(15, duration * (tp/1000)) -- Minimum 15 seconds. Maximum 27~ Seconds.
        end
    end
    skill:setMsg(xi.mobskills.mobGazeMove(mob, target, xi.effect.TERROR, 30, 0, duration))

    return xi.effect.TERROR
end

return mobskillObject
