-----------------------------------
-- Area: Al'Taieu
--  Mob: Qn'xzomit
-- Note: Pet for JOJ
-----------------------------------
-- mixins = { require('scripts/mixins/job_special') }
local ID = zones[xi.zone.ALTAIEU]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobEngage = function(mob)
    mob:timer(30000, function(mobArg)
        mobArg:useMobAbility(xi.jsa.MIJIN_GAKURE)
        mobArg:timer((2000),
        function(mobArg2)
            mobArg2:setHP(0)
        end)
    end)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    mob:setMobMod(xi.mobMod.SPECIAL_SKILL, 0)
    mob:addStatusEffectEx(xi.effect.FLEE, 0, 100, 0, 60)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    if mob:getID() > ID.mob.JAILER_OF_LOVE then
        local jailerOfLove = GetMobByID(ID.mob.JAILER_OF_LOVE)

        if jailerOfLove then
            local xzomitsKilled = jailerOfLove:getLocalVar('JoL_Qn_xzomit_Killed')

            jailerOfLove:setLocalVar('JoL_Qn_xzomit_Killed', xzomitsKilled + 1)
        end
    end
end

return entity
