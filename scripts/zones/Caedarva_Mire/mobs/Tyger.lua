-----------------------------------
-- Area: Caedarva Mire
--  ZNM: Tyger
-- !pos -766 -12 632 79
-- Spawn with Singed Buffalo: !additem 2593
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.GIL_MIN, 12000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 30000)
    mob:setMobMod(xi.mobMod.MUG_GIL, 4000)
    mob:setMod(xi.mod.SLEEPRES, 30)
    mob:setMod(xi.mod.BINDRES, 30)
    mob:setMod(xi.mod.GRAVITYRES, 30)
    mob:setMod(xi.mod.STR, 40)
    mob:setMod(xi.mod.ATTP, 30)
    mob:setMod(xi.mod.MAIN_DMG_RATING, 50)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
    mob:setLocalVar('[rage]timer', 3600) -- 60 minutes
    mob:setBehavior(bit.bor(mob:getBehavior(), xi.behavior.NO_TURN))
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if skill:getID() == 3267 then -- howl
        mob:useMobAbility(2024) -- Tourbillion
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
