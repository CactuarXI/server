-----------------------------------
-- Area: Korroloka Tunnel
--  Mob: Combat
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 728, 2, xi.regime.type.GROUNDS)
    xi.cactuarRegimes.checkRegime(player, mob, 2, 2, xi.regime.type.FIELDS)
end

return entity
