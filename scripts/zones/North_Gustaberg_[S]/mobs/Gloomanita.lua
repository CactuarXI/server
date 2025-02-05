-----------------------------------
-- Area: North Gustaberg [S]
--   NM: Gloomanita
-----------------------------------
mixins = {require('scripts/mixins/families/funguar_s')}
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobSpawn = function(mob)
    mob:setAnimationSub(0)
--    mob:setStealItemID(4373) -- Woozyshroom is default steal item, needed here in case first action on the mob is steal

end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.POISON, { power = 5 })
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 498)
    xi.magian.onMobDeath(mob, player, optParams, set{ 779 })
end

return entity
