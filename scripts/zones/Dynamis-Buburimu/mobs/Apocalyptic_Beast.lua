-----------------------------------
-- Area: Dynamis - Buburimu
--  Mob: Apocalyptic Beast
-- Note: Mega Boss
-----------------------------------
require('scripts/globals/dynamis')
mixins =
{
    require('scripts/mixins/dynamis_beastmen'),
    require('scripts/mixins/job_special')
}
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    -- Set Mods
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:setMod(xi.mod.GRAVITYRES, 100)
    mob:setMod(xi.mod.BINDRES, 50)
    mob:setMod(xi.mod.STUNRES, 50)
    mob:setMod(xi.mod.REGAIN, 500)
    mob:setMod(xi.mod.REFRESH, 500)
    mob:setMod(xi.mod.SILENCERES, 100)
    mob:setMod(xi.mod.BLINDRES, 100)
    mob:setMod(xi.mod.PARALYZERES, 50)
    mob:setMod(xi.mod.SLOWRES, 50)
    mob:setMod(xi.mod.SLEEPRES, 100)
    mob:setMod(xi.mod.LULLABYRES, 100)
    mob:setMobMod(xi.mobMod.HP_SCALE, 300)
    
    -- for spells to land/do non-trivial damage
    mob:setMod(xi.mod.MATT, 100)
    mob:setMod(xi.mod.MACC, 150)
    -- for songs (lullaby) to land more reliably
    mob:setMod(xi.mod.SINGING, 200)

    -- Set Vars
    mob:setLocalVar('debuff_Blood', 0) -- Cageblood used, 2 hours locked.
    mob:setLocalVar('debuff_Heart', 0) -- Mobskill 'Songs' locked.
    mob:setLocalVar('debuff_Skull', 0) -- Mobskill Breath attacks locked.
    mob:setLocalVar('debuff_Talon', 0) -- Petroeyes/Chaos Blade locked.
    mob:setLocalVar('debuff_Femur', 0) -- Body Slam/Heavy Stomp locked.
    mob:setLocalVar('next2hr', 1) -- 2hr rotation not reset by a wipe
    mob:setLocalVar('[isDynamis_Megaboss]', 1)
end

entity.onMobFight = function(mob, target)

    local abilities2hr =
    {
        xi.jsa.MIGHTY_STRIKES,
        xi.jsa.HUNDRED_FISTS,
        xi.jsa.BENEDICTION,
        xi.jsa.MANAFONT,
        xi.jsa.CHAINSPELL,
        xi.jsa.PERFECT_DODGE,
        xi.jsa.INVINCIBLE,
        xi.jsa.BLOOD_WEAPON,
        xi.jsa.FAMILIAR,
        xi.jsa.SOUL_VOICE,
        xi.jsa.EES_KINDRED,
        xi.jsa.MEIKYO_SHISUI,
        xi.jsa.MIJIN_GAKURE,
        xi.jsa.CALL_WYVERN,
        xi.jsa.ASTRAL_FLOW,
    }


    local manafontspells =
    {
        176, -- Firaga III
        181, -- Blizzaga III
        186, -- Aeroga III
        191, -- Stonega III
        196, -- Thundaga III
        201, -- Waterga III
        367, -- Death
    }

    local chainspellspells =
    {
        361, -- Blindga
        356, -- Paralyga
        362, -- Bindga
        365, -- Breakga
        274, -- Sleepga II
    }

    local soulvoicesongs =
    {
        376, -- Horde Lullaby
        373, -- Foe Requiem VI
        397, -- Valor Minuet IV
        420, -- Victory March
        422, -- Carnage Elegy
        463, -- Foe Lullaby
    }
    
    if mob:getCurrentAction() <= 1 and mob:getLocalVar('debuff_Blood') == 0 then  -- Do not use 2hrs if item was used on mob
        while os.time() >= (mob:getLocalVar('next2hrtime')) do
            i = mob:getLocalVar('next2hr')
                mob:setLocalVar('next2hrtime', os.time() + math.random(45,75)) -- 45s-75s after previous usage
                if abilities2hr[i] == xi.jsa.FAMILIAR then
                    -- charm
                    mob:useMobAbility(710)
                else
                    mob:useMobAbility(abilities2hr[i])
                end
            -- After going through all two-hour abilities, it will start over again
            mob:setLocalVar('next2hr', (i % #abilities2hr) + 1)
        end
    end


    if mob:hasStatusEffect(xi.effect.MANAFONT) then
        -- ensure only spells
        mob:setTP(0)
        if mob:getCurrentAction() <= 1 then
            local spell = manafontspells[math.random(#manafontspells)]
            mob:castSpell(spell, target)
        end
    end

    -- take care not to spam castSpell, as the spell queuing system will stack them alllll up
    if mob:hasStatusEffect(xi.effect.CHAINSPELL) then
        -- ensure only spells
        mob:setTP(0)
        if mob:getCurrentAction() <= 1 then
            local spell = chainspellspells[math.random(#chainspellspells)]
            mob:castSpell(spell, target)
        end
    end

    if mob:hasStatusEffect(xi.effect.SOUL_VOICE) then
        -- ensure only spells
        mob:setTP(0)
        if mob:getCurrentAction() <= 1 then
            local song = soulvoicesongs[math.random(#soulvoicesongs)]
            mob:castSpell(song, target)
        end
    end
end

entity.onMobEngage = function(mob, target)
    mob:setTP(0)
    mob:setLocalVar('next2hrtime', os.time() + 5) -- 5s after aggro
end

entity.onMobDeath = function(mob, player, optParams)
    xi.dynamis.megaBossOnDeath(mob, player, optParams)
    mob:resetLocalVars()
end

return entity
