-----------------------------------
-- Area: Dynamis - Jeuno
--  Mob: Quicktrix Hexhands
-----------------------------------
mixins =
{
    require('scripts/mixins/dynamis_beastmen'),
    require('scripts/mixins/job_special')
}
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.HP_SCALE, 1000)
end

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        between = 75,
        delay = 15,
        specials =
        {
            { id = xi.jsa.MIJIN_GAKURE, cooldown = 300, hpp = 50 },
            { id = xi.jsa.CHAINSPELL, cooldown = 120, hpp = 100 },
        },
    })
    mob:setLocalVar('[ranged_attack]weaponDmg', 25)
    mob:setLocalVar('[ranged_attack]dmgmod', 0)
    mob:setMod(xi.mod.REFRESH, 10)
end

entity.onMobFight = function(mob, target)
    for _, member in pairs(target:getParty()) do
        if member:getObjType() == xi.objType.PC then
        member:changeMusic(2, 88)
        member:changeMusic(3, 88)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    for _, member in pairs(player:getParty()) do
        if member:getObjType() == xi.objType.PC then
        member:changeMusic(2, 121)
        member:changeMusic(3, 121)
        end
    end
end

return entity
