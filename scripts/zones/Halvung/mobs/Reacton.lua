-----------------------------------
-- Area: Halvung
--  ZNM: Reacton
-----------------------------------
mixins = {require('scripts/mixins/rage')}

require('scripts/globals/utils')
-----------------------------------
---@type TMobEntity
local entity = {}

local function getSwole(mob)
    -- disable/enable actions to avoid interrupting animation
    mob:setAutoAttackEnabled(false)
    mob:setMagicCastingEnabled(false)
    mob:setMobAbilityEnabled(false)

    mob:timer(1800, function(mob)
        mob:setAutoAttackEnabled(true)
        mob:setMagicCastingEnabled(true)
        mob:setMobAbilityEnabled(true)
    end)

    -- increase size
    local size = mob:getLocalVar('currentSize') + 1
    mob:setLocalVar('currentSize', size)

    -- animate and apply attack boost
    mob:setAnimationSub(size)
    mob:addMod(xi.mod.ATTP, 33)

    -- apply new spell list based on size
    local listID = 0
    if size == 1 then
        listID = 717
    elseif size == 2 then
        listID = 718
    end
    mob:setSpellList(listID)

    -- return size so we can trigger self-destruct
    return size
end

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
    mob:setMobMod(xi.mobMod.GIL_MIN, 4500)
    mob:setMobMod(xi.mobMod.GIL_MAX, 7500)

    -- fast attack speed and high defense
    mob:setMod(xi.mod.DELAY, 1800)
    mob:setMod(xi.mod.DMGPHYS, -33)
    mob:setMod(xi.mod.DMGMAGIC, -33)

    -- immune to stun and immune or extremely resistant to Silence, as if
    mob:setMod(xi.mod.SILENCERES, 95)
    mob:setMod(xi.mod.STUNRES, 100)

    -- resist building
    --mob:setMod(xi.mod.RESBUILD_GRAVITY, 25)
    --mob:setMod(xi.mod.RESBUILD_LULLABY, 40)
    --mob:setMod(xi.mod.RESBUILD_SLEEP, 40)

    -- don't standback like your regular black mage mob
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
end

entity.onMobSpawn = function(mob)
    -- setting enrage timer anyways, in case of continuous wipes
    mob:setLocalVar('[rage]timer', 4500)

    -- phase change mechanics
    mob:setAnimationSub(0)
    mob:setLocalVar('currentSize', 0)
    mob:setLocalVar('nextChange', 0)
    mob:setSpellList(0)
end

entity.onMobEngage = function(mob, target)
    -- starting the phase change timer
    mob:setLocalVar('nextChange', os.time() + 45)
end

entity.onMobFight = function(mob, target)
    -- phase changes
    if utils.canUseAbility(mob) == true then
        local next = mob:getLocalVar('nextChange')
        if next > 0 and next < os.time() and mob:actionQueueEmpty() then
            if getSwole(mob) < 3 then
                mob:setLocalVar('nextChange', os.time() + 45)
            else
                -- time to go! self-destruct
                mob:setLocalVar('nextChange', 0)
                mob:useMobAbility(597)
            end
    end
            end
        end

entity.onMobDisengage = function(mob)
    -- pause phase changes
    mob:setLocalVar('nextChange', 0)
    end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    -- reset size
    mob:setAnimationSub(0)
end

return entity
