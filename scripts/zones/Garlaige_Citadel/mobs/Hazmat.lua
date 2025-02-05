-----------------------------------
-- Area: Garlaige Citadel
--   NM: Hazmat
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addMod(xi.mod.UFASTCAST, 50)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 300)
end

return entity
