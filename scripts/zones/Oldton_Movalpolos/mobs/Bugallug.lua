-----------------------------------
-- Area: Oldton Movalpolos
--  Mob: Bugallug
-- Note: NM for quest: A Question of Faith
-----------------------------------
local entity = {}

entity.onMobEngage = function(mob)
    -- Immediately uses Bionic Boost and Heavy Whisk
    mob:useMobAbility(359)
    mob:queue(2000, function(mobArg)
        mobArg:useMobAbility(358)
    end)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
