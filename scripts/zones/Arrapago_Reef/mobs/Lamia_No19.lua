-----------------------------------
-- Area: Arrapago Reef
--  Mob: Lamia No.19
-----------------------------------
mixins = { require('scripts/mixins/weapon_break') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 60)
end

entity.onMobSpawn = function(mob)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.PLAGUE, { chance = 10 })
end

entity.onMobEngage = function(mob, target)
    local mobId = mob:getID()
    local mobPos = mob:getPos()
    local skeletonOne = GetMobByID(mob:getID() + 1)
    local skeletonTwo = GetMobByID(mob:getID() + 2)
    skeletonOne:setSpawn(mobPos.x + math.random(-2, 2), mobPos.y, mobPos.z + math.random(-2, 2), mobPos.rot)
    skeletonTwo:setSpawn(mobPos.x + math.random(-2, 2), mobPos.y, mobPos.z + math.random(-2, 2), mobPos.rot)
    SpawnMob(mobId + 1):updateEnmity(target)
    SpawnMob(mobId + 2):updateEnmity(target)
end

entity.onMobDespawn = function(mob)
    local mobId = mob:getID()
    DespawnMob(mobId + 1)
    DespawnMob(mobId + 2)
end

entity.onMobRoam = function(mob)
end

entity.onMobDeath = function(mob, player, optParams)
    local mobId = mob:getID()
    xi.mob.nmTODPersist(mob, math.random(7200, 14400)) -- 2 to 4 hours
    DespawnMob(mobId + 1)
    DespawnMob(mobId + 2)
end

return entity
