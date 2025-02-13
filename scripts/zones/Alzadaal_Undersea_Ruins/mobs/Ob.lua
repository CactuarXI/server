-----------------------------------
-- Area: Alzadaal Undersea Ruins
--  Mob: Ob
-----------------------------------
mixins = { require('scripts/mixins/rage') }
-----------------------------------
---@type TMobEntity
local entity = {}

local harlequinFrameModelId = 1977
local valoredgeFrameModelId = 1983
local sharpshotFrameModelId = 1990
local stormwalkerFrameModelId = 1994

local function overloadRageDisengage(mob)
    -- Dont allow an un-rage from actual rage
    if mob:getLocalVar('[rage]started') == 0 then
        -- Pulled from Rage.lua - may need tweaking
        mob:delMod(xi.mod.DELAY, 2600)
        mob:delMod(xi.mod.ATTP, 60)
        mob:delMod(xi.mod.ACC, 500)
        mob:delMod(xi.mod.MAIN_DMG_RATING, 75)
        mob:delMod(xi.mod.CRITHITRATE, 30)
        mob:delMod(xi.mod.MEVA, 500)
        mob:delMod(xi.mod.BINDRES, 100)
        mob:delMod(xi.mod.GRAVITYRES, 100)

        -- per capture, will tp quickly, but its not chain tp at 70%+ hp
        mob:delMod(xi.mod.REGAIN, 700)

    end
end

-- used to begin rage due to overload
local function overloadRageEngage(mob)
    -- Pulled from Rage.lua - may need tweaking
    mob:addMod(xi.mod.DELAY, 2600)
    mob:addMod(xi.mod.ATTP, 60)
    mob:addMod(xi.mod.ACC, 500)
    mob:addMod(xi.mod.MAIN_DMG_RATING, 75)
    mob:addMod(xi.mod.CRITHITRATE, 30)
    mob:addMod(xi.mod.MEVA, 500)
    mob:addMod(xi.mod.BINDRES, 100)
    mob:addMod(xi.mod.GRAVITYRES, 100)

    -- per capture, will tp quickly, but its not chain tp at 70%+ hp
    mob:addMod(xi.mod.REGAIN, 700)
end

local function changeToValoredge(mob, percent)
    if(mob:getLocalVar('CurrentFrame') == valoredgeFrameModelId) then
        return
    end

    mob:setLocalVar('CurrentFrame', valoredgeFrameModelId)
    mob:setMod(xi.mod.UDMGPHYS, -75)
    mob:setMod(xi.mod.UDMGRANGE, -75)
    mob:setMod(xi.mod.UDMGMAGIC, -50)
    mob:setMobMod(xi.mobMod.HP_STANDBACK, 0)
    mob:setMobMod(xi.mobMod.SPECIAL_SKILL, 1944) -- shield bash
    mob:setMobMod(xi.mobMod.SPECIAL_COOL, 120) -- cooldown
    mob:setMod(xi.mod.DELAY, 2400) -- high attack speed
    mob:setMod(xi.mod.DOUBLE_ATTACK, 10) -- has double attack
    mob:setMobMod(xi.mobMod.SKILL_LIST, 2029)

    mob:setMagicCastingEnabled(false)
    mob:useMobAbility(2018)
end

local function changeToStormwaker(mob)
    if(mob:getLocalVar('CurrentFrame') == stormwalkerFrameModelId) then
        return
    end

    mob:setLocalVar('CurrentFrame', stormwalkerFrameModelId)
    mob:setMod(xi.mod.UDMGPHYS, 50)
    mob:setMod(xi.mod.UDMGRANGE, 50)
    mob:setMod(xi.mod.UDMGMAGIC, -75)
    mob:setSpellList(2) -- generic blm
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 20)
    mob:setMod(xi.mod.UFASTCAST, 25)
    mob:setMobMod(xi.mobMod.HP_STANDBACK, 66)
    mob:setMobMod(xi.mobMod.SPECIAL_SKILL, 0) -- ranged attacks disabled
    mob:setMod(xi.mod.DELAY, 0) -- remove high attack speed
    mob:setMod(xi.mod.DOUBLE_ATTACK, 0)
    mob:setMobMod(xi.mobMod.SKILL_LIST, 2027)

    mob:setMagicCastingEnabled(false)
    mob:useMobAbility(2018)
end

local function changeToSharpshot(mob)
    if(mob:getLocalVar('CurrentFrame') == sharpshotFrameModelId) then
        return
    end

    mob:setLocalVar('CurrentFrame', sharpshotFrameModelId)
    mob:setMod(xi.mod.UDMGPHYS, 0)
    mob:setMod(xi.mod.UDMGRANGE, 0)
    mob:setMod(xi.mod.UDMGMAGIC, 50)
    mob:setMobMod(xi.mobMod.HP_STANDBACK, 66)
    mob:setMobMod(xi.mobMod.SPECIAL_SKILL, 272) -- ranged attacks enabled
    mob:setMobMod(xi.mobMod.SPECIAL_COOL, 14) -- ranged attack speed
    mob:setMod(xi.mod.DELAY, 0) -- remove high attack speed
    mob:setMod(xi.mod.DOUBLE_ATTACK, 0)
    mob:setMobMod(xi.mobMod.SKILL_LIST, 2028)

    mob:setMagicCastingEnabled(false)
    mob:useMobAbility(2018)
end

local function setupHarlequin(mob)
    mob:setLocalVar('CurrentFrame', harlequinFrameModelId)
    mob:setModelId(mob:getLocalVar('CurrentFrame'))
    mob:setMagicCastingEnabled(true)
    mob:setMod(xi.mod.UDMGPHYS, -50)
    mob:setMod(xi.mod.UDMGRANGE, -50)
    mob:setMod(xi.mod.UDMGMAGIC, -50)
    mob:setSpellList(700)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 35)
    mob:setMod(xi.mod.UFASTCAST, 25)
    mob:setBehavior(0) -- Standback disabled
    mob:setMobMod(xi.mobMod.HP_STANDBACK, 0)
    mob:setMobMod(xi.mobMod.SPECIAL_SKILL, 0) -- ranged attacks disabled
    mob:setMod(xi.mod.DELAY, 0) -- remove high attack speed
    mob:setMod(xi.mod.DOUBLE_ATTACK, 0)
    mob:setMobMod(xi.mobMod.SKILL_LIST, 2027)
    --mob:addMod(xi.mod.REGAIN, 3000)
end

local function scanForManeuvers(mob, target, member)
    local sharpshotCount = 0
    local valoredgeCount = 0
    local stormwalkerCount = 0
    local currentFrame = mob:getLocalVar('CurrentFrame')

    local overloadCount = 0
    local largestOverloadDuration = 0

    local zoneID = mob:getZoneID()
    local enmityList = mob:getEnmityList()
    for _, member in pairs(target:getAlliance()) do
        if (member:getMainJob() == xi.job.PUP or member:getSubJob() == xi.job.PUP) then -- filter by Puppetmasters
            if (member:getZoneID() == zoneID and mob:checkDistance(member) < 50) then -- filter by zone and distance

                -- Different number of maneuversRequired for main vs sub pup
                local maneuversRequired = 2
                if member:getMainJob() == xi.job.PUP then
                    maneuversRequired = 2
                end

                -- Determine the player's 'vote'
                if (member:countEffect(xi.effect.WIND_MANEUVER) + member:countEffect(xi.effect.THUNDER_MANEUVER)) >= maneuversRequired then
                    sharpshotCount = sharpshotCount + 1
                elseif (member:countEffect(xi.effect.FIRE_MANEUVER) + member:countEffect(xi.effect.EARTH_MANEUVER) + member:countEffect(xi.effect.LIGHT_MANEUVER)) >= maneuversRequired then
                    valoredgeCount = valoredgeCount + 1
                elseif (member:countEffect(xi.effect.ICE_MANEUVER) + member:countEffect(xi.effect.WATER_MANEUVER) + member:countEffect(xi.effect.DARK_MANEUVER)) >= maneuversRequired then
                    stormwalkerCount = stormwalkerCount + 1
                end

                -- Catch overloads
                local overloadStatus = member:getStatusEffect(xi.effect.OVERLOAD)
                if (overloadStatus ~= nil) then
                    overloadCount = overloadCount + 1
                    local duration = overloadStatus:getDuration()
                    if (duration > largestOverloadDuration) then
                        largestOverloadDuration = duration
                    end
                end
            end
        end
    end

    -- [rage]started is from rage.lua - we dont need to overload rage when actually raging
    if (overloadCount > 0 and mob:getLocalVar('OverloadRage') == 0 and mob:getLocalVar('[rage]started') == 0) then
         -- ya done goofed
        mob:setLocalVar('OverloadRage', os.time() + largestOverloadDuration) -- per capture, appears to match overload time on puppetmaster.
        mob:useMobAbility(627) -- per capture
        overloadRageEngage(mob)
    end

    if (sharpshotCount > valoredgeCount) and (sharpshotCount > stormwalkerCount) and (sharpshotCount > 0) then
        changeToSharpshot(mob)
    elseif (valoredgeCount > sharpshotCount) and (valoredgeCount > stormwalkerCount) and (valoredgeCount > 0) then
        changeToValoredge(mob)
    elseif (stormwalkerCount > sharpshotCount) and (stormwalkerCount > valoredgeCount) and (stormwalkerCount > 0) then
        changeToStormwaker(mob)
    end
    -- does not change back to Harlequin see https://www.youtube.com/watch?v=12nNGdEicUE for a scenario with 0 manuevers up after setting valor

end



entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
    mob:setMobMod(xi.mobMod.GIL_MIN, 3000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 5000)
    --mob:setMobMod(xi.mobMod.MP_BASE, 5000)
    setupHarlequin(mob)
    mob:addImmunity(xi.immunity.SILENCE)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar('[rage]timer', 3600) -- 60 minutes
    setupHarlequin(mob)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
