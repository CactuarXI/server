-----------------------------------
-- Area: Gustav Tunnel
--   NM: Taxim
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.ICE_MEVA, 1000)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 424)
end

return entity
