-----------------------------------
-- Area: Arrapago Reef
--  Mob: Qutrub
-----------------------------------
mixins = { require('scripts/mixins/families/qutrub') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.cactuarRegimes.checkRegime(player, mob, 1, 2, xi.regime.type.FIELDS)
end

return entity
