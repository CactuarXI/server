-----------------------------------
-- Area: The Boyahda Tree
--  Mob: Mourning Crawler
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 726, 3, xi.regime.type.GROUNDS)
    xi.cactuarRegimes.checkRegime(player, mob, 8, 3, xi.regime.type.FIELDS)
end

return entity
