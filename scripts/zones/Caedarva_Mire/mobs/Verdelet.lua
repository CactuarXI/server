-----------------------------------
-- Area: Caedarva Mire (79)
--  ZNM: Verdelet
-- !pos 417 -19.3 -70 79
-----------------------------------
mixins = { require('scripts/mixins/families/imp') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
    mob:setMobMod(xi.mobMod.GIL_MIN, 4500)
    mob:setMobMod(xi.mobMod.GIL_MAX, 7500)

    -- take less damage
    mob:setMod(xi.mod.DMGPHYS, -33)
    mob:setMod(xi.mod.DMGMAGIC, -33)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.UFASTCAST, 50) -- Appears to have 50% FC from capture.
    mob:setMobMod(xi.mobMod.GA_CHANCE, 80)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 12) -- Sets recast time in line with capture.

    mob:setLocalVar('horn', 0)
end

entity.onMobFight = function(mob)
    local horn = mob:getAnimationSub()

    if horn == 1 then
        mob:timer(30000, function(mob)
            mob:setAnimationSub(0)
        end)
        mob:setSpellList(703)
    else
        mob:setSpellList(702)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
