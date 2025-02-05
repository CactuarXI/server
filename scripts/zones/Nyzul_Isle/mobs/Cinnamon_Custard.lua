-----------------------------------
--  MOB: Cinnamon Custard
-- Area: Nyzul Isle
-- Info: Enemy Leader, Absorbs water elemental damage
-----------------------------------
mixins = { require('scripts/mixins/families/flan') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.WATER_ABSORB, 100)
end

entity.onCastStarting = function(mob, spell)
    if (mob:getLocalVar('Xenoglossia') > 0) then
        mob:setLocalVar('Xenoglossia', 0)
        spell:setCastTime(1)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        xi.nyzul.spawnChest(mob, player)
        xi.nyzul.enemyLeaderKill(mob)
    end
end

return entity
