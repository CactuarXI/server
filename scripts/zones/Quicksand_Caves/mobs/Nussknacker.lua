-----------------------------------
-- Area: Quicksand Caves
--   NM: Nussknacker
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.GIL_MIN, 4800)
    mob:setMobMod(xi.mobMod.GIL_MAX, 6000)
end

entity.onMobRoam = function(mob)
    if mob:getWeather() ~= xi.weather.SAND_STORM then
        DespawnMob(mob:getID())
    end
end

entity.onMobDisengage = function(mob)
    if mob:getWeather() ~= xi.weather.SAND_STORM then
        DespawnMob(mob:getID())
    end
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 435)
    DisallowRespawn(mob:getID(), true)
end

return entity
