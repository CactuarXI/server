-----------------------------------
-- Area: QuBia_Arena
-----------------------------------
zones = zones or {}

zones[xi.zone.QUBIA_ARENA] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        LOST_KEYITEM                  = 6394, -- Lost key item: <keyitem>.
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7060, -- Tallying conquest results...
        PARTY_MEMBERS_HAVE_FALLEN     = 7569, -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED     = 7576, -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        FLAT_PREPARE                  = 7635, -- I am Trion, of San d'Oria!
        FLAT_LAND                     = 7636, -- Feel the fire of my forefathers!
        RLB_PREPARE                   = 7637, -- The darkness before me that shrouds the light of good...
        RLB_LAND                      = 7638, -- ...Return to the hell you crawled out from!
        SAVAGE_PREPARE                = 7639, -- The anger, the pain, and the will to survive... Let the spirit of San d'Oria converge within this blade.
        SAVAGE_LAND                   = 7640, -- And with this blade I will return the glory to my kingdom's people!
        YOU_DECIDED_TO_SHOW_UP        = 7641, -- So, you decided to show up. Now it's time to see what you're really made of, heh heh heh.
        LOOKS_LIKE_YOU_WERENT_READY   = 7642, -- Looks like you weren't ready for me, were you? Now go home, wash your face, and come back when you think you've got what it takes.
        YOUVE_COME_A_LONG_WAY         = 7643, -- Hm. That was a mighty fine display of skill there, <name>. You've come a long way...
        TEACH_YOU_TO_RESPECT_ELDERS   = 7644, -- I'll teach you to respect your elders!
        TAKE_THAT_YOU_WHIPPERSNAPPER  = 7645, -- Take that, you whippersnapper!
        NOW_THAT_IM_WARMED_UP         = 7646, -- Now that I'm warmed up...
        THAT_LL_HURT_IN_THE_MORNING   = 7647, -- Ungh... That'll hurt in the morning...
        PROMISE_ME_YOU_WONT_GO_DOWN   = 8017, -- Promise you won't go down too easy, okay?
        IM_JUST_GETTING_WARMED_UP     = 8018, -- Haha! I'm just getting warmed up!
        YOU_PACKED_MORE_OF_A_PUNCH    = 8019, -- Hah! You pack more of a punch than I thoughtaru. But I won't go down as easy as old Maat!
        WHATS_THIS_STRANGE_FEELING    = 8020, -- What's this strange feeling...? It's not supposed to end...like...
        HUH_IS_THAT_ALL               = 8021, -- Huh? Is that all? I haven't even broken a sweataru...
        YIKEY_WIKEYS                  = 8022, -- Yikey-wikeys! Get that thing away from meee!
        WHATS_THE_MATTARU             = 8023, -- <Pant, wheeze>... What's the mattaru, <name>? Too much of a pansy-wansy to fight fair?

        -- TODO: Shift IDs
        ENTERING_THE_BATTLEFIELD_FOR  = 7596, -- Entering the battlefield for [The Rank 5 Mission/Come Into My Parlor/E-vase-ive Action/Infernal Swarm/The Heir to the Light/Shattering Stars (PLD)/Shattering Stars (DRK)/Shattering Stars (BRD)/Demolition Squad/Die by the Sword/Let Sleeping Dogs Die/Brothers D'Aurphe/Undying Promise/Factory Rejects/Idol Thoughts/An Awful Autopsy/Celery/Mirror Images/A Furious Finale/Clash of the Comrades/Those Who Lurk in Shadows/Beyond Infinity/Factory Rejects/Demolition Squad/Brothers D'Aurphe/Mumor's Encore]!
        TIME_IN_THE_BATTLEFIELD_IS_UP = 7224, -- Your time in the battlefield is up! Now exiting...
        PARTY_MEMBERS_ARE_ENGAGED     = 7239, -- The battlefield where your party members are engaged in combat is locked. Access is denied.
        NO_BATTLEFIELD_ENTRY          = 7242, -- A mysterious force is sealing the platform.
        TESTIMONY_IS_TORN             = 7282, -- Your <item> is torn...
        TESTIMONY_WEARS               = 7283, -- Your <item> [/rips into shreds!/is on the verge of tearing apart.../is showing signs of wear...] (# [use remains/uses remain].)
        MEMBERS_OF_YOUR_PARTY         = 7530, -- Currently, # members of your party (including yourself) have clearance to enter the battlefield.
        MEMBERS_OF_YOUR_ALLIANCE      = 7531, -- Currently, # members of your alliance (including yourself) have clearance to enter the battlefield.
        TIME_LIMIT_FOR_THIS_BATTLE_IS = 7533, -- The time limit for this battle is <number> minutes.
        ORB_IS_CRACKED                = 7534, -- There is a crack in the %. It no longer contains a monster.
        A_CRACK_HAS_FORMED            = 7535, -- A crack has formed on the <item>, and the beast inside has been unleashed!

        -- TODO: Shift IDs
        SOUL_GEM_REACTS               = 8002, -- The <keyitem> reacts to the <keyitem>, sending a jolt of energy through your veins!
    },

    mob =
    {
        ARCHLICH_TABERQUOAN      = GetFirstID('Archlich_Taberquoan'),
        ATORI_TUTORI             = GetFirstID('Atori-Tutori_qm'),
        CHAHNAMEEDS_STOMACH      = GetFirstID('Chahnameeds_Stomach'),
        DOLL_FACTORY             = GetFirstID('Doll_Factory'),
        GHUL_I_BEABAN            = GetFirstID('Ghul-I-Beaban'),
        MAAT                     = GetFirstID('Maat'),
        NEPHIYL_RAMPARTBREACHER  = GetFirstID('Nephiyl_Rampartbreacher'),
        SEED_ORC                 = GetFirstID('Seed_Orc'),
        VAICOLIAUX_B_DAURPHE     = GetFirstID('Vaicoliaux_B_DAurphe'),
        WARLORD_ROJGNOJ          = GetFirstID('Warlord_Rojgnoj'),
        ANANSI                   = GetFirstID('Anansi'),
        SON_OF_ANANSI            = GetFirstID('Son_of_Anansi'),
        IDOL_THOUGHTS =
        {
            {
                17621122,
                17621123,
                17621124,
                17621125,
            },
            {
                17621127,
                17621128,
                17621129,
                17621130,
            },
            {
                17621132,
                17621133,
                17621134,
                17621135,
            },
        },
    },

    npc =
    {
    },
    hounds =
    {
        17621077,
        17621082,
        17621087,
    },
}

return zones[xi.zone.QUBIA_ARENA]
