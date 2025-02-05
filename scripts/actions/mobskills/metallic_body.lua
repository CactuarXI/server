-----------------------------------
-- Metalid Body
--
-- Gives the effect of 'Stoneskin.'
-- Type: Magical
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:hasStatusEffect(xi.effect.STONESKIN) then
        return 1
    else
        return 0
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power = 25 -- ffxiclopedia claims its always 25 on the crabs page. Tested on wootzshell in mt zhayolm..
    local duration = 300
    local master = mob:getMaster()
    local skillID = skill:getID()
    if mob:isPet() then
        if master and master:hasJugPet() and master:checkDistance(mob) <= 8.5 then
            local tp       = skill:getTP()
            duration       = 600
            power          = mob:getMaxHP() * 0.0975
            playerPower    = master:getMaxHP() * 0.0975
            duration       = math.max(600, duration * (tp/1000)) -- Minimum 10 minutes. Maximum 30 minutes.
            master:addStatusEffect(xi.effect.STONESKIN, playerPower, 0, duration)
            mob:injectActionPacket(master:getID(), 11, 192, 0, 0, 0, 10, 1)
            master:timer(4000, function(masterArg)
                master:messageBasic(xi.msg.basic.GAINS_EFFECT_OF_STATUS, xi.effect.STONESKIN)
            end)
        end
    end
    --[[
    if mob:isNM() then
        power = ???  Betting NMs aren't 25 but I don't have data..
    end
    ]]
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.STONESKIN, power, 0, duration))
    return xi.effect.STONESKIN
end

return mobskillObject
