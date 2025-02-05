-----------------------------------
-- Waking Dreams
-----------------------------------
-- NPCs:
--  Kerutoto (Windurst Waters) !pos 13 -5 -157
-- Tools:
--  !addquest 2 93
-----------------------------------
local ID = zones[xi.zone.WINDURST_WATERS]
-----------------------------------

local quest = Quest:new(xi.questLog.WINDURST, xi.quest.id.windurst.WAKING_DREAMS)

quest.sections =
{
    {
        check = function(player, status, vars)
            return status ~= xi.questStatus.QUEST_ACCEPTED and
                player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.DARKNESS_NAMED) and
                not player:hasKeyItem(xi.ki.VIAL_OF_DREAM_INCENSE) and
                vars.Stage < os.time()
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Kerutoto'] = quest:progressEvent(918),

            onEventFinish =
            {
                [918] = function(player, csid, option, npc)
                    quest:begin(player)
                    npcUtil.giveKeyItem(player, xi.ki.VIAL_OF_DREAM_INCENSE)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status ~= xi.questStatus.QUEST_AVAILABLE
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Kerutoto'] =
            {
                onTrigger = function(player, npc)
                    -- TODO: Options still appear even if player has the item or spell
                    if player:hasKeyItem(xi.ki.WHISPER_OF_DREAMS) then
                        local availRewards = 0
                            + (player:hasItem(xi.item.DIABOLOSS_POLE) and 1 or 0)    -- Diabolos's Pole
                            + (player:hasItem(xi.item.DIABOLOSS_EARRING) and 2 or 0) -- Diabolos's Earring
                            + (player:hasItem(xi.item.DIABOLOSS_RING) and 4 or 0)    -- Diabolos's Ring
                            + (player:hasItem(xi.item.DIABOLOSS_TORQUE) and 8 or 0)  -- Diabolos's Torque
                            + (player:hasSpell(304) and 32 or 16) -- Pact or gil

                        return quest:progressEvent(920,
                            xi.item.DIABOLOSS_POLE,
                            xi.item.DIABOLOSS_EARRING,
                            xi.item.DIABOLOSS_RING,
                            xi.item.DIABOLOSS_TORQUE,
                            { availRewards })
                    end
                end,
            },

            onEventFinish =
            {
                [920] = function(player, csid, option, npc)
                    quest.reward.item = nil
                    quest.reward.gil = nil
                    
                    if option == 1 and not player:hasItem(xi.item.DIABOLOSS_POLE) then
                        quest.reward.item = xi.item.DIABOLOSS_POLE

                    elseif option == 2 and not player:hasItem(xi.item.DIABOLOSS_EARRING) then
                        quest.reward.item = xi.item.DIABOLOSS_EARRING

                    elseif option == 3 and not player:hasItem(xi.item.DIABOLOSS_RING) then
                        quest.reward.item = xi.item.DIABOLOSS_RING

                    elseif option == 4 and not player:hasItem(xi.item.DIABOLOSS_TORQUE) then
                        quest.reward.item = xi.item.DIABOLOSS_TORQUE

                    elseif option == 5 then
                        quest.reward.gil = 15000

                    elseif option == 6 and not player:hasSpell(304) then
                        player:addSpell(304)
                        player:messageSpecial(ID.text.DIABOLOS_UNLOCKED)
                    end

                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.WHISPER_OF_DREAMS)
                        quest:setVar(player, 'Stage', getMidnight())
                    end
                end,
            },
        },
    },
}

return quest
