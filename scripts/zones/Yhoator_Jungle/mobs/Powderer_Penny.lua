-----------------------------------
-- Area: Yhoator Jungle (124)
--   NM: Powderer Penny
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 365)
end

entity.onMobDespawn = function(mob)
    xi.mob.nmTODPersist(mob, math.random(5400, 7200)) -- 90 to 120 minutes
end

return entity
