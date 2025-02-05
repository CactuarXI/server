-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Quiebitiel
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
    mob:setMobMod(xi.mobMod.HP_SCALE, 200)
    mob:setSpellList(5076)
end

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        between = 60,
        specials =
        {
            { id = xi.jsa.BENEDICTION, cooldown = 0, hpp = 25 },
            { id = xi.jsa.MANAFONT, cooldown = 0, hpp = 95 },
            { id = xi.jsa.SOUL_VOICE, cooldown = 0, hpp = 95 },
        },
    })
end

entity.onMobDeath = function(mob, player, optParams)
    xi.magian.onMobDeath(mob, player, optParams, set{ 2660, 2684, 2715 })
end

return entity
