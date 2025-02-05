-----------------------------------
-- Bubble Curtain
--
-- Description: Reduces magical damage received by 50%
-- Type: Enhancing
-- Utsusemi/Blink absorb: N/A
-- Range: Self
-- Notes:Nightmare Crabs use an enhanced version that applies a Magic Defense Boost that cannot be dispelled.
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
        -- hasJugPet is really hasJugPet.  Given an entity it returns true if that entity has a pet and the pet is a jug pet
        -- TODO - Rule of 3 counter = 1 - rename hasJugPet to has, add hasJugPet
        if master and master:hasJugPet() and master:checkDistance(mob) < 8.5 then
            local tp = skill:getTP()
            duration = 180
            duration = math.max(180, duration * (tp/1000)) -- Minimum 3 minutes. Maximum 9 minutes.
            master:addStatusEffect(xi.effect.SHELL, 5000, 0, duration)
            mob:injectActionPacket(master:getID(), 11, 187, 0, 0, 0, 10, 1)
            master:timer(4000, function(masterArg)
                master:messageBasic(xi.msg.basic.GAINS_EFFECT_OF_STATUS, xi.effect.SHELL)
            end)
        end
    end
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.SHELL, 5000, 0, 180))

    return xi.effect.SHELL
end

return mobskillObject
