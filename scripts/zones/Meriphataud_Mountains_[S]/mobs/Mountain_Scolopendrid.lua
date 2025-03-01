-----------------------------------
-- Area: Meriphataud Mountains [S]
--  Mob: Mountain Scolopendrid
-- Note: PH for Centipedal Centruroides
-----------------------------------
mixins = { require('scripts/mixins/families/scolopendrid') }
-----------------------------------
local ID = zones[xi.zone.MERIPHATAUD_MOUNTAINS_S]
-----------------------------------
---@type TMobEntity
local entity = {}

local centipedalPHTable =
{
    [ID.mob.CENTIPEDAL_CENTRUROIDES - 1] = ID.mob.CENTIPEDAL_CENTRUROIDES,
}

entity.onMobInitialize = function(mob)
    mob:addMobMod(xi.mobMod.EXP_BONUS, 10)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.cactuarRegimes.checkRegime(player, mob, 8, 1, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, centipedalPHTable, 10, 3600) -- 1 hour
end

return entity
