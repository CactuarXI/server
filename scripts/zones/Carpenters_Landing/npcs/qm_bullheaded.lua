-----------------------------------
-- Area: Carpenters' Landing (2)
--  NPC: ???
-- Note: Used to spawn Bullheaded Grosvez
-- !pos 39.877, -7.397, -565.422 2
-----------------------------------
local ID = zones[xi.zone.CARPENTERS_LANDING]
require('scripts/globals/npc_util')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
end

return entity
