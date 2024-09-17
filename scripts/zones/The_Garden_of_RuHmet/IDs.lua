-----------------------------------
-- Area: The_Garden_of_RuHmet
-----------------------------------
zones = zones or {}

zones[xi.zone.THE_GARDEN_OF_RUHMET] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        PARTY_MEMBERS_HAVE_FALLEN     = 7410, -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED     = 7417, -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        CONQUEST_BASE                 = 7452, -- Tallying conquest results...
        PORTAL_WONT_OPEN_ON_THIS_SIDE = 7625, -- The portal won't open from this side.
        NO_NEED_INVESTIGATE           = 7631, -- There is no need to investigate further.
        PORTAL_SEALED                 = 7660, -- The portal is firmly sealed by a mysterious energy.
        UNKNOWN_PRESENCE              = 7768, -- You sense some unknown presence...
        NONE_HOSTILE                  = 7769, -- You sense some unknown presence, but it does not seem hostile.
        MENACING_CREATURES            = 7770, -- Menacing creatures appear out of nowhere!
        SHEER_ANIMOSITY               = 7771, -- <name> is enveloped in sheer animosity!
        HOMEPOINT_SET                 = 7776, -- Home point set!

        -- TODO Shift IDs
        TIME_IN_THE_BATTLEFIELD_IS_UP = 7065, -- Your time in the battlefield is up! Now exiting...
        PARTY_MEMBERS_ARE_ENGAGED     = 7080, -- The battlefield where your party members are engaged in combat is locked. Access is denied.
        MEMBERS_OF_YOUR_PARTY         = 7371, -- Currently, # members of your party (including yourself) have clearance to enter the battlefield.
        MEMBERS_OF_YOUR_ALLIANCE      = 7372, -- Currently, # members of your alliance (including yourself) have clearance to enter the battlefield.
        TIME_LIMIT_FOR_THIS_BATTLE_IS = 7374, -- The time limit for this battle is <number> minutes.
        ENTERING_THE_BATTLEFIELD_FOR  = 7615, -- Entering the battlefield for [When Angels Fall/]!
        YOU_MUST_MOVE_CLOSER          = 7623, -- You must move closer.
    },

    mob =
    {
        AWAERN_DRG_GROUPS = -- First Aw'Aerns in each group. Used to randomize the mobID as the new placeholder.
        {
            16920777,
            16920781,
            16920785,
            16920789,
        },

        AWAERN_DRK_GROUPS =
        {
            16920646, -- SW
            16920651, -- NW
            16920660, -- NE
            16920665, -- SE
        },

        JAILER_OF_FORTITUDE     = GetFirstID('Jailer_of_Fortitude'),
        KFGHRAH_WHM             = GetFirstID('Kfghrah_WHM'),
        KFGHRAH_BLM             = GetFirstID('Kfghrah_BLM'),
        IXAERN_DRK              = GetFirstID('Ixaern_DRK'),
        JAILER_OF_FAITH         = GetFirstID('Jailer_of_Faith'),
        IXAERN_DRG              = GetFirstID('Ixaern_DRG'),
        IXZDEI_BASE             = GetFirstID('Ixzdei_RDM'),
        IXZDEI_RDM              = GetFirstID('Ixzdei_RDM'),
        QNZDEI_OFFSET           = GetFirstID('Qnzdei'),

        QNZDEI_GROUP_1 =
        {
            16920577,
            16920578,
            16920579,
            16920580,
        },

        QNZDEI_GROUP_2 =
        {
            16920581,
            16920582,
            16920583,
            16920584,
        },

        QNZDEI_GROUP_3 =
        {
            16920585,
            16920586,
            16920587,
            16920588,
        },
    },

    npc =
    {
        QM_JAILER_OF_FORTITUDE  = GetFirstID('qm_jailer_of_fortitude'),
        QM_IXAERN_DRK           = GetFirstID('qm_ixaern_drk'),
        QM_JAILER_OF_FAITH      = GetFirstID('qm_jailer_of_faith'),
        QNZDEI_DOOR_OFFSET      = GetFirstID('_0zw'),
        QM_IXAERN_DRK_POS =
        {
            { -560, 5.00, 239 }, -- Taru-Mithra
            { -600, 5.00, 440 }, -- Mithra-Hume
            { -240, 5.00, 440 }, -- Hume-Elvaan
            { -280, 5.00, 240 }, -- Elvaan-Galka
        },

        QM_JAILER_OF_FORTITUDE_POS =
        {
            { -420.00, 0.00, 755.00 }, -- North / Hume tower.
            {  -43.00, 0.00, 460.00 }, -- NE / Elvaan tower.
            { -260.00, 0.00, 44.821 }, -- SE / Galka tower.
            { -580.00, 0.00,  43.00 }, -- SW / Tarutaru tower.
            { -796.00, 0.00, 460.00 }, -- NW / Mithra tower.
        },

        QM_JAILER_OF_FAITH_POS =
        {
            { -420.00, 0.00, -157.00 }, -- North / Hume tower.
            { -157.00, 0.00, -340.00 }, -- NE / Elvaan tower.
            { -260.00, 0.00, -643.00 }, -- SE / Galka tower.
            { -580.00, 0.00, -644.00 }, -- SW / Tarutaru tower.
            { -683.00, 0.00, -340.00 }, -- NW / Mithra tower.
        },
    },
}

return zones[xi.zone.THE_GARDEN_OF_RUHMET]
