-----------------------------------
-- Area: Beaucedine Glacier [S]
-- NM: Scylla
-- ID: 17334336
-----------------------------------
local ID = zones[xi.zone.BEAUCEDINE_GLACIER_S]

mixins = {
    require('scripts/mixins/families/ruszor'),
    require('scripts/mixins/rage'),
         }
-----------------------------------
mixins = { require('scripts/mixins/families/ruszor') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    -- fairly high humanoid killer
    mob:setMod(xi.mod.HUMANOID_KILLER, 25)

    -- immune to bind and gravity
    mob:setMod(xi.mod.BINDRES, 100)
    mob:setMod(xi.mod.GRAVITYRES, 100)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar('[rage]timer', 3600)
    mob:setLocalVar('fuAmount', 0)
    mob:setLocalVar('omfCooldown', 0)

    mob:setAnimationSub(0)
    mob:setAutoAttackEnabled(true)
    mob:setMobAbilityEnabled(true)
    mob:setMobSkillAttack(0)
    mob:setMagicCastingEnabled(false)

    -- slightly faster attack speed
    mob:setMod(xi.mod.DELAY, 300)
end

entity.onMobFight = function(mob, target)
    mob:setMagicCastingEnabled(true)
        if mob:getLocalVar('omfCooldown') < os.time() then
            -- run these checks once per second
            mob:setLocalVar('omfCooldown', os.time())
    
            -- Scylla has a 10 yalms Silence and Paralyze aura under certain conditions
            local animSub = mob:getAnimationSub()
            local typeEffect = 0
            if animSub == 1 then
                -- 'Frosty' state gives a Paralyze aura
                typeEffect = xi.effect.PARALYSIS
            elseif animSub == 2 then
                -- 'Bubbly' state gives a Silence aura
                typeEffect = xi.effect.SILENCE
            end
    
            local mobPos = mob:getPos()
            local spawnPos = mob:getSpawnPos()
    
            -- check everyone on enmity list
            local finks = mob:getEnmityList()
            for _, fink in pairs(finks) do
                local entity = fink.entity
                local entityPos = entity:getPos()
                local distFromMob = math.sqrt((entityPos.x - mobPos.x) ^ 2 + (entityPos.y - mobPos.y) ^ 2 + (entityPos.z - mobPos.z) ^ 2)
                local distFromSpawn = math.sqrt((entityPos.x - spawnPos.x) ^ 2 + (entityPos.y - spawnPos.y) ^ 2 + (entityPos.z - spawnPos.z) ^ 2)
    
                if distFromMob < 10 and typeEffect > 0 then
                    -- (re)apply the aura if applicable
                    entity:delStatusEffectSilent(typeEffect)
                    entity:addStatusEffect(typeEffect, 0, 0, 5)
                elseif distFromSpawn > 25 then
                    -- draw in to spawn point if too far
                    entity:setPos(spawnPos.x, spawnPos.y, spawnPos.z)
                    mob:messageBasic(xi.msg.basic.DRAWN_IN, 0, 0, entity)
                end
            end
        end
    end

entity.onMobWeaponSkillPrepare = function (mob, target)
    local fuAmount = mob:getLocalVar('fuAmount')
    if fuAmount == 0 then
        -- will prioritize Aqua Wave and Frozen Mist more as hp goes down (up to 80%)
        local chances = math.min(100 - mob:getHPP(), 50) + 30
        if math.random(100) <= chances then
            if math.random() < 0.5 then
                return 2438
            else
                return 2439
            end
        end
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    local skillID = skill:getID()
    if skillID == 2438 or skillID == 2439 then
        -- Frozen Mist (2438) will be followed by multiple Ice Guillotine (2440)
        -- Aqua Wave (2439) will be followed by multiple Aqua Cannon (2441)
        mob:setLocalVar('fuAmount', math.random(6, 10))
        mob:setAutoAttackEnabled(true)
        mob:setMagicCastingEnabled(false)
        mob:setMobAbilityEnabled(false)
        mob:setMobSkillAttack(skillID + 2)
        mob:setMod(xi.mod.DELAY, 1800)

    elseif skillID == 2440 or skillID == 2441 then
        local fuAmount = math.max(0, mob:getLocalVar('fuAmount') - 1)
        mob:setLocalVar('fuAmount',  fuAmount)

        -- back to regular auto attacks when we're done
        if fuAmount < 1 then
            mob:setAutoAttackEnabled(true)
            mob:setMagicCastingEnabled(true)
            mob:setMobAbilityEnabled(true)
            mob:setMobSkillAttack(0)
            mob:setMod(xi.mod.DELAY, 300)
        end
    end
end

entity.onMobMagicPrepare = function(mob, target, spellId)
    local rnd = math.random()

    if rnd < 0.90 then
        return 226 -- Bindga
    else
        return 362 -- Poisonga 2
    end
end

entity.onMobDisengage = function(mob)
    mob:setLocalVar('fuAmount', 0)
    mob:setAutoAttackEnabled(true)
    mob:setMagicCastingEnabled(false)
    mob:setMobAbilityEnabled(true)
    mob:setMobSkillAttack(0)
    mob:setMod(xi.mod.DELAY, 300)

    -- Scylla will despawn after the fight if a certain threshold was reached
    --if mob:getHPP() < 90 then
    --    -- display message to players in range
    --    local enmityList = mob:getEnmityList()
    --    for _,v in ipairs(enmityList) do
    --        for _, player in pairs(players) do
    --                    if players == nil then
    --            player:messageSpecial(ID.text.SCYLLA_DESPAWN)
    --        end
    --    end

        -- aaand.. its gone
    --    DespawnMob(ID.mob.SCYLLA)
    --end
end

entity.onMobDeath = function(mob, player, optParams)
    -- xi.mob.nmTODPersist(mob, math.random(14400, 18000)) -- 4 to 5 hours
    xi.hunts.checkHunt(mob, player, 539)
    player:addTitle(xi.title.SCYLLA_SKINNER)
end

return entity
