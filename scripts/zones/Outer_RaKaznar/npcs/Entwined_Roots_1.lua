-----------------------------------
-- Area: Outer Ra'Kaznar
--  NPC: Entwined Roots (1)
-- !pos -222.581 -150 -145.591 274
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(31)
end

entity.onEventFinish = function(player, csid, option, npc)
    -- TODO: Verify that CS moves the player
    if csid == 31 and option == 1 then
        player:setPos(820, 90, -139)
    end
end

return entity
