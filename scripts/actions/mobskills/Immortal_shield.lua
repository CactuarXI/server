-----------------------------------
-- Immortal Shield
-- Description: Grants a Magic Shield effect for a time.
-- Type: Enhancing
-- Range: Self
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if (mob:getMod(xi.mod.MAGIC_STONESKIN) == 0) then
        -- only use this skill if there is no remainig magical stoneskin
        return 0
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)

    local magicalStoneskinAmount = 1000
    
    if (mob:isNM()) then
       magicalStoneskinAmount = 2000
    end

    mob:setMod(xi.mod.MAGIC_STONESKIN, magicalStoneskinAmount)
    --mob:addStatusEffect(xi.effect.MAGIC_SHIELD, 0, 4, 0, 45)
    skill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT)
    mob:setAnimationSub(2)
    return xi.effect.MAGIC_SHIELD
end

return mobskillObject
