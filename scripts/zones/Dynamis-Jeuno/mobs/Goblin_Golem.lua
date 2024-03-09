-----------------------------------
-- Area: Dynamis - Jeuno
--  Mob: Goblin Golem
-- Note: Mega Boss
-----------------------------------
require('scripts/globals/dynamis')
mixins =
{
    require('scripts/mixins/dynamis_beastmen')
}
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.dynamis.megaBossOnDeath(mob, player, optParams)
    xi.magian.onMobDeath(mob, player, optParams, set{ 2713 })
end

return entity
