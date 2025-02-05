-----------------------------------
-- Area: Promyvion-Dem
--  Mob: Satiator
-----------------------------------
mixins = { require('scripts/mixins/families/empty_terroanima') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.cactuarRegimes.checkRegime(player, mob, 1, 1, xi.regime.type.FIELDS)
end

return entity
