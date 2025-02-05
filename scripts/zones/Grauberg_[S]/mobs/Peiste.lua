-----------------------------------
-- Area: Grauberg_[S]
--  Mob: Peiste
-----------------------------------
mixins = { require('scripts/mixins/families/peiste') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.cactuarRegimes.checkRegime(player, mob, 6, 1, xi.regime.type.FIELDS)
end

return entity
