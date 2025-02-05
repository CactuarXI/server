-----------------------------------
-- Area: Phanauet Channel
--  NPC: Riche
-- !pos 5.945 -3.75 13.612 1
-----------------------------------
local ID = zones[xi.zone.PHANAUET_CHANNEL]
require('scripts/globals/barge')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.RICHE_MESSAGE) -- Ticket Count -1 Message
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
