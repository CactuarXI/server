-----------------------------------
-- Area: Carpenters' Landing
--  NPC: Coupulie
-- !pos -313.585 -3.628 490.944 2
-----------------------------------
require('scripts/globals/barge')
-----------------------------------
---@type TNpcEntity
local entity = {}
local eventId = 32

entity.onTrigger = function(player, npc)
    xi.barge.ticketshopOnTrigger(player, eventId)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.barge.ticketshopOnEventFinish(player, csid, option)
end

return entity
