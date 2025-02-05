-----------------------------------
-- Area: Pashhow Marshlands
--   NM: Bo'Who Warmonger
-----------------------------------
mixins = { require('scripts/mixins/job_special'), require('scripts/mixins/rotz_bodyguarded_nm') }
-----------------------------------
---@type TMobEntity
local entity = {}

-- all body guard functionality in the rotz_bodyguarded_nm mixin

entity.onMobSpawn = function(mob)
    -- retail captures show these mods are not dependent on region control
    mob:setMod(xi.mod.UDMGPHYS, -5000)
    mob:setMod(xi.mod.UDMGRANGE, -5000)
    mob:setMod(xi.mod.UDMGBREATH, -5000)
    mob:setMod(xi.mod.UDMGMAGIC, -5000)
end

entity.onMagicCastingCheck = function(mob, target, spell)
    -- Frequently casts Cure 3 on itself below 50% HP
    if mob:getHPP() < 50 then
        mob:setMobMod(xi.mobMod.HEAL_CHANCE, 80)
    else
        mob:setMobMod(xi.mobMod.HEAL_CHANCE, 40)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 60, 1, xi.regime.type.FIELDS)
    xi.cactuarRegimes.checkRegime(player, mob, 5, 1, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(75600 + math.random(600, 900)) -- 21 hours, plus 10 to 15 min
end

return entity
