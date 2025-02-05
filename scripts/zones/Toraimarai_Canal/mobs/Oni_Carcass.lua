-----------------------------------
-- Area: Toraimarai Canal
--   NM: Oni Carcass
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.nmTODPersist(mob, math.random(75600, 76400)) -- 21 to 24 hours
end

return entity
