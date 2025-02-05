-----------------------------------
-- Area: Beadeaux
--  Mob: Old Quadav
-- PH for Ge'Dha Evileye
-----------------------------------
local ID = zones[xi.zone.BEADEAUX]
-----------------------------------
---@type TMobEntity
local entity = {}

local geDhaPHTable =
{
    [ID.mob.GE_DHA_EVILEYE - 3] = ID.mob.GE_DHA_EVILEYE, -- -242.709 0.5 -188.01
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, geDhaPHTable, 25, 3600) -- 1 Minimum
end

return entity
