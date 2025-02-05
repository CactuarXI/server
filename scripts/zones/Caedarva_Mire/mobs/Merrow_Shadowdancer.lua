-----------------------------------
-- Area: Caedarva Mire (79)
--  Mob: Merrow Shadowdancer
-- Note: Minion of Experimental Lamia
-----------------------------------
mixins =
    {
        require('scripts/mixins/job_special'),
        require('scripts/mixins/weapon_break')
    }
-----------------------------------
---@type TMobEntity
local entity = {}
local ID = zones[xi.zone.CAEDARVA_MIRE]

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ALLI_HATE, 30)
end

entity.onMobDeath = function(mob, player, optParams)
    local mother = GetMobByID(ID.mob.EXPERIMENTAL_LAMIA)
    local dance = mother:getLocalVar('dances')  
    mother:setLocalVar('dances', dance + 1)
end

entity.onMobRoam = function(mob)
    local mother = GetMobByID(ID.mob.EXPERIMENTAL_LAMIA)
    if mother:isSpawned() and mother:getCurrentAction() == xi.act.ATTACK then
        mob:updateEnmity(mother:getTarget())
    end
end


return entity
