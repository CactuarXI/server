-----------------------------------
-- Area: Maze of Shakhrami
--  Mob: Warren Bat
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 702, 1, xi.regime.type.GROUNDS)
    xi.cactuarRegimes.checkRegime(player, mob, 8, 1, xi.regime.type.FIELDS)
end

return entity
