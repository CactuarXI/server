-- Scolopendrid(Scorpion Subspecies) family mixin

require('scripts/globals/mixins')
require('scripts/enum/weather')

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.scolopendrid = function(scolopendridMob)

    scolopendridMob:addListener('COMBAT_TICK', 'SCOLOPENDRID_CTICK', function(mob)
        if
            mob:getWeather() == xi.weather.DUST_STORM or
            mob:getWeather() == xi.weather.SAND_STORM
        then
            mob:setMod(xi.mod.REGAIN, 100)
        else
            mob:setMod(xi.mod.REGAIN, 0)
        end
    end)

    scolopendridMob:addListener('ROAM_TICK', 'SCOLOPENDRID_RTICK', function(mob)
        if
            mob:getWeather() == xi.weather.DUST_STORM or
            mob:getWeather() == xi.weather.SAND_STORM
        then
            mob:setMod(xi.mod.REGAIN, 100)
        else
            mob:setMod(xi.mod.REGAIN, 0)
        end
    end)
end

return g_mixins.families.scolopendrid

