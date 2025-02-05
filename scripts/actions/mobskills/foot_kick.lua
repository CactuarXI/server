-----------------------------------
-- Foot Kick
-- Deals critical damage. Chance of critical hit varies with TP.
-- 100% TP: ??? / 200% TP: ??? / 300% TP: ???
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits   = 1
    local accmod    = 1
    local dmgmod    = 1.0
    local tpEffect1 = xi.mobskills.physicalTpBonus.DMG_VARIES
    local tpEffect2 = xi.mobskills.physicalTpBonus.CRIT_VARIES
    local crit = 1
    local shadowsTaken = xi.mobskills.shadowBehavior.NUMSHADOWS_1
    if mob:getZone():getTypeMask() == xi.zoneType.DYNAMIS and not mob:isPet() then
        shadowsTaken = xi.mobskills.shadowBehavior.IGNORE_SHADOWS
    end

    local master = mob:getMaster()
    if mob:isPet() then
        if master and master:hasJugPet() then
            skill:setSkillchainProps(xi.skillchainType.REVERBERATION, xi.skillchainType.NONE, xi.skillchainType.NONE)
        end
    end

    -- Level 50+ rabbits have a different type of foot kick that has a 2.0 FTP instead of 1.0 This version also crits 100% of the time.
    if mob:getMainLvl() >= 50 then
        info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, tpEffect1, 2.25, 3.50, 5.0, tpEffect2, 1, 2, 3, crit)
    else
        info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, tpEffect1, 2, 3, 4, tpEffect2, 1, 2, 3, crit)
    end

    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, shadowsTaken)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    return dmg
end

return mobskillObject
