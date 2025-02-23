-----------------------------------
-- Area: La Vaule [S]
--   NM: Hawkeyed Dnatbat
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.RANGED_DMG_RATING, 100)
    mob:setMod(xi.mod.RATT, 500)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.random(7200, 18000)) -- 2 to 5 hours
end

return entity
