-----------------------------------
-- Area: Yahse Hunting Grounds
-- Mob: Shrubshredder_Chapuli
-----------------------------------
mixins =
{
    require('scripts/mixins/families/chapuli')
}
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
