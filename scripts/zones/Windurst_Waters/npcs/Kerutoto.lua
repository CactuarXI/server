-----------------------------------
-- Area: Windurst Waters
--  NPC: Kerutoto
-- Involved in Quests:
--   Riding on the Clouds
--   Food for Thought
-- !pos 13 -5 -157
-----------------------------------
local ID = zones[xi.zone.WINDURST_WATERS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
