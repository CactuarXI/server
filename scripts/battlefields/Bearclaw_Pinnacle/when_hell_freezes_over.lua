-----------------------------------
-- When Hell Freezes Over
-- Bearclaw Pinnacle ENM, Zephyr Fan
-- !addkeyitem ZEPHYR_FAN
-- !pos 121 -171 758 6
-----------------------------------
local ID = zones[xi.zone.BEARCLAW_PINNACLE]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.BEARCLAW_PINNACLE,
    battlefieldId    = xi.battlefield.id.WHEN_HELL_FREEZES_OVER,
    maxPlayers       = 18,
    levelCap         = 75,
    timeLimit        = utils.minutes(30),
    index            = 2,
    entryNpc         = 'Wind_Pillar_3',
    exitNpc          = 'Wind_Pillar_Exit',
    requiredKeyItems = { xi.ki.ZEPHYR_FAN, message = ID.text.ZEPHYR_RIPS },
    grantXP          = 3500,
    armouryCrates =
    {
        ID.mob.SNOW_DEVIL + 6,
        ID.mob.SNOW_DEVIL + 14,
        ID.mob.SNOW_DEVIL + 22,
    },
})

function content:setupBattlefield(battlefield)
    battlefield:setLocalVar('adds', 2)
end

local handleDeath = function(battlefield, mob)
    if
        battlefield:getLocalVar('wave') >= 3
    then
        content:handleAllMonstersDefeated(battlefield, mob)
    end
end

content:addEssentialMobs({ 'Snow_Devil' })

content.groups =
{
    {
        mobIds =
        {
            {
                ID.mob.SNOW_DEVIL,
                ID.mob.SNOW_DEVIL + 1,
                ID.mob.SNOW_DEVIL + 2,
            },

            {
                ID.mob.SNOW_DEVIL + 8,
                ID.mob.SNOW_DEVIL + 9,
                ID.mob.SNOW_DEVIL + 10,
            },

            {
                ID.mob.SNOW_DEVIL + 16,
                ID.mob.SNOW_DEVIL + 17,
                ID.mob.SNOW_DEVIL + 18,
            },
        },
        death = handleDeath,
    },

    {
        mobIds =
        {
            {
                ID.mob.SNOW_DEVIL + 3,
                ID.mob.SNOW_DEVIL + 4,
                ID.mob.SNOW_DEVIL + 5,
            },

            {
                ID.mob.SNOW_DEVIL + 11,
                ID.mob.SNOW_DEVIL + 12,
                ID.mob.SNOW_DEVIL + 13,
            },

            {
                ID.mob.SNOW_DEVIL + 19,
                ID.mob.SNOW_DEVIL + 20,
                ID.mob.SNOW_DEVIL + 21,
            },
        },
        spawned  = false,
        death = handleDeath,
    },
}

content.loot =
{
    {
        { item = xi.item.NONE,                   weight = 100 },
        { item = xi.item.SQUARE_OF_GALATEIA,     weight = 500 },
        { item = xi.item.SQUARE_OF_KEJUSU_SATIN, weight = 150 },
        { item = xi.item.POT_OF_VIRIDIAN_URUSHI, weight = 250 },
    },

    {
        { item = xi.item.NONE,         weight = xi.loot.weight.EXTREMELY_HIGH },
        { item = xi.item.CLOUD_EVOKER, weight = xi.loot.weight.LOW            },
    },

    {
        quantity = 2,
        { item = xi.item.NONE,                weight = 250 },
        { item = xi.item.MARTIAL_BHUJ,        weight = 125 },
        { item = xi.item.MARTIAL_GUN,         weight = 125 },
        { item = xi.item.MARTIAL_STAFF,       weight = 125 },
        { item = xi.item.HEXEREI_CAPE,        weight = 125 },
        { item = xi.item.SETTLERS_CAPE,       weight = 125 },
        { item = xi.item.SCROLL_OF_RAISE_III, weight = 125 },
    },
}

return content:register()
