-----------------------------------
-- Area: Labyrinth of Onzozo
--   NM: Ubume
-- Involved in Quest: Yomi Okuri
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 10)
end 

entity.onMobDeath = function(mob, player, optParams)
end

return entity
