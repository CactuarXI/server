-----------------------------------
-- Area: Sauromugue Champaign
--   NM: Climbpix Highrise
-- Involved in Quest: As Thick as Thieves 
-----------------------------------
mixins = {require('scripts/mixins/job_special')}
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 97, 2, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 98, 2, xi.regime.type.FIELDS)
end

return entity
