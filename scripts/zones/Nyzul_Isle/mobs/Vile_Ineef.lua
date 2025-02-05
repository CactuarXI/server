-----------------------------------
--  MOB: Vile Ineef
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
    return 1967 -- Trbulation
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        xi.nyzul.spawnChest(mob, player)
        xi.nyzul.enemyLeaderKill(mob)
    end
end

return entity
