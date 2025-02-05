-----------------------------------
-- Area: North Gustaberg [S]
--  Mob: Coppercap
-- Note: PH for Gloomanita
-----------------------------------
mixins = {require('scripts/mixins/families/funguar_s')}
local ID = zones[xi.zone.NORTH_GUSTABERG_S]
-----------------------------------
---@type TMobEntity
local entity = {}

local gloomanitaPHTable =
{
    [ID.mob.GLOOMANITA - 1] = ID.mob.GLOOMANITA, -- -19.961 0.5 623.989
}

entity.onMobSpawn = function(mob)
    mob:setAnimationSub(0)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, gloomanitaPHTable, 10, 3600) -- 1 hour
end

return entity
