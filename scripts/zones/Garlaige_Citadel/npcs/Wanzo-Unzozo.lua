-----------------------------------
-- Area: Garlaige Citadel
--  NPC: Wanzo-Unzozo
-- Type: Quest NPC (Escort for Hire - Windurst)
-- !pos -381 -12 398
-----------------------------------

require('scripts/globals/pathfind')
require('scripts/globals/quests')
-----------------------------------
ID = require('scripts/zones/Garlaige_Citadel/IDs')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(60)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
