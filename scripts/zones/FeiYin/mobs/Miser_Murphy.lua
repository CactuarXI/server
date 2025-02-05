-----------------------------------
-- Area: FeiYin
--  Mob: Miser Murphy
--  Quest: Peace for the Spirit
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 30)
end

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.SILENCE)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.HP_DRAIN, { power = math.random(450, 550) })
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.MACC, 80)
    mob:setMod(xi.mod.UFASTCAST, 50)
    mob:addMod(xi.mod.BINDRES, 50)
    mob:addMod(xi.mod.STUNRES, 50)
    mob:addMod(xi.mod.SILENCERES, 95)
    -- mob:addMod(xi.mod.RESBUILD_GRAVITY, 10)
    mob:addMod(xi.mod.ACC, 175)
    mob:addStatusEffectEx(xi.effect.ICE_SPIKES, 0, 60, 0, 0)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
