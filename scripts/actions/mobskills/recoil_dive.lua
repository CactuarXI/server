-----------------------------------
-- Recoil Dive
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1.0
    local crit = 0.33
    local shadowsTaken = xi.mobskills.shadowBehavior.NUMSHADOWS_1
        if mob:getZone():getTypeMask() == xi.zoneType.DYNAMIS and not mob:isPet() then
            shadowsTaken = xi.mobskills.shadowBehavior.NUMSHADOWS_2
        end
    local tpEffect1      = xi.mobskills.physicalTpBonus.DMG_VARIES
    local tpEffect2      = xi.mobskills.physicalTpBonus.CRIT_VARIES
    local attmod         = 1.0
    local info           = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, tpEffect1, 2, 3, 4, tpEffect2, 1, 2, 3, crit, attmod)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, shadowsTaken)
    
    local master = mob:getMaster()
    if mob:isPet() then
        if master and master:hasJugPet() then
            skill:setSkillchainProps(xi.skillchainType.TRANSFIXION, xi.skillchainType.NONE, xi.skillchainType.NONE)
        end
    end
    
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    return dmg
end

return mobskillObject
