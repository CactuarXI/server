-----------------------------------
-- Area: Dynamis - San d'Oria
--  Mob: Spellspear Djokvukk
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
    mob:setSpellList(5077)
    mob:setMobMod(xi.mobMod.HP_SCALE, 1500)
end

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        between = 75,
        delay = 15,
        specials =
        {
            { id = xi.jsa.CHAINSPELL, cooldown = 0, hpp = 100 },
        },
    })
    mob:setMod(xi.mod.REFRESH, 25)
end

entity.onMobFight = function(mob, target)
    local timeInterval = mob:getBattleTime() % 6

    for _, member in pairs(target:getParty()) do
        if member:getObjType() == xi.objType.PC then
        member:changeMusic(2, 88)
        member:changeMusic(3, 88)
        end
    end

    -- Spawn pets
    local child = GetMobByID(mob:getID() + 1)
    if child then
        if child:isSpawned() then
            if target and child:getCurrentAction() == xi.act.ROAMING then -- doing nothing, make share enmity
                child:updateEnmity(target)
            end
        elseif -- not spawned, not casting, not using an ability and should summon
                mob:getCurrentAction() ~= xi.act.MAGIC_CASTING and
                mob:actionQueueEmpty() and
                timeInterval == (1 - 1) * 3
        then
            mob:setAutoAttackEnabled(false)
            mob:setMobMod(xi.mobMod.NO_MOVE, 1)
            mob:entityAnimationPacket('casm')
            mob:timer(4000, function(orc)
                orc:entityAnimationPacket('shsm')
                mob:setAutoAttackEnabled(true)
                mob:setMobMod(xi.mobMod.NO_MOVE, 0)
                local pos = orc:getPos()
                child:setSpawn(pos.x + 1, pos.y - 0.5, pos.z - 1, pos.rot)
                child:spawn()
                xi.follow.follow(child, mob)
            end)
        end
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    local child = GetMobByID(mob:getID() + 1)
    local master = GetMobByID(mob:getID())
    if child then
        child:useMobAbility(896, master)
    end
end

entity.onMobDespawn = function(mob)
end

entity.onMobDeath = function(mob, zone, optParams)
    for _, member in pairs(zone:getParty()) do
        if member:getObjType() == xi.objType.PC then
        member:changeMusic(2, 121)
        member:changeMusic(3, 121)
        end
    end
end

return entity
