-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Trench Antlion
-- Note: PH for Ambusher Antlion
-----------------------------------
mixins = { require('scripts/mixins/families/antlion_ambush') }
local ID = zones[xi.zone.ATTOHWA_CHASM]
-----------------------------------
---@type TMobEntity
local entity = {}

local ambusherAntlionPHTable =
{
    [ID.mob.AMBUSHER_ANTLION - 78] = ID.mob.AMBUSHER_ANTLION, -- -433.309 -4.3 113.841
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ROAM_TURNS, 0)
    mob:setMobMod(xi.mobMod.ROAM_RATE, 0)
    mob:setMobMod(xi.mobMod.ROAM_DISTANCE, 0)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ambusherAntlionPHTable, 10, 3600) -- 1 hour
end

return entity
