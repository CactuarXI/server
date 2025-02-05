-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Goublefaupe
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
    mob:setMobMod(xi.mobMod.HP_SCALE, 300)
    mob:setSpellList(5075)
    mob:setMobMod(xi.mobMod.CAN_SHIELD_BLOCK, 1)
end

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        between = 60,
        specials =
        {
            { id = xi.jsa.CHAINSPELL, cooldown = 0, hpp = 95 },
            { id = xi.jsa.INVINCIBLE, cooldown = 0, hpp = 95 },
            { id = xi.jsa.MIGHTY_STRIKES, cooldown = 0, hpp = 95 },
        },
    })
end

entity.onMobDeath = function(mob, player, optParams)
    xi.magian.onMobDeath(mob, player, optParams, set{ 2667, 2671, 2674, 4403 })
end

return entity
