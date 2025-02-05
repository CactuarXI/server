-----------------------------------
-- Harden Shell
-- Description: Enhances defense.
-- Type: Magical (Earth)
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)

    local power = 50

    local duration = 60
    local master = mob:getMaster()
    local skillID = skill:getID()
    if mob:isPet() then
        -- hasJugPet is really hasJugPet.  Given an entity it returns true if that entity has a pet and the pet is a jug pet
        -- TODO - Rule of 3 counter = 1 - rename hasJugPet to has, add hasJugPet
        if master and master:hasJugPet() and master:checkDistance(mob) < 8.5 then
            local tp = skill:getTP()
            duration = 180
            duration = math.max(60, duration * (tp/1000)) -- Minimum 1 minutes. Maximum 9 minutes.
            master:addStatusEffect(xi.effect.DEFENSE_BOOST, power, 0, duration)
            mob:injectActionPacket(master:getID(), 11, 479, 0, 0, 0, 10, 1)
            master:timer(4000, function(masterArg)
                master:messageBasic(xi.msg.basic.GAINS_EFFECT_OF_STATUS, xi.effect.DEFENSE_BOOST)
            end)
        end
    end
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.DEFENSE_BOOST, 100, 0, duration))

    return xi.effect.DEFENSE_BOOST
end

return mobskillObject
