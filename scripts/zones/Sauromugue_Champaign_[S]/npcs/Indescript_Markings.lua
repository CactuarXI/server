-----------------------------------
-- Area: Sauromugue Champaign [S]
--  NPC: Indescript Markings
-- !pos 322 24 113 98
-- Quest NPC
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 4 then
        player:setCharVar('DownwardHelix', 4)
    end
end

return entity
