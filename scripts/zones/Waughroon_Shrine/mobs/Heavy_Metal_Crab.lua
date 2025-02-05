-----------------------------------
-- Area: Waughroon Shrine
-- Mob: Heavy Metal Crab
-- BCNM: Crustacean Conundrum
-----------------------------------
---@type TMobEntity
local entity = {}

local dots =
    {
        xi.effect.DIA,
        xi.effect.POISON,
        xi.effect.BIO,
        xi.effect.REQUIEM,
        xi.effect.CHOKE,
        xi.effect.SHOCK,
        xi.effect.FROST,
    }

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobSpawn = function(mob)
    if VanadielDayOfTheWeek() == xi.day.WATERSDAY then
        mob:setMod(xi.mod.REGEN, 6)
    end
    mob:setMod(xi.mod.DMGMAGIC_CAP, 1)
    mob:setMod(xi.mod.DMGPHYS_CAP, 1)
    mob:setMod(xi.mod.DMGRANGE_CAP, 1)
    mob:setMod(xi.mod.DMGBREATH_CAP, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.HP_DRAIN, { power = 30 })
end

entity.onMobFight = function(mob, target)
    local count = 0

    for _, v in pairs(dots) do
        if mob:hasStatusEffect(v) then
            count = count + 1
        end
    end

    mob:setMod(xi.mod.REGEN_DOWN, count)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
