-----------------------------------
-- Area: Palborough Mines
--   NM: Ni'Ghu_Nestfender
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
end

entity.onMobFight = function(mob, target)
    if mob:getHPP() < 35 then
        mob:setMobMod(xi.mobMod.HEAL_CHANCE, 80)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
