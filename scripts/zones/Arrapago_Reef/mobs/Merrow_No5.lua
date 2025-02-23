-----------------------------------
-- Area: Arrapago Reef
--  Mob: Merrow No.5
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
    mob:addImmunity(xi.immunity.SILENCE)
    mob:setSpellList(5110)
end

entity.onMobRoam = function(mob)
end

entity.onMobEngage = function(mob, target)
end

entity.onMobFight = function(mob, target)
    if mob:getHPP() < 20 then
        mob:setSpellList(5111)
    end
end

entity.onMobWeaponSkillPrepare = function (mob)
end

entity.onMobWeaponSkill = function(target, mob, skill)
end

entity.onMobDeath = function(mob, player, optParams)
    -- xi.mob.nmTODPersist(mob, 259200) -- 3 Days
end

entity.onMobDespawn = function(mob)
end

return entity
