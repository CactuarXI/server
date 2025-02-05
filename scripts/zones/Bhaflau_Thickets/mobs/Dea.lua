-----------------------------------
-- Area: Bhaflau Thickets
--  ZNM: Dea(T3ZNM)
-- Author: Chiefy
-- To do:   As HP decreases, the effective range of 'Demoralizing Roar' and 'Crippling Slam' expands. -- Need more evidence.
--          Dispel message for boiling blood needs to fixed.
-- Issues:  If mob is never moved after spawning the target:isBehind/isInFront can react weirdly.
-----------------------------------
mixins = {require('scripts/mixins/rage')}

-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
    mob:setMobMod(xi.mobMod.GIL_MIN, 3000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 5000)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar('QueuedAbility', 0)
    mob:setLocalVar('[rage]timer', 5400)
    mob:setBehavior(bit.bor(mob:getBehavior(), xi.behavior.NO_TURN))
end

entity.onMobWeaponSkillPrepare = function(mob, target)
    return 0
end

entity.onMobWeaponSkill = function(target, mob, skill)
    local QueuedAbility = mob:getLocalVar('QueuedAbility')

    if skill:getID() == 2101 then
        mob:useMobAbility(2104)
    end
    if skill:getID() == 2102 then
        mob:setLocalVar('QueuedAbility', math.random(1,3))
        if QueuedAbility == 1 then
            mob:useMobAbility(2104)
        elseif QueuedAbility == 2 or 3 then
            if target:isBehind(mob, 96) then
                mob:useMobAbility(2099)
            elseif target:isInfront(mob, 90) then
                mob:useMobAbility(2100)
            else
                mob:useMobAbility(2104)
            end
        end
    end
    local skillID = skill:getID()
    if skillID == 2099 or skillID == 2100 or skillID == 2104 then
        mob:setLocalVar('QueuedAbility', 0)
    end
end

entity.onMobFight = function(mob, target)
    if mob:hasStatusEffect(xi.effect.PHYSICAL_SHIELD) then
        mob:setMod(xi.mod.DOUBLE_ATTACK, 100)
    else
        mob:setMod(xi.mod.DOUBLE_ATTACK, 10)
    end
end

entity.onMobDeath = function(mob, player, isKiller)
end

entity.onMobDespawn = function(mob)
end

return entity