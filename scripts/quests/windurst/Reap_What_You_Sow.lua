-----------------------------------
-- Reap What You sow
-----------------------------------
-- !addquest 2 29
-- Mashuu-Ajuu 130 -5 167
-----------------------------------
local ID = zones[xi.zone.WINDURST_WATERS]
-----------------------------------

local quest = Quest:new(xi.questLog.WINDURST, xi.quest.id.windurst.REAP_WHAT_YOU_SOW)

quest.reward =
{
    item = xi.item.STATIONERY_SET,
    gil = 700,
    fame = 75,
    fameArea = xi.fameArea.WINDURST,
}

quest.sections =
{
    {
        -- Players can only start the quest if they are below rank 4 fame
        -- else they must complete let sleeping dogs lie
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
            (player:getFameLevel(xi.fameArea.WINDURST) < 4 or
            player:hasCompletedQuest(xi.questLog.WINDURST, xi.quest.id.windurst.LET_SLEEPING_DOGS_LIE))
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Mashuu-Ajuu'] =
            {
                onTrigger = function(player, npc)
                    if player:getFameLevel(xi.fameArea.WINDURST) >= 4 then
                        return quest:progressEvent(483)
                    else
                        return quest:progressEvent(463, 0, xi.item.SOBBING_FUNGUS, xi.item.BAG_OF_HERB_SEEDS)
                    end
                end,
            },

            onEventFinish =
            {
                [463] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, xi.item.BAG_OF_HERB_SEEDS) and option == 3 then
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Mashuu-Ajuu'] =
            {
                onTrigger = function(player, npc)
                    local rand = math.random()

                    if rand > 0.5 then
                        return quest:progressEvent(464, 0, xi.item.SOBBING_FUNGUS, xi.item.BAG_OF_HERB_SEEDS)
                    else
                        return quest:progressEvent(476)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.item.SOBBING_FUNGUS) then
                        return quest:progressEvent(475, 500, 131)
                    elseif npcUtil.tradeHasExactly(trade, xi.item.DEATHBALL) then
                        return quest:progressEvent(477, 700)
                    end
                end,
            },

            onEventFinish =
            {
                [475] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, xi.item.STATIONERY_SET) then
                        player:confirmTrade()
                        npcUtil.giveCurrency(player, 'gil', 500)
                    end
                end,

                [477] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },
    },
}

return quest
