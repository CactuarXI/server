-----------------------------------
-- Area: The Eldieme Necropolis
-- NM: Skull of Greed
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 185)
    player:addTitle(xi.title.SKULLCRUSHER)
    xi.cactuarRegimes.checkRegime(player, mob, 1, 1, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 5, 2, xi.regime.type.FIELDS)
end

return entity
