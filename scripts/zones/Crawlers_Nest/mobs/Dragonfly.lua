-----------------------------------
-- Area: Crawlers' Nest
--  Mob: Dragonfly
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 691, 3, xi.regime.type.GROUNDS)
    xi.cactuarRegimes.checkRegime(player, mob, 5, 3, xi.regime.type.FIELDS)
end

return entity
