-----------------------------------
-- Area: Dynamis - Valkurm
--  Mob: Nightmare Manticore
-----------------------------------
mixins = { require('scripts/mixins/dynamis_dreamland') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setLocalVar('dynamis_currency', 1449)
    mob:setMod(xi.mod.REGAIN, 50)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
