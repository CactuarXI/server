-----------------------------------
-- Area: Ru'Aun Gardens
-- NM: Genbu
-- ID: 17309980
-----------------------------------
local ID = zones[xi.zone.RUAUN_GARDENS]
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob, target)
    GetNPCByID(ID.npc.PORTAL_OFFSET + 5):setAnimation(xi.anim.CLOSE_DOOR)
    mob:setMobMod(xi.mobMod.WEAPON_BONUS, 21)
    mob:setMod(xi.mod.SILENCERES, 90)
    mob:setMod(xi.mod.EVA, 316)
    mob:addMod(xi.mod.DEF, 210)
    mob:addMod(xi.mod.VIT, 78)
    mob:addMod(xi.mod.DOUBLE_ATTACK, 10)
    mob:setMod(xi.mod.COUNTER, 25)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 35)
    mob:setLocalVar('defaultATT', mob:getMod(xi.mod.ATT))
    mob:setMagicCastingEnabled(false)
end

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobEngage = function(mob, target)
    mob:messageText(mob, ID.text.SKY_GOD_OFFSET + 5)
    mob:timer(5000, function(mobArg)
        mobArg:setMagicCastingEnabled(true)
    end)
end

entity.onMobFight = function(mob, target)
    -- Appears to gain +10 attack per 1% HP lost
    local hp = mob:getHPP()
    local power = (100 - hp) * 10

    mob:setMod(xi.mod.ATT, mob:getLocalVar('defaultATT') + power)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENWATER)
end

entity.onMobDeath = function(mob, player, optParams)
    player:showText(mob, ID.text.SKY_GOD_OFFSET + 6)
    GetNPCByID(ID.npc.PORTAL_OFFSET + 5):setAnimation(xi.anim.OPEN_DOOR)
end

entity.onMobDespawn = function(mob)
    GetNPCByID(ID.npc.PORTAL_OFFSET + 5):setAnimation(xi.anim.OPEN_DOOR)
end

return entity