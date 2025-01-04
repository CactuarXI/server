-----------------------------------
-- Area: Arrapago Reef
--  Mob: Lamia's Skeleton
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:setMod(xi.mod.MAIN_DMG_RATING, 50)
    mob:setMod(xi.mod.ATT, 600)
end

entity.onMobEngage = function(mob, target)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
