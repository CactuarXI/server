-----------------------------------
-- Area: Rabao
--  NPC: Alfesar
-- Starts The Missing Piece
-- !addquest 5 193
-- !pos 22 8 40 247
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local theMissingPiece = player:getQuestStatus(xi.questLog.OUTLANDS, xi.quest.id.outlands.THE_MISSING_PIECE)
    local fame = player:getFameLevel(xi.fameArea.SELBINA_RABAO)

    if theMissingPiece == xi.questStatus.QUEST_AVAILABLE and fame >= 4 then -- start quest
        player:startEvent(6, xi.ki.ANCIENT_TABLET_FRAGMENT)
    elseif
        theMissingPiece == xi.questStatus.QUEST_ACCEPTED and
        not player:hasKeyItem(xi.ki.ANCIENT_TABLET_FRAGMENT) and
        not player:hasKeyItem(xi.ki.TABLET_OF_ANCIENT_MAGIC)
    then
        -- talk to again with quest activated
        player:startEvent(7, xi.ki.ANCIENT_TABLET_FRAGMENT)
    elseif
        theMissingPiece == xi.questStatus.QUEST_ACCEPTED and
        player:hasKeyItem(xi.ki.ANCIENT_TABLET_FRAGMENT) and
        not player:hasKeyItem(xi.ki.TABLET_OF_ANCIENT_MAGIC)
    then
        -- successfully retrieve key item
        player:startEvent(8, xi.ki.ANCIENT_TABLET_FRAGMENT)
    elseif
        theMissingPiece == xi.questStatus.QUEST_ACCEPTED and
        player:hasKeyItem(xi.ki.TABLET_OF_ANCIENT_MAGIC)
    then
        -- They got their Key items. tell them to goto sandy
        player:startEvent(9, 0, xi.ki.ANCIENT_TABLET_FRAGMENT)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 6 then
        player:addQuest(xi.questLog.OUTLANDS, xi.quest.id.outlands.THE_MISSING_PIECE)
    elseif csid == 8 then -- give the player the key items he needs to complete the quest
        player:delKeyItem(xi.ki.ANCIENT_TABLET_FRAGMENT)
        npcUtil.giveKeyItem(player, xi.ki.TABLET_OF_ANCIENT_MAGIC)
        npcUtil.giveKeyItem(player, xi.ki.LETTER_FROM_ALFESAR)
    end
end

return entity
