-----------------------------------
-- Area: Upper Jeuno
--  NPC: Bozz
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getCharVar('theLostCardianVar') > 1 then
        player:startEvent(77)
    else
        player:startEvent(78)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
