-----------------------------------
-- Area: Jugner Forest [S]
--  Mob: Lobison
-----------------------------------
mixins = { require('scripts/mixins/families/gnole') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.cactuarRegimes.checkRegime(player, mob, 7, 1, xi.regime.type.FIELDS)
end

return entity
