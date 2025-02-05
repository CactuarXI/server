-----------------------------------
--  Spiral Spin
--  Description: Chance of effect varies with TP. Additional Effect: Accuracy Down.
--  Type: Physical (Slashing)
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod  = 2
    local dmgmod  = 3
    local info    = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2, 3)
    local dmg     = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    local duration = 120
    local power    = 50
    local master   = mob:getMaster()
    local skillID  = skill:getID()

    if mob:isPet() then
        if master and master:hasJugPet() then
            local tp = skill:getTP()
            power    = 20
            duration = 50
            duration = math.max(60, duration * (tp/1000)) -- Minimum 60seconds. Maximum 2.5 minutes.
        end
    end

    local master = mob:getMaster()
    if mob:isPet() then
        if master and master:hasJugPet() then
            skill:setSkillchainProps(xi.skillchainType.SCISSION, xi.skillchainType.NONE, xi.skillchainType.NONE)
        end
    end
    
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.ACCURACY_DOWN, power, 0, duration)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    return dmg
end

return mobskillObject
