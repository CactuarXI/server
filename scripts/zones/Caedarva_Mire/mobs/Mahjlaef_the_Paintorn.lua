-----------------------------------
-- Area: Caedarva Mire
--  Mob: Mahjlaef the Paintorn (ZNM T3)
-----------------------------------
--Spell list 550 base, 551 2shield, 552 1shield
--TODO: Needs a listener if mind purge is stunned. It will still use it after the stun.
-----------------------------------
mixins = {require('scripts/mixins/rage')}
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
    mob:setMobMod(xi.mobMod.GIL_MIN, 3000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 5000)
end 

entity.onMobSpawn = function(mob)
    mob:setLocalVar('Shielded', 0)
    mob:setLocalVar('[rage]timer', 5400) -- 90 minutes
end

entity.onMobWeaponSkillPrepare = function(mob, target)
    if mob:getHPP() <= 30 and math.random() <= .7 then
        return 1969
    else
        return 0
    end

end

entity.onMobWeaponSkill = function(mob, target, skill)
local Shielded = mob:getLocalVar('Shielded')
    if skill:getID() == 1965 then -- Immortal Shield
        mob:setLocalVar('Shielded', 1)
end
end

entity.onMobFight = function(mob, target)
    local Shielded = mob:getLocalVar('Shielded')
    local hpp = mob:getHPP()
    local useImmortalShield = false

    if (mob:getMod(xi.mod.MAGIC_STONESKIN) == 0 and Shielded == 1 and hpp <= 30) then
        mob:useMobAbility(1969) -- AoE Dispely thing
        mob:setLocalVar('Shielded', 0)
    elseif (mob:getMod(xi.mod.MAGIC_STONESKIN) == 0 and Shielded == 1) then
        mob:useMobAbility(1966) -- Dispely thing
        mob:setLocalVar('Shielded', 0)
    end

    if hpp < 90 and mob:getLocalVar('Shield89') == 0 then
        mob:setLocalVar('Shield89', 1)
        useImmortalShield = true
    elseif hpp < 70 and mob:getLocalVar('Shield69') == 0 then
        mob:setLocalVar('Shield69', 1)
        useImmortalShield = true
    elseif hpp < 50 and mob:getLocalVar('Shield49') == 0 then
        mob:setLocalVar('Shield49', 1)
        useImmortalShield = true
    elseif hpp < 30 and mob:getLocalVar('Shield29') == 0 then
        mob:setLocalVar('Shield29', 1)
        useImmortalShield = true
    elseif hpp < 10 and mob:getLocalVar('Shield9') == 0 then
        mob:setLocalVar('Shield9', 1)
        useImmortalShield = true
    end

    if useImmortalShield then
        mob:useMobAbility(1965)
    end

    -- Immortal Shield should also reduce physical damage
    if (mob:getMod(xi.mod.MAGIC_STONESKIN) >= 1001) then
        mob:setAnimationSub(2)
        mob:setSpellList(705)
    elseif (mob:getMod(xi.mod.MAGIC_STONESKIN) >= 1) then
        mob:setAnimationSub(1)
        mob:setSpellList(706)
    else
        mob:setAnimationSub(0)
        mob:setSpellList(704)
    end
end

function onMobDeath(mob, player, isKiller)
    mob:setAnimationSub(0) -- If he dies with Immortal Shield up, the shield effect will go down on death.
end

return entity
