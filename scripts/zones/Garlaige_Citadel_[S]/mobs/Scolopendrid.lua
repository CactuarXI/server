-----------------------------------
-- Area: Garlaige Citadel [S]
-----------------------------------
mixins = { require('scripts/mixins/families/scolopendrid') }
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addMobMod(xi.mobMod.EXP_BONUS, 10)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
