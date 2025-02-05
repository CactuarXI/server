-----------------------------------
-- Pyric Bulwark
-- Description: Grants a Physical Shield effect for a time.
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

    --Used only if all 3 heads are alive
    if mob:getAnimationSub() == 0 then
        return 0
    else
        return 1
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    mob:delStatusEffectSilent(xi.effect.PHYSICAL_SHIELD)
    mob:delStatusEffectSilent(xi.effect.MAGIC_SHIELD)
    mob:addStatusEffect(xi.effect.PHYSICAL_SHIELD, 1, 0, 45)
    mob:getStatusEffect(xi.effect.PHYSICAL_SHIELD):delEffectFlag(xi.effectFlag.DISPELABLE) -- Cannot be dispelled
    skill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT)
    if mob:getFamily() == 313 then -- Tinnin follows this up immediately with Nerve Gas
        mob:useMobAbility(1836)
    end

    return xi.effect.PHYSICAL_SHIELD
end

return mobskillObject
