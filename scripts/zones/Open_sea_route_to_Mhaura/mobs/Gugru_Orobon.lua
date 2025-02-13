-----------------------------------
-- Area: Open Sea route to Mhaura
--  Mob: Gugru Orobon
-----------------------------------
mixins = { require('scripts/mixins/families/orobon') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setBaseSpeed(40) -- Reportedly has lower movement speed
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
end

return entity
