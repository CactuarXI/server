-----------------------------------
-- Area: Yhoator Jungle
--   NM: Edacious Opo-opo
-----------------------------------
local ID = zones[xi.zone.YHOATOR_JUNGLE]
-----------------------------------
---@type TMobEntity
local entity = {}


entity.onMobDespawn = function(mob)
    GetNPCByID(ID.npc.EDACIOUS_QM):setLocalVar('despawned', os.time() + 900)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 366)
end

entity.onMobDespawn = function(mob)
    mob:setLocalVar('cooldown', os.time() + 900)
end

return entity
