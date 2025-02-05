-----------------------------------
--  Tortoise Stomp
--  Description: Single target Defense Down xi.effect.
--  Type: Physical
--  Utsusemi/Blink absorb:&nbsp??
--  Range: Varying Area of Effect
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits        = 1
    local accmod         = 1
    local dmgmod         = 1.25
    local tpEffect1      = xi.mobskills.physicalTpBonus.DMG_VARIES
    local tpEffect2      = xi.mobskills.physicalTpBonus.NONE
    local crit           = 0.00
    local attmod         = 1
    local info           = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, tpEffect1, 3, 4, 5, tpEffect2, 1, 2, 3, crit, attmod)
    local dmg            = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    local master = mob:getMaster()
    if mob:isPet() then
        if master and master:hasJugPet() then
            skill:setSkillchainProps(xi.skillchainType.LIQUEFACTION, xi.skillchainType.NONE, xi.skillchainType.NONE)
        end
    end
    
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.DEFENSE_DOWN, 30, 0, 300)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    return dmg
end

return mobskillObject
