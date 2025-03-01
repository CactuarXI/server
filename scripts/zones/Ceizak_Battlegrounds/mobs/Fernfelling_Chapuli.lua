-----------------------------------
-- Area: Ceizak Battlegrounds
-- Mob: Fernfelling Chapuli
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
