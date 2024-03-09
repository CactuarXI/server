-- Dynamis procs mixin

require('scripts/globals/mixins')
require('scripts/globals/dynamis')

g_mixins = g_mixins or {}

g_mixins.dynamis_beastmen = function(dynamisBeastmenMob)
    local procjobs =
    {
        [xi.job.WAR] = 'ws',
        [xi.job.MNK] = 'ja',
        [xi.job.WHM] = 'ma',
        [xi.job.BLM] = 'ma',
        [xi.job.RDM] = 'ma',
        [xi.job.THF] = 'ja',
        [xi.job.PLD] = 'ws',
        [xi.job.DRK] = 'ws',
        [xi.job.BST] = 'ja',
        [xi.job.BRD] = 'ma',
        [xi.job.RNG] = 'ja',
        [xi.job.SAM] = 'ws',
        [xi.job.NIN] = 'ja',
        [xi.job.DRG] = 'ws',
        [xi.job.SMN] = 'ma'
    }

    local familyCurrency =
    {
        [334] = xi.item.ORDELLE_BRONZEPIECE, -- OrcNM (bronzepiece)
        [337] = xi.item.ONE_BYNE_BILL,       -- QuadavNM (1 byne bill)
        [360] = xi.item.TUKUKU_WHITESHELL,   -- YagudoNM (whiteshell)
        [93] = xi.item.ORDELLE_BRONZEPIECE,  -- OrcStatue (bronzepiece)
        [94] = xi.item.ONE_BYNE_BILL,        -- QuadavStatue (1 byne bill)
        [95] = xi.item.TUKUKU_WHITESHELL,    -- YagudoStatue (whiteshell)
    }

    -- Converts ItemID to a string for message print.
    local currencyName = {
        [1449] = "Tukuku Whiteshell",
        [1450] = "Lungo Nango Jadeshell",
        [1451] = "Rimilala Stripeshell",
        [1452] = "Ordelle Bronzepiece",
        [1453] = "Montiont Silverpiece",
        [1454] = "Ranperre_Goldpiece",
        [1455] = "One Byne Bill",
        [1456] = "One Hundred Byne Bill",
        [1457] = "Ten Thousand Byne Bill",
    }

    -- With Treasure Hunter on every procced monster, you can expect approximately 1.7 coins per kill on average.
    -- Without Treasure Hunter, you can expect about 1.25 coins per kill on average.
    -- Without a proc, the coin drop rate is very low (~10%)
    local thCurrency =
    {
        [0] = { single = 100, hundred = 15 }, -- 100, 5
        [1] = { single = 120, hundred = 20 }, -- 115, 10
        [2] = { single = 145, hundred = 35 }, -- 145, 20
        [3] = { single = 190, hundred = 55 }, -- 190, 35
        [4] = { single = 250, hundred = 75 }, -- 250, 50
    }

    dynamisBeastmenMob:addListener('MAGIC_TAKE', 'DYNAMIS_MAGIC_PROC_CHECK', function(target, caster, spell)
        if
            procjobs[target:getMainJob()] == 'ma' and
            math.random(0, 99) < 8 and
            target:getLocalVar('dynamis_proc') == 0
        then
            xi.dynamis.procMonster(target, caster)
        end
    end)

    dynamisBeastmenMob:addListener('WEAPONSKILL_TAKE', 'DYNAMIS_WS_PROC_CHECK', function(target, user, wsid)
        if
            procjobs[target:getMainJob()] == 'ws' and
            math.random(0, 99) < 25 and
            target:getLocalVar('dynamis_proc') == 0
        then
            xi.dynamis.procMonster(target, user)
        end
    end)

    dynamisBeastmenMob:addListener('ABILITY_TAKE', 'DYNAMIS_ABILITY_PROC_CHECK', function(mob, user, ability, action)
        if
            procjobs[mob:getMainJob()] == 'ja' and
            math.random(0, 99) < 20 and
            mob:getLocalVar('dynamis_proc') == 0
        then
            xi.dynamis.procMonster(mob, user)
        end
    end)

    dynamisBeastmenMob:addListener('DEATH', 'DYNAMIS_ITEM_DISTRIBUTION', function(mob, killer)
        if killer then
            local th = thCurrency[math.min(mob:getTHlevel(), 4)]
            local family = mob:getFamily()
            local currency = familyCurrency[family]
            if currency == nil then
                currency = 1449 + math.random(0, 2) * 3
            end

            local singleChance = th.single
            local hundredChance = th.hundred
            if mob:getMainLvl() > 77 then -- 90
                singleChance = math.floor(singleChance * 1.5)
            end

            -- White (special) adds 100% hundred slot
            if mob:getLocalVar('dynamis_proc') >= 4 then
                killer:addTreasure(currency + 1, mob)
            end

            -- Base hundred slot
            if mob:isNM() then
                killer:addTreasure(currency + 1, mob, hundredChance)
            end

            -- red (high) adds 100% single slot
            if mob:getLocalVar('dynamis_proc') >= 3 then
                killer:addTreasure(currency, mob)
                killer:addTreasure(currency, mob)
                killer:addTreasure(currency + 1, mob, hundredChance)
                killer:addTreasure(currency + 1, mob, hundredChance)
            end

            -- yellow (medium) adds single slot
            if mob:getLocalVar('dynamis_proc') >= 2 then
                killer:addTreasure(currency + 1, mob, hundredChance)
                killer:addTreasure(currency, mob, singleChance)
            end

            -- blue (low) adds single slot
            if mob:getLocalVar('dynamis_proc') >= 1 then
                killer:addTreasure(currency, mob, singleChance)
            end

            -------------------------
            -- Cactuar Changes Below
            -------------------------

            -- Trash Mob
            --[[if not mob:isNM() then
                -- local CurrencyVarName = string.format('Dynamis_Currency[%d]', currency)
                -- local GetCurrency = killer:getCharVar(string.format('Dynamis_Currency[%d]', currency))
                local MessageCheck = killer:getCharVar('Dynamis_Currency[' .. currency .. ']')
                local currencyText = currencyName[currency] or tostring(currency)
                local totalCurrencyChange = 0 -- Variable to store the total currency change during the loop
                
                for i = 1, math.random(1, 10) do
                    if math.random(0, 1000) < singleChance then
                        local party = killer:getParty()
                        if killer ~= nil then
                            local partySize = #party
                            if partySize > 0 then
                                local randomIndex = math.random(1, partySize) -- Randomly select a party member
                                local partyMember = party[randomIndex]
                                local partyMemberCurrency = partyMember:getCharVar('Dynamis_Currency[' .. currency .. ']')
                                partyMemberCurrency = partyMemberCurrency + 1 -- Increment the currency for the selected party member
                                partyMember:setCharVar('Dynamis_Currency[' .. currency .. ']', partyMemberCurrency)
                                totalCurrencyChange = totalCurrencyChange + 1 -- Update total currency change
                            end
                        end
                    end
                end]]

            -- Trash Mob
            if not mob:isNM() then
                -- local CurrencyVarName = string.format('Dynamis_Currency[%d]', currency)
                -- local GetCurrency = killer:getCharVar(string.format('Dynamis_Currency[%d]', currency))
                --[[local MessageCheck = killer:getCharVar('Dynamis_Currency[' .. currency .. ']')
                local currencyText = currencyName[currency] or tostring(currency)
                local totalCurrencyChange = 0 -- Variable to store the total currency change during the loop
                
                for i = 1, math.random(1, 10) do
                    if math.random(0, 1000) < singleChance then
                        local party = killer:getParty()
                        if killer ~= nil then
                            local partySize = #party
                            if partySize > 0 then
                                local randomIndex = math.random(1, partySize) -- Randomly select a party member
                                local partyMember = party[randomIndex]
                                local partyMemberCurrency = partyMember:getCharVar('Dynamis_Currency[' .. currency .. ']')
                                partyMemberCurrency = partyMemberCurrency + 1 -- Increment the currency for the selected party member
                                totalCurrencyChange = totalCurrencyChange + 1 -- Update total currency change
                                partyMember:setCharVar('Dynamis_Currency[' .. currency .. ']', partyMemberCurrency)
                                if totalCurrencyChange > 0 then
                                    partyMember:PrintToPlayer(string.format('Total[%s]: %i(+%i) ', currencyText, partyMemberCurrency, totalCurrencyChange), xi.msg.channel.SYSTEM_3)
                                end
                            end
                        end
                    end
                end]]

                --[[local currencyText = currencyName[currency] or tostring(currency)
                local totalCurrencyChange = 0
                local party = killer:getParty()
                local partySize = #party
                local randomIndex = math.random(1, partySize)
                local partyMember = party[randomIndex]
                local partyMemberCurrency = partyMember:getCharVar('Dynamis_Currency[' .. currency .. ']')
                
                if partySize > 0 then  -- Move this condition outside the loop
                    for i = 1, math.random(1, 10) do
                        if math.random(0, 1000) < singleChance then
                            partyMemberCurrency = partyMemberCurrency + 1
                            totalCurrencyChange = totalCurrencyChange + 1
                            partyMember:setCharVar('Dynamis_Currency[' .. currency .. ']', partyMemberCurrency)
                        end
                    end
                end

                if totalCurrencyChange > 0 then
                    partyMember:PrintToPlayer(string.format('Total[%s]: %i(+%i) ', currencyText, partyMemberCurrency, totalCurrencyChange), xi.msg.channel.SYSTEM_3)
                end
                


                --if totalCurrencyChange > 0 then
                --    killer:PrintToPlayer(string.format('Total[%s]: %i ', currencyText, MessageCheck + totalCurrencyChange), xi.msg.channel.SYSTEM_3)
                --end]]
                
                killer:addTreasure(currency + 1, mob, hundredChance) -- hundred slot
                killer:addTreasure(currency, mob, singleChance)      -- single slot
                killer:addTreasure(currency, mob, singleChance)      -- single slot
                killer:addTreasure(currency, mob, singleChance)      -- single slot
                killer:addTreasure(currency, mob, singleChance)      -- single slot
            end

            -- Timed/Lottery
            if
                mob:isNM() and
                (mob:getLocalVar('[isDynamis_Megaboss]') ~= 1 or   -- Is not a megaboss
                mob:getLocalVar('[isDynamis_Arch_Megaboss]') ~= 1) -- Is not an arch megaboss
            then
                local party = killer:getParty() -- Fetch party list.
                if killer ~= nil then
                    for _, v in pairs(party) do -- For every party member, do loot roll.
                        if v:getZone() == mob:getZone() then -- If a party member is not in same zone as mob, exclude their loot roll.
                            -- v:addTreasure(currency, mob, singleChance)      -- single slot
                            -- v:addTreasure(currency, mob, singleChance)      -- single slot
                            v:addTreasure(currency + 1, mob, 1000)          -- hundred slot (100%)
                            v:addTreasure(currency + 1, mob, hundredChance) -- hundred slot
                            v:addTreasure(currency + 1, mob, hundredChance) -- hundred slot
                        end
                    end
                end
            end

            -- Megaboss NM
            if
                mob:isNM() and
                mob:getLocalVar('[isDynamis_Megaboss]') == 1 
            then
                local party = killer:getParty() -- Fetch party list.
                if killer ~= nil then
                    for _, v in pairs(party) do -- For every party member, do loot roll.
                        if v:getZone() == mob:getZone() then -- If a party member is not in same zone as mob, exclude their loot roll.
                            -- v:addTreasure(currency + 1, mob, 1000)          -- hundred slot (100%)
                            v:addTreasure(currency + 1, mob, 1000)          -- hundred slot (100%)
                            v:addTreasure(currency + 1, mob, hundredChance) -- hundred slot
                            v:addTreasure(currency + 1, mob, hundredChance) -- hundred slot
                            v:addTreasure(currency + 1, mob, hundredChance) -- hundred slot
                        end
                    end
                end
            end

            -- Arch Megaboss NM
            if
                mob:isNM() and
                mob:getLocalVar('[isDynamis_Arch_Megaboss]') == 1
            then
                local party = killer:getParty() -- Fetch party list.
                if killer ~= nil then
                    for _, v in pairs(party) do -- For every party member, do loot roll.
                        if v:getZone() == mob:getZone() then -- If partymember is not in same zone as mob, exclude their loot roll.
                            v:addTreasure(currency + 1, mob, 1000)          -- hundred slot (100%)
                            v:addTreasure(currency + 1, mob, 1000)          -- hundred slot (100%)
                            v:addTreasure(currency + 1, mob, hundredChance) -- hundred slot
                        end
                    end
                end
            end

            killer:addTreasure(currency, mob, singleChance) -- base single slot
        end
    end)
end

return g_mixins.dynamis_beastmen
