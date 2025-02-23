-----------------------------------
-- Persists NM time of deaths to the database. They must be added to the list here
-- to get this extra behavior.
-- This is useful if you don't want players rushing to NM spawns after a server
-- restart or a crash (or trying to force crashes/restarts to get NM pops)
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('persist_nm_time_of_deaths')

-- NOTE: These names are as they are as filenames.
-- Example: Behemoth's Dominion => Behemoths_Dominion
-- Example: King Behemoth       => King_Behemoth
-- { zone name, mob name, function to generate respawn time}
-- Format:
local nmsToPersist =
{
    {
        'Arrapago_Reef',
        'Medusa',
        function()
            return 259200 -- 3 Days
        end
    },
    {
        'Arrapago_Reef',
        'Merrow_No5',
        function()
            return 259200 -- 3 Days
        end
    },
    {
        'Arrapago_Reef',
        'Lamie_No7',
        function()
            return 259200 -- 3 Days
        end
    },
    {
        'Arrapago_Reef',
        'Lamie_No8',
        function()
            return 259200 -- 3 Days
        end
    },
    {
        'Arrapago_Reef',
        'Lamie_No9',
        function()
            return 259200 -- 3 Days
        end
    },
    {
        'Arrapago_Reef',
        'Euryale',
        function()
            return 7200 -- 2 Hours
        end
    },
    --[[{
        'Arrapago_Reef',
        'Lamia_No19',
        function()
            return math.random(7200, 14400) -- 2 to 4 hours
        end
    },]]
    {
        'Attohwa_Chasm',
        'Tiamat',
        function()
            return math.random(144, 240) * 1800 -- 3 to 5 days in 30 minute windows
        end
    },
    {
        'Attohwa_Chasm',
        'Sekhmet',
        function()
            return math.random(6, 8) * 900 -- 1.5 to 2 hours in 15 minute windows
        end
    },
    {
        'Batallia_Downs',
        'Ahtu',
        function()
            return math.random(7200, 14400) -- 2-4 hours
        end
    },
    {
        'Beaucedine_Glacier',
        'Humbaba',
        function()
            return math.random(3600, 4200) -- 60 to 70 minutes
        end
    },
    {
        'Beaucedine_Glacier_[S]',
        'Scylla',
        function()
            return math.random(14400, 18000) -- 4 to 5 hours
        end
    },
    {
        'Bostaunieux_Oubliette',
        'Drexerion_the_Condemned',
        function()
            return math.random(216000, 259200) -- 60 to 72 hours
        end
    },
    {
        'Bostaunieux_Oubliette',
        'Phanduron_the_Condemned',
        function()
            return math.random(216000, 259200) -- 60 to 72 hours
        end
    },
    {
        'Caedarva_Mire',
        'Khimaira',
        function()
            return math.random(48, 72) * 3600 -- 48 to 72 hours in 60min windows
        end
    },
    {
        'Cape_Teriggan',
        'Zmey_Gorynych',
        function()
            return math.random(3600, 7200) -- 1-2 hours
        end
    },
    {
        'Carpenters_Landing',
        'Tempest_Tigon',
        function()
            return math.random(3600, 7200) -- 1 to 2 hours
        end
    },
    {
        'Castle_Zvahl_Baileys',
        'Likho',
        function()
            return math.random(3600, 4200) -- 60 to 70 minutes
        end
    },
    {
        'Castle_Zvahl_Baileys',
        'Marquis_Allocen',
        function()
            return math.random(75600, 86400) -- 21 to 24 hours
        end
    },
    {
        'Castle_Zvahl_Baileys',
        'Marquis_Amon',
        function()
            return math.random(75600, 86400) -- 21 to 24 hours
        end
    },
    {
        'Castle_Zvahl_Baileys',
        'Marquis_Naberius',
        function()
            return math.random(3600, 7200) -- 1 to 2 hours
        end
    },
    {
        'Castle_Zvahl_Baileys',
        'Duke_Haborym',
        function()
            return math.random(75600, 86400) -- 21 to 24 hours
        end
    },
    {
        'Castle_Zvahl_Baileys',
        'Grand_Duke_Batym',
        function()
            return math.random(75600, 86400) -- 21 to 24 hours
        end
    },
    {
        'Crawlers_Nest',
        'Dynast_Beetle',
        function()
            return math.random(5400, 7200) -- 90 to 120 minutes
        end
    },
    {
        'Crawlers_Nest',
        'Aqrabuamelu',
        function()
            return math.random(7200, 7800) -- 120 to 130 min
        end
    },
    {
        'East_Ronfaure',
        'Rambukk',
        function()
            return math.random(900, 3600) -- 15 min to 1 hour
        end
    },
    {
        'East_Sarutabaruta',
        'Duke_Decapod',
        function()
            return math.random(3600, 4200) -- 60 to 70 min
        end
    },
    {
        'Eastern_Altepa_Desert',
        'Nandi',
        function()
            return math.random(3600, 4200) -- 1 to 1 hour 10 min
        end
    },
    {
        'Eastern_Altepa_Desert',
        'Cactrot_Rapido',
        function()
            return math.random(172800, 259200) -- 2 to 3 days
        end
    },
    {
        'Eastern_Altepa_Desert',
        'Centurio_XII-I',
        function()
            return math.random(0, 600) + 75600 -- 21 hours, 10 minute window
        end
    },
    {
        'FeiYin',
        'Capricious_Cassie',
        function()
            return math.random(75600, 86400) -- 21 to 24 hours
        end
    },
    {
        'Fort_Ghelsba',
        'Orcish_Panzer',
        function()
            return math.random(3600, 4200) -- 60 to 70 minutes
        end
    },
    {
        'Fort_Ghelsba',
        'Kegpaunch_Doshgnosh',
        function()
            return 3600 -- 1 hour
        end
    },
    {
        'Garlaige_Citadel',
        'Old_Two-Wings',
        function()
            return math.random(75600, 86400) -- 21 to 24 hours
        end
    },
    {
        'Garlaige_Citadel',
        'Skewer_Sam',
        function()
            return math.random(75600, 86400) -- 21 to 24 hours
        end
    },
    {
        'Garlaige_Citadel',
        'Serket',
        function()
            return math.random(75600, 86400) -- 21 to 24 hours
        end
    },
    {
        'Ghelsba_Outpost',
        'Orcish_Barricader',
        function()
            return math.random(4200, 5700) -- 70 to 95 min
        end
    },
    {
        'Ghelsba_Outpost',
        'Orcish_Wallbreacher',
        function()
            return math.random(3900, 5400) -- 65 to 90 min
        end
    },
    {
        'Giddeus',
        'Quu_Xijo_the_Illusory',
        function()
            return math.random(3600, 4200) -- 60 to 70 minutes
        end
    },
    {
        'Gusgen_Mines',
        'Juggler_Hecatomb',
        function()
            return math.random(75600, 86400) -- 21 to 24 hours
        end
    },
    {
        'Gustav_Tunnel',
        'Bune',
        function()
            return math.random(75600, 86400) -- 21-24 hours
        end
    },
    {
        'Ifrits_Cauldron',
        'Ash_Dragon',
        function()
            return math.random(259200, 432000) -- 3 to 5 days
        end
    },
    {
        'Inner_Horutoto_Ruins',
        'Maltha',
        function()
            return math.random(3600, 7200) -- 1 to 2 hours
        end
    },
    {
        'Jugner_Forest',
        'Meteormauler_Zhagtegg',
        function()
            return 75600 + math.random(0, 600) -- 21 hours, 10 minute window
        end
    },
    {
        'Jugner_Forest',
        'Fraelissa',
        function()
            return math.random(3600, 4500) -- 60 to 75 minutes
        end
    },
    {
        'King_Ranperres_Tomb',
        'Vrtra',
        function()
            return math.random(259200, 432000) -- 3 to 5 days
        end
    },
    {
        'King_Ranperres_Tomb',
        'Barbastelle',
        function()
            return math.random(1800, 5400) -- 30 to 90 minutes
        end
    },
    {
        'Konschtat_Highlands',
        'Highlander_Lizard',
        function()
            return math.random(1200, 1800) -- 20~30 min repop
        end
    },
    {
        'Konschtat_Highlands',
        'Ghillie_Dhu',
        function()
            return math.random(3600, 4200) -- 60~70 min repop
        end
    },
    {
        'Korroloka_Tunnel',
        'Thoon',
        function()
            return math.random(3600, 4200) -- 60 to 70 minutes
        end
    },
    {
        'Kuftal_Tunnel',
        'Guivre',
        function()
            return math.random(64800, 86400) -- 18 to 24 hours
        end
    },
    {
        'La_Vaule_[S]',
        'Agrios',
        function()
            return math.random(7200, 14400) -- 2 to 4 hours
        end
    },
    {
        'La_Vaule_[S]',
        'All-seeing_Onyx_Eye',
        function()
            return math.random(7200, 14400) -- 2 to 4 hours
        end
    },
    {
        'La_Vaule_[S]',
        'Ashmaker_Gotblut',
        function()
            return math.random(7200, 18000) -- 2 to 5 hours
        end
    },
    {
        'La_Vaule_[S]',
        'Cogtooth_Skagnogg',
        function()
            return math.random(7200, 18000) -- 2 to 5 hours
        end
    },
    {
        'La_Vaule_[S]',
        'Coinbiter_Cjaknokk',
        function()
            return math.random(7200, 18000) -- 2 to 5 hours
        end
    },
    {
        'La_Vaule_[S]',
        'Draketrader_Zlodgodd',
        function()
            return math.random(7200, 18000) -- 2 to 5 hours
        end
    },
    {
        'La_Vaule_[S]',
        'Falsespinner_Bhudbrodd',
        function()
            return math.random(7200, 18000) -- 2 to 5 hours
        end
    },
    {
        'La_Vaule_[S]',
        'Feeblescheme_Bhogbigg',
        function()
            return math.random(7200, 18000) -- 2 to 5 hours
        end
    },
    {
        'La_Vaule_[S]',
        'Hawkeyed_Dnatbat',
        function()
            return math.random(7200, 18000) -- 2 to 5 hours
        end
    },
    {
        'Labyrinth_of_Onzozo',
        'Mysticmaker_Profblix',
        function()
            return math.random(24, 30) * 300 -- 2 to 2.5 hours in 5 minute windows
        end
    },
    {
        'Mamook',
        'Darting_Kachaal_Ja',
        function()
            return math.random(100800, 259200) -- 28 to 72 hours
        end
    },
    {
        'Mamook',
        'Devout_Radol_Ja',
        function()
            return math.random(100800, 259200) -- 28 to 72 hours
        end
    },
    {
        'Mamook',
        'Dragonscaled_Bugaal_Ja',
        function()
            return math.random(100800, 259200) -- 28 to 72 hours
        end
    },
    {
        'Mamook',
        'Firedance_Magmaal_Ja',
        function()
            return math.random(100800, 259200) -- 28 to 72 hours
        end
    },
    {
        'Mamook',
        'Gulool_Ja_Ja',
        function()
            return math.random(75600, 86400) -- 21 to 24 Hours
        end
    },
    {
        'Mamook',
        'Hundredfaced_Hapool_Ja',
        function()
            return math.random(100800, 259200) -- 28 to 72 hours
        end
    },
    {
        'Mamook',
        'Venomfang',
        function()
            return math.random(3600, 4200) -- 60 to 70 minutes
        end
    },
    {
        'Meriphataud_Mountains',
        'Coo_Keja_the_Unseen',
        function()
            return math.random(75600, 86400) -- 21 to 24 hours
        end
    },
    {
        'Meriphataud_Mountains',
        'Chonchon',
        function()
            return math.random(3600, 5400) -- 60 to 90 minutes
        end
    },
    {
        'Meriphataud_Mountains',
        'Coo_Keja_the_Unseen',
        function()
            return math.random(75600, 86400) -- 21 to 24 hours
        end
    },
    {
        'Meriphataud_Mountains',
        'Waraxe_Beak',
        function()
            return math.random(75600, 86400) -- 21 to 24 hours
        end
    },
    {
        'North_Gustaberg',
        'Bedrock_Barry',
        function()
            return math.random(3600, 4200) -- 60 to 70 minutes
        end
    },
    {
        'Ordelles_Caves',
        'Morbolger',
        function()
            return math.random(75600, 86400) -- 21 to 24 hours
        end
    },
    {
        'Palborough_Mines',
        'NoMho_Crimsonarmor',
        function()
            return math.random(75600, 86400) -- 21 to 24 hours
        end
    },
    {
        'Palborough_Mines',
        'QuVho_Deathhurler',
        function()
            return math.random(3600, 4200) -- 60 to 70 minutes
        end
    },
    {
        'Pashhow_Marshlands',
        'BoWho_Warmonger',
        function()
            return 75600 + math.random(600, 900) -- 21 hours, plus 10 to 15 min
        end
    },
    {
        'Quicksand_Caves',
        'Antican_Consul',
        function()
            return math.random(75600, 86400) -- 21 to 24 hours
        end
    },
    {
        'Quicksand_Caves',
        'Proconsul_XII',
        function()
            return 7200 -- 2 hours
        end
    },
    {
        'Riverne-Site_B01',
        'Boroka',
        function()
            return math.random(75600, 86400) -- 21-24 hour respawn
        end
    },
    {
        'Rolanberry_Fields',
        'Simurgh',
        function()
            return math.random(75600, 86400) -- 21-24 hour respawn
        end
    },
    {
        'RoMaeve',
        'Shikigami_Weapon',
        function()
            return 75600 -- 21 hours
        end
    },
    {
        'Sauromugue_Champaign',
        'Roc',
        function()
            return math.random(75600, 86400) -- 21-24 hour respawn
        end
    },
    {
        'South_Gustaberg',
        'Tococo',
        function()
            return math.random(3600, 4200) -- 60 to 70 minutes
        end
    },
    {
        'The_Boyahda_Tree',
        'Ancient_Goobbue',
        function()
            return math.random(75600, 86400) -- 21 to 24 hours
        end
    },
    {
        'The_Shrine_of_RuAvitau',
        'Faust',
        function()
            return math.random(10800, 21600) -- 3 to 6 hrs
        end
    },
    {
        'The_Shrine_of_RuAvitau',
        'Mother_Globe',
        function()
            return math.random(10800, 21600) -- 3 to 6 hrs
        end
    },
    {
        'Toraimarai_Canal',
        'Oni_Carcass',
        function()
            return math.random(75600, 76400) -- 21 to 24 hours
        end
    },
    {
        'Uleguerand_Range',
        'Jormungand',
        function()
            return math.random(144, 240) * 1800 -- 3 to 5 days in 30 minute windows
        end
    },
    {
        'VeLugannon_Palace',
        'Zipacna',
        function()
            return math.random(10800, 14400) -- respawn 3-4 hrs
        end
    },
    {
        'West_Ronfaure',
        'Amanita',
        function()
            return math.random(3600, 4200) -- 60 to 70 minutes
        end
    },
    {
        'Yhoator_Jungle',
        'Woodland_Sage',
        function()
            return math.random(75600, 86400) -- 21 to 24 hours
        end
    },
    {
        'Yhoator_Jungle',
        'Powderer_Penny',
        function()
            return math.random(5400, 7200) -- 90 to 120 minutes
        end
    },
    {
        'Yhoator_Jungle',
        'Bright-handed_Kunberry',
        function()
            return math.random(75600, 77400) -- 21 to 21.5 hours
        end
    },
    {
        'Yuhtunga_Jungle',
        'Meww_the_Turtlerider',
        function()
            return math.random(126, 144) * 60 -- 21 to 24 hours, 10 minute windows
        end
    },
    {
        'Yuhtunga_Jungle',
        'Pyuu_the_Spatemaker',
        function()
            return math.random(5400, 7200) -- 1.5 to 2 hours
        end
    },
}

-- NOTE: At the time we iterate over these entries, the Lua zone and mob objects won't be ready,
--     : so we deal with everything as strings for now.
for _, entry in pairs(nmsToPersist) do
    local zoneName    = entry[1]
    local mobName     = entry[2]
    local varName     = '[Respawn]' .. mobName
    local respawnFunc = entry[3]

    m:addOverride(string.format('xi.zones.%s.mobs.%s.onMobDespawn', zoneName, mobName),
    function(mob)
        super(mob)

        local respawn = respawnFunc()
        mob:setRespawnTime(respawn)
        SetServerVariable(varName, (os.time() + respawn))
        print(string.format('Writing respawn time to server vars: %s %i', mob:getName(), respawn))
    end)

    m:addOverride(string.format('xi.zones.%s.Zone.onInitialize', zoneName),
    function(zone)
        super(zone)

        local mob = zone:queryEntitiesByName(mobName)[1]
        local respawn = GetServerVariable(varName)
        print(string.format('Getting respawn time from server vars: %s %i', mob:getName(), respawn))

        if os.time() < respawn then
            UpdateNMSpawnPoint(mob:getID())
            mob:setRespawnTime(respawn - os.time())
        else
            SpawnMob(mob:getID())
        end
    end)
end

return m
