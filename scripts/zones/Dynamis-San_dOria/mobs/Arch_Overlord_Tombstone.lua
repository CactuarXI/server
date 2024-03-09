-----------------------------------
-- Area: Dynamis - San d'Oria
--  Mob: Overlord's Tombstone
-- Note: Mega Boss
-----------------------------------
require('scripts/globals/dynamis')
mixins =
{
    require('scripts/mixins/dynamis_beastmen'),
    require('scripts/mixins/job_special')
}
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.HP_SCALE, 800)
    mob:setSpellList(5078)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.FASTCAST, 50)
    mob:setMod(xi.mod.REFRESH, 25)
    xi.mix.jobSpecial.config(mob, {
        between = 180,
        delay = 60,
        duration = 20,
        specials =
        {
            { id = xi.jsa.HUNDRED_FISTS, cooldown = 0, hpp = 100 },
        },
    })
end

entity.onMobFight = function(mob, target)
    if target:isPet() then
        mob:setMod(xi.mod.FASTCAST, 100)
        mob:castSpell(367, target) -- Insta-death any pet with most enmity.
        mob:setMod(xi.mod.FASTCAST, 50)
    end
    for _, member in pairs(target:getParty()) do
        if member:getObjType() == xi.objType.PC then
        member:changeMusic(2, 88)
        member:changeMusic(3, 88)
        end
    end
end

entity.onMobEngaged = function(mob, target)
end

entity.onSpellPrecast = function(mob, spell)
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if skill:getID() == 1110 then
        local stompCounter = mob:getLocalVar('stompCounter')

        stompCounter = stompCounter + 1
        mob:setLocalVar('stompCounter', stompCounter)

        if stompCounter > 1 then
            mob:setLocalVar('stompCounter', 0)
        elseif mob:checkDistance(target) < 6 then
            mob:useMobAbility(1110)
            mob:resetEnmity(target)
        end
    end
end

entity.onMobDespawn = function(mob)
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
