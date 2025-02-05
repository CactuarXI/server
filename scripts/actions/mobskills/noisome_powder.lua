-----------------------------------
-- Noisome Powder
-- Reduces attack of targets in area of effect.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if VanadielHour() >= 6 and VanadielHour() <= 18 then
        return 0
    else
        return 1
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local duration = 120
    local power    = 50
    local master   = mob:getMaster()
    local skillID  = skill:getID()
    if mob:isPet() then
        if master and master:hasJugPet() then
            local tp = skill:getTP()
            power    = 15
            duration = 60
            duration = math.max(45, duration * (tp/1000)) -- Minimum 45 seconds. Maximum 3 minutes.
        end
    end
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.ATTACK_DOWN, 40, 0, 120))

    return xi.effect.ATTACK_DOWN
end

return mobskillObject
