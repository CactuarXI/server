-----------------------------------
-- Area: Meriphataud Mountains
--   NM: Chonchon
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 20) -- 'Double Attack: Frequent and accurate'
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENSTONE)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 270)
end

entity.onMobDespawn = function(mob)
    xi.mob.nmTODPersist(mob, math.random(3600, 5400)) -- 60 to 90 minutes
end

return entity
