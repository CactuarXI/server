-----------------------------------
-- Area: Fei'Yin
--   NM: Western Shadow
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.cactuarRegimes.checkRegime(player, mob, 2, 1, xi.regime.type.FIELDS)
end

return entity
