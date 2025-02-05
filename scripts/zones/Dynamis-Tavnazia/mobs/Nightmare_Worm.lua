-----------------------------------
-- Area: Dynamis - Tavnazia
--  Mob: Nightmare Worm
-----------------------------------
mixins = { require('scripts/mixins/dynamis_dreamland') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setLocalVar('dynamis_currency', 1449)
end

entity.onMobFight = function(mob, target)
    if mob:getTP() >= 1000 then
        mob:useMobAbility()
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
