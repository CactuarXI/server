-----------------------------------
-- Area: La_Vaule_[S] (85)
-----------------------------------
zones = zones or {}

zones[xi.zone.LA_VAULE_S] =
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
        FISHING_MESSAGE_OFFSET        = 7060, -- You can't fish here.
        GATE_IS_LOCKED                = 7206, -- The gate is locked.
        -- CAMPAIGN_RESULTS_TALLIED      = 7598, -- Campaign results tallied.
        DOOR_IS_LOCKED                = 7727, -- The door is locked.
        PARTY_MEMBERS_HAVE_FALLEN     = 8032, -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED     = 8039, -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        GATHERED_DAWNDROPS_LIGHT      = 8347, -- The gathered dawndrops unleash a brilliant light, melding together to form <keyitem>!
        RETRACED_ALL_JUNCTIONS        = 8348, -- You have retraced all junctions of eventualities. Hasten back to where Cait Sith and Lilisette await.

        -- TODO: Shift IDs

        TIME_IN_THE_BATTLEFIELD_IS_UP = 7687, -- Your time in the battlefield is up! Now exiting...
        PARTY_MEMBERS_ARE_ENGAGED     = 7702, -- The battlefield where your party members are engaged in combat is locked. Access is denied.
    },
    mob =
    {
        ASHMAKER_GOTBLUT = GetFirstID('Ashmaker_Gotblut'),
        HAWKEYED_DNATBAT = GetFirstID('Hawkeyed_Dnatbat'),
        GALARHIGG        = GetFirstID('Galarhigg'),
    },
    npc =
    {
        CAMPAIGN_NPC_OFFSET = GetFirstID('Framaraix_TK'), -- San, Bas, Win, Flag +4, CA
    },
}

return zones[xi.zone.LA_VAULE_S]
