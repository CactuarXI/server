-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Seven of Swords
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.amk.helpers.cardianOrbDrop(mob, player, xi.ki.ORB_OF_SWORDS)
    -- xi.regime.checkRegime(player, mob, 666, 3, xi.regime.type.GROUNDS)
    xi.cactuarRegimes.checkRegime(player, mob, 4, 3, xi.regime.type.FIELDS)
end

return entity
