-----------------------------------
-- Area: Wajaom Woodlands
--  Mob: Hydra
-- !pos -282 -24 -1 51
-----------------------------------
---@type TMobEntity
local entity = {}

local drawInPos =
{
    {-280.20, -23.88,  -5.94},
    {-272.08, -23.75,  -1.73},
    {-276.90, -24.00,   2.09},
    {-268.59, -23.96, -16.00},
    {-285.57, -24.20,  -0.56},
    {-282.16, -24.00,   1.95},
    {-271.35, -23.66,  -5.46},
    {-272.75, -23.55, -11.25},
}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DEF, 450)
    mob:setMod(xi.mod.ATT, 350)
    mob:setMod(xi.mod.PIERCE_SDT, 250) -- 25% piercing resistance
    mob:setMod(xi.mod.DOUBLE_ATTACK, 20)
    mob:setMod(xi.mod.MEVA, 400)
    mob:setMod(xi.mod.WATER_SDT, 200)
    mob:setMod(xi.mod.ICE_SDT, 200)
    mob:setMod(xi.mod.FIRE_SDT, 200)
end

entity.onMobRoam = function(mob)
    local battletime = mob:getBattleTime()
    local headgrow = mob:getLocalVar('headgrow')
    local broken = mob:getAnimationSub()

    if (headgrow < battletime and broken > 0) then
        mob:setAnimationSub(broken - 1)
    end
end

entity.onMobFight = function(mob, target)
    local targetPos = target:getPos()
    local spawnPos = mob:getSpawnPos()

    local drawInPositions =
    {
        { -279.879,    -24,  -1.103, targetPos.rot },
        { -268.899,  -23.5, -11.148, targetPos.rot },
        { -279.844, -23.75, -11.462, targetPos.rot },
        { -268.952, -23.75,  -0.583, targetPos.rot },
    }

    local drawInTable =
    {
        conditions =
        {
            utils.distanceSquared(targetPos, spawnPos) > math.pow(18, 2),
        },
        position = utils.randomEntry(drawInPositions),
        wait = 2,
    }

    for _, condition in ipairs(drawInTable.conditions) do
        if condition then
            mob:setMobMod(xi.mobMod.NO_MOVE, 1)
            utils.drawIn(target, drawInTable)
            break
        else
            mob:setMobMod(xi.mobMod.NO_MOVE, 0)
        end
    end

    local battletime = mob:getBattleTime()
    local headgrow = mob:getLocalVar('headgrow')
    local broken = mob:getAnimationSub()
    local headthreshold = mob:getLocalVar('headthreshold')

    if (headgrow < battletime and broken > 0) then
        mob:setAnimationSub(broken - 1)
        mob:setLocalVar('headgrow', battletime + math.random(60, 120))
        mob:setTP(3000)
    end

    if broken == 0 then
        mob:setMod(xi.mod.REGAIN, 100)
        mob:setMod(xi.mod.REGEN, 165) -- 1% per 14s
    elseif broken == 1 then
        mob:setMod(xi.mod.REGAIN, 90)
        mob:setMod(xi.mod.REGEN, 70) -- 1% per 33s
    elseif broken == 2 then
        mob:setMod(xi.mod.REGAIN, 80)
        mob:setMod(xi.mod.REGEN, 10) -- 1% per 240s
    end

    if mob:getHPP() == 100 then
        mob:setLocalVar('headthreshold', 0)
    elseif mob:getHPP() < 75 and headthreshold == 0 then
        mob:setLocalVar('headgrow', headgrow - 240)
        mob:setLocalVar('headthreshold', 1)
    elseif mob:getHPP() < 50 and headthreshold == 1 then
        mob:setLocalVar('headgrow', headgrow - math.random(150, 180))
        mob:setLocalVar('headthreshold', 2)
    elseif mob:getHPP() < 25 and headthreshold == 2 then
        mob:setLocalVar('headgrow', headgrow - math.random(50, 90))
        mob:setLocalVar('headthreshold', 3)
    end

    local drawInWait = mob:getLocalVar('DrawInWait')

    if (target:getXPos() < -295 or target:getXPos() > -260) and os.time() > drawInWait then
        local rot = target:getRotPos()
        local position = math.random(1,8)
        target:setPos(drawInPos[position][1],drawInPos[position][2],drawInPos[position][3],rot)
        mob:messageBasic(232, 0, 0, target)
        mob:setLocalVar('DrawInWait', os.time() + 2)
    elseif (target:getZPos() < -25 or target:getZPos() > 13) and os.time() > drawInWait then
        local rot = target:getRotPos()
        local position = math.random(1,8)
        target:setPos(drawInPos[position][1],drawInPos[position][2],drawInPos[position][3],rot)
        mob:messageBasic(232, 0, 0, target)
        mob:setLocalVar('DrawInWait', os.time() + 2)
    end
end

entity.onMobDrawIn = function(mob, target)
    mob:setTP(3000)
end


entity.onCriticalHit = function(mob)
    local battletime = mob:getBattleTime()
    local headbreak  = mob:getLocalVar('headbreak')
    local broken     = mob:getAnimationSub()

    if mob:getHPP() > 75 then
        if (math.random(1, 100) <= 15 and broken < 2) then
            mob:setAnimationSub(broken + 1)
            mob:setLocalVar('headgrow', battletime + math.random(480, 600))
        end
    elseif mob:getHPP() > 50 then
        if (math.random(1, 100) <= 10 and broken < 2) then
            mob:setAnimationSub(broken + 1)
            mob:setLocalVar('headgrow', battletime + math.random(240, 360))
        end
    elseif mob:getHPP() > 25 then
        if (math.random(1, 100) <= 10 and broken < 2) then
            mob:setAnimationSub(broken + 1)
            mob:setLocalVar('headgrow', battletime + math.random(90, 180))
        end
    elseif mob:getHPP() < 25 then
        if (math.random(1, 100) <= 10 and broken < 2) then
            mob:setAnimationSub(broken + 1)
            mob:setLocalVar('headgrow', battletime + math.random(40, 90))
        end
    end
end


entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.HYDRA_HEADHUNTER)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.random(48, 72) * 3600) -- 48 to 72 hours, in 1 hour windows
end

return entity
