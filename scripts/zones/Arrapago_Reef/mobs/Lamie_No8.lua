-----------------------------------
-- Area: Arrapago Reef
--  Mob: Lamie No.7
-----------------------------------
mixins =
{
    require('scripts/mixins/weapon_break')
}
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
end

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.STUN)
    mob:setLocalVar('EES_Timer', os.time())
    mob:setMod(xi.mod.REGAIN, 600)
    mob:addMod(xi.mod.STR, 10)
    mob:setMod(xi.mod.RATT, 345)
end

entity.onMobRoam = function(mob)
    mob:setLocalVar('EES_Timer', os.time())
end

entity.onMobEngage = function(mob, target)
end

entity.onMobFight = function(mob, target)
    if
        mob:getLocalVar('EES_Timer') < os.time() and
        mob:canUseAbilities() and
        mob:getHPP() < 75
    then
        mob:useMobAbility(1932)
    end
end

entity.onMobWeaponSkillPrepare = function (mob)
    return 1761 -- Arrow Deluge
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if
        skill:getID() == 1932 -- Eagle Eye Shot
    then
        mob:setLocalVar('EES_Timer', os.time() + 300) -- 5min Cooldown
    end
end

entity.onMobDeath = function(mob, player, optParams)
    xi.mob.nmTODPersist(mob, 259200) -- 3 Days
end

entity.onMobDespawn = function(mob)
end

return entity
