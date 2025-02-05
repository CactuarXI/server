-----------------------------------
-- Area: Beaucedine Glacier [S]
--   NM: Amphiptere
-----------------------------------
mixins = { require('scripts/mixins/families/amphiptere') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.SKILL_LIST, 6)  
    mob:setMobAbilityEnabled(true)
    mob:setAnimationSub(1)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
