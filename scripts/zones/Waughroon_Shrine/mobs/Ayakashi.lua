-----------------------------------
-- Area: Waughroon Shrine
--   NM: Ayakashi
-- Involved in Quest: A Thief in Norg
-----------------------------------
mixins = { require('scripts/mixins/families/avatar') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
