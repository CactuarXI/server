-----------------------------------
-- Area: Xarcabard [S]
--   NM: Tikbalang
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 540)
    xi.cactuarRegimes.checkRegime(player, mob, 4, 1, xi.regime.type.FIELDS)
end

return entity
