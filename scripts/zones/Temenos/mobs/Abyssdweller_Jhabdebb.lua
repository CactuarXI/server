-----------------------------------
-- Area: Temenos
--  Mob: Abyssdweller Jhabdebb
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
local ID = zones[xi.zone.TEMENOS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
