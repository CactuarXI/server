-----------------------------------
-- Area: Heavens Tower
--  NPC: Gamimi
-- Type: GOLD WORLD PASS ARBITER
-- !pos 4 0.1 32 242
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
   -- player:startEvent(10000) -- , 0, 0, 0, 0, 0, -1, 2)
   player:printToPlayer('The Vana\'diel Adventurer Recruitment Program isn\'t running currently. World Passes aren\'t available for purchase at this time.', xi.msg.channel.SAY, npc:getPacketName())
end

return entity
