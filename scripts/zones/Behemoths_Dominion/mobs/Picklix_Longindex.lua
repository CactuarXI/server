-----------------------------------
-- Area: Behemoth's Dominion
--   NM: Picklix Longindex
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.STORETP, 500)
end

entity.onMobFight = function(mob, target)
    if mob:getHPP() <= 25 then 
        mob:setMod(xi.mod.STORETP, 1000)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
