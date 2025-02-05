-----------------------------------
-- Area: Caedarva Mire
--  Mob: Heraldic Imp
-----------------------------------
mixins = { require('scripts/mixins/families/imp'), require('scripts/mixins/families/imp_aggro') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.cactuarRegimes.checkRegime(player, mob, 9, 1, xi.regime.type.FIELDS)
end

return entity
