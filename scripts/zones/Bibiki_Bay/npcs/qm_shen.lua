-----------------------------------
-- Area: Bibiki Bay
--  NPC: ???
-- Note: Used to spawn Shen
-- !pos -115.108 0.300 -724.664 4
-----------------------------------
local ID = zones[xi.zone.BIBIKI_BAY]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHasExactly(trade, xi.item.SHRIMP_LANTERN) and
        npcUtil.popFromQM(player, npc, ID.mob.SHEN)
    then
        player:messageSpecial(ID.text.SHEN_SPAWN, xi.item.SHRIMP_LANTERN)
        player:confirmTrade()
        player:messageSpecial(ID.text.SHEN_SPAWN)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.SHEN_QM)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
