-----------------------------------
-- Area: Xarcabard [S]
--  Mob: Greater Amphiptere
-----------------------------------
mixins = { require('scripts/mixins/families/amphiptere') }
-----------------------------------
---@type TMobEntity
local entity = {}

local path1 = {
    { x = 205, y = -30, z = -211 },
    { x = 154, y = -30, z = -187 },
    { x = 105, y = -30, z = -158 },
    { x = 50, y = -30, z = -111 },
    { x = 12, y = -30, z = -110 },
    { x = -22, y = -30, z = -130 },
    { x = -40, y = -30, z = -80 },
    { x = 60, y = -30, z = -62 },
    { x = 134, y = -30, z = -72 },
    { x = 181, y = -30, z = -157 },
}

local path2 = {
    { x = 246, y = -30, z = -216 },
    { x = 342, y = -30, z = -275 },
    { x = 424, y = -30, z = -186 },
    { x = 389, y = -30, z = -87 },
    { x = 461, y = -30, z = 67 },
    { x = 360, y = -30, z = -63 },
    { x = 303, y = -30, z = -88 },
    { x = 327, y = -30, z = 206 },
    { x = 303, y = -30, z = -88 },
    { x = 360, y = -30, z = -63 },
    { x = 461, y = -30, z = 67 },
    { x = 389, y = -30, z = -87 },
    { x = 424, y = -30, z = -186 },
    { x = 342, y = -30, z = -275 },
    { x = 246, y = -30, z = -216 },
}

local path3 = {
    { x = -299, y = -35, z = -18 },
    { x = -292, y = -35, z = 117 },
    { x = -181, y = -35, z = 108 },
    { x = -196, y = -35, z = -63 },
    { x = -257, y = -35, z = -118 },
    { x = -278, y = -35, z = -50 },
    { x = -291, y = -35, z = 10 },
    { x = -315, y = -35, z = -63 },
    { x = -330, y = -35, z = -10 },
    { x = -382, y = -35, z = 22 },
}

function onPath(mob)
    local mobID = mob:getID()
    if mobID == 17338587 then
        mob:pathThrough(path1, bit.bor(xi.path.flag.PATROL, xi.path.flag.RUN))
    elseif mobID == 17338586 then
        mob:pathThrough(path2, bit.bor(xi.path.flag.COORDS, xi.path.flag.RUN))
    elseif mobID == 17338588 then
        mob:pathThrough(path3, bit.bor(xi.path.flag.PATROL, xi.path.flag.RUN))
    end
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.SKILL_LIST, 6)  
    mob:setMobAbilityEnabled(true)
    mob:setAnimationSub(1)
    onPath(mob)
end

entity.onMobRoam = function(mob)
end

entity.onMobFight = function(mob, target)
end

entity.onMobWeaponSkill = function(target, mob, skill)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
