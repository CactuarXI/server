-----------------------------------
-- Area: Caedarva Mire
--   NM: Zikko
-- !pos -608.5 11.3 -186.5 79
-----------------------------------
mixins = { require('scripts/mixins/families/imp') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.SILENCE)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 469)
end

entity.onMobDespawn = function(mob)
    xi.mob.nmTODPersist(mob, 7200) -- 2 hours
    DisallowRespawn(mob:getID(), true)
end

return entity
