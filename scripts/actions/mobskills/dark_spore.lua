-----------------------------------
--  Dark Spore
--
--  Description: Unleashes a torrent of black spores in a fan-shaped area of effect, dealing dark damage to targets. Additional effect: Blind
--  Type: Magical Dark (Element)
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local duration = 120
    local master = mob:getMaster()
    local skillID = skill:getID()
    if mob:isPet() then
        if master and master:hasJugPet() then
            local tp = skill:getTP()
            duration = 165
            duration = math.max(190, duration * (tp/1000)) -- Minimum 4:40 minutes. Maximum 9 minutes.
        end
    end

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BLINDNESS, 15, 3, duration)

    local dmgcap = 800
    if mob:getName() == 'Fairy_Ring' then
        dmgcap = 1005
    
        local typeEffect = xi.effect.POISON
        xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 50, 3, 60) -- 50/tic Poison
    end
    local dmgmod = xi.mobskills.mobBreathMove(mob, target, skill, 0.25, 2, xi.element.DARK, dmgcap)

    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    --if dmg > dmgcap then
    --    dmg = dmgcap / math.floor(mob:getHPP() / mob:getHP())
    --end

    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.DARK)

    if skill:getID() == 3874 then
        -- does not display the regular message (mimics auto attack)
        skill:setMsg(xi.msg.basic.HIT_DMG)
    end

    return dmg
end

return mobskillObject
