-----------------------------------
-- Area: Open Sea Route to Al Zhabi
--   NM: Gugru Orobon
-- Note: Fished up
-----------------------------------
mixins = { require('scripts/mixins/families/orobon') }
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setBaseSpeed(40) -- Reportedly has lower movement speed
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
end

return entity
