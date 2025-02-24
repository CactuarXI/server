-----------------------------------
-- Area: Ceizak Battlegrounds
-- NPC: Root
-----------------------------------
mixins =
{
require('scripts/mixins/families/orobon'),
}
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
