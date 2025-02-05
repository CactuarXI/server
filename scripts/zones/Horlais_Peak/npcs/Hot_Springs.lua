-----------------------------------
-- Area: Horlais Peak
--  NPC: Hot Springs
-- !pos 444 -37 -18 139
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
    if csid == 2 then
        player:tradeComplete()
        player:addItem(4949) -- Scroll of Jubaku: Ichi
        player:messageSpecial(ID.text.ITEM_OBTAINED, 4949)
        player:addFame(xi.fameArea.NORG, 75)
        player:addTitle(xi.title.CRACKER_OF_THE_SECRET_CODE)
        player:completeQuest(xi.questLog.OUTLANDS, xi.quest.id.outlands.SECRET_OF_THE_DAMP_SCROLL)
    end
end

return entity
