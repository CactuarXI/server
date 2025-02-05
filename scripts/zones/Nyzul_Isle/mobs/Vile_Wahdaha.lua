-----------------------------------
--  MOB: Vile Wahdaha
-- Area: Nyzul Isle
-- Info: Enemy Leader
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    -- mob:addImmunity(xi.immunity.DARKSLEEP)
    mob:setMod(xi.mod.SILENCERES, 100)

end

entity.onMobWeaponSkillPrepare = function(mob, target)
    if (math.random(1,2)) then
        return 1968 -- Immortal Anathema?
    end
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        xi.nyzul.spawnChest(mob, player)
        xi.nyzul.enemyLeaderKill(mob)
    end
end

return entity
