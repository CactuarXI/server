-----------------------------------
-- Area: Arrapago Reef
--  Mob: Lamie No.9
-----------------------------------
mixins =
{
    require('scripts/mixins/weapon_break'),
    require('scripts/mixins/job_special')
}
-----------------------------------
local entity = {}

local function handleAvatarSummoning(mob)
    local avatar = GetMobByID(mob:getID() + 1)
    local petRespawnTimer = mob:getLocalVar('petRespawnTimer')
    local masterTarget = mob:getTarget()
    if
        avatar and
        os.time() > petRespawnTimer and
        not avatar:isSpawned() and
        mob:canUseAbilities() and
        mob:getLocalVar('currentlySummoning') == 0
    then
        -- Begin summon sequence
        if
            mob:getCurrentAction() ~= xi.act.MAGIC_CASTING and
            mob:actionQueueEmpty()
        then
            mob:setAutoAttackEnabled(false)
            mob:setMagicCastingEnabled(false)
            mob:setMobAbilityEnabled(false)
            mob:setMobMod(xi.mobMod.NO_MOVE, 1)
            mob:entityAnimationPacket('casm')
            mob:setLocalVar('currentlySummoning', 1)

            mob:timer(2000, function(master)
                master:entityAnimationPacket('shsm')
                master:setAutoAttackEnabled(true)
                master:setMagicCastingEnabled(true)
                master:setMobAbilityEnabled(true)
                master:setMobMod(xi.mobMod.NO_MOVE, 0)

                -- Spawn the avatar near the mob
                local pos = master:getPos()
                avatar:setSpawn(pos.x + math.random(-1, 1), pos.y, pos.z + math.random(-1, 1), pos.rot)
                avatar:spawn()
                avatar:stun(2000)
                master:stun(2000)
                master:setLocalVar('petRespawnTimer', os.time() + math.random(30, 35))
                master:setLocalVar('currentlySummoning', 0)
            end)
        end
    end
end

entity.onMobInitialize = function(mob)
end

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.STUN)
    mob:setLocalVar('petRespawnTimer', os.time() + 5)

    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.jsa.ASTRAL_FLOW,
              hpp = 75,
              cooldown = 180,
              begCode = function(mob)
                local avatar = GetMobByID(mob:getID() + 1)
                mob:setLocalVar('petRespawnTimer', os.time())
                -- mob:addStatusEffect(xi.effect.ASTRAL_FLOW, 1, 0, 20)
                    if avatar:isAlive() then
                        avatar:useMobAbility(866) -- Leviathan
                    elseif not avatar:isSpawned() then
                        handleAvatarSummoning(mob)
                        -- If avatar is not alive, then summon it.
                        -- In Avatar's script: Use avatar astral flow ability when it spawns.
                    end
                end,
                endCode = function(mob)
                end,
            },
        },
    })
end

entity.onMobRoam = function(mob)
    handleAvatarSummoning(mob)
end

entity.onMobEngage = function(mob, target)
    local avatar = GetMobByID(mob:getID() + 1)
    if avatar then
        avatar:updateEnmity(target)
    end
    mob:setLocalVar('hateTimer', os.time() + math.random(27, 33))
end

entity.onMobFight = function(mob, target)
    -- every 30~ seconds have the avatar refocus on the her battle target
    local avatar = GetMobByID(mob:getID() + 1)
    if mob:getLocalVar('hateTimer') < os.time() then
        if
            avatar and
            avatar:isAlive()
        then
            mob:setLocalVar('hateTimer', os.time() + math.random(27, 33))
            avatar:updateEnmity(target)
        end
    end

    handleAvatarSummoning(mob)
end

entity.onMobDeath = function(mob, player, optParams)
    local avatar = GetMobByID(mob:getID() + 1)
    if avatar then
        avatar:setHP(0)
    end
    -- xi.mob.nmTODPersist(mob, 259200) -- 3 Days
end

entity.onMobDespawn = function(mob)
    local avatar = GetMobByID(mob:getID() + 1)
    if avatar then
        avatar:setHP(0)
    end
end

return entity
