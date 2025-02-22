-----------------------------------
-- Area: Aydeewa_Subterrane
-----------------------------------
zones = zones or {}

zones[xi.zone.AYDEEWA_SUBTERRANE] =
{
    text =
    {
        NOTHING_HAPPENS               = 119,  -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6404, -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET         = 6419, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        FISHING_MESSAGE_OFFSET        = 7057, -- You can't fish here.
        MINING_IS_POSSIBLE_HERE       = 7328, -- Mining is possible here if you have <item>.
        SENSE_OMINOUS_PRESENCE        = 8007, -- You sense an ominous presence...
        BLOOD_STAINS                  = 8013, -- The ground is smeared with bloodstains...
        DRAWS_NEAR                    = 8038, -- Something draws near!
        COMMON_SENSE_SURVIVAL         = 8910, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        UNITY_WANTED_BATTLE_INTERACT  = 8974, -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]

        MUSHROOM_GROWING_HERE         = 7413, -- There is a mushroom growing here. It might grow larger if it had some fertilizer.
        MUSHROOM_INTO_MONSTER         = 7416, -- The mushroom has grown into a monster!
        MUSHROOM_GROWN_A_BIT          = 7417, -- The mushroom seems to have grown a bit.
        MUSHROOM_NO_MORE_FERT         = 7418, -- The mushroom does not need any more fertilizer now.
        NO_MORE_SPROUTS               = 7706, -- However, you cannot carry any more sprouts.
    },
    mob =
    {
        BLUESTREAK_GYUGYUROON = GetFirstID('Bluestreak_Gyugyuroon'),
        CHIGRE                = GetFirstID('Chigre'),
        NOSFERATU             = GetFirstID('Nosferatu'),
        PANDEMONIUM_WARDEN    = GetFirstID('Pandemonium_Warden'), -- 2 Copies: +0, +1
        CRYSTAL_EATER         = 17056155,
    },
    npc =
    {
        MUSHROOM_PATCH = GetFirstID('Mushroom_Patch')
    },
}

return zones[xi.zone.AYDEEWA_SUBTERRANE]
