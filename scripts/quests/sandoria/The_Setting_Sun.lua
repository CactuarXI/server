-----------------------------------
-- The Setting Sun
-- !addquest 0 72
-- Vamorcote !gotoid 17723526
-- Engraved_Key: !additem 535
-- Ahut !gotoid 17207657
-----------------------------------
require('scripts/globals/interaction/quest')
require('scripts/globals/npc_util')
require('scripts/globals/quests')


-----------------------------------

local quest = Quest:new(xi.questLog.SANDORIA, xi.quest.id.sandoria.THE_SETTING_SUN)

quest.reward =
{
    fame = 30,
    fameArea = xi.fameArea.SANDORIA,
    gil = 10000,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getFameLevel(xi.fameArea.SANDORIA) >= 5
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Vamorcote'] = quest:progressEvent(654, 0, 535, 535),

            onEventFinish =
            {
                [654] = function(player, csid, option, npc)
                    if option == 1 then
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

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Vamorcote'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(655, 0, 0, 535)
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.item.ENGRAVED_KEY) then
                        return quest:progressEvent(658)
                    end
                end,
            },

            onEventFinish =
            {
                [658] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Vamorcote'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(659):replaceDefault()
                end,
            },
        },
    },
}

return quest
