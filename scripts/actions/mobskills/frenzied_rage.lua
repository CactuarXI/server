-----------------------------------
-- Frenzied Rage
--
-- Description: Attack Boost
-- Type: Enhancing
-- Utsusemi/Blink absorb: N/A
-- Range: Self
-- Notes: 20% Attack Boost.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power = 20
    local duration = 120
    local master = mob:getMaster()
    local skillID = skill:getID()
    if mob:isPet() then
        if master and master:hasJugPet() and master:checkDistance(mob) < 8.5 then
            local tp = skill:getTP()
            power    = 25
            duration = 180
            duration = math.max(270, duration * (tp/1000)) -- Minimum 4.5 minutes. Maximum 9 minutes.
            master:addStatusEffect(xi.effect.ATTACK_BOOST, power, 0, duration)
            mob:injectActionPacket(master:getID(), 11, 289, 0, 0, 0, 10, 1)
            master:timer(4000, function(masterArg)
                master:messageBasic(xi.msg.basic.GAINS_EFFECT_OF_STATUS, xi.effect.ATTACK_BOOST)
            end)
        end
    end

    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.ATTACK_BOOST, power, 0, duration))
    return xi.effect.ATTACK_BOOST
end

return mobskillObject
