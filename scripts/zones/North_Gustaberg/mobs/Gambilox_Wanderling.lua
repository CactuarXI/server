-----------------------------------
-- Area: North Gustaberg
--  Mob: Gambilox Wanderling
-- Quest NM - 'As Thick as Thieves'
-----------------------------------
mixins = {require('scripts/mixins/job_special')}
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.REGAIN, 150)
end 

entity.onMobDeath = function(mob, player, optParams)
end

return entity
