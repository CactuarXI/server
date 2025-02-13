-----------------------------------
-- The Merchants Bidding
-----------------------------------
-- Log ID: 0, Quest ID: 69
-- Parvipon : !pos -169 -1 13 230
-----------------------------------
local ID = zones[xi.zone.SOUTHERN_SAN_DORIA]
-----------------------------------

local quest = Quest:new(xi.questLog.SANDORIA, xi.quest.id.sandoria.THE_MERCHANTS_BIDDING)

quest.reward =
{
    fame = 30,
    fameArea = xi.fameArea.SANDORIA,
    gil = 120,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Parvipon'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(90)
                end,
            },

            onEventFinish =
            {
                [90] = function(player, csid, option, npc)
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

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Parvipon'] = quest:progressEvent(88),
        },
    },

    -- These functions check the status of ~= xi.questStatus.QUEST_AVAILABLE to support repeating
    -- the quest.  Does not have to be flagged again to complete an additional time.
    {
        check = function(player, status, vars)
            return status ~= xi.questStatus.QUEST_AVAILABLE
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Parvipon'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { { xi.item.RABBIT_HIDE, 3 } }) then
                        return quest:progressEvent(89)
                    end
                end,
            },

            onEventFinish =
            {
                [89] = function(player, csid, option, npc)
                    player:confirmTrade()
                        if not player:hasCompletedQuest(quest.areaId, quest.questId) then
                            quest:complete(player)
                        else
                            player:addFame(xi.fameArea.SANDORIA, 5)
                            npcUtil.giveCurrency(player, 'gil', xi.settings.main.GIL_RATE * 120)
                        end
                end,
            },
        },
    },
}

return quest
