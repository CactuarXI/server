-----------------------------------
-- Area: Wajaom Woodlands
--  ZNM: Gotoh Zha the Redolent
-----------------------------------
mixins =
{
    require('scripts/mixins/job_special'),
    require('scripts/mixins/rage'),
    require('scripts/mixins/weapon_break')
}
-----------------------------------
-- Detailed Notes & Todos
-- (please remove these if you handle any)
-- 1. Find out if stats (INT, MND, MAB..)
--    actually change when it switches mode on retail.
-- 2. Correct mobskill use behavior:
--    Will always do Groundburst after Warm-Up,
--    will never use Groundburst without a preceding Warm-Up.
--    will not attempt any other TP attacks until Groundburst finished
--    (either landed or failed from lack of targets, resetting his TP)
-- 3. Firespit can land over 1500 dmg during rage.
--    If rage is reset/removed its 2hrs are also reset.
-- 4. This NM also shows some insight into retail mob 2hrs/1hrs:
--    they actually have the same cooldown as players and only
--    time, respawn, or rage loss will reset them.
-- 6. Speaking of those two functions..
--    We have no data on the weapon break chance, went with 10% on both for now.
--    Do crit ws hits count differently than regular ws hits on retail?
--    Should onCriticalHit count WS crit hits if regular WS hits do not count?
-----------------------------------
---@type TMobEntity
local entity = {}

-- 2-hour map
local JobTo2Hour = {
    [xi.job.WHM] = xi.jsa.BENEDICTION,
    [xi.job.BLM] = xi.jsa.MANAFONT
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
    mob:setMobMod(xi.mobMod.GIL_MIN, 3000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 5000)
    mob:setMod(xi.mod.UFASTCAST, 50)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar('BreakChance', 5)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 25)
    mob:setMod(xi.mod.FASTCAST, 25)
    mob:setLocalVar('BLM', math.random(66,80))
    mob:setLocalVar('BLMused', 0)
    mob:setLocalVar('WHM', math.random(1,50))
    mob:setLocalVar('WHMused', 0)
    mob:setLocalVar('jobChanged', 0)
    mob:setLocalVar('[rage]timer', 5400) -- 90 minutes
    mob:setSpellList(296) -- Set BLM spell list
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    mob:setMod(xi.mod.SILENCERES, 100)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.jsa.MANAFONT, hpp = math.random(66, 95) },
            { id = xi.jsa.BENEDICTION, hpp = 0 },
        },
    })

    mob:setLocalVar('[rage]timer', 3600) -- 60 minutes
    mob:setSpellList(296) -- Set BLM spell list
end

entity.onMobFight = function(mob, target)
    if mob:getAnimationSub() == 1 and mob:getLocalVar('jobChanged') == 0 then
        mob:setLocalVar('jobChanged', 1)
        mob:setSpellList(297) -- Set WHM spell list.
        -- set new JSA parameters
        xi.mix.jobSpecial.config(mob, {
            specials =
            {
                { id = xi.jsa.MANAFONT, hpp = 0 },
                { id = xi.jsa.BENEDICTION, hpp = math.random(25, 50) },
            },
        })
    end

    if mob:hasStatusEffect(xi.effect.MANAFONT) == 1 then
        mob:setMobMod(xi.mobMod.MAGIC_COOL, 5)
    elseif mob:hasStatusEffect(xi.effect.MANAFONT) == 0 then
        mob:setMobMod(xi.mobMod.MAGIC_COOL, 25)
    end

end

entity.onCriticalHit = function(mob)
    local randVal = math.random(1, 100)

    if mob:getAnimationSub() == 0 and randVal <= 10 then
        mob:setAnimationSub(1)
    end
end

entity.onWeaponskillHit = function(mob, attacker, weaponskill)
    local randVal = math.random(1, 100)

    if mob:getAnimationSub() == 0 and randVal <= 10 then
        mob:setAnimationSub(1)
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if skill:getID() == 1924 then
        mob:useMobAbility(1926)
    end
end


entity.onMobDeath = function(mob, killer)
end

return entity
