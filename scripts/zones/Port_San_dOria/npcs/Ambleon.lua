-----------------------------------
-- Area: Port San d'Oria
--  NPC: Ambleon
-- Type: NPC World Pass Dealer
-- !pos 71.622 -17 -137.134 232
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    -- player:startEvent(710)
    player:printToPlayer('The Vana\'diel Adventurer Recruitment Program isn\'t running currently. World Passes aren\'t available for purchase at this time.', xi.msg.channel.SAY, npc:getPacketName())
end

return entity
