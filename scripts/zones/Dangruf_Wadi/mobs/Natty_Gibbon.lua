-----------------------------------
-- Area: Dangruf Wadi
--  Mob: Natty Gibbon
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 646, 2, xi.regime.type.GROUNDS)
    xi.cactuarRegimes.checkRegime(player, mob, 8, 2, xi.regime.type.FIELDS)
end

return entity
