-----------------------------------
-- Area: Empyreal_Paradox
-- Name: Apocalypse Nigh
-----------------------------------
local empyrealParadoxID = zones[xi.zone.EMPYREAL_PARADOX]
-----------------------------------

local content = BattlefieldQuest:new({
    zoneId        = xi.zone.EMPYREAL_PARADOX,
    battlefieldId = xi.battlefield.id.APOCALYPSE_NIGH,
    maxPlayers    = 6,
    timeLimit     = utils.minutes(30),
    index         = 1,
    entryNpc      = 'TR_Entrance',
    exitNpc       = 'Transcendental_Radiance',
    questArea     = xi.questLog.JEUNO,
    quest         = xi.quest.id.jeuno.APOCALYPSE_NIGH,
    requiredVar   = 'Quest[3][89]Status',
    requiredValue = 4,
})

function content:onEventFinishWin(player, csid, option, npc)
    if
        player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.APOCALYPSE_NIGH) == xi.questStatus.QUEST_ACCEPTED and
        player:getCharVar('Quest[3][89]Status') == 4
    then
        player:setCharVar('Quest[3][89]Status', 5)
        player:setCharVar('Quest[3][89]Wait', getMidnight())
        player:setPos(540, 0, -514, 63, xi.zone.EMPYREAL_PARADOX)
    end
end

content.groups =
{
    {
        mobIds =
        {
            {
                empyrealParadoxID.mob.KAMLANAUT,
                empyrealParadoxID.mob.KAMLANAUT + 1,
            },

            {
                empyrealParadoxID.mob.KAMLANAUT + 2,
                empyrealParadoxID.mob.KAMLANAUT + 3,
            },

            {
                empyrealParadoxID.mob.KAMLANAUT + 4,
                empyrealParadoxID.mob.KAMLANAUT + 5,
            },
        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
