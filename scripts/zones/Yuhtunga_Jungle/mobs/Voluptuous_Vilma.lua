-----------------------------------
-- Area: Yuhtunga Jungle
--  Mob: Voluptuous Vilma
-----------------------------------
local ID = zones[xi.zone.YUHTUNGA_JUNGLE]
-----------------------------------
---@type TMobEntity
local entity = {}

local roseGardenPH = ID.mob.ROSE_GARDEN - 1
local updateRegen = function(mob)
    local regen = mob:getMod(xi.mod.REGEN)

    if mob:getWeather() == xi.weather.SUNSHINE then
        if regen ~= 50 then
            mob:setMod(xi.mod.REGEN, 50)
        end
    else
        if regen ~= 0 then
            mob:setMod(xi.mod.REGEN, 0)
        end
    end
end

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    -- Vilma randomly effects its target with one of the following effects
    local effects =
    {
        [1] = xi.mob.ae.POISON,
        [2] = xi.mob.ae.PARALYZE,
        [3] = xi.mob.ae.BLIND,
        [4] = xi.mob.ae.SILENCE,
        [5] = xi.mob.ae.WEIGHT,
        [6] = xi.mob.ae.SLOW,
        [7] = xi.mob.ae.BIND,
    }
    local random = math.random(1, #effects)

    return xi.mob.onAddEffect(mob, target, damage, effects[random])
end

entity.onMobFight = function(mob, target)
    updateRegen(mob)
end

entity.onMobRoam = function(mob)
    updateRegen(mob)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    DisallowRespawn(ID.mob.VOLUPTUOUS_VILMA, true)
    DisallowRespawn(ID.mob.ROSE_GARDEN_PH, false)
    GetMobByID(ID.mob.ROSE_GARDEN_PH):setRespawnTime(GetMobRespawnTime(ID.mob.ROSE_GARDEN_PH))
end

return entity
