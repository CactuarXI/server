-----------------------------------
-- Area: Rabao
--  NPC: Mileon
-- Type: Lucky Roll Gambler
-- !pos 26.080 8.201 65.297 247
-----------------------------------
local ID = zones[xi.zone.RABAO]
require('scripts/globals/npc_util')
-----------------------------------

---@type TNpcEntity
local entity = {}

entity.onSpawn = function(npc)
    npc:setLocalVar('[LuckyRoll]Rabao', math.random (150, 250)) -- ~observed range from retail
end

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local gil = player:getGil()
    local playCheck = player:getCharVar('[LuckyRoll]Played')
    local winCheck = npc:getLocalVar('[LuckyRoll]RabaoLastWon')

    if playCheck ~= VanadielUniqueDay() and winCheck ~= VanadielUniqueDay() then
        player:startEvent(100, gil)
    else
        player:showText(npc, ID.text.LUCKY_ROLL_GAMEOVER)
    end

end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
