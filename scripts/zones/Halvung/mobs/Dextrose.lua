-----------------------------------
-- Area: Halvung
--   NM: Dextrose (ZNM T2)
-----------------------------------
mixins = {require('scripts/mixins/rage')}
require('scripts/globals/pathfind')
-----------------------------------
---@type TMobEntity
local entity = {}

local EbonyIDs = {
    17031451,
    17031452,
    17031453,
    17031456,
    17031457,
}

-- find the lowest (but greater than >5%) hp ebony pudding regardless of distance
local function FindMeal(mob)
    -- keep track of target id, hpp, distance
    local target = { 0, 100, 0 }

    for _, id in pairs(EbonyIDs) do
        local meal = GetMobByID(id)
        if meal:isSpawned() and meal:isAlive() and meal:getHPP() > 5 then
            local distance = mob:checkDistance(meal)
            local remaining = meal:getHPP()

            -- prioritize lowest hp first, closest second
            if target[1] == 0 or target[2] > remaining or ( target[2] == remaining and target[3] > distance ) then
                target = { id, remaining, distance }
            end
        end
    end

    -- return the id
    return target[1]
end

-- function that will trigger the synergism process
local function PickupMeal(mob, mealID)
    -- stop going where ever we're going to
    mob:clearPath()

    -- keep track of our meal
    mob:setLocalVar('MealID', mealID)

    if mealID > 0 then
        -- disable any actions
        mob:setAutoAttackEnabled(false)
        mob:setMagicCastingEnabled(false)
        mob:setMobAbilityEnabled(false)

        -- immobilize our meal
        local meal = GetMobByID(mealID)
        meal:setMobMod(xi.mobMod.NO_MOVE, 1)

        -- path to it
        local pos = meal:getPos()
        mob:pathTo(pos.x, pos.y, pos.z, xi.path.flag.RUN + xi.path.flag.SCRIPT)
    else
        -- seems like the meal was a lie afterall, back to the killin' business
        mob:setAutoAttackEnabled(true)
        mob:setMagicCastingEnabled(true)
        mob:setMobAbilityEnabled(true)
    end
end

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 900)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
    mob:setMobMod(xi.mobMod.GIL_MIN, 4500)
    mob:setMobMod(xi.mobMod.GIL_MAX, 7500)

    -- immune to sleep
    mob:setMod(xi.mod.LULLABYRES, 100)
    mob:setMod(xi.mod.SLEEPRES, 100)
    mob:setMod(xi.mod.REGAIN, 400)

    -- very high fast cast and prioritize ga spells a bit more
    mob:setMod(xi.mod.UFASTCAST, 50)
    mob:setMobMod(xi.mobMod.GA_CHANCE, 60)

    -- take less damage
    mob:setMod(xi.mod.DMGPHYS, -33)
    mob:setMod(xi.mod.DMGMAGIC, -33)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar('[rage]timer', 4500)
    mob:setLocalVar('LastSynergism', 100)
    mob:setLocalVar('MealID', 0)
    mob:setLocalVar('NextAttempt', math.random(70, 79))

    -- will counter attack weapon skills
    mob:addListener('WEAPONSKILL_TAKE', 'DEXTROSE_COUNTERATTACK', function(target, attacker, skillid, tp, action)
        -- counters with Amorphic Spikes, targeting the user of the weaponskill regardless of who has hate
        if attacker:isPC() or attacker:isPet() then
            target:useMobAbility(1824, attacker)
        end
    end)
end

entity.onMobFight = function(mob, target)
    -- are we going for meal
    local mealID = mob:getLocalVar('MealID')
    if mealID > 0 then
        local meal = GetMobByID(mealID)
        if meal:isAlive() and meal:getHPP() > 5 then
            if mob:checkDistance(meal) < 5 then
                -- tonight we feast!
                mob:setLocalVar('LastSynergism', mob:getHPP())
                mob:useMobAbility(1826, meal)

                -- make sure the leftover is able to move again and links to target
                meal:stun(3000)
                meal:setMobMod(xi.mobMod.NO_MOVE, 0)
                meal:updateEnmity(target)

                -- unset mealID to prevent further abuse
                mob:setLocalVar('MealID', 0)
                mob:clearPath()
            end
        else
            -- meal vanished?! let's try to find a new one
            meal:setMobMod(xi.mobMod.NO_MOVE, 0)
            PickupMeal(mob, FindMeal(mob))
        end
    else
        -- figure out if its time for a snack
        local hpp = mob:getHPP()
        local nextAttempt = mob:getLocalVar('NextAttempt')

        if hpp <= nextAttempt then
            -- will not try again for another 5%
            mob:setLocalVar('NextAttempt', math.max(0, hpp - 5))

            -- calculate up to 80% chances at +10% per 5% hp lost since last successful synergism
            local chances = 1 + math.floor((mob:getLocalVar('LastSynergism') - hpp) / 5)
            if math.min(8, chances) >= math.random(1, 10) then
                -- trigger the synergism process
                PickupMeal(mob, FindMeal(mob))
            end
        end
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    -- resume fighting after synergism
    if skill:getID() == 1826 then
        mob:setAutoAttackEnabled(true)
        mob:setMagicCastingEnabled(true)
        mob:setMobAbilityEnabled(true)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    mob:removeListener('DEXTROSE_COUNTERATTACK')

    -- remove lingering movement restrictions
    local mealID = mob:getLocalVar('MealID')
    if mealID > 0 then
        local meal = GetMobByID(mealID)
        meal:setMobMod(xi.mobMod.NO_MOVE, 0)
    end    
end

return entity
