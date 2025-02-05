-----------------------------------
-- Area: Dynamis - Jeuno
--  Mob: Feralox Honeylips
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
    mob:setMobMod(xi.mobMod.HP_SCALE, 1000)
end

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        between = 75,
        specials =
        {
            { id = xi.jsa.SOUL_VOICE, cooldown = 120 , hpp = 100 },
            { id = xi.jsa.FAMILIAR,
              hpp = 100,
              cooldown = 120,
              begCode = function(mob)
                local child = GetMobByID(mob:getID() + 1)
                    if child:isSpawned() then
                        child:addHP(500)
                        child:wakeUp()
                        child:addMod(xi.mod.REGAIN, 250)
                        child:addMod(xi.mod.REFRESH, 50)
                        child:addMod(xi.mod.ATT, 25)
                        child:addMod(xi.mod.DEF, 25)
                        child:addMod(xi.mod.MATT, 25)
                        child:addMod(xi.mod.ACC, 25)
                        child:addMod(xi.mod.MACC, 25)
                        child:addMod(xi.mod.EVA, 25)
                    end
                end,
                endCode = function(mob)
                end,
            },
        },
    })

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
        mob:timer(4000, function(goblin)
            goblin:entityAnimationPacket('shsm')
            mob:setAutoAttackEnabled(true)
            mob:setMobMod(xi.mobMod.NO_MOVE, 0)
            local pos = goblin:getPos()
            child:setSpawn(pos.x + 1, pos.y - 0.5, pos.z - 1, pos.rot)
            child:spawn()
            xi.follow.follow(child, mob)
        end)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    for _, member in pairs(player:getParty()) do
        if member:getObjType() == xi.objType.PC then
        member:changeMusic(2, 121)
        member:changeMusic(3, 121)
        end
    end
end

return entity
