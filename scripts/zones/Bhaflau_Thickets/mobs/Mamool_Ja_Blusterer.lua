-----------------------------------
-- Area: Bhaflau Thickets
--  Mob: Mamool Ja Blusterer
-----------------------------------
mixins = { require('scripts/mixins/families/mamool_ja'), require('scripts/mixins/weapon_break') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.cactuarRegimes.checkRegime(player, mob, 6, 1, xi.regime.type.FIELDS)
end

return entity
