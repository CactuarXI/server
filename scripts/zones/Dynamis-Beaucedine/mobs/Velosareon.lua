-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Velosareon
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
    --mob:setMobMod(xi.mobMod.SPECIAL_SKILL, 272)
    --mob:setMobMod(xi.mobMod.SPECIAL_COOL, 20)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    mob:setSpellList(5)
end

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        between = 60,
        specials =
        {
            { id = xi.jsa.BLOOD_WEAPON, cooldown = 0, hpp = 95 },
            { id = xi.jsa.MEIKYO_SHISUI, cooldown = 0, hpp = 95 },
            { id = xi.jsa.EES_SHADE, cooldown = 0, hpp = 75 },
        },
    })
end

entity.onMobDeath = function(mob, player, optParams)
    xi.magian.onMobDeath(mob, player, optParams, set{ 2676, 2682, 2690 })
end

return entity
