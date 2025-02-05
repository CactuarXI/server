-----------------------------------
-- Area: Inner Horutoto Ruins
--  Mob: Goblin Flesher
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 652, 2, xi.regime.type.GROUNDS)
    xi.cactuarRegimes.checkRegime(player, mob, 6, 2, xi.regime.type.FIELDS)
end

return entity
