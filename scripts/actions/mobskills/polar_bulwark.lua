-----------------------------------
-- Polar Bulwark
-- Description: Grants a Magic Shield effect for a time.
-- Type: Enhancing
-- Range: Self
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getFamily() == 316 then
        local mobSkin = mob:getModelId()

        if mobSkin == 1796 then
            return 0
        else
            return 1
        end
    end
   --Only used when 2 or more heads alive
    if mob:getAnimationSub() <= 1 then
        return 0
    else
        return 1
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    mob:delStatusEffectSilent(xi.effect.MAGIC_SHIELD)
    mob:addStatusEffect(xi.effect.MAGIC_SHIELD, 1, 1, 45)
    mob:delStatusEffectSilent(xi.effect.PHYSICAL_SHIELD)
    mob:getStatusEffect(xi.effect.MAGIC_SHIELD):delEffectFlag(xi.effectFlag.DISPELABLE) -- Cannot be dispelled
    skill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT)
    if mob:getFamily() == 313 then -- Tinnin follows this up immediately with Nerve Gas
        mob:useMobAbility(1836)
    end

    return xi.effect.MAGIC_SHIELD
end

return mobskillObject
