-----------------------------------
-- Area: Temple of Uggalepih
--  NPC: ??? (Tonberry Rattle ITEM)
-- !pos 269 0 91 159
-----------------------------------
local ID = zones[xi.zone.TEMPLE_OF_UGGALEPIH]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if not player:hasItem(xi.item.TONBERRY_RATTLE) then
        if npcUtil.giveItem(player, xi.item.TONBERRY_RATTLE) then -- Tonberry Rattle
            local positions =
            {
                {126.84, 0.00,  -5.644},
                {126.84, 0.00, -25.704},
                {126.84, 0.00, -86.419},
                {126.84, 0.00,-105.698},
                {113.68, 0.00,-127.061},
                { 93.67, 0.00,-127.061},
            }
            local newPosition = npcUtil.pickNewPosition(npc:getID(), positions)
            npc:setStatus(xi.status.DISAPPEAR)
            npc:setPos(newPosition.x, newPosition.y, newPosition.z)
            npc:updateNPCHideTime(7200) -- 2 hours
        end
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

return entity
