-----------------------------------
-- Area: Promyvion-Mea
--  Mob: Seether
-----------------------------------
mixins =
{
    require('scripts/mixins/families/empty_terroanima'),
    require('scripts/mixins/families/empty')
}
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.cactuarRegimes.checkRegime(player, mob, 4, 3, xi.regime.type.FIELDS)
end

return entity
