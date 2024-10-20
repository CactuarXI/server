-----------------------------------
-- Area: Qu'Bia Arena
--  Mob: Nephiyl Moatfiller
-- BCNM: Demolition Squad
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local entity = {}

entity.onMobFight = function(mob, target)
    if mob:getHPP() < 80 and mob:getLocalVar('control') < 0 then
        mob:setLocalVar('control', 1)
        mob:useMobAbility(710)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
