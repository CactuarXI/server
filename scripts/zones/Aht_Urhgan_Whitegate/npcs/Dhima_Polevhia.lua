-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Dhima Polevhia
-----------------------------------
---@type TNpcEntity
local entity = {}

local craftingItems = {
    [1] = -- puppetry tobe
    {
        materials = {786, 1636, 1699, 2289, {2187, 1}},
        result = 14523
    } , 
    [2] = -- puppetry dastanas
    {
        materials = {821, 2289, 2152, 754, {2186, 1}},
        result = 14930
    },
    [3] = -- puppetry babouches
    {
        materials = {786, 2289, 2152, 754, {2186, 2}},
        result = 15686
    }
}

entity.onTrade = function(player, npc, trade)
    local PuppetmasterBlues = player:getQuestStatus(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.PUPPETMASTER_BLUES)

    if PuppetmasterBlues >= xi.questStatus.QUEST_ACCEPTED then
        if (player:getCharVar('[PUPAF]Current') > 0 and player:getCharVar('[PUPAF]TradeDone') == 0) then
            if (npcUtil.tradeHasExactly(trade, craftingItems[player:getCharVar('[PUPAF]Current')].materials)) then
                player:startEvent(795)
            end
        end
    end
end

entity.onTrigger = function(player, npc)
    local PuppetmasterBlues = player:getQuestStatus(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.PUPPETMASTER_BLUES)

    if PuppetmasterBlues >= xi.questStatus.QUEST_ACCEPTED then
        local remainingPUPAF = player:getCharVar('[PUPAF]Remaining') -- Bitmask of AF the player has NOT crafted
        local totalCraftedPieces = 3 - utils.mask.countBits(remainingPUPAF)
        local currentTask = player:getCharVar('[PUPAF]Current')
        local tradeDone = player:getCharVar('[PUPAF]TradeDone')
        local pickupReady = VanadielUniqueDay() > player:getCharVar('[PUPAF]TradeDay')

        if currentTask == 0 and totalCraftedPieces ~= 3 then
            if totalCraftedPieces == 0 then
                player:startEvent(789) -- first interaction
            else
                player:startEvent(791, 0, 14 - (remainingPUPAF * 2)) -- followup interaction, hides already crafted items
            end
        elseif currentTask > 0 then
            if tradeDone == 0 then
                player:startEvent(790, 0,0,0, currentTask)
            elseif not pickupReady then
                player:startEvent(796) -- patience is a virtue
            else
                player:startEvent(792) -- give item
            end
        elseif totalCraftedPieces == 3 then
            player:startEvent(793) -- Dialogue after crafting all PUP AF
        end
    else
        player:startEvent(788) -- Default dialogue
    end

end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 789 or csid == 791 and option ~=0 then -- choosing CSs
        player:setCharVar('[PUPAF]Current', option)
    end
    local remainingPUPAF = player:getCharVar('[PUPAF]Remaining') -- Bitmask of AF the player has NOT crafted
    local currentTask = player:getCharVar('[PUPAF]Current')

    if csid == 795 then -- Trade Accepted
        player:confirmTrade()
        player:setCharVar('[PUPAF]TradeDay', VanadielUniqueDay())
        player:setCharVar('[PUPAF]TradeDone', 1)
    elseif csid == 792 then --Item Complete
        if npcUtil.giveItem(player, craftingItems[currentTask].result) then
            remainingPUPAF = remainingPUPAF - math.pow(2, (currentTask - 1))
            player:setCharVar('[PUPAF]Remaining', remainingPUPAF)
            player:setCharVar('[PUPAF]Current', 0)
            player:setCharVar('[PUPAF]TradeDone', 0)
            player:setCharVar('[PUPAF]TradeDay', 0)
        end
    end
end

return entity
