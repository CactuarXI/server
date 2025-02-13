-----------------------------------
-- Area: Arrapago Reef
--   NM: Nuhn (ZNM T3)
-----------------------------------
mixins =
{
    require('scripts/mixins/job_special'),
    require('scripts/mixins/rage')
}

-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
    mob:setMobMod(xi.mobMod.GIL_MIN, 3000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 5000)
    mob:setMod(xi.mod.ATT, 1500)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = xi.jsa.MIGHTY_STRIKES, hpp = -1},
            
        },
    })
end


entity.onMobSpawn = function(mob)
    mob:setLocalVar('[rage]timer', 5400)                 -- 90 minutes
    mob:setLocalVar('Phase', 1)  
    mob:setLocalVar('Changed',0)
    mob:setMobMod(xi.mobMod.SKILL_LIST, 5305) 
end   

entity.onMobFight = function(mob, target)
    if mob:getLocalVar('Changed') == 1 then
        if mob:getLocalVar('Phase') == 2 then  
            mob:setMod(xi.mod.REGAIN, 1000)
            mob:setMobMod(xi.mobMod.SKILL_LIST, 5306)
        else
            mob:setTP(0)
            mob:delMod(xi.mod.REGAIN, 1000)
            mob:setMobMod(xi.mobMod.SKILL_LIST, 5305)
end
        mob:setLocalVar('Changed', 0)
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
end
  
entity.onMobDeath = function(mob, player, optParams)
end

return entity
