-----------------------------------
-- Area: Lower Delkfutt's Tower
--   NM: Eurymedon
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 342)
    xi.cactuarRegimes.checkRegime(player, mob, 2, 2, xi.regime.type.FIELDS)
end

return entity
