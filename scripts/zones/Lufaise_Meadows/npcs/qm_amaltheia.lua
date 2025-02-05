-----------------------------------
-- Area: Lufaise Meadows
--  NPC: ??? - Amaltheia spawn
-- !pos 347.897 -10.895 264.382 24
-----------------------------------
local ID = zones[xi.zone.LUFAISE_MEADOWS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, xi.item.RELIC_SHIELD) and
        npcUtil.popFromQM(player, npc, ID.mob.AMALTHEIA)
    then
        player:confirmTrade()
        player:messageText(npc, ID.text.AMALTHEIA_SPAWN1, false)
        player:messageText(npc, ID.text.AMALTHEIA_SPAWN2, false)
    else
        player:messageSpecial(ID.text.AMALTHEIA_WRONG_TRADE)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.AMALTHEIA_TRIGGER)
end

return entity
