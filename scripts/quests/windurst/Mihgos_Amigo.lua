-----------------------------------
-- Mihgo's Amigo
-----------------------------------
-- !addquest 2 25
-- Nanaa Mihgo: !pos 62   -4    240    241
-- Ardea      : !pos -198 -6   -69     235
-- Varun      : !pos 7.8  -3.5 -10.064 241
-----------------------------------

local quest = Quest:new(xi.questLog.WINDURST, xi.quest.id.windurst.MIHGOS_AMIGO)

local gilPerTrade = 200

quest.reward =
{
    fame = 4, -- Baesd on 212 yag necklaces needed to reach level 4 tenshodo fame.
    fameArea = xi.fameArea.NORG,
    title = xi.title.CAT_BURGLAR_GROUPIE,
}

quest.sections =
{
    {
        -- QUEST AVAILABLE
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getFameLevel(xi.fameArea.NORG) >= 1 and
                player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.THE_TENSHODO_SHOWDOWN) ~= xi.questStatus.QUEST_ACCEPTED and
                player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.AS_THICK_AS_THIEVES) ~= xi.questStatus.QUEST_ACCEPTED and
                not player:hasItem(xi.item.MARAUDERS_KNIFE)
        end,

        [xi.zone.WINDURST_WOODS] =
        {
            ['Nanaa_Mihgo'] =
            {
                onTrigger = function(player, npc)
                    if player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.CRYING_OVER_ONIONS) == xi.questStatus.QUEST_ACCEPTED then
                        return quest:progressEvent(81)
                    else
                        return quest:progressEvent(80)
                    end
                end,
            },

            onEventFinish =
            {
                [80] = function(player, csid, option, npc)
                    return quest:begin(player)
                end,

                [81] = function(player, csid, option, npc)
                    return quest:begin(player)
                end,
            },
        },
    },

    {
        -- QUEST ACCEPTED
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.WINDURST_WOODS] =
        {
            ['Nanaa_Mihgo'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(82)
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { { xi.item.YAGUDO_BEAD_NECKLACE, 4 } }) then
                        return quest:progressEvent(88, { [0] = gilPerTrade })
                    end
                end,
            },

            onEventFinish =
            {
                [88] = function(player, csid, option, npc)
                    player:confirmTrade()
                    player:addGil(gilPerTrade)
                    quest:complete(player)
                    xi.quest.setMustZone(player, xi.questLog.WINDURST, xi.quest.id.windurst.ROCK_RACKETEER)
                end,
            },
        },
    },

    -- QUEST COMPLETE
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.WINDURST_WOODS] =
        {
            ['Nanaa_Mihgo'] =
            {
                onTrigger = function (player, npc)
                    if player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.ROCK_RACKETEER) < xi.questStatus.QUEST_ACCEPTED then
                        return quest:event(89):replaceDefault()
                    end
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { { xi.item.YAGUDO_BEAD_NECKLACE, 4 } }) then
                        return quest:progressEvent(494, { [0] = gilPerTrade })
                    end
                end,
            },

            onEventFinish =
            {
                [494] = function(player, csid, option, npc)
                    player:confirmTrade()
                    player:addGil(gilPerTrade)
                    player:addFame(xi.fameArea.NORG, 4)
                end,
            },
        },
    },
}

return quest
