-----------------------------------
-- Area: Carpenters' Landing
--  NPC: Cofisephe
-- Type: Phanauet Channel Barge Ticket Vendor
-- !pos 210.327 -3.885 -532.511 2
-----------------------------------
local ID = zones[xi.zone.CARPENTERS_LANDING]
require('scripts/globals/barge')
-----------------------------------
local entity = {}
local eventId = 31

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.barge.ticketshopOnTrigger(player, eventId)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.barge.ticketshopOnEventFinish(player, csid, option)
end

return entity
