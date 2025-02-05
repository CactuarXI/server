-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Dagourmarche
-----------------------------------
mixins =
{
    require('scripts/mixins/dynamis_beastmen'),
    require('scripts/mixins/job_special')
}
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.HP_SCALE, 325)
end

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        between = 60,
        specials =
        {
            { id = xi.jsa.ASTRAL_FLOW, cooldown = 0, hpp = 25,
            begCode = function(mob)
                local avatar = GetMobByID(mob:getID() + 2)
                avatar:useMobAbility(838)
            end, },
        },
    })
end

entity.onMobEngage = function(mob, target)
end

entity.onMobFight = function(mob, target)
    local timeInterval = mob:getBattleTime() % 6

    -- Spawn pets
    for i = 1, 2 do
        local child = GetMobByID(mob:getID() + i)
        if child:isSpawned() then
            if target and child:getCurrentAction() == xi.act.ROAMING then -- doing nothing, make share enmity
                child:updateEnmity(target)
            end
        elseif -- not spawned, not casting, not using an ability and should summon
                mob:getCurrentAction() ~= xi.act.MAGIC_CASTING and
                mob:actionQueueEmpty() and
                timeInterval == (i - 1) * 3
        then
            mob:setAutoAttackEnabled(false)
            mob:setMobMod(xi.mobMod.NO_MOVE, 1)
            mob:entityAnimationPacket('casm')
            mob:timer(4000, function(dagourmarche)
                dagourmarche:entityAnimationPacket('shsm')
                mob:setAutoAttackEnabled(true)
                mob:setMobMod(xi.mobMod.NO_MOVE, 0)
                local pos = dagourmarche:getPos()
                child:setSpawn(pos.x + i, pos.y - 0.5, pos.z - i, pos.rot)
                child:spawn()
                xi.follow.follow(child, mob)
            end)
        end
    end
end

entity.onMobWeaponSkillPrepare = function(mob, target)
    local charm = 710
    if math.random() < 0.2 then
        return charm
    else
        return 0
    end
end

entity.onMobDeath = function(mob, player, optParams)
    xi.magian.onMobDeath(mob, player, optParams, set{ 2672, 2678, 2686 })
    DespawnMob(17326091)
    DespawnMob(17326092)
end

return entity
