-----------------------------------
-- Area: Spire of Vahzl
--  Mob: Contemplator
-----------------------------------
mixins =
{
    require('scripts/mixins/families/empty_terroanima')
}
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    xi.promyvion.emptyOnMobSpawn(mob, xi.promyvion.mobType.THINKER)
end

entity.onMobDeath = function(mob, player)
end

return entity
