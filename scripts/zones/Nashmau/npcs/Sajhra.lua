-----------------------------------
-- Area: Nashmau
--  NPC: Sajhra
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local PuppetmasterBluesProgress = player:getCharVar("PuppetmasterBluesProgress")

    if(PuppetmasterBluesProgress == 5) then
        player:startEvent(291) -- Iruki-Waraki and Ellie reunite
    else
        player:startEvent(220)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if (csid == 291) then
        player:setCharVar("PuppetmasterBluesProgress", 6)
    end
end

return entity
