-----------------------------------
-- Rage
--
-- Description: The Ram goes berserk
-- Type: Enhancing
-- Utsusemi/Blink absorb: N/A
-- Range: Self
-- Notes: 25% Attack UP, -25% defense DOWN
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
            duration = math.max(270, duration * (tp/1000)) -- Minimum 4.5 minutes. Maximum 9 minutes.
            master:addStatusEffect(xi.effect.BERSERK, 50 + master:getMod(xi.mod.BERSERK_POTENCY), 0, duration + master:getMod(xi.mod.BERSERK_DURATION))
            mob:injectActionPacket(master:getID(), 11, 5, 0, 0, 0, 10, 1)
            master:timer(4000, function(masterArg)
                master:messageBasic(xi.msg.basic.GAINS_EFFECT_OF_STATUS, xi.effect.BERSERK)
            end)
        end
    end

    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.BERSERK, 50, 0, duration))
    return xi.effect.BERSERK
end

return mobskillObject
