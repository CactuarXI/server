-----------------------------------
-- Area: Maze of Shakhrami
--   NM: Leech King
-----------------------------------
local ID = zones[xi.zone.MAZE_OF_SHAKHRAMI]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    if math.random(2) == 1 then
        DisallowRespawn(ID.mob.LEECH_KING, true)
        DisallowRespawn(ID.mob.ARGUS, false)
        UpdateNMSpawnPoint(ID.mob.ARGUS)
        xi.mob.nmTODPersist(mob, math.random(36000, 43200)) -- 10 - 12 hrs
    else
        DisallowRespawn(ID.mob.ARGUS, true)
        DisallowRespawn(ID.mob.LEECH_KING, false)
        UpdateNMSpawnPoint(ID.mob.LEECH_KING)
        xi.mob.nmTODPersist(GetMobByID(ID.mob.LEECH_KING), math.random(36000, 43200)) -- 10 - 12 hrs
    end
end

return entity
