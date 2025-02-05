-----------------------------------
-- Area: Caedarva Mire (79)
--  ZNM: Experimental Lamia
-- !pos -773.369 -11.824 322.298 79
-----------------------------------
local ID = zones[xi.zone.CAEDARVA_MIRE]
-----------------------------------
---@type TMobEntity
local entity = {}
local ID = zones[xi.zone.CAEDARVA_MIRE]

local function spawnMinions(mob, target)
    mob:setLocalVar('spawnedMinions', 1)

    local x = mob:getXPos()
    local y = mob:getYPos()
    local z = mob:getZPos()

    for i = ID.mob.EXPERIMENTAL_LAMIA + 1, ID.mob.EXPERIMENTAL_LAMIA + 3 do
        local minion = GetMobByID(i)

        if minion then
            minion:setSpawn(x + math.random(-2, 2), y, z + math.random(-2, 2))
            minion:spawn()
            minion:updateEnmity(target)
        end
    end
end

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
    mob:setMobMod(xi.mobMod.GIL_MIN, 3000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 5000)
    mob:setMobMod(xi.mobMod.ALLI_HATE, 30)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar('[rage]timer', 5400)                 -- 90 minutes
    mob:setLocalVar('adds', 0)   
    mob:setLocalVar('dances', 0)
    mob:setLocalVar('tailSlap', 0)   
    mob:setMod(xi.mod.GRAVITYRES, 100)
    mob:setAnimationSub(0)       
end   


entity.onMobFight = function(mob, target)
    if mob:getHPP() < 75 and mob:getLocalVar('spawnedMinions') == 0 then
        spawnMinions(mob, target)
    end

    -- make sure minions have a target
    for i = ID.mob.EXPERIMENTAL_LAMIA + 1, ID.mob.EXPERIMENTAL_LAMIA + 3 do
        local minion = GetMobByID(i)
        if
            minion and
            minion:getCurrentAction() == xi.act.ROAMING
        then
            minion:updateEnmity(target)
        end
    end

    if mob:getLocalVar('dances') > 0 then
        mob:setLocalVar('dances', mob:getLocalVar('dances') - 1)
        mob:useMobAbility(1762)
    elseif mob:getLocalVar('tailSlap') == 1 then
        -- use arrow_deluge after tail_slap, after belly dances
        mob:setLocalVar('tailSlap', 0)
        mob:useMobAbility(1761)
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if mob:getLocalVar('spawnedMinions') == 0 then
        spawnMinions(mob, target)
    end

    if skill:getID() == 1758 then -- Tail Slap
        mob:setLocalVar('tailSlap', 1)
    end
end

entity.onCriticalHit = function(mob)
    local RND = math.random(1, 100)
    if mob:getAnimationSub() == 0 and RND <= 5 then
        mob:setAnimationSub(1)
    end
end


entity.onMobDeath = function(mob, player, optParams)
end

return entity
