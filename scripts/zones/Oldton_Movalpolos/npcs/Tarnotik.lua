-----------------------------------
-- Area: Oldton Movalpolos
--  NPC: Tarnotik
-- !pos 160.896 10.999 -55.659 11
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getCurrentMission(xi.mission.log_id.COP) >= xi.mission.id.cop.THREE_PATHS and
        npcUtil.tradeHas(trade, xi.item.SNOW_LILY)
    then
        if player:hasKeyItem(xi.ki.SHAFT_2716_OPERATING_LEVER) then
            player:startEvent(54)
        else
            player:startEvent(32)
        end
    end
end

entity.onTrigger = function(player, npc)
    if math.random(1, 100) <= 50 then -- TODO: this isn't retail at all.
        player:startEvent(30)
    else
        player:startEvent(31)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 32 then
        player:confirmTrade()
        xi.teleport.to(player, xi.teleport.id.MINESHAFT)
    elseif csid == 54 and option == 1 then
        player:delKeyItem(xi.ki.SHAFT_2716_OPERATING_LEVER)
    end
end

return entity
