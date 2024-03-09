-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Arch Angra Mainyu
-- Note: Mega Boss
mixins =
{
    require('scripts/mixins/dynamis_beastmen')
}
-----------------------------------
local entity = {}

-- Phase Arrays   Ahriman, Statue, Ahriman, Dragon, Ahriman
--                  1       2      3       4      5
local triggerHPP = {    1,    1,    1,    1,    1 }
local mobHP =      { 20000, 20000, 20000, 20000, 20000 }
local mobModelID = {  265, 1056,  265,  420,  265 }
local skillID =    {    4,   93,    4,   87,    4 }

entity.onMobInitialize = function(mob)
end

entity.onMobSpawn = function(mob)
    -- Make sure model is reset back to start
    mob:setModelId(265)
    -- Prevent death and hide HP until final phase
    mob:setUnkillable(true)
    -- mob:hideHP(true)

    -- Two hours to forced depop
    mob:setLocalVar('phase', 1)
    mob:setLocalVar('2Hour', 0)
end

entity.onMobDisengage = function(mob)
    -- Make sure model is reset back to start
    mob:setModelId(265)
    mob:setMobMod(xi.mobMod.SKILL_LIST, 4)

    -- Prevent death and hide HP until final phase
    mob:setUnkillable(true)
    -- mob:hideHP(true)

    -- Reset phases
    mob:setLocalVar('phase', 1)
end


entity.onMobFight = function(mob, target)
    -- Init Vars
    local mobHPP = mob:getHPP()
    local phase = mob:getLocalVar('phase')
    local timeInterval = mob:getBattleTime() % 6

    for _, member in pairs(target:getParty()) do
        if member:getObjType() == xi.objType.PC then
        member:changeMusic(2, 88)
        member:changeMusic(3, 88)
        end
    end

    -- Check for phase change
    if phase < 6 and mobHPP <= triggerHPP[phase] then
        if phase == 5 then -- Prepare for death
            mob:hideHP(false)
            mob:setUnkillable(false)
        end

        if  
            mob:getCurrentAction() ~= xi.act.MAGIC_CASTING and
            mob:actionQueueEmpty() and
            timeInterval == (1 - 1) * 3
        then
            mob:setAutoAttackEnabled(false)
            mob:setMagicCastingEnabled(false)
            mob:setMobAbilityEnabled(false)
            mob:setMobMod(xi.mobMod.NO_MOVE, 1)
            mob:entityAnimationPacket('casm')
            mob:timer(5000, function(mobArg)
                mobArg:entityAnimationPacket('shsm')
                -- Change phase
                mobArg:setTP(0)
                mobArg:setModelId(mobModelID[phase])
                mobArg:setHP(mobHP[phase])
                mobArg:setMobMod(xi.mobMod.SKILL_LIST, skillID[phase])
                -- Increment phase
                mobArg:setLocalVar('phase', phase + 1)

                if mobArg:getModelId() == 1056 then
                    mobArg:setAnimationSub(1)
                end

                mobArg:setAutoAttackEnabled(true)
                mobArg:setMagicCastingEnabled(true)
                mobArg:setMobAbilityEnabled(true)
                mobArg:setMobMod(xi.mobMod.NO_MOVE, 0)

                if mob:getLocalVar('2Hour') == 0 and phase == 5 then 
                    mob:timer(2000, function(mobArg2)
                    mobArg2:useMobAbility(xi.jsa.CHAINSPELL)
                    mobArg2:setLocalVar('2Hour', 1)
                    end)
                end
            end)
        end
    end
end

entity.onMobMagicPrepare = function(mob, target, spellId)
end

entity.onMobDeath = function(mob, player, optParams)
    for _, member in pairs(player:getParty()) do
        if member:getObjType() == xi.objType.PC then
        member:changeMusic(2, 121)
        member:changeMusic(3, 121)
        end
    end
end

return entity
