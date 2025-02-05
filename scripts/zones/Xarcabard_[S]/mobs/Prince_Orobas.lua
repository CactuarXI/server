-----------------------------------
-- Area: Xarcabard [S]
--   NM: Prince Orobas
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 541)
    xi.cactuarRegimes.checkRegime(player, mob, 4, 1, xi.regime.type.FIELDS)
end

return entity
