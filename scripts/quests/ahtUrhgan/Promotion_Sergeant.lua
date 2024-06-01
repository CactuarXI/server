-----------------------------------
-- Promotion Sergeant
-- Log: 6, Quest: 94
-- Naja Salaheem: !pos 26 -8 -45.5 50
-- Totoroon: !pos -11.8 0 -26 53
-- qm11: !pos 196 0.8 -617 79
-----------------------------------
local ahtUrhganID = zones[xi.zone.AHT_URHGAN_WHITEGATE]
local nashmauID = zones[xi.zone.NASHMAU]
-----------------------------------

local quest = Quest:new(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.PROMOTION_SERGEANT)

quest.reward =
{
    ki    = xi.ki.S_WILDCAT_BADGE,
    title = xi.title.SERGEANT,
}

quest.sections =
{

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
            player:getCharVar('AssaultPromotion') >= 25 and
            player:getQuestStatus(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.PROMOTION_CORPORAL) == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Naja_Salaheem'] = quest:progressEvent(5055), -- may have to speak twice if there is a current TOAU Mission ongoing.

            onEventFinish =
            {
                [5055] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Naja_Salaheem'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:event(5058):importantOnce()
                    elseif quest:getVar(player, 'Prog') == 5 then
                        return quest:progressEvent(5057)
                    end
                end,
            },

            onTriggerAreaEnter =
            {
                [12] = function(player, triggerArea)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(5056)
                    end
                end,
            },

            onEventFinish =
            {
                [5056] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [5057] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:messageSpecial(ahtUrhganID.text.S_PROMOTION)
                        player:delKeyItem(xi.ki.C_WILDCAT_BADGE)
                        player:setCharVar('AssaultPromotion', 0)
                    end
                end,
            },
        },

        [xi.zone.NASHMAU] =
        {
            onTriggerAreaEnter =
            {
                [1] = function(player, triggerArea)
                    if
                        quest:getVar(player, 'Prog') == 1 and
                        quest:getVar(player, 'Wait') < VanadielUniqueDay()
                    then
                        return quest:progressEvent(303)
                    end
                end,
            },

            ['Totoroon'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 2 then
                        return quest:progressEvent(246)
                    elseif quest:getVar(player, 'Prog') == 4 then
                        player:showText(npc, nashmauID.text.TOTOROON_SERGEANT_HINT)
                        return quest:noAction()
                    end
                end,

                onTrade = function(player, npc, trade)
                    if
                        quest:getVar(player, 'Prog') == 3 and
                        npcUtil.tradeHasExactly(trade, xi.item.BOWL_OF_SUTLAC)
                    then
                        return quest:progressEvent(304)
                    end
                end,
            },

            onEventFinish =
            {
                [246] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,

                [303] = function(player, csid, option, npc)
                    if option < 2 then
                        quest:setVar(player, 'Wait', VanadielUniqueDay()) -- only if chose not to assist on either of the dialog option. Otherwise, there is no wait.
                    else
                        quest:setVar(player, 'Prog', 2)
                    end
                end,

                [304] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
                    player:confirmTrade()
                end,
            },
        },

        [xi.zone.CAEDARVA_MIRE] =
        {
            ['qm11'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 4 then
                        return quest:progressEvent(20)
                    end
                end,
            },

            onEventFinish =
            {
                [20] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 5)
                end,
            },
        },
    },
}

return quest
