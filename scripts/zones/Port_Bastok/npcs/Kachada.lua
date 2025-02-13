-----------------------------------
-- Area: Port Bastok
--  NPC: Kachada
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    -- player:startEvent(96)--, 0, 0, 0, 0, 0, -1, 2)
    player:printToPlayer('The Vana\'diel Adventurer Recruitment Program isn\'t running currently. World Passes aren\'t available for purchase at this time.', xi.msg.channel.SAY, npc:getPacketName())
end

return entity
