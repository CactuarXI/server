-----------------------------------
-- Area: Waughroon Shrine
--   NM: Gaki
-- Involved in Quest: A Thief in Norg
-----------------------------------
mixins = {require('scripts/mixins/job_special')}
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
