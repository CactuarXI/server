-----------------------------------
-- Area: Ceizak Battlegrounds
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
end

entity.onMobEngaged = function(mob, target)
end

entity.onMobFight = function(mob, target)
end
entity.onMobWeaponSkillPrepare = function(mob, target)
    if bit.band(mob:getBehavior(), xi.behavior.NO_TURN) == 0 then -- re-enable noturn
        mob:setBehavior(bit.bor(mob:getBehavior(), xi.behavior.NO_TURN))
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if skill:getID() == 2755 then -- Preying Posture
        mob:setMobSkillAttack(5401)
        mob:timer(30000, function(mobArg)
            mob:setMobSkillAttack(0)
        end)
    end

    if bit.band(mob:getBehavior(), xi.behavior.NO_TURN) > 0 then -- default behaviour
        mob:setBehavior(bit.band(mob:getBehavior(), bit.bnot(xi.behavior.NO_TURN)))
    end
end

entity.onMobDisengage = function(mob, target)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
end

return entity
