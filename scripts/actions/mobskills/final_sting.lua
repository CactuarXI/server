-----------------------------------
--  Final Sting
--  Description: Deals damage proportional to HP. Reduces HP to 1 after use. Damage varies with TP.
--  Type: Physical (Slashing)
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    local param = skill:getParam()
    if param == 0 then
        param = 35
    end

    if mob:getHPP() <= param then
        return 0
    end

    return 1
end

-- TODO: this is totally wrong, see https://docs.google.com/spreadsheets/d/1YBoveP-weMdidrirY-vPDzHyxbEI2ryECINlfCnFkLI/
mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1

    local hpMod = skill:getMobHPP() / 100
    dmgmod = dmgmod + hpMod * 5 + math.random(1, 3)

    if mob:isMobType(xi.mobType.NOTORIOUS) then
        dmgmod = dmgmod * 5
    end

    mob:setHP(0)

    if mob:isDead() then
        mob:setAnimationSub(1) -- Don't die twice
    end

local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    return dmg
end

return mobskillObject
