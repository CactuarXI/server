-----------------------------------
-- Area: Port San d'Oria
--  NPC: Portaure
-----------------------------------
require('scripts/quests/flyers_for_regine')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    quests.ffr.onTrade(player, npc, trade, 3) -- FLYERS FOR REGINE
end

entity.onTrigger = function(player, npc)
    local mirrorMirror = player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.MIRROR_MIRROR)
    local mirrorMirrorProgress = player:getCharVar('[Quest]Mirror_Mirror')
    local fellowParam = xi.fellow_utils.getFellowParam(player)

    if
        mirrorMirror == xi.questStatus.QUEST_ACCEPTED and
        mirrorMirrorProgress == 1
    then
        player:startEvent(745, 0, 0, 0, 0, 0, 0, 0, fellowParam)
    else
        player:startEvent(650)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 745 then
        player:setCharVar('[Quest]Mirror_Mirror', 2)
    end
end

return entity
