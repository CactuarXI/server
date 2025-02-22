-----------------------------------
-- Area: Promyvion-Vahzl
--  Mob: Apex Livid Rager
-----------------------------------
mixins =
{
    require('scripts/mixins/families/empty_terroanima')
}
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    xi.promyvion.emptyOnMobSpawn(mob, xi.promyvion.mobType.SEETHER)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.cactuarRegimes.checkRegime(player, mob, 1, 1, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 8, 2, xi.regime.type.FIELDS)
end

return entity
