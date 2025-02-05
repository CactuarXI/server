-----------------------------------
-- Area: Korroloka Tunnel
--  Mob: Gigas Stonegrinder
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 733, 1, xi.regime.type.GROUNDS)
    xi.cactuarRegimes.checkRegime(player, mob, 7, 1, xi.regime.type.FIELDS)
end

return entity
