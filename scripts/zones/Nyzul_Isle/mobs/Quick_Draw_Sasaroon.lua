-----------------------------------
--  MOB: Quick Draw Sasaroon
-- Area: Nyzul Isle
-- Info: Enemy Leader, Ranger
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.ACC, 100) -- extra accurate
end

entity.onMobWeaponSkillPrepare = function(mob, target)
    return 1728 -- faze
end

entity.onMobFight = function(mob, target)
    local mobHPP = mob:getHPP()
    if mobHPP < 25 then
        if (mob:getMod(xi.mod.REGAIN) ~= 250) then
            mob:setMod(xi.mod.REGAIN, 250)
        end
    elseif mobHPP < 50 then
        if (mob:getMod(xi.mod.REGAIN) ~= 125) then
            mob:setMod(xi.mod.REGAIN, 125)
        end
    elseif mobHPP < 75 then
        if (mob:getMod(xi.mod.REGAIN) ~= 75) then
            mob:setMod(xi.mod.REGAIN, 75)
        end
    end
end


entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        xi.nyzul.spawnChest(mob, player)
        xi.nyzul.enemyLeaderKill(mob)
    end
end

return entity
