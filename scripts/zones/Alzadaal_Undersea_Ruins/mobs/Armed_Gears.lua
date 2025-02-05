-----------------------------------
-- Area: Alzadaal Undersea Ruins
--  Mob: Armed Gears
-- !pos -19 -4 -153
-----------------------------------
-- todo
-- add add random elemental magic absorb to elements its casting
mixins =
{
    require('scripts/mixins/job_special'),
    require('scripts/mixins/families/gears'),
    require('scripts/mixins/rage')
}
local ID = zones[xi.zone.ALZADAAL_UNDERSEA_RUINS]

-----------------------------------
---@type TMobEntity
local entity = {}
local function clearAbsorb(mob) -- we can use this block to 'clean the slate' for absorbs and elemental _SDT
    mob:setMod(xi.mod.FIRE_ABSORB, 0)
    mob:setMod(xi.mod.EARTH_ABSORB, 0)
    mob:setMod(xi.mod.WATER_ABSORB, 0)
    mob:setMod(xi.mod.WIND_ABSORB, 0)
    mob:setMod(xi.mod.ICE_ABSORB, 0)
    mob:setMod(xi.mod.LTNG_ABSORB, 0)
    mob:setMod(xi.mod.LIGHT_ABSORB, 0)
    mob:setMod(xi.mod.DARK_ABSORB, 0)
    mob:setMod(xi.mod.FIRE_SDT, 231)
    mob:setMod(xi.mod.EARTH_SDT, 231)
    mob:setMod(xi.mod.WATER_SDT, 231)
    mob:setMod(xi.mod.WIND_SDT, 231)
    mob:setMod(xi.mod.ICE_SDT, 231)
    mob:setMod(xi.mod.THUNDER_SDT, 231)
    mob:setMod(xi.mod.LIGHT_SDT, 231)
    mob:setMod(xi.mod.DARK_SDT, 231)
end

local function formChange(mob)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 25)
    clearAbsorb(mob)

    if mob:getLocalVar('State') == 1 then     -- Fire
        mob:setSpellList(708)
        mob:setMod(xi.mod.FIRE_ABSORB, 100)
        mob:setMod(xi.mod.WATER_SDT, 0)
        mob:setMod(xi.mod.FIRE_SDT, 0)
    elseif mob:getLocalVar('State') == 2 then -- Earth
        mob:setSpellList(709)
        mob:setMod(xi.mod.EARTH_ABSORB, 100)
        mob:setMod(xi.mod.WIND_SDT, 0)
        mob:setMod(xi.mod.EARTH_SDT, 0)
    elseif mob:getLocalVar('State') == 3 then -- Water
        mob:setSpellList(710)
        mob:setMod(xi.mod.WATER_ABSORB, 100)
        mob:setMod(xi.mod.THUNDER_SDT, 0)
        mob:setMod(xi.mod.WATER_SDT, 0)
    elseif mob:getLocalVar('State') == 4 then -- Wind
        mob:setSpellList(711)
        mob:setMod(xi.mod.WIND_ABSORB, 100)
        mob:setMod(xi.mod.ICE_SDT, 0)
        mob:setMod(xi.mod.WIND_SDT, 0)
    elseif mob:getLocalVar('State') == 5 then -- Ice
        mob:setSpellList(712)
        mob:setMod(xi.mod.ICE_ABSORB, 100)
        mob:setMod(xi.mod.FIRE_SDT, 0)
        mob:setMod(xi.mod.ICE_SDT, 0)
    elseif mob:getLocalVar('State') == 6 then -- Lightning
        mob:setSpellList(713)
        mob:setMod(xi.mod.LTNG_ABSORB, 100)
        mob:setMod(xi.mod.EARTH_SDT, 0)
        mob:setMod(xi.mod.THUNDER_SDT, 0)
    elseif mob:getLocalVar('State') == 7 then -- Light
        mob:setSpellList(714)
        mob:setMod(xi.mod.LIGHT_ABSORB, 100)
        mob:setMod(xi.mod.DARK_SDT, 0)
        mob:setMod(xi.mod.LIGHT_SDT, 0)
    else                                      -- Dark
        mob:setSpellList(715)
        mob:setMod(xi.mod.DARK_ABSORB, 100)
        mob:setMod(xi.mod.LIGHT_SDT, 0)
        mob:setMod(xi.mod.DARK_SDT, 0)
    end
    mob:setLocalVar('Dispelled', 0)
end


entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
    mob:setMobMod(xi.mobMod.GIL_MIN, 3000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 5000)
    mob:setMod(xi.mod.UFASTCAST, 50)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar('[rage]timer', 5400)                                      -- 90 minutes
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 25)
    mob:setAnimationSub(0)         -- 3 gears
    mob:setLocalVar('gears', 3)
    mob:setLocalVar('State', math.random(7,8))        -- starts in either light or dark mode
   
    mob:setLocalVar('Change', 0)
    mob:setLocalVar('Dispelled', 0)
    mob:setLocalVar('HP', mob:getHP()-1500)
    formChange(mob)
end

entity.onMobFight = function(mob, target)

    -- This Block deals with WHEN it is time to change form

    if mob:getLocalVar('Dispelled') == 1 then -- need to also check for en-spell
        --Means State was 1-6 (one of the other elements), so lets put it to light/dark
        mob:setLocalVar('State', math.random(7,8))
        mob:setLocalVar('Change', 1)
        mob:setLocalVar('Dispelled', 0)
        mob:setLocalVar('HP', mob:getHP()-1500)
    end

    if mob:getLocalVar('HP') >= mob:getHP() then -- we lost enough HP
        
        if mob:getLocalVar('State') == 7 or mob:getLocalVar('State') == 8 then -- Going from Light or Dark
            mob:setSpellList(716)
            mob:setMobMod(xi.mobMod.MAGIC_COOL, 1)
            
        else -- Means we are in element phase, just dispel our own en-spell and let the other functions change stuff
            mob:setLocalVar('Change', 1)
            if mob:hasStatusEffect(xi.effect.ENFIRE) then
                mob:delStatusEffect(xi.effect.ENFIRE)
            elseif mob:hasStatusEffect(xi.effect.ENAERO) then 
                mob:delStatusEffect(xi.effect.ENAERO)
            elseif mob:hasStatusEffect(xi.effect.ENSTONE) then
                mob:delStatusEffect(xi.effect.ENSTONE)
            elseif mob:hasStatusEffect(xi.effect.ENWATER) then
                mob:delStatusEffect(xi.effect.ENWATER)
            elseif mob:hasStatusEffect(xi.effect.ENBLIZZARD) then
                mob:delStatusEffect(xi.effect.ENBLIZZARD)
            elseif mob:hasStatusEffect(xi.effect.ENTHUNDER) then
                mob:delStatusEffect(xi.effect.ENTHUNDER)
            end
        end
        mob:setLocalVar('HP', mob:getHP()-1500)
    end



    if mob:getLocalVar('State') == 7 or mob:getLocalVar('State') == 8 then -- if we are light/dark and get an enspell, means we are changing to that element
        if mob:hasStatusEffect(xi.effect.ENFIRE) then
            mob:setLocalVar('Change', 1)
            mob:setLocalVar('State', 1)
            mob:setLocalVar('Dispelled', 0)
        elseif mob:hasStatusEffect(xi.effect.ENAERO) then 
            mob:setLocalVar('Change', 1)
            mob:setLocalVar('State', 4)
            mob:setLocalVar('Dispelled', 0)
        elseif mob:hasStatusEffect(xi.effect.ENSTONE) then
            mob:setLocalVar('Change', 1)
            mob:setLocalVar('State', 2)
            mob:setLocalVar('Dispelled', 0)
        elseif mob:hasStatusEffect(xi.effect.ENWATER) then
            mob:setLocalVar('Change', 1)
            mob:setLocalVar('State', 3)
            mob:setLocalVar('Dispelled', 0)
        elseif mob:hasStatusEffect(xi.effect.ENBLIZZARD) then
            mob:setLocalVar('Change', 1)
            mob:setLocalVar('State', 5)
            mob:setLocalVar('Dispelled', 0)
        elseif mob:hasStatusEffect(xi.effect.ENTHUNDER) then
            mob:setLocalVar('Change', 1)
            mob:setLocalVar('State', 6)
            mob:setLocalVar('Dispelled', 0)
        end
    else -- We are in an element phase and missing en-spell
        if not (mob:hasStatusEffect(xi.effect.ENFIRE) or
            mob:hasStatusEffect(xi.effect.ENAERO) or
            mob:hasStatusEffect(xi.effect.ENSTONE) or
            mob:hasStatusEffect(xi.effect.ENWATER) or
            mob:hasStatusEffect(xi.effect.ENBLIZZARD) or
            mob:hasStatusEffect(xi.effect.ENTHUNDER)) then
                mob:setLocalVar('Dispelled', 1)
        end
    end
        
    -- This block deals with def/mdef changes from dropping gears.
    if mob:getLocalVar('gears') == 3 and mob:getHPP() <= 49 then
        mob:setAnimationSub(1)   -- 2 gears Should be done in mob families ASCAR remove if not needed
        mob:setMod(xi.mod.DMGPHYS, 25)
        mob:setMod(xi.mod.DMGRANGE, 25)
        mob:setMod(xi.mod.DMGMAGIC, 25)
        mob:setLocalVar('gears', 2)
     elseif mob:getLocalVar('gears') == 2 and mob:getHPP() <= 25 then
        mob:setAnimationSub(2)   -- 1 gear Should be done in mob families ASCAR remove if not needed
        mob:setMod(xi.mod.DMGPHYS, 50)
        mob:setMod(xi.mod.DMGRANGE, 50)
        mob:setMod(xi.mod.DMGMAGIC, 50)
        mob:setLocalVar('gears', 1)
    end

    -- Below is the block to deal with changing forms.
    if mob:getLocalVar('Change') == 1 then
        mob:setLocalVar('Change', 0)
        formChange(mob)
    end

end

entity.onMobDeath = function(mob, player, optParams)
  
end

entity.onMobDespawn = function(mob)

end

return entity
