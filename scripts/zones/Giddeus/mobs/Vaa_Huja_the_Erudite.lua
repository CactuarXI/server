-----------------------------------
-- Area: Giddeus
--   NM: Vaa Huja the Erudite
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
end

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.jsa.MANAFONT, chance = math.random(30,80) },
        },
    })
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
