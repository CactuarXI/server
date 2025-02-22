-----------------------------------
-- Area: Promyvion-Vahzl
--   NM: Wailer
-----------------------------------
mixins = { require('scripts/mixins/families/empty_terroanima') }
-----------------------------------
---@type TMobEntity
local entity = {}

-- TODO: Random Element Mobskill Mechanic?
entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
end

entity.onMobSpawn = function(mob)
    xi.promyvion.emptyOnMobSpawn(mob, xi.promyvion.mobType.WEEPER)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
