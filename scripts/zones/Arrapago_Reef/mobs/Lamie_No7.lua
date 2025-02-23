-----------------------------------
-- Area: Arrapago Reef
--  Mob: Lamie No.7
-----------------------------------
mixins =
{
    require('scripts/mixins/weapon_break'),
    require('scripts/mixins/job_special')
}
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
end

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.STUN)
    mob:setLocalVar('diceRollNumber', 0)

    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.jsa.WILD_CARD,
              hpp = 95,
              cooldown = 60,
              begCode = function(mob)
                end,
                endCode = function(mob)
                end,
            },
        },
    })
end

entity.onMobRoam = function(mob)
    mob:setLocalVar('diceRollNumber', 0)
end

entity.onMobEngage = function(mob, target)
end

entity.onMobFight = function(mob, target)
    if mob:getLocalVar('diceRollNumber') > 0  and mob:canUseAbilities() and mob:checkDistance(target) < 4 then
        mob:useMobAbility()
        -- print(mob:getLocalVar('diceRollNumber'))
    end
end

entity.onMobWeaponSkillPrepare = function (mob)
    local abilityCount = mob:getLocalVar('diceRollNumber')
    if
        abilityCount > 0 and
        mob:getAnimationSub() == 0 -- Weapon Unbroken
    then
        mob:setLocalVar('diceRollNumber', abilityCount - 1)
        -- print('AbilityCount:', abilityCount)
        return 1752 -- Gusting Gouge
    elseif
        abilityCount > 0 and
        mob:getAnimationSub() == 1 -- Weapon Broken
    then
        mob:setLocalVar('diceRollNumber', abilityCount - 1)
        -- print('AbilityCount:', abilityCount)
        return 1753 -- Hysteric Barrage
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    local abilityCount = mob:getLocalVar('diceRollNumber')
    if -- After using Dukkeripen, pick an random number between 1 and 9. Spam Gusting Gouge/Hysteric Barrage that many times.
        skill:getID() == 1754 or
        skill:getID() == 1755 or
        skill:getID() == 1756 or
        skill:getID() == 1757
    then
        local diceRoll = math.random(1, 9)
        local mobTarget = mob:getTarget()
        if mobTarget:isPC() then
            mobTarget:printToArea(tostring(diceRoll) .. ' ...', xi.msg.channel.SAY, xi.msg.area.SAY, 'Lamie No.7')
        elseif mobTarget:isPet() then
            local petMaster = mobTarget:getMaster()
            petMaster:printToArea(tostring(diceRoll) .. ' ...', xi.msg.channel.SAY, xi.msg.area.SAY, 'Lamie No.7')
        end
        mob:setLocalVar('diceRollNumber', diceRoll)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    -- xi.mob.nmTODPersist(mob, 259200) -- 3 Days
end

entity.onMobDespawn = function(mob)
end

return entity
