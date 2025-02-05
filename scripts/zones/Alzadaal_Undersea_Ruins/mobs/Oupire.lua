-----------------------------------
-- Area: Alzadaal Undersea Ruins
--   NM: Oupire
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    -- mob:setMobMod(xi.mobMod.DRAW_IN, 1) -- TODO: DRAW_IN Now Handled In Lua
    mob:setMobMod(xi.mobMod.DRAW_IN_CUSTOM_RANGE, 10)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.PLAGUE)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 478)
    player:addTitle(xi.title.OUPIRE_IMPALER)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.random(14400, 18000)) -- 4 to 5 hours
end

return entity
