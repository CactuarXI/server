-----------------------------------
-- Area: Behemoths Dominion
--  Mob: Bhuta
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 103, 2, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 3, 2, xi.regime.type.FIELDS)
end

return entity
