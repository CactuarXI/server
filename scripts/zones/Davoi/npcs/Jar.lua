-----------------------------------
-- Area: Davoi
--  NPC: Jar
-- Involved in Quest: Test my Mettle
-- Notes: Used to obtain Power Sandals
-- !pos <randomized>
-----------------------------------
---@type TNpcEntity
local entity = {}

local move = function(npc)
    local positions =
    {
        { -119.202, 4, 44.765 },
        { -95.542, 3.297, -50.745 },
        { -128.66, 4, -237.566 },
        { -36.727, 3.7471, -218.116 },
        { 58.426, -9.1595, -132.309 },
        { 25.152, 1.1248, -107.308 },
        { 58.939, -9.0408, -160.195 },
        { 204.125, 3.7826, -126.883 },
        { 171.651, -2.6630, -111.846 },
        { 185.165, -0.2327, -189.646 },
        { 232.036, 4, -241.122 },
        { 275.811, 4, -204.266 },
    }
    local newPosition = npcUtil.pickNewPosition(npc:getID(), positions, true)
    npcUtil.queueMove(npc, newPosition)
end

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
