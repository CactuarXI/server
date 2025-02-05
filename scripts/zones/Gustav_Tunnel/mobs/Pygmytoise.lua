-----------------------------------
-- Area: Gustav Tunnel
--  Mob: Pygmytoise
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
end

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 770, 2, xi.regime.type.GROUNDS)
    xi.cactuarRegimes.checkRegime(player, mob, 8, 2, xi.regime.type.FIELDS)
end

return entity
