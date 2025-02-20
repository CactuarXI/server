-----------------------------------
-- Area: Wajaom_Woodlands
-----------------------------------
zones = zones or {}

zones[xi.zone.WAJAOM_WOODLANDS] =
{
    text =
    {
        NOTHING_HAPPENS               = 119,  -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        GIGANTIC_WARHORSE             = 6400, -- You find the hoofprint of a gigantic warhorse...≺Prompt≻
        PLACE_QUARTZ                  = 6401, -- You set the ≺Possible Special Code: 01≻≺Possible Special Code: 05≻3≺BAD CHAR: 8280≻≺BAD CHAR: 80≻≺BAD CHAR: 80≻ in the warhorse hoofprint.≺Prompt≻
        FELLOW_MESSAGE_OFFSET         = 6419, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        FISHING_MESSAGE_OFFSET        = 7057, -- You can't fish here.
        DIG_THROW_AWAY                = 7070, -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING                  = 7072, -- You dig and you dig, but find nothing.
        PLACE_HYDROGAUGE              = 7350, -- You set the <item> in the glowing trench.
        ENIGMATIC_LIGHT               = 7351, -- The <item> is giving off an enigmatic light.
        LEYPOINT                      = 7406, -- An eerie red glow emanates from this stone platform. The surrounding air feels alive with energy...
        HARVESTING_IS_POSSIBLE_HERE   = 7414, -- Harvesting is possible here if you have <item>.
        GIWAHB_WATCHTOWER_LOCKED      = 7988, -- The door is locked...
        INCREASED_STANDING            = 7989, -- Your Imperial Standing has increased!
        HEADY_FRAGRANCE               = 8493, -- The heady fragrance of wine pervades the air...
        BROKEN_SHARDS                 = 8495, -- Broken shards of insect wing are scattered all over...
        PAMAMA_PEELS                  = 8497, -- Piles of pamama peels litter the ground...
        DRAWS_NEAR                    = 8523, -- Something draws near!
        COMMON_SENSE_SURVIVAL         = 9641, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        UNITY_WANTED_BATTLE_INTERACT  = 9705, -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]

        ITEM_RETURNED                 = 6402, -- A <item ID> is returned to you.
        FOUND_ITEM_WITH_EASE          = 7147,  -- It appears your chocobo found this item with ease.
    },
    mob =
    {
        CHIGOES =
        {
            ['Marid'] = GetTableOfIDs('Chigoe', 5),
        },
        JADED_JODY             = GetFirstID('Jaded_Jody'),
        ZORAAL_JAS_PKUUCHA     = GetFirstID('Zoraal_Jas_Pkuucha'),
        PERCIPIENT_ZORAAL_JA   = GetFirstID('Percipient_Zoraal_Ja'),
        VULPANGUE              = GetFirstID('Vulpangue'),
        IRIZ_IMA               = GetFirstID('Iriz_Ima'),
        GOTOH_ZHA_THE_REDOLENT = GetFirstID('Gotoh_Zha_the_Redolent'),
        TINNIN                 = GetFirstID('Tinnin'),
        CHIGOE_POOLS           =  -- Used for spawning Chigoe during mob weapon skills
        {
            {
                16986118,
                16986119,
                16986120,
                16986121,
                16986122,
            }
        },
        GRAND_MARID1_PH =
        {
            [16986144] = 16986149, -- 142.000 -26.000 284.000
            [16986145] = 16986149, -- 133.000 -26.000 304.000
            [16986150] = 16986149, -- 203.000 -24.000 279.000
            [16986151] = 16986149, -- 207.000 -25.000 294.000
            [16986172] = 16986149, -- 286.000 -24.000 125.000
            [16986178] = 16986149, -- 157.000 -24.000 122.000
            [16986173] = 16986149, -- 278.000 -23.000 113.000
            [16986177] = 16986149, -- 188.000 -24.000 143.000
        },
        GRAND_MARID2_PH =
        {
            [16986144] = 16986174, -- 142.000 -26.000 284.000
            [16986145] = 16986174, -- 133.000 -26.000 304.000
            [16986150] = 16986174, -- 203.000 -24.000 279.000
            [16986151] = 16986174, -- 207.000 -25.000 294.000
            [16986172] = 16986174, -- 286.000 -24.000 125.000
            [16986178] = 16986174, -- 157.000 -24.000 122.000
            [16986173] = 16986174, -- 278.000 -23.000 113.000
            [16986177] = 16986174, -- 188.000 -24.000 143.000
        }
    },
    npc =
    {
        HARVESTING = GetTableOfIDs('Harvesting_Point'),
        HOOFPRINT  = GetFirstID('Warhorse_Hoofprint'),
    },
}

return zones[xi.zone.WAJAOM_WOODLANDS]
