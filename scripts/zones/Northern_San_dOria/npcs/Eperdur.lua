-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Eperdur
-- Starts and Finishes Quest: Healing the Land,
-- !pos 129 -6 96 231
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
    if csid == 681 and option == 0 then
        player:addQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.HEALING_THE_LAND)
        player:addKeyItem(xi.ki.SEAL_OF_BANISHING)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.SEAL_OF_BANISHING)
    elseif csid == 683 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.SCROLL_OF_TELEPORT_HOLLA)
        else
            player:addTitle(xi.title.PILGRIM_TO_HOLLA)
            player:addItem(xi.item.SCROLL_OF_TELEPORT_HOLLA)
            player:messageSpecial(ID.text.ITEM_OBTAINED, xi.item.SCROLL_OF_TELEPORT_HOLLA) -- Scroll of Teleport-Holla
            player:needToZone(true)
            player:addFame(xi.fameArea.SANDORIA, 30)
            player:completeQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.HEALING_THE_LAND)
        end
    end
end

return entity
