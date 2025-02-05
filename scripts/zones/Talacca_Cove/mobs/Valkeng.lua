-----------------------------------
-- Area: Talacca Cove
--  Mob: Velkeng
-----------------------------------
local ID = zones[xi.zone.TALACCA_COVE]
-----------------------------------
local entity = {}

local harlequinFrameModelId   = 1977
local valoredgeFrameModelId   = 1983
local sharpshotFrameModelId   = 1990
local stormwalkerFrameModelId = 1994

local function messageAllPlayersInBattlefield(mob, messageId, percent)
    local battlefield = mob:getBattlefield()
    local players = battlefield:getPlayers()
    for _, member in pairs(players) do
        member:messageSpecial(messageId, percent)
    end
end

local function changeToValoredge(mob, percent)
    if(mob:getLocalVar("CurrentFrame") == valoredgeFrameModelId) then
        local consecutiveManeuvers = mob:getLocalVar("ConsecutiveManeuvers")
        messageAllPlayersInBattlefield(mob, ID.text.VALKENG_MELEE_KEEP_FRAME, percent)
        if (consecutiveManeuvers < 5) then
            mob:setLocalVar("ConsecutiveManeuvers", consecutiveManeuvers + 1)
            mob:addMod(xi.mod.DELAY, 200) -- Speed up attack rate
        end
        return
    end

    mob:setLocalVar("ConsecutiveManeuvers", 0)
    messageAllPlayersInBattlefield(mob, ID.text.VALKENG_MELEE_CHANGE_FRAME, percent)
    mob:setModelId(valoredgeFrameModelId)
    mob:setLocalVar("CurrentFrame", valoredgeFrameModelId)
    mob:sendUpdateToZoneCharsInRange(1000)
    mob:setMod(xi.mod.UDMGPHYS, -8500)
    mob:setMod(xi.mod.UDMGRANGE, 0)
    mob:setMod(xi.mod.UDMGMAGIC, 0)
    mob:setMagicCastingEnabled(false)
    -- mob:setBehavior(0) -- Standback disabled
    mob:setBehavior(bit.band(mob:getBehavior(), bit.bnot(xi.behavior.STANDBACK)))
    mob:setMobMod(xi.mobMod.SPECIAL_SKILL, 0) -- ranged attacks disabled
    mob:delMobMod(xi.mobMod.HP_STANDBACK, 50)
    mob:setMod(xi.mod.DELAY, 2400) -- high attack speed
    mob:setMod(xi.mod.REGEN, 10) --Weak Auto Regen
end

local function changeToStormwaker(mob, percent)
    if(mob:getLocalVar("CurrentFrame") == stormwalkerFrameModelId) then
        local consecutiveManeuvers = mob:getLocalVar("ConsecutiveManeuvers")
        messageAllPlayersInBattlefield(mob, ID.text.VALKENG_MAGIC_KEEP_FRAME, percent)
        if (consecutiveManeuvers < 5) then
            mob:setLocalVar("ConsecutiveManeuvers", consecutiveManeuvers + 1)
                mob:delMobMod(xi.mobMod.MAGIC_COOL, 1) -- Speed up magic casting
                mob:addMod(xi.mod.UFASTCAST, 15) -- Speed up fast cast
        end
        return
    end

    mob:setLocalVar("ConsecutiveManeuvers", 0)
    messageAllPlayersInBattlefield(mob, ID.text.VALKENG_MAGIC_CHANGE_FRAME, percent)
    mob:setModelId(stormwalkerFrameModelId)
    mob:setLocalVar("CurrentFrame", stormwalkerFrameModelId)
    mob:sendUpdateToZoneCharsInRange(1000)
    mob:setMod(xi.mod.UDMGPHYS, 0)
    mob:setMod(xi.mod.UDMGRANGE, 0)
    mob:setMod(xi.mod.UDMGMAGIC, -8500)
    mob:setMagicCastingEnabled(true)
    mob:setSpellList(2) -- generic blm
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 20)
    mob:setMod(xi.mod.UFASTCAST, 25)
    -- mob:setBehavior(0) -- Standback disabled
    mob:setBehavior(bit.band(mob:getBehavior(), bit.bnot(xi.behavior.STANDBACK)))
    mob:setMobMod(xi.mobMod.HP_STANDBACK, 20)
    mob:setMobMod(xi.mobMod.SPECIAL_SKILL, 0) -- ranged attacks disabled
    mob:setMod(xi.mod.DELAY, 0) -- remove high attack speed
    mob:setMod(xi.mod.REGEN, 0) -- remove weak auto regen
end

local function changeToSharpshot(mob, percent)
    if(mob:getLocalVar("CurrentFrame") == sharpshotFrameModelId) then
    local consecutiveManeuvers = mob:getLocalVar("ConsecutiveManeuvers")
        messageAllPlayersInBattlefield(mob, ID.text.VALKENG_RANGED_KEEP_FRAME, percent)
         if (consecutiveManeuvers < 5) then
            mob:setLocalVar("ConsecutiveManeuvers", consecutiveManeuvers + 1)
            mob:delMobMod(xi.mobMod.SPECIAL_COOL, 2)  -- Speed Up Ranged attacks
        end
        return
    end

    mob:setLocalVar("ConsecutiveManeuvers", 0)
    messageAllPlayersInBattlefield(mob, ID.text.VALKENG_RANGED_CHANGE_FRAME, percent)
    mob:setModelId(sharpshotFrameModelId)
    mob:setLocalVar("CurrentFrame", sharpshotFrameModelId)
    mob:sendUpdateToZoneCharsInRange(1000)
    mob:setMod(xi.mod.UDMGPHYS, 2500)
    mob:setMod(xi.mod.UDMGRANGE, -8500)
    mob:setMod(xi.mod.UDMGMAGIC, 0)
    mob:setMagicCastingEnabled(false)
    mob:setBehavior(bit.bor(mob:getBehavior(), xi.behavior.STANDBACK))
    -- mob:setBehavior(2) --Standback enabled
    mob:setMobMod(xi.mobMod.SPECIAL_SKILL, 272) -- ranged attacks enabled
    mob:setMobMod(xi.mobMod.SPECIAL_COOL, 14) -- ranged attack speed
    mob:setMod(xi.mod.DELAY, 0) -- remove high attack speed
    mob:setMod(xi.mod.REGEN, 0) -- remove weak auto regen
end


entity.onMobInitialize = function(mob)
    mob:setLocalVar("PhysicalDamage", 0)
    mob:setLocalVar("MagicalDamage", 0)
    mob:setLocalVar("RangedDamage", 0)
    mob:setLocalVar("CurrentFrame", harlequinFrameModelId)
    mob:addListener("TAKE_DAMAGE", "VALKENG_TAKE_DAMAGE", function(mob, amount, attacker, attackType, damageType)
        if attackType == xi.attackType.PHYSICAL then
            mob:setLocalVar("PhysicalDamage", mob:getLocalVar("PhysicalDamage") + amount)
        elseif attackType == xi.attackType.MAGICAL then
            mob:setLocalVar("MagicalDamage", mob:getLocalVar("MagicalDamage") + amount)
        elseif attackType == xi.attackType.RANGED then
            mob:setLocalVar("RangedDamage", mob:getLocalVar("RangedDamage") + amount)
        else
            -- ignore Untyped Damage
        end

        local sum = mob:getLocalVar("PhysicalDamage") + mob:getLocalVar("MagicalDamage") + mob:getLocalVar("RangedDamage")
        local physicalPercent =  mob:getLocalVar("PhysicalDamage") / sum * 100
        local magicalPercent =  mob:getLocalVar("MagicalDamage") / sum * 100
        local rangedPercent =  mob:getLocalVar("RangedDamage") / sum * 100

        --useful debug output
        --printf(string.format("Physical %d %d Magical %d %d  Ranged %d %d",
        --mob:getLocalVar("PhysicalDamage"), physicalPercent, mob:getLocalVar("MagicalDamage"), magicalPercent, mob:getLocalVar("RangedDamage"), rangedPercent))

    end)
end

entity.onMobSpawn = function(mob)
    mob:setModelId(harlequinFrameModelId)
    mob:setLocalVar("CurrentFrame", harlequinFrameModelId)
    mob:setMod(xi.mod.UDMGPHYS, 0)
    mob:setMod(xi.mod.UDMGRANGE, 0)
    mob:setMod(xi.mod.UDMGMAGIC, 0)
    mob:setMagicCastingEnabled(true)
    mob:setSpellList(444)
    mob:setMod(xi.mod.LULLABYRES, 100)
    mob:setMod(xi.mod.SLEEPRES, 100)
    mob:setMod(xi.mod.SILENCERES, 100)
    -- mob:setMod(xi.mod.MAIN_DMG_RATING, -20) -- tweaking down melee - was OP on late stage Valoredge
end

entity.onMobWeaponSkill = function(target, mob, skill)
    -- Scripting to account for the fact that shield_bash is currently a "special" and therefore does not consume TP
    -- Valkeng (uniquely) treats this as a TP move
    if(skill:getID()==1944) then
        mob:setTP(0)
    end
end

entity.onMobWeaponSkillPrepare = function(mob, target)
    local currentFrame = mob:getLocalVar("CurrentFrame")
    if (currentFrame == harlequinFrameModelId or currentFrame == stormwalkerFrameModelId) then
        return 1943 -- slapstick
    elseif (currentFrame == sharpshotFrameModelId) then
        return 1942 -- arcuballista
    else
        local tpMove = math.random(1,3)
        if (tpMove == 1) then
            return 1940 -- chimera_ripper
        elseif (tpMove == 2) then
            return 1941 -- string_clipper
        else
            return 1944 -- shield_bash
        end
    end
end


entity.onMobFight = function(mob, target)
    local battleTime = mob:getBattleTime();
    -- calculate leading damage type every 30s
    if(battleTime%30 == 0 and battleTime~=0) then
        if(battleTime == mob:getLocalVar("LastUpdateTime")) then
            -- This function is called (locally) 2-4 times per battleTime second.  Ignore calls after the first
            return
        else
            mob:setLocalVar("LastUpdateTime", battleTime)
        end

        local sum = mob:getLocalVar("PhysicalDamage") + mob:getLocalVar("MagicalDamage") + mob:getLocalVar("RangedDamage")
        local physicalPercent = mob:getLocalVar("PhysicalDamage") / sum * 100
        local magicalPercent = mob:getLocalVar("MagicalDamage") / sum * 100
        local rangedPercent =  mob:getLocalVar("RangedDamage") / sum * 100

        if(physicalPercent > magicalPercent and physicalPercent > rangedPercent) then
            changeToValoredge(mob, physicalPercent)
        elseif (magicalPercent > physicalPercent and magicalPercent > rangedPercent) then
            changeToStormwaker(mob, magicalPercent)
        elseif (rangedPercent > physicalPercent and rangedPercent > magicalPercent) then
            changeToSharpshot(mob, rangedPercent)
        else
            -- if no dmg taken or no leading dmg type - dont trigger a change
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
