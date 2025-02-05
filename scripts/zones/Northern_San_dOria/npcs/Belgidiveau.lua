-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Belgidiveau
-- Starts and Finishes Quest: Trouble at the Sluice
-- !pos -98 0 69 231
-----------------------------------
local ID = zones[xi.zone.NORTHERN_SAN_DORIA]
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
