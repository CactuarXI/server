-----------------------------------
-- Area: Yhoator Jungle
--   NM: Bright-handed Kunberry
-----------------------------------
mixins =
{
    require('scripts/mixins/families/tonberry'),
    require('scripts/mixins/job_special'),
    require('scripts/mixins/rotz_bodyguarded_nm')
}
local ID = zones[xi.zone.YHOATOR_JUNGLE]
-----------------------------------
---@type TMobEntity
local entity = {}

-- TODO: Implement better pathing systems for guards to follow master

entity.onMobSpawn = function(mob)
    -- Takes half damage from all attacks
    mob:addMod(xi.mod.DMG, -5000)

    -- May spawn in a party with two other Orcs
    if math.random(1,2) == 1 then
        GetMobByID(ID.mob.BRIGHT_HANDED_KUNBERRY + 1):setSpawn(mob:getXPos() + 2, mob:getYPos(), mob:getZPos())
        GetMobByID(ID.mob.BRIGHT_HANDED_KUNBERRY + 2):setSpawn(mob:getXPos() + 4, mob:getYPos(), mob:getZPos())
        SpawnMob(ID.mob.BRIGHT_HANDED_KUNBERRY + 1)
        SpawnMob(ID.mob.BRIGHT_HANDED_KUNBERRY + 2)
    end
end

entity.onMobEngage = function(mob, target)
    local mobId = mob:getID()
    for i = 1, 2 do
        local guardID = GetMobByID(mobId + i)
        guardID:updateEnmity(target)
    end
end

entity.onMobRoam = function(mob)
    local mobId = mob:getID()

    for i = 1, 2 do
        local guard = GetMobByID(mobId + i)
        if guard:isSpawned() and guard:getID() == mobId + 1 then
            guard:pathTo(mob:getXPos() + 1, mob:getYPos() + 3, mob:getZPos() + 0.15)
        elseif guard:isSpawned() and guard:getID() == mobId + 2 then
            guard:pathTo(mob:getXPos() + 3, mob:getYPos() + 5, mob:getZPos() + 0.15)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 133, 1, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 5, 1, xi.regime.type.FIELDS)
end

-- all body guard functionality in the rotz_bodyguarded_nm mixin

entity.onMobSpawn = function(mob)
    -- retail captures show these mods are not dependent on region control
    mob:setMod(xi.mod.UDMGPHYS, -5000)
    mob:setMod(xi.mod.UDMGRANGE, -5000)
    mob:setMod(xi.mod.UDMGBREATH, -5000)
    mob:setMod(xi.mod.UDMGMAGIC, -5000)
end

entity.onMobDespawn = function(mob)
    -- xi.mob.nmTODPersist(mob, math.random(75600, 77400)) -- 21 to 21.5 hours
    DespawnMob(ID.mob.BRIGHT_HANDED_KUNBERRY + 1)
    DespawnMob(ID.mob.BRIGHT_HANDED_KUNBERRY + 2)
end

return entity
