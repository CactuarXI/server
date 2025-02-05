-- This file is called by login_campaign.lua and require()'s no file, it should not be require()'d by any
-- other lua scripts, which should instead require() login_campaign.lua directly.

-- TODO: Move this table somewhere untracked so it can be freely modified without polluting the
--       git workspace

-- TODO: Fill in with _commented out entries_ for all the things seen in each category
-- https://www.bg-wiki.com/ffxi/Repeat_Login_Campaign/Past_Login_Campaign_Rewards
---@class prizes : { [integer] : { ['price']: integer, ['items']: { [integer]: xi.item } } }
local prizes =
{
    [1] =
    {
        ['price'] = 10,
        ['items'] =
        {
            xi.item.BEASTMENS_SEAL,    -- 1
            xi.item.KINDREDS_SEAL,     -- 2
            xi.item.EARTH_CLUSTER,     -- 3
            xi.item.WATER_CLUSTER,     -- 4
            xi.item.WIND_CLUSTER,      -- 5
            xi.item.FIRE_CLUSTER,      -- 6
            xi.item.ICE_CLUSTER,       -- 7
            xi.item.LIGHTNING_CLUSTER, -- 8
            xi.item.LIGHT_CLUSTER,     -- 9
            xi.item.DARK_CLUSTER,      -- 10
            4177, -- Buff Token (Self) -- 11
            -- 12. Blank Slot
            -- 13. Blank Slot
            -- 14. Blank Slot
            -- 15. Blank Slot
            -- 16. Blank Slot
            -- 17. Blank Slot
            -- 18. Blank Slot
            -- 19. Blank Slot
            -- 20. Blank Slot

            -- 2955, -- Kindred's Crest
            -- 2956, -- High Kindred's Crest
            -- 2957, -- Sacred Kindred's Crest
        },
    },

    [5] = 
    {
        ['price'] = 100,
        ['items'] =
        {
            4176,  -- 1. Mysterious Gift
            4178,  -- 2. Buff Token (Party)
            27733, -- 3. Straw Hat (Male)
            27734, -- 4. Straw Hat (Female)
            25910, -- 5. Caitsith Subligar
            25909, -- 6. Morbol Subligar
            25850, -- 7. Pretty pink Subligar 
            26965, -- 8. Ta Moko
            -- 9.  Blank Slot
            -- 10. Blank Slot
            -- 11. Blank Slot
            -- 12. Blank Slot
            -- 13. Blank Slot
            -- 14. Blank Slot
            -- 15. Blank Slot
            -- 16. Blank Slot
            -- 17. Blank Slot
            -- 18. Blank Slot
            -- 19. Blank Slot
            -- 20. Blank Slot
            
        },
    },

    [9] =
    {
        ['price'] = 250,
        ['items'] =
        {   
            558,   -- 1. Tarut:The Fool
            559,   -- 2. Tarut:The Death
            561,   -- 3. Tarut:The King
            562,   -- 4. Tarut:The Hermit
            25741, -- 5. Naja Unity Shirt
            26518, -- 6. Jody Shirt
            25743, -- 7. Yoran-Oran Unity Shirt
            25739, -- 8. Aldo Unity Shirt
            26520, -- 9. Akitu Shirt
            25737, -- 10. Apururu Unity Shirt
            25735, -- 11. Ayame Unity Shirt
            25742, -- 12. Flaviria Unity Shirt
            25736, -- 13. Invincible Shield Unity Shirt 
            25740, -- 14. Jakoh Wahcondalo Unity Shirt 
            25738, -- 15. Maat Unity Shirt
            25734, -- 16. Pieuje Unity Shirt
            25744, -- 17. Sylvie Unity Shirt
            26729, -- 18. Corolla
            11482, -- 19. Eyepatch
            23753, -- 20. Sandogasa

        },
    },

    [13] =
    {
        ['price'] = 500,
        ['items'] =
        {
            1418, -- 1. Gem of the East
            1420, -- 2. Gem of the South
            1422, -- 3. Gem of the West
            1424, -- 4. Gem of the North
            1850, -- 5. First Virtue
            1853, -- 6. Second Virtue
            1856, -- 7. Third Virtue
            26496, -- 8. Ageist
            26169, -- 9. Reraise Ring
            27455, -- 10. Pupil's Shoes
            27325, -- 11. Track Pants
            25713, -- 12. Track Shirt
            25911, -- 13. Denim Pants
            27879, -- 14. Overalls (Male)
            27880, -- 15. Overalls (Female)
            26545, -- 16. Mithkabob Shirt
                   -- 17.
                   -- 18.
                   -- 19.
                   -- 20.

    },
},

    [17] =
    {
        ['price'] = 750,
        ['items'] =
        {
            1419,  -- 1. Springstone
            1421,  -- 2. Summerstone
            1423,  -- 3. Autumnstone
            1425,  -- 4. Winterstone
            3339,  -- 5. Honey Wine
            3341,  -- 6. Beastly Shank
            3343,  -- 7. Blue Pondweed
            27631, -- 8. Caitsith Guard
            15554, -- 9. Pelican Ring
            26717, -- 10. Caitsith Cap
            23807, -- 11. Esthete's Masque
            10384, -- 12. Cumulus Masque
            27281, -- 13. Pupil's Trousers
            25778, -- 14. Iratsume Happi (Female)
            25777, -- 15. Iratsugo Happi (Male)
            10594, -- 16. Decennial Hose (Female)
            23809, -- 17. Esthete's Hose
            10593, -- 18. Decennial Tights (Male)
            26166, -- 19. Invisible Ring
            26167, -- 20. Sneak Ring
        },

    },

    [21] =
    {
        ['price'] = 1500,
        ['items'] =
        {

            1907, -- 1. Silver Chip
            1908, -- 2. Cerulean Chip
            1909, -- 3. Smalt Chip
            1910, -- 4. Smoky Chip
            1986, -- 5. Orchid Chip
            1987, -- 6. Charcoal Chip
            1988, -- 7. Magenta Chip
            1851, -- 8. Dead of Placidity
            1854, -- 9. Dead of Moderation
            1870, -- 10. Dead of Sensibility
            3340, -- 11. Sweet Tea
            3342, -- 12. Savory Shank
            3344, -- 13. Red Pondweed
            26889, -- 14. Heart Apron
            23800, -- 15. Cancrine Apron
            23805, -- 16. Morbol Apron
            25670, -- 17. Rarab Cap
            25675, -- 18. White Rarab Cap
            26964, -- 19. Pupil's Camisa
            26946, -- 20. Pupil's Shirt
            -- 27765, -- Chocobo Masque
            -- 27911, -- Chocobo Suit
            -- 10429, -- Moogle Masque
            -- 10250, -- Moogle Suit
        },
    },

    [25] =
    {
        ['price'] = 2500,
        ['items'] =
        {
            26490, -- 1. Ark Shield
            23808, -- 2. Esthete's Coat
            10251, -- 3. Decennial Coat (Male)
            10252, -- 4. Decennial Dress (Female)
            25657, -- 5. Wyrmking Masque
            25756, -- 6. Wyrmking Suit
            18464, -- 7. Ark Tachi
            18545, -- 8. Ark Tabar
            18563, -- 9. Ark Scythe
            18912, -- 10. Ark Saber 
            18913, -- 11. Ark Sword
            20573, -- 12. Aern Dagger
            20674, -- 13. Aern Sword
            21742, -- 14. Aern Axe
            21860, -- 15. Aern Spear
            22065, -- 16. Aern Staff
            10430, -- 17. Decennial Crown (Male)
            10431, -- 18. Decennial Tiara (Female)
            27872, -- 19. Purple Spriggan Coat
                   -- 20.
        },
    },

    [29] =
    {
        ['price'] = 4000,
        ['items'] =
        {
            11538, -- 1. Nexus Cape
			10050, -- 2. ♪Tiger
			10051, -- 3. ♪Crab
			10052, -- 4. ♪Red Crab
			10053, -- 5. ♪Bomb
			10054, -- 6. ♪Sheep
			10055, -- 7. ♪Morbol
			10056, -- 8. ♪Crawler
			10058, -- 9. ♪Beetle
			10059, -- 10. ♪Moogle
			10061, -- 11. ♪Tulfaire
			10062, -- 12. ♪Warmachine
			10063, -- 13. ♪Xzmoit
			10064, -- 14. ♪Hippogryph
            28585, -- 15. Craftkeeper's Ring
            28586, -- 16. Craftmaster's Ring
			-- 10065, -- 15. ♪Spectral Chair
			-- 10066, -- 16. ♪Spheroid
			10068, -- 17. ♪Coeurl
			10071, -- 18. ♪Levitus
			10069, -- 19. ♪Goobbue
            26517, -- 20. Shadow Lord Shirt
			-- 10070, -- 20. ♪Raaz
        },
    },

}

return prizes