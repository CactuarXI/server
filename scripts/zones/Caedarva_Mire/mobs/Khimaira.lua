-----------------------------------
-- Area: Caedarva Mire
--   NM: Khimaira
-----------------------------------
mixins =
{
    require('scripts/mixins/families/khimaira'),
}
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addListener('EFFECT_LOSE', 'KHIMAIRA_EFFECT_LOSE', function(owner, effect)
        local effectType = effect:getEffectType()
        if effectType == xi.effect.STUN then
            owner:addMod(xi.mod.STUNRES, 5)
        end
    end)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 20)
    mob:setMod(xi.mod.MDEF, 100) -- 385 * 1.32/2 = 254 nether blast
    mob:setMod(xi.mod.STATUSRES, 50)
    mob:setMod(xi.mod.PARALYZERES, 50)
    mob:setMod(xi.mod.STUNRES, -75)
    mob:setAnimationSub(0)
end

entity.onMobFight = function(mob, target)
    local drawInTableNorth =
    {
        condition1 = target:getZPos() > 442,
        position   =
        {
            { 574.86, -20.32, 437.50, target:getRotPos() },
        }
    }

    local drawInTableEast =
    {
        condition1 = target:getXPos() > 645,
        position   =
        {
            { 640.47, -15.81, 304.56, target:getRotPos() },
            { 640.47, -15.81, 313.56, target:getRotPos() },
            { 640.47, -15.81, 320.56, target:getRotPos() },
            { 640.47, -15.81, 325.56, target:getRotPos() },
            { 640.47, -15.81, 333.56, target:getRotPos() },
        }
    }

    if
        target:getLocalVar('[Draw-In]WaitTime') < os.time()
    then
        utils.arenaDrawIn(mob, target, drawInTableNorth)
        utils.arenaDrawIn(mob, target, drawInTableEast)
    end
end

entity.onMobEngage = function(mob, target)
    if mob:getHPP() == 100 then
        mob:setMod(xi.mod.STUNRES, -75)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.KHIMAIRA_CARVER)
end

entity.onMobDespawn = function(mob)
    -- local respawn = math.random(48, 72) * 3600 -- 48 to 72 hours in 60min windows
    -- xi.mob.nmTODPersist(mob, respawn)
end

return entity
