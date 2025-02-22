-----------------------------------
-- Area: Gustav Tunnel
--   NM: Taxim
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.GIL_MIN, 3600)
    mob:setMobMod(xi.mobMod.GIL_MAX, 3600)
    mob:setMod(xi.mod.ICE_MEVA, 1000)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 424)
    xi.cactuarRegimes.checkRegime(player, mob, 3, 2, xi.regime.type.FIELDS)
end

return entity
