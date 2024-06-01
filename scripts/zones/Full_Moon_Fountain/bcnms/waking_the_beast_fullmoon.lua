-----------------------------------
-- Area: Full Moon Fountain
-- BCNM: Waking the Beast
-----------------------------------
local ID = zones[xi.zone.FULL_MOON_FOUNTAIN]
require('scripts/globals/battlefield')


require('scripts/globals/npc_util')
require('scripts/globals/quests')

-----------------------------------
local battlefieldObject = {}

local loot =
{
    xi.item.CARBUNCLES_CUFFS,
    xi.item.IFRITS_BOW,
    xi.item.SHIVAS_SHOTEL,
    xi.item.TITANS_BASELARDE,
    xi.item.GARUDAS_SICKLE,
    xi.item.LEVIATHANS_COUSE,
    xi.item.RAMUHS_MACE,
}

battlefieldObject.onBattlefieldInitialise = function(battlefield)
    battlefield:setLocalVar('carbuncleHP', 20000)
    battlefield:setLocalVar('phase', 1)
end

battlefieldObject.onBattlefieldTick = function(battlefield, tick)
    xi.battlefield.onBattlefieldTick(battlefield, tick)
end

battlefieldObject.onBattlefieldRegister = function(player, battlefield)
end

battlefieldObject.onBattlefieldEnter = function(player, battlefield)
end

battlefieldObject.onBattlefieldLeave = function(player, battlefield, leavecode)
    if leavecode == xi.battlefield.leaveCode.WON then
        local _, clearTime, partySize = battlefield:getRecord()
        local arg8 = (player:hasCompletedQuest(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.WAKING_THE_BEAST)) and 1 or 0

        if battlefield:getLocalVar('loot') == 0 then
            battlefield:setLocalVar('loot', 1)
            local lootChance = 40

            -- Loot has 3 chances to drop. The droprates are as follows: 40% -> 20% -> 10%
            for i = 1, 3 do
                if math.random(1, 100) < lootChance then
                    player:addTreasure(loot[math.random(1, 7)])
                end

                lootChance = lootChance / 2
            end
        end

        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar('[cs]bit'), arg8)
    elseif leavecode == xi.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

battlefieldObject.onEventUpdate = function(player, csid, option)
end

battlefieldObject.onEventFinish = function(player, csid, option)
    -- Only award players with faded ruby if they have appropriately
    -- progressed through all battlefields.
    if csid == 32001 then
        local key =
        {
            xi.ki.EYE_OF_FLAMES,
            xi.ki.EYE_OF_FROST,
            xi.ki.EYE_OF_GALES,
            xi.ki.EYE_OF_STORMS,
            xi.ki.EYE_OF_TIDES,
            xi.ki.EYE_OF_TREMORS,
            xi.ki.RAINBOW_RESONATOR,
        }
        local check = true

        for i = 1, 7 do
            if not player:hasKeyItem(key[i]) then
                check = false
                return
            end
        end

        if check then
            for i = 1, 7 do
                player:delKeyItem(key[i])
            end

            npcUtil.giveKeyItem(player, xi.ki.FADED_RUBY)
            if option == 0 then
                player:setCharVar('Quest[4][32]Option', 1)
            else
                player:setCharVar('Quest[4][32]Option', 0)
            end
        end
    end
end

return battlefieldObject
