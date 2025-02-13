-----------------------------------
-- Area: Mount Zhayolm
--  Mob: Anantaboga (ZNM T2)
-----------------------------------
mixins = {require('scripts/mixins/rage')}

-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
    mob:setMobMod(xi.mobMod.GIL_MIN, 4500)
    mob:setMobMod(xi.mobMod.GIL_MAX, 7500)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar('[rage]timer', 4500)
    --mob:setMod(xi.mod.RESBUILD_GRAVITY, 25)
    --mob:setMod(xi.mod.RESBUILD_BIND, 25)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 15)
    mob:setMod(xi.mod.SLEEPRES, 100)

    -- event listeners for when silence is applied/wears off
    mob:addListener('EFFECT_GAIN', 'SILENCE_IS_HERE', function(mob, effect)
        if effect:getEffectType() == xi.effect.SILENCE then
            mob:setMobMod(xi.mobMod.SKILL_LIST, 5298)
            mob:setMod(xi.mod.REGAIN, 200)
end
    end)

    mob:addListener('EFFECT_LOSE', 'SILENCE_WAS_HERE', function(mob, effect)
        if effect:getEffectType() == xi.effect.SILENCE then
            mob:setMobMod(xi.mobMod.SKILL_LIST, 298)
            mob:setMod(xi.mod.REGAIN, 0)
        end
    end)
end

entity.onMobRoam = function(mob)
    -- do not delay roaming back to spawn and don't do a direct path when over 20 yalms away (in case he charms all players on hate table)
    if not mob:isFollowingPath() then
        local spawn = mob:getSpawnPos()
        mob:pathTo(spawn.x, spawn.y, spawn.z)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    -- remove listeners upon despawn
    mob:removeListener('SILENCE_IS_HERE')
    mob:removeListener('SILENCE_WAS_HERE')
end

return entity
