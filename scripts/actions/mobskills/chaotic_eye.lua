-----------------------------------
-- Chaotic Eye
--
-- Description: Silences an enemy.
-- Type: Magical (Wind)
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:hasStatusEffect(xi.effect.BLINDNESS) then
        return 1
    else
        return 0
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local duration = 120
    local master = mob:getMaster()
    local skillID = skill:getID()
    if mob:isPet() then
        if master and master:hasJugPet() then
            local tp = skill:getTP()
            duration = 260
            duration = math.max(110, duration * (tp/1000)) -- Minimum 1:50 minutes. Maximum 13 minutes.
        end
    end
    skill:setMsg(xi.mobskills.mobGazeMove(mob, target, xi.effect.SILENCE, 1, 0, duration))

    return xi.effect.SILENCE
end

return mobskillObject
