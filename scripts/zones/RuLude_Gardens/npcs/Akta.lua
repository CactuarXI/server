-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Akta
-----------------------------------
local ID = zones[xi.zone.RULUDE_GARDENS]
require('scripts/globals/quests')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local fellowQuest = player:getCharVar('[Quest]Unlisted_Qualities')
    if
        player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.UNLISTED_QUALITIES) == xi.questStatus.QUEST_ACCEPTED and
        not utils.mask.getBit(fellowQuest, 0)
    then
        player:startEvent(10103, 0, 0, 0, 0, 0, 0, 0, player:getFellowValue('fellowid'))
    else
        player:startEvent(116)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if
        csid == 10103 and
        option >= 1 and option <= 3
    then
        player:setFellowValue('size', option * 4)
        player:setCharVar('[Quest]Unlisted_Qualities', utils.mask.setBit(player:getCharVar('[Quest]Unlisted_Qualities'), 0, true))
    end

    --[[
    Adventuring Fellow Size Options:
        3   Pretty tall
        2   Around average
        1   On the small side
    --]]
end

return entity
