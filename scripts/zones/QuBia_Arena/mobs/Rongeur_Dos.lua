-----------------------------------
-- Area: Qu'Bia Arena
--  Mob: Rongeur D'os
-- BCNM: Let Sleeping Dogs Die
-----------------------------------
local ID = zones[xi.zone.QUBIA_ARENA]
-----------------------------------
---@type TMobEntity
local entity = {}

local checkHounds = function(mob)
    for i = 0, 3 do
        if GetMobByID(ID.hounds[mob:getBattlefield():getArea()]+i):isAlive() then
            return true
        end
    end
    return false
end

entity.onMobSpawn = function(houndMob)
    houndMob:setBehavior(bit.bor(houndMob:getBehavior(), xi.behavior.NO_DESPAWN))

    houndMob:addListener('DEATH', 'RONGEUR_DEATH', function(mob, killer)
        if checkHounds(mob) then
            mob:timer(35000, function(mobArg)
                mobArg:setHP(mobArg:getMaxHP())
                mobArg:resetAI()
                mobArg:updateEnmity(killer)
            end)
        else
            for i = 0, 3 do
                GetMobByID(ID.hounds[mob:getBattlefield():getArea()]+i):setBehavior(0)
            end
        end
    end)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
