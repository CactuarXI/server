-----------------------------------
-- Area: FeiYin
--  Mob: Clockwork Pod
-- Note: PH for Mind Hoarder
-----------------------------------
local ID = zones[xi.zone.FEIYIN]
-----------------------------------
---@type TMobEntity
local entity = {}

local mindHoarderPHTable =
{
    [ID.mob.MIND_HOARDER - 3] = ID.mob.MIND_HOARDER,
    [ID.mob.MIND_HOARDER - 2] = ID.mob.MIND_HOARDER,
    [ID.mob.MIND_HOARDER - 1] = ID.mob.MIND_HOARDER,
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, mindHoarderPHTable, 10, 5400) -- 1.5 hour minimum
end

return entity
