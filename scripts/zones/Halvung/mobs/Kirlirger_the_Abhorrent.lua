-----------------------------------
-- Area: Halvung
--  Mob: Kirlirger the Abhorrent
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
mixins = {require('scripts/mixins/weapon_break')}

-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMod(xi.mod.CRITHITRATE, 0)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobFight = function(mob, target)
    if mob:getAnimationSub() == 1 then
        mob:setMod(xi.mod.CRITHITRATE, 100)
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.STUN, { chance = 100, duration = math.random(2, 5) })
end


return entity
