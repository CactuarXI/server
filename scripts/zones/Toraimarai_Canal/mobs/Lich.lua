-----------------------------------
-- Area: Toraimarai Canal
--  Mob: Lich
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 619, 2, xi.regime.type.GROUNDS)
    xi.cactuarRegimes.checkRegime(player, mob, 2, 2, xi.regime.type.FIELDS)
end

return entity
