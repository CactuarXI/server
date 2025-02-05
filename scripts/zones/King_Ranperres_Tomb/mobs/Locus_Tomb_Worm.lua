-----------------------------------
-- Area: King Ranperres Tomb
--  Mob: Stone Eater
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.HP_SCALE, 300)
    mob:setMobMod(xi.mobMod.EXP_BONUS, 200)
end

entity.onMobSpawn = function(mob)
    mob:addMod(xi.mod.MAIN_DMG_RATING, 25)
end

entity.onMobFight = function(mob, target)
end

entity.onMobWeaponSkillPrepare = function (mob, target)
end

entity.onMobWeaponSkill = function(target, mob, skill)
end

entity.onMobDisengage = function(mob)
end

entity.onMobDeath = function(mob, player, optParams)
    -- xi.regime.checkRegime(player, mob, 632, 1, xi.regime.type.GROUNDS)
    xi.cactuarRegimes.checkRegime(player, mob, 2, 1, xi.regime.type.FIELDS)
end

return entity
