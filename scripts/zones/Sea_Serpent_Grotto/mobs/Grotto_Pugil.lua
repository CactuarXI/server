-----------------------------------
-- Area: Sea Serpent Grotto
--  Mob: Grotto Pugil
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 808, 2, xi.regime.type.GROUNDS)
    xi.cactuarRegimes.checkRegime(player, mob, 5, 2, xi.regime.type.FIELDS)
end

return entity
