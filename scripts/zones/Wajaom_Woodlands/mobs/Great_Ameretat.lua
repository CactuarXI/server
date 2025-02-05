-----------------------------------
-- Area: Wajaom Woodlands
--  Mob: Great Ameretat
-- Note: PH for Jaded Jody
-----------------------------------
local ID = zones[xi.zone.WAJAOM_WOODLANDS]
mixins = 
{ 
require('scripts/mixins/families/ameretat'),
}
-----------------------------------
---@type TMobEntity
local entity = {}

local jodyPHTable =
{
    [ID.mob.JADED_JODY - 2]  = ID.mob.JADED_JODY, -- -560 -8 -360
    [ID.mob.JADED_JODY + 12] = ID.mob.JADED_JODY, -- -565 -7 -324
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.HP_DRAIN, { chance = 100, power = 17})
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, jodyPHTable, 10, 7200) -- 2 hours
end

return entity
