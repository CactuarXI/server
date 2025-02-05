-----------------------------------
-- Area: Horlais Peak
--  Mob: Pilwiz
-- BCNM: Carapace Combatants
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
