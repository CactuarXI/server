-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Eperdur
-- Starts and Finishes Quest: Healing the Land,
-- !pos 129 -6 96 231
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 681 and option == 0 then
        player:addQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.HEALING_THE_LAND)
        npcUtil.giveKeyItem(player, xi.ki.SEAL_OF_BANISHING)
    elseif csid == 683 then
        if npcUtil.giveItem(player, xi.item.SCROLL_OF_TELEPORT_HOLLA) then
            player:addTitle(xi.title.PILGRIM_TO_HOLLA)
            player:needToZone(true)
            player:addFame(xi.fameArea.SANDORIA, 30)
            player:completeQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.HEALING_THE_LAND)
        end
    end
end

return entity
