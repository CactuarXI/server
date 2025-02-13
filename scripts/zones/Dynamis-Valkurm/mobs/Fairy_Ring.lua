-----------------------------------
-- Area: Dynamis - Valkurm
--  Mob: Fairy Ring
-----------------------------------
mixins = 
{
    require('scripts/mixins/dynamis_dreamland'),
    require('scripts/mixins/dynamis_beastmen')
}
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setAutoAttackEnabled(true)
    mob:setMobAbilityEnabled(true)
    -- mob:setMobSkillAttack(5368)
    -- mob:setMobMod(xi.mobMod.BREATH_ATTACK_LINEAR, 1)
    mob:setBaseSpeed(70)
    mob:setMobSkillAttack(2008) -- use mephitic spare as its auto attack
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
end

entity.onMobWeaponSkillPrepare = function(mob, target)
    mob:setLocalVar('skill_tp', mob:getTP())
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if skill:getID() == 3874 then
        mob:addTP(mob:getLocalVar('skill_tp'))
        mob:setLocalVar('skill_tp', 0)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
