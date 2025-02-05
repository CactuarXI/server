-----------------------------------
-- Area: Dynamis - Xarcabard
--  Mob: Count Haagenti
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
    local mobID = mob:getID()
    local avatar = GetMobByID(mobID + 1)

    xi.mix.jobSpecial.config(mob, {
        between = 75,
        delay = 15,
        specials =
        {
            { id = xi.jsa.ASTRAL_FLOW, cooldown = 500, hpp = 50,
            begCode = function(mob)
                if avatar:getModelId() == 19 then
                    avatar:useMobAbility(857) -- Titan
                elseif avatar:getModelId() == 18 then
                    avatar:useMobAbility(848) -- Ifrit
                elseif avatar:getModelId() == 20 then
                    avatar:useMobAbility(866) -- Leviathan
                elseif avatar:getModelId() == 23 then
                    avatar:useMobAbility(893) -- Ramuh
                elseif avatar:getModelId() == 21 then
                    avatar:useMobAbility(875) -- Garuda
                elseif avatar:getModelId() == 22 then
                    avatar:useMobAbility(884) -- Shiva
                end
            end, },
            { id = xi.jsa.INVINCIBLE, cooldown = 120, hpp = 100 },
        },
    })
    mob:setMod(xi.mod.DOUBLE_ATTACK, 25)
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
    local mobID = mob:getID()
    local avatarID = mobID + 1
    local avatarMob = GetMobByID(avatarID)
    if avatarMob:isSpawned() then
        if target and avatarMob:getCurrentAction() == xi.act.ROAMING then -- doing nothing, make share enmity
            avatarMob:updateEnmity(target)
        end
    elseif -- not spawned, not casting, not using an ability and should summon
            mob:getCurrentAction() ~= xi.act.MAGIC_CASTING and
            mob:actionQueueEmpty() and
            timeInterval == (1 - 1) * 5
    then
        mob:setAutoAttackEnabled(false)
        mob:setMobMod(xi.mobMod.NO_MOVE, 1)
        mob:entityAnimationPacket('casm')
        mob:timer(5000, function(master)
            master:entityAnimationPacket('shsm')
            mob:setAutoAttackEnabled(true)
            mob:setMobMod(xi.mobMod.NO_MOVE, 0)
            local pos = master:getPos()
            avatarMob:setSpawn(pos.x + 1, pos.y - 0.5, pos.z - 1, pos.rot)
            avatarMob:spawn()
            xi.follow.follow(avatarMob, mob)
        end)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    for _, player in pairs(player:getParty()) do
        if player:getObjType() == xi.objType.PC then
        player:changeMusic(2, 121)
        player:changeMusic(3, 121)
        end
    end
    local mobID = mob:getID()
    local avatarID = mobID + 1
    local avatarMob = GetMobByID(avatarID)
    avatarMob:setHP(0)

end

return entity
