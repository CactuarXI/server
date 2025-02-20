-----------------------------------
--  Head Butt
--  Description: Damage varies with TP. Additional effect: 'Stun.'
--  Type: Physical (Blunt)
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local ftp    = 1.5
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.NO_EFFECT, 0, 0, 0)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    local master = mob:getMaster()
    if mob:isPet() then
        if master and master:hasJugPet() then
            skill:setSkillchainProps(xi.skillchainType.DETONATION, xi.skillchainType.NONE, xi.skillchainType.NONE)
        end
    end

    -- Mandragora Head Butt does not Stun
    if mob:getFamily() ~= 178 then
        xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.STUN, 1, 0, 4)
    end

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    return dmg
end

return mobskillObject
