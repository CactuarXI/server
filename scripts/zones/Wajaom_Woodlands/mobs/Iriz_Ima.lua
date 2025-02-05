-----------------------------------
-- Area: Wajaom Woodlands
--  ZNM: Iriz Ima
-----------------------------------
mixins = { require('scripts/mixins/rage') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
    mob:setMobMod(xi.mobMod.GIL_MIN, 4500)
    mob:setMobMod(xi.mobMod.GIL_MAX, 7500)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar('[rage]timer', 3600) -- 60 minutes
    mob:setLocalVar('BreakChance', 5)
    mob:setMod(xi.mod.MOVE_SPEED_STACKABLE, -15)
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if  skill:getID() == 1704 then -- (Onrush)
        mob:lowerEnmity(target, 20)
    end

    if skill:getID() == 1704 then
        local OnrushCounter = mob:getLocalVar('OnrushCounter')
        local OnrushMax = mob:getLocalVar('OnrushMax')

        if OnrushCounter == 0 and OnrushMax == 0 then
            OnrushMax = math.random(3, 5)
            mob:setLocalVar('OnrushMax', OnrushMax)
        end

        OnrushCounter = OnrushCounter + 1
        mob:setLocalVar('OnrushCounter', OnrushCounter)

        if OnrushCounter > OnrushMax then
            mob:setLocalVar('OnrushCounter', 0)
            mob:setLocalVar('OnrushMax', 0)
        else
            mob:useMobAbility(1704)
        end
    end
end

entity.onCriticalHit = function(mob, attacker)
    if math.random(1, 100) <= mob:getLocalVar('BreakChance') then
        local animationSub = mob:getAnimationSub()
        if animationSub == 4 then
            mob:setAnimationSub(1) -- 1 horn broken
        elseif animationSub == 1 then
            mob:setAnimationSub(2) -- both horns broken
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
