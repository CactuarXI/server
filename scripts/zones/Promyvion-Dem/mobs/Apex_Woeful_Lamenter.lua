-----------------------------------
-- Area: Promyvion-Dem
--  Mob: Apex Woeful Lamenter
-----------------------------------
mixins =
{
    require('scripts/mixins/families/empty_terroanima')
}
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    xi.promyvion.emptyOnMobSpawn(mob, xi.promyvion.mobType.WEEPER)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.cactuarRegimes.checkRegime(player, mob, 1, 1, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 6, 2, xi.regime.type.FIELDS)
end

return entity
