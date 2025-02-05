-----------------------------------
-- Area: Dynamis-Tavnazia
--  Mob: Diabolos Diamond
-- Note: Mega Boss
-----------------------------------
require('scripts/globals/dynamis')
mixins =
{
    require('scripts/mixins/dynamis_beastmen'),
    require('scripts/mixins/job_special')
}
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = 1908, hpp = 80, 
            begCode = function(mob)
                mob:setLocalVar('nightmare_01_Used', 1)  
                end,
            endCode = function(mob)
            end,},
            { id = 1908, hpp = math.random(40, 50), 
            begCode = function(mob)
                mob:setLocalVar('nightmare_02_Used', 1)  
                end,
            endCode = function(mob)
            end,},
        },
    })
    mob:setLocalVar('[isDynamis_Megaboss]', 1)
end

entity.onMobFight = function(mob, target)
    for _, member in pairs(target:getParty()) do
        if member:getObjType() == xi.objType.PC then
        member:changeMusic(2, 239)
        member:changeMusic(3, 239)
        end
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if mob:getLocalVar('nightmare_01_Used') == 1 then -- Daydream unlocked after first Nightmare.
        mob:setMobMod(xi.mobMod.SKILL_LIST, 5393)
    end

    if mob:getLocalVar('nightmare_02_Used') == 1 then -- Use Daydream 2 times in a row after the 2nd Nightmare.
        if skill:getID() == 1919 then
            mob:timer(4000, function(mobArg)
                mobArg:useMobAbility(1919)
            end)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    xi.dynamis.megaBossOnDeath(mob, player, optParams)
    player:addTitle(xi.title.NIGHTMARE_AWAKENER)
    mob:resetLocalVars()
    for _, member in pairs(player:getParty()) do
        if member:getObjType() == xi.objType.PC then
        member:changeMusic(2, 121)
        member:changeMusic(3, 121)
        end
    end
end

return entity
