-----------------------------------
-- Area: Arrapago Reef
--   NM: Lamia's Avatar
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setSpawnAnimation(1)
end

entity.onMobSpawn = function(mob)
    local master = GetMobByID(mob:getID() - 1)
    local masterTarget = master:getTarget()
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.STUN)
    mob:setMobMod(xi.mobMod.SKILL_LIST, 40)
    mob:setModelId(20)
    mob:setSpawnAnimation(1)

    mob:updateEnmity(masterTarget)
end

entity.onMobEngage = function(mob, target)
    local master = GetMobByID(mob:getID() - 1)
    if master:hasStatusEffect(xi.effect.ASTRAL_FLOW) then
        mob:useMobAbility(866, target)
    end

    mob:queue(3000, function(avatarArg)
        avatarArg:setSpawnAnimation(0)
    end)
end

entity.onMobFight = function(mob, target)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    mob:setSpawnAnimation(1)
    local master = GetMobByID(mob:getID() - 1)
    master:setLocalVar('petRespawnTimer', os.time() + math.random(30, 35))
end

return entity
