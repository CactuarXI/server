-----------------------------------
-- Area: Mamook
--  Mob: Mamool Ja Chamberlain
-- Note: When this mob dies, it updates a timer to be respawned
--       by Gulool.
-----------------------------------
mixins = { require('scripts/mixins/weapon_break') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

entity.onMobSpawn = function(mob)
    -- Adds not witnessed to use any mob skills
    mob:setMobAbilityEnabled(false)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    GetMobByID(zones[mob:getZoneID()].mob.GULOOL_JA_JA):setLocalVar('[GULOOL]respawnAdd' .. mob:getID(), os.time() + 30)
end

return entity
