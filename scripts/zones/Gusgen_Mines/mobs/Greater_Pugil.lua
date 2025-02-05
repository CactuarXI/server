-----------------------------------
-- Area: Gusgen Mines
--  Mob: Greater Pugil
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 682, 1, xi.regime.type.GROUNDS)
    xi.cactuarRegimes.checkRegime(player, mob, 4, 1, xi.regime.type.FIELDS)
end

return entity
